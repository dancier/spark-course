import csv
import uuid
from names_generator import generate_name

from datetime import datetime

start_ts = datetime.strptime('9/1/2023 1:30 PM', '%m/%d/%Y %I:%M %p')
end_ts = datetime.strptime('9/20/2023 1:30 PM', '%m/%d/%Y %I:%M %p')

##### Kontext Angebots begin
antrag_erzeugt = []  # check
'''
Wenn der Antrag abgegeben wurde.
Enthält immer:
AntragsId:
StartZeit: wann mit dem Antrag begonnen wurde
EndZeit: wann der Antrag abgegeben wurde
Enthält manchmal:
KundenId: wenn diese aus dem Antragsschritt ermittelt werde konnte
'''

ab_test = []  # check

kunde_hat_angebot_akzeptiert = []
'''
das liest wieder das vertragssystem und policierts
'''

kunde_hat_angebot_abgelehnt = [] # check
'''
hier machen wir nix besonderes
'''


##### Kontext Angebot zu ende


##### Kontext Vertrags
kunde_angelegt = [] # check
'''
Wenn ein Antrag angelegt wurde ohne das auf einen bestehenden Kunden verwiesen wurde, muss dieser Angelegt werden.
Das Event enthält ausschließlich die KundenId
'''

vertrag_angeboten = [] # check
'''
Wenn der Kunden uns einen Antrag auf Erstellung eines Vertrags stellt, antworten wir einmal mit der Erstellung eines solchen,
oder lehnen die erstellung ab.
'''

antrag_abgelehnt = [] # check
'''
Wie können den Vertrag aus verschiedenen Gründen nicht erstellen. Dann verschicken diese Event mit einem Hinweis auf den Grund.
'''

vertrag_policiert = []
'''
VertragsId
Gültigkeitsstart:
'''

# Leistungs Kontext

schaden_gemeldet = []
schaden_reguliert = []


kunden = [
    {
        "id": "ce4cf720-4a1a-11ee-8349-7b31dfcc7252",
        "name": "gorzala"
    },
    {
        "id": "d55a2ede-4a1a-11ee-8cce-b739d8c6e256",
        "name": "Scharrenberch"
    }
]
'''
Enthält alle Kunden die es überhaupt gibt.
'''

def reagiere_auf_kunde_akzeptiert_vertrag_event(kunde_akzeptiert_vertrags_event):
    pass


def reagiere_auf_vertrag_angeboten_event(vertrag_angeboten_event):
    # VertragsId, AntragsId, KundenId, TimeStamp
    from random import randrange
    from datetime import timedelta
    diese_startzeit = vertrag_angeboten_event["TimeStamp"] + timedelta(days = randrange(1,15))
    match draw_item(
        {
            "keineReaktion": 20,
            "positiveReaktion": 90,
            "negativeReaktion": 20
        }
    ):
        case "keineReaktion": 
            return
        case "positiveReaktion": 
            event = {
                "VertragsId": vertrag_angeboten_event["VertragsId"],
                "AntragsId": vertrag_angeboten_event["AntragsId"],
                "KundenId": vertrag_angeboten_event["KundenId"],
                "TimeStamp": diese_startzeit
            }
            kunde_hat_angebot_akzeptiert.append(event)
            reagiere_auf_kunde_akzeptiert_vertrag_event(event)
            
        case "negativeReaktion": 
            event = {
                "VertragsId": vertrag_angeboten_event["VertragsId"],
                "AntragsId": vertrag_angeboten_event["AntragsId"],
                "Grund": "zu teuer",
                "Timestamp": diese_startzeit
            }
            kunde_hat_angebot_abgelehnt.append(event)
            # hier geht es für uns nicht mehr weiter
            


