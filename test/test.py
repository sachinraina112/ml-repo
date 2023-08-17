import pandas as pd
import json
import requests




def test(ip):
# url = "http://localhost:6666/inference"
    port = '6666'
    url = "http://" + str(ip) + ":" + port + '/inference'
    df = pd.DataFrame([[0,5,7,6]])

    res = df.to_json(orient='records')
    pj = json.loads(res)
    response = requests.post(url, json=pj)
    if response.status_code == 200:
        return True
    else:
        raise Exception

if __name__ == "__main__":
    import sys
    arg = sys.argv[1]
    test(arg)
