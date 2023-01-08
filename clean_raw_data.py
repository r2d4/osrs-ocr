import json

outfile = 'training-data-all.txt'

with open(outfile, 'w') as f:
    for data in [
        "raw_data/items-complete.json", 
        "raw_data/monsters-complete.json", 
        "raw_data/npcs-summary.json", 
        "raw_data/objects-summary.json"
        ]:
        with open(data) as f2:
            d = json.load(f2)
            for attribute, value in d.items():
                if value.get('name') is not None:
                    f.write(value['name'] + '\n')
                if value.get('examine') is not None:
                    f.write(value['examine'] + '\n')

uniqlines = set(open(outfile).readlines())
cleaned = open(outfile, 'w').writelines(uniqlines)

