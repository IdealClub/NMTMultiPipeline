#!/bin/sh
ENGINEDIR=$1
DATADIR=$ENGINEDIR/data
MODELDIR=$ENGINEDIR/model

INPUT=$2

DEVICEID=$3

MTTools=$( dirname $0 )
SUBWORDTools=$MTTools/"subword-nmt"

MARIAN=$MTTools/marian

echo "Translating with MARIAN on " $DEVICEID

$MARIAN/build/marian-decoder \
    --devices $DEVICEID \
    --model $MODELDIR/model.npz \
    --workspace 10000 \
    --vocabs $DATADIR/train.tc.bpe.src.json $DATADIR/train.tc.bpe.trg.json < $INPUT > $INPUT.out
