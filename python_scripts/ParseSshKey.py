
import json
f = open("ParseSshKeyfile.json",)
data = json.load(f)
for ek in data["data"]:
    if ek["attributes"]["name"] == "team-abc":
        print (ek["id"])
f.close()