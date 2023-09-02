import csv
from names_generator import generate_name

antrag_erzeugt = []


kunden = [
    {
        "id": "1",
        "name": "gorzala"
    },
    {
        "id": "1",
        "name": "Scharrenberch"
    }
]


def data_to_csv_with_filename(file_name, data):
    if data:
        myFile = open(file_name, 'w')
        writer = csv.writer(myFile)
        writer.writerow(list(data[0].keys()))
        for dictionary in data:
            print("check")
            writer.writerow(dictionary.values())
        myFile.close()

def write_files():
    data_to_csv_with_filename("kunden.csv", kunden)
    data_to_csv_with_filename("antrag_erzeugt.csv", antrag_erzeugt)
    

def generate():
    write_files()
    

print("hallo" )