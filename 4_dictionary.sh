#!/bin/bash
ENGINEDIR=$1
DATADIR=$ENGINEDIR/data
MODELDIR=$ENGINEDIR/model

MTTools=$( dirname $0 )
MTTools=$MTTools/"MTTools"
SUBWORDTools=$MTTools/"subword-nmt"

NUMSYM=50000

# train BPE
$SUBWORDTools/learn_bpe.py --input $DATADIR/train.tc.src --output $DATADIR/bpe.src --symbols $NUMSYM
$SUBWORDTools/learn_bpe.py --input $DATADIR/train.tc.trg --output $DATADIR/bpe.trg --symbols $NUMSYM

# apply BPE
for FILE in 'train' 'test' 'val'
do
    $SUBWORDTools/apply_bpe.py -c $DATADIR/bpe.src < $DATADIR/$FILE.tc.src > $DATADIR/${FILE}.tc.bpe.src
    $SUBWORDTools/apply_bpe.py -c $DATADIR/bpe.trg < $DATADIR/$FILE.tc.trg > $DATADIR/${FILE}.tc.bpe.trg
done

 build network dictionary
python2 $MTTools/build_dictionary.py $DATADIR/train.tc.bpe.src
python2 $MTTools/build_dictionary.py $DATADIR/train.tc.bpe.trg

python2 $MTTools/build_dictionary.py $DATADIR/train.tc.src
python2 $MTTools/build_dictionary.py $DATADIR/train.tc.trg

