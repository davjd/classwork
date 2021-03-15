import csv
import click
import os.path
from os import path as os_path


class DataContainer(object):
    """Class that'll contain paths and static data for writes."""
    dataset_path = ''
    cache_path = 'cache.csv'
    fields = ['Borough', 'Count']

    def __init__(self, dataset_path):
        self.dataset_path = dataset_path

    def get_projects_dict(self):
        """Question: How many projects does each borough contain?"""
        borough_to_project = dict()
        with open(self.dataset_path) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            for row in csv_reader:
                if line_count != 0:
                    project_id = row[1]
                    borough = row[36]
                    if (borough != "") and (borough not in borough_to_project):
                        borough_to_project[borough] = set()
                    if borough != "":
                        borough_to_project[borough].add(project_id)
                line_count += 1
        result = {}
        for key, value in borough_to_project.items():
            result[key] = len(value)
        return result

    def write_cache(self, projects_dict):
        with open(self.cache_path, 'w') as csv_file:
            csv_writer = csv.writer(csv_file)
            rows = []
            for key, value in projects_dict.items():
                rows.append([key, value])
            csv_writer.writerow(self.fields)
            csv_writer.writerows(rows)

    def read_cache(self):
        borough_to_count = dict()
        with open(self.cache_path, 'r') as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            next(csv_reader)
            for row in csv_reader:
                borough = row[0]
                count = row[1]
                borough_to_count[borough] = count
        return borough_to_count


@click.group()
def cli():
    pass


@click.command()
@click.argument('data_path')
@click.option('--borough', type=str, help='Name of a New York City borough.')
def get_count(data_path, borough):
    data_container = DataContainer(data_path)
    results_dict = {}
    if os_path.exists(data_container.cache_path):
        results_dict = data_container.read_cache()
    else:
        results_dict = data_container.get_projects_dict()
        data_container.write_cache(results_dict)

    if borough:
        borough = borough.upper()
    if borough:
        if borough in results_dict:
            output = '{b} has {c} project complexes!'.format(
                b=borough, c=results_dict[borough])
        else:
            output = '{b} is not a valid borough in New York City or it has no available data!'.format(
                b=borough)
    else:
        output = 'Here is a report of the number of project complexes in each borough. {report}'.format(
            report=results_dict)
    click.echo(output)


cli.add_command(get_count)
if __name__ == '__main__':
    cli()