def reagiere_auf_erzeugten_vertrag(vertrag_erzeugt_event):
    # AntragsId, StartZeit, EndZeit, KundenId
    from random import randrange
    from datetime import timedelta

    # in sehr seltenen fällen hier direkt abbrechen (da hat wohl einer Kafka oder noch nicht richtig genutzt)
    if randrange(100) > 97:
        return

    diese_startzeit = vertrag_erzeugt_event["EndZeit"] + timedelta(minutes=1)
    kunden_id = vertrag_erzeugt_event["KundenId"]
    # behandeln des falles ohne kundenid
    if not vertrag_erzeugt_event["KundenId"]:
        if randrange(1,100) < 97:
            kunden_id = createUser()
            event = {
                "KundenId": kunden_id,
                "TimeStamp": diese_startzeit
            }
            kunde_angelegt.append(event)
        else:
            # prozess stop hier (excection beim partner anlegen)
            return

    
    # wenn es bzgl. der kunden id kein problem gab
    ## manchmal vertrag anbieten
    match draw_item(
        {
            "vertrag": 100,
            "kein-vertrag": 2
        }
    ):
        case "vertrag" :
            event = {
                "VertragsId": str(uuid.uuid4()),
                "AntragsId": vertrag_erzeugt_event["AntragsId"],
                "KundenId": kunden_id,
                "TimeStamp": diese_startzeit
            }
            vertrag_angeboten.append(event)
            reagiere_auf_vertrag_angeboten_event(event)
        case "kein-vertrag":
            event = {
                "AntragsId": vertrag_erzeugt_event["AntragsId"],
                "KundenId": kunden_id,
                "TimeStamp": diese_startzeit,
                "Grund": "Betrugstype"
            }
            antrag_abgelehnt.append(event)
            # hierauf wird nicht mehr gesondert reagiert

    ## oder auch nicht anbieten
    

def erzeuge_antrag(antrag_start):
    from random import randrange
    from datetime import timedelta

    antrags_id = uuid.uuid4()

    ab_case = draw_item(
        {
            True: 1,
            False: 8
        }
    )

    duration = 0
    if ab_case:
        duration = randrange(1,5)
        ab_test.append({
            "AntragsId": antrags_id
        })
    else:
        duration = randrange(1,10)

    antrag_ende = antrag_start + timedelta(minutes = duration)

    kunden_id = None
    match draw_item({
        "with_kunde": 8,
        "without_kunde": 2
    }):
        case "with_kunde": kunden_id = createUser()

    event = {
            "AntragsId": antrags_id,
            "StartZeit": antrag_start,
            "EndZeit": antrag_ende,
            "KundenId": kunden_id
        }
    antrag_erzeugt.append(event)
    reagiere_auf_erzeugten_vertrag(event)
    

### Lib

def createUser():
    user_id = uuid.uuid4()
    name = generate_name(style="capital")
    kunden.append(
        {
            "id": user_id,
            "name": name
        }
    )
    return user_id

def main(count):
    
    for i in range(count):
        erzeuge_antrag(random_between(start_ts, end_ts))
    write_files()

def draw_item(classes):
    all_weights = sum(classes.values())
    from random import randrange
    shot = randrange(1,all_weights+1)
    count = 0
    for classy in classes.keys():
        count = count + classes[classy]
        if count >= shot:
            return classy

def random_between(start, end):
    """
    This function will return a random datetime between two datetime 
    objects.
    """
    from random import randrange
    from datetime import timedelta
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = randrange(int_delta)
    return start + timedelta(seconds=random_second)


def data_to_csv_with_filename(file_name, data):
    if data:
        myFile = open(file_name, 'w')
        writer = csv.writer(myFile)
        writer.writerow(list(data[0].keys()))
        for dictionary in data:
            writer.writerow(dictionary.values())
        myFile.close()

def write_files():
    data_to_csv_with_filename("kunden.csv", kunden)
    data_to_csv_with_filename("antrag_erzeugt.csv", antrag_erzeugt)
    data_to_csv_with_filename("ab_test.csv", ab_test)
    data_to_csv_with_filename("vertrag_angeboten.csv", vertrag_angeboten)
    data_to_csv_with_filename("kunde_angelegt.csv", kunde_angelegt)
    data_to_csv_with_filename("antrag_abgelehnt.csv", antrag_abgelehnt)
    data_to_csv_with_filename("kunde_hat_angebot_abgelehnt.csv", kunde_hat_angebot_abgelehnt)
    data_to_csv_with_filename("kunde_hat_angebot_akzeptiert.csv", kunde_hat_angebot_akzeptiert)
    

