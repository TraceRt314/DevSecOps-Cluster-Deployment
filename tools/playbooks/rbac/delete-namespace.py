import argparse
import re
import subprocess

####################
# Global variables #
####################
ROLE_NAMESPACE = "user-full-access"
ROLEBINDING_NAMESPACE = "user-access"

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

# Function to delete namespace
@validate_namespace_name
def delete_namespace(namespace):
    subprocess.run(["kubectl", "delete", "namespace", namespace])
    if subprocess.run(["kubectl", "get", "namespace", namespace]).returncode != 0:
        print(f"Namespace '{namespace}' deleted successfully.")
    else:
        print(f"Error deleting namespace '{namespace}'.")

# Function to delete groups and roles
@validate_namespace_name
def delete_groups_roles(project, namespace, groups):
    for group in groups:
        subprocess.run(["kubectl", "delete", "rolebinding", f'{group}-{namespace}-{ROLEBINDING_NAMESPACE}', "-n", namespace])
        subprocess.run(["kubectl", "delete", "role", f'{group}-{namespace}-{ROLE_NAMESPACE}', "-n", namespace])
        subprocess.run(["az", "ad", "group", "delete", "--group", f'{project}-{namespace}-{group}'])

def main():
    parser = argparse.ArgumentParser(description="Delete namespace and other features (role, rolebinding...)")
    parser.add_argument("--namespace_name", help="Name of the namespace.")
    parser.add_argument("--project_name", help="Name of the project.")
    args = parser.parse_args()

    namespace = args.namespace_name
    project = args.project_name
    groups = ["Admin", "Coord", "Viewer"]

    delete_groups_roles(project=project, namespace=namespace, groups=groups)
    delete_namespace(namespace=namespace)

if __name__ == "__main__":
    main()
