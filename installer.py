from shutil import which
import re, json, subprocess

def detect_pm():
    if which('dnf'):
        return 'dnf'
    elif which('apt'):
        return 'apt'
    else:
        return 'null'

package_manager = detect_pm() 

if package_manager == 'null':
     print('unsupported system')
     exit()

def parse_system(pkglist_filename, system_name):
    matching_lines = []
    collecting = False
    collected = []

    with open(pkglist_filename, 'r') as file:
        non_comment_lines = [line for line in file if not line.startswith('#')]
        for line in non_comment_lines:
            if collecting:
                if ']' in line:
                    break
                collected.append(line.rstrip())

            if f'[{system_name}' in line:
                collecting = True
                collected.append(line.rstrip())

    for i, line in enumerate(collected[1:]):
        i += 1
        if '!u' in line:
           collected[i] = line.replace(';', f'sudo {package_manager} install ')
           continue
        elif '!p' in line:
           collected[i] = line.replace(';', f'pip install --user ')

    required_packages, optional_packages = [],[]

    for command in collected[1:]:
        clean_command = re.sub(r' !\w+', '', command)
        if '!r' in command:
            required_packages.append(clean_command)
        elif '!o' in command:
            optional_packages.append(clean_command)

    return {
        "required": required_packages,
        "optional": optional_packages,
    }

data = json.loads(json.dumps(parse_system('test.pkglist','hyprland'), indent=4))

package_req, package_opt = data['required'],data['optional']

print(f'There are a Total of {len(package_req)+len(package_opt)} packages to be installed\n')
print(f'{len(package_req)} of these are required:')
print(f'{package_req}\n\n{len(package_opt)} of these are optional\n{package_opt}\n')
print('a/all r/required n/none')
user_input = input('a/r/n $ ')

if user_input == 'n':
    exit()
if user_input == 'a':
    selected = package_req + package_opt
elif user_input == 'r':
    selected = package_req 

for line in selected:
    subprocess.run(line, shell=True, check=True)
