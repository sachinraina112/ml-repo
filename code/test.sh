#/bin/bash
echo "Testing Inference"
retval=$?
{ # try

    python test.py "http://localhost:6666" || python test.py "http://127.0.0.1:6666" 
    #save your output

} || { python3 test.py "http://localhost:6666" || python3 test.py "http://127.0.0.1:6666" 
} $retval

 echo "Return code $retval"



