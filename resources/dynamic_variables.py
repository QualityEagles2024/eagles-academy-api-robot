from faker import Faker
import random
import string

# Inicializa o Faker com o locale pt_BR
fake = Faker('pt_BR')

def generate_password():
    """Gera uma senha forte seguindo o padrão: uma letra maiúscula, uma letra minúscula, um número,
    um caractere especial (@#$%), e tamanho entre 8-12 caracteres."""
    upper = random.choice(string.ascii_uppercase)
    lower = random.choice(string.ascii_lowercase)
    digit = random.choice(string.digits)
    special = random.choice("@#$%")
    length = random.randint(4, 8)
    remaining = random.choices(string.ascii_letters + string.digits + "@#$%", k=length)
    password = upper + lower + digit + special + ''.join(remaining)
    password = ''.join(random.sample(password, len(password)))
    return password

def generate_invalid_password():
    """Gera uma senha inválida para testar cenários que não atendem aos critérios."""
    length = random.randint(5, 7)  # Tamanho abaixo do mínimo permitido
    return ''.join(random.choices(string.ascii_lowercase, k=length))

def generate_empty_string():
    """Retorna uma string vazia, que pode ser usada para testar campos obrigatórios."""
    return ""

def generate_user_data(
        full_name_empty=False,
        special_char_in_name=False,
        lowercase_name=False,
        invalid_email=False,
        invalid_password=False,
        custom_email=None
    ):
    """Gera dados dinâmicos para um novo usuário, permitindo personalizar campos como nome, email e senha."""

    # Gera nome completo de acordo com os parâmetros
    if full_name_empty:
        full_name = ""
    elif special_char_in_name:
        first_name = fake.first_name() + random.choice("!@#$%&*")
        last_name = fake.last_name() + random.choice("!@#$%&*")
        full_name = f"{first_name} {last_name}"
    elif lowercase_name:
        # Gera um nome com iniciais minúsculas
        first_name = fake.first_name().lower()
        last_name = fake.last_name().lower()
        full_name = f"{first_name} {last_name}"
    else:
        first_name = fake.first_name()
        last_name = fake.last_name()
        full_name = f"{first_name} {last_name}"

    # Gera um email inválido, se especificado, ou um válido
    if invalid_email:
        email = "email_invalido@sem_dominio"
    else:
        email = custom_email if custom_email else fake.email()

    # Gera uma senha inválida se especificado, ou uma senha válida
    if invalid_password:
        password = generate_invalid_password()
    else:
        password = generate_password()
    confirm_password = password

    # Gera um CPF válido e remove os caracteres especiais
    cpf = fake.cpf().replace('.', '').replace('-', '')

    return {
        "firstName": full_name.split()[0] if full_name else "",
        "lastName": full_name.split()[-1] if full_name else "",
        "fullName": full_name,
        "email": email,
        "cpf": cpf,
        "password": password,
        "confirmPassword": confirm_password,
        "emptyString": generate_empty_string()
    }
