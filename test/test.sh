#/bin/bash
echo "Testing Inference"
retval=$?
echo "First arg: $1"
{ # try

    python test.py $1
    #save your output

} || { python3 test.py $1
} $retval

 echo "Return code $retval"



