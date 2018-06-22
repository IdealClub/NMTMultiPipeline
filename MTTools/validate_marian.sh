#!/bin/bash
# validate.sh
DATADIR=$ENGINEDIR/data
REF=$DATADIR/val.trg

./postprocess.sh < $1 > file.out 2>/dev/null
./multi-bleu-detok.perl $REF < file.out 2>/dev/null \
    | sed -r 's/BLEU = ([0-9.]+),.*/\1/'
