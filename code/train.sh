#/bin/bash
echo "Starting training"
{ # try

    python train.py
    #save your output

} || { python3 train.py
}