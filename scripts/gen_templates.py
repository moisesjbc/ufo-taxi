import yaml
from jinja2 import Environment, PackageLoader, select_autoescape, FileSystemLoader
import sys

if __name__ == '__main__':
    template_file = sys.argv[1]
    template_loader = FileSystemLoader(searchpath="./")
    template_environment = Environment(loader=template_loader, autoescape=select_autoescape())
    template = template_environment.get_template(template_file)

    with open('metadata/en.yaml', 'r') as input_file:
        values = yaml.load(input_file.read(), Loader=yaml.SafeLoader)
        output_text = template.render(**values)
        print(output_text.encode('utf-8'))
