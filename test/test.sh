#/bin/bash
echo "Testing Inference"
echo "First arg: $1"
{ # try

    python test/test.py $1
    #save your output

} || { python3 test/test.py $1
}

 echo "Executed test script"



