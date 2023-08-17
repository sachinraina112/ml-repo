#/bin/bash
echo "Testing Inference"
echo "First arg: $1"
{ # try

    python test.py $1
    #save your output

} || { python3 test.py $1
}

 echo "Executed test script"



