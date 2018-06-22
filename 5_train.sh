#!/bin/sh

ENGINEDIR=$1
DATADIR=$ENGINEDIR/data
MODELDIR=$ENGINEDIR/model
export ENGINEDIR=$ENGINEDIR

DEVICEID=$2
export DEVICEID=$DEVICEID

NMT=$3

MTTools=$( dirname $0 )
MTTools=$MTTools/"MTTools"
SUBWORDTools=$MTTools/"subword-nmt"

echo "Engine directory: " $ENGINEDIR
echo "Device id: " $DEVICEID

echo 'Checking'
for FILE in $NEMATUS/nmt.py $DATADIR/train.tc.bpe.src $DATADIR/train.tc.bpe.trg $DATADIR/val.tc.bpe.src $DATADIR/val.tc.bpe.trg $DATADIR/train.tc.bpe.src.json $DATADIR/train.tc.bpe.trg.json
do
    printf $FILE
    if [ -f $FILE ]
    then
        echo 'v'
    else
        echo 'x'
    fi
done

case "$NMT" in
        nematus)
            $MTTools/5_a_train_nematus.sh $ENGINEDIR $DEVICEID
            ;;
        1)
            $MTTools/5_a_train_nematus.sh $ENGINEDIR $DEVICEID
            ;;
        marian)
            $MTTools/5_b_train_marian.sh $ENGINEDIR $DEVICEID
            ;;
        2)
            $MTTools/5_b_train_marian.sh $ENGINEDIR $DEVICEID
            ;;
        opennmt)
            $MTTools/5_c_train_opennmt.sh $ENGINEDIR $DEVICEID
            ;;
        3)
            $MTTools/5_c_train_opennmt.sh $ENGINEDIR $DEVICEID
            ;; 
esac
