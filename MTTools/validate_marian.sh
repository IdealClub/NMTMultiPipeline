#!/bin/bash
# validate.sh
DATADIR=$ENGINEDIR/data
REF=$DATADIR/val.trg

MTTools=$( dirname $0 )

cat $1 > $DATADIR/raw.out

$MTTools/postprocess.sh < $DATADIR/raw.out > $DATADIR/postprocessed.out 2>/dev/null
$MTTools/multi-bleu-detok.perl $REF < $DATADIR/postprocessed.out 2>/dev/null \
    | sed -r 's/BLEU = ([0-9.]+),.*/\1/'
