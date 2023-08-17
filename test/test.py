import pandas as pd
import json
import requests




def test(base_url):
# url = "http://localhost:6666/inference"
 
    url = base_url + '/inference'
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
