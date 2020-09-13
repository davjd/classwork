import csv

# How many projects does each borough contain.
with open('Affordable_Housing.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    borough_to_project = dict()
    for row in csv_reader:
        if line_count == 0:
            print(f'Column names are {", ".join(row)}\n')
        else:
            project_id = row[0]
            borough = row[4]
            if borough not in borough_to_project:
                borough_to_project[borough] = set()
            borough_to_project[borough].add(project_id)
        line_count += 1
    for key, value in borough_to_project.items():
        print(f'{key} has {len(value)} projects.')
    print(f'Processed {line_count} lines')
