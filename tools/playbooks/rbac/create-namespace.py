import argparse
import re
import subprocess
import os

####################
# Global variables #
####################
ROLE_NAMESPACE_FILE = "role-namespace-template.yaml"
ROLEBINDING_NAMESPACE_FILE = "rolebinding-namespace-template.yaml"
ROLE_NAMESPACE_FILE_TMP = "role-namespace-tmp.yaml"
ROLEBINDING_NAMESPACE_FILE_TMP = "rolebinding-namespace-tmp.yaml"

REPLACE_NAMESPACE = "REPLACE-NAMESPACE"
REPLACE_NS_ROLE = "REPLACE-NS-ROLE"
REPLACE_ID = "REPLACE-ID"

# Decorator to validate namespace name
def validate_namespace_name(func):
    def wrapper(*args, **kwargs):
        pattern = "^[a-zA-Z0-9-]+$"
        namespace = kwargs.get('namespace', '')
        if not re.match(pattern, namespace):
            print(f"Error: The namespace name '{namespace}' contains invalid characters")
            exit(1)
        return func(*args, **kwargs)
    return wrapper

# Function to create namespace
@validate_namespace_name
def create_namespace(namespace):
    subprocess.run(["kubectl", "create", "namespace", namespace])
    if subprocess.run(["kubectl", "get", "namespace", namespace]).returncode == 0:
        print(f"Namespace '{namespace}' created successfully.")
    else:
        print(f"Error creating namespace '{namespace}'.")

# Function to create groups
def create_groups(project, namespace, groups):
    try:
        for group_name in groups:
            command = ["az", "ad", "group", "create", "--display-name", f"{project}-{namespace}-{group_name}", "--mail-nickname", f"{project}-{namespace}-{group_name}", "--query", "id", "-o", "tsv"]
            subprocess.run(command)
    except Exception as e:
        print(f"Error creating groups: {e}")
        pass
    
# Function to apply yaml files
def apply_yaml_files(project, namespace, groups):
    for group in groups:
        with open(f'{group}-{ROLE_NAMESPACE_FILE}', "r") as file:
            content = file.read().replace(REPLACE_NAMESPACE, namespace).replace(REPLACE_NS_ROLE, f'{group}-{namespace}')
        with open(f'{group}-{ROLE_NAMESPACE_FILE_TMP}', "w") as file:
            file.write(content)

        subprocess.run(["kubectl", "apply", "-f", f'{group}-{ROLE_NAMESPACE_FILE_TMP}'])

        GROUP_ID = subprocess.getoutput(f"az ad group show --group {project}-{namespace}-{group} --query id -o tsv")
        with open(ROLEBINDING_NAMESPACE_FILE, "r") as file:
            content = file.read().replace(REPLACE_NAMESPACE, namespace).replace(REPLACE_NS_ROLE, f'{group}-{namespace}').replace(REPLACE_ID, '"'+ GROUP_ID + '"')
        with open(ROLEBINDING_NAMESPACE_FILE_TMP, "w") as file:
            file.write(content)

        subprocess.run(["kubectl", "apply", "-f", ROLEBINDING_NAMESPACE_FILE_TMP])

        # Remove temp files
        os.remove(ROLEBINDING_NAMESPACE_FILE_TMP)
        os.remove(f'{group}-{ROLE_NAMESPACE_FILE_TMP}')

def main():
    parser = argparse.ArgumentParser(description="Create namespace and other features (role, rolebinding...)")
    parser.add_argument("--namespace_name", help="Name of the namespace.")
    parser.add_argument("--project_name", help="Name of the project.")
    args = parser.parse_args()

    namespace = args.namespace_name
    project = args.project_name.upper()
    groups = ["Admin", "Coord", "Viewer"]

    create_namespace(namespace=namespace)
    create_groups(project=project, namespace=namespace, groups=groups)
    apply_yaml_files(project=project, namespace=namespace, groups=groups)

if __name__ == "__main__":
    main()