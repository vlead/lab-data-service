
import os
import os.path
import json
import requests
import glob

URL= 'http://localhost:5000'
json_path_list = []

def post_lab_spec(file_path):

    with open(file_path) as json_file:
        print file_path
        data = json.load(json_file)
        if 'lab' in data.keys():
            end_point = "/labs"
        if 'experiment' in data.keys():
            end_point = "/experiments"

        data['key'] = 'defaultkey'
        APP_URL = URL + end_point
        headers = {'Content-Type': 'application/json'}
        try:
            response = requests.post(APP_URL, data = json.dumps(data),
                                     headers=headers)
            if response.status_code == 200:
                print "Added json data : " + file_path
            else:
                print "Errore in adding json file " + file_path + " due to " + response.text
        except Exception as e:
            print str(e)
try:
    exp_file_list = glob.glob(os.getcwd() + "/e9*.json")
    lab_file_list = glob.glob(os.getcwd() + "/[!e9]*.json")

    for filename in exp_file_list:
        json_path_list.append(filename)
except Exception as e:
    print str(e)

for file_path in json_path_list:
    post_lab_spec(file_path)
post_lab_spec(lab_file_list[0])
