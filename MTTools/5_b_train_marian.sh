#!/bin/sh
ENGINEDIR=$1
DATADIR=$ENGINEDIR/data
MODELDIR=$ENGINEDIR/model

DEVICEID=$2
MTTools=$( dirname $0 )
SUBWORDTools=$MTTools/"subword-nmt"

MARIAN=$MTTools/marian

echo "Running MARIAN on " $DEVICEID

$MARIAN/build/marian \
    --devices $DEVICEID \
    --type amun \
    --model $MODELDIR/model.npz \
    --train-sets $DATADIR/train.tc.bpe.src $DATADIR/train.tc.bpe.trg \
    --vocabs $DATADIR/train.tc.bpe.src.json $DATADIR/train.tc.bpe.trg.json \
    --mini-batch-fit --workspace 9000 \
    --layer-normalization --dropout-rnn 0.2 --dropout-src 0.1 --dropout-trg 0.1 \
    --early-stopping 5 \
    --valid-freq 10000 --save-freq 10000 --disp-freq 1000 \
    --valid-metrics cross-entropy translation \
    --valid-sets $DATADIR/val.tc.bpe.src $DATADIR/val.tc.bpe.trg \
    --valid-script-path $MTTools/validate_marian.sh \
    --log $MODELDIR/train.log --valid-log $MODELDIR/val.log
