#!/bin/bash
# Cleansing and tokenising the data.
SRCLANG=$1
TRGLANG=$2
ENGINEDIR=$3

DATADIR=$ENGINEDIR/data

MTTools=$( dirname $0 )
MTTools=$MTTools/"MTTools"

echo 'Tokenising...'
# tokenize
for FILE in 'train' 'test' 'val'
do
    cat ${DATADIR}/${FILE}.src | \
    $MTTools/normalize-punctuation.perl -l ${SRCLANG} | \
    $MTTools/tokenizer.perl -a -l $SRCLANG > ${DATADIR}/${FILE}.tok.src

    cat ${DATADIR}/${FILE}.trg | \
    $MTTools/normalize-punctuation.perl -l ${TRGLANG} | \
    $MTTools/tokenizer.perl -a -l $TRGLANG > ${DATADIR}/${FILE}.tok.trg
done

# clean empty and long sentences, and sentences with high source-target ratio (training corpus only)
$MTTools/clean-corpus-n.perl $DATADIR/train.tok src trg $DATADIR/train.tok.clean 1 60

echo 'Done.'
