#!/bin/bash
# Translates with an already translateed model
# Arguments:
# ENGINEDIR - the engine directory where model and data are stored
# INPUT - the file to translate
# NMTTYPE - nematus, marian, opennmt, opennmt-py
# DEVICEID - the device ID on which we run the translation.

ENGINEDIR=$1
INPUT=$2
NMT=$3
DEVICEID=$4

DATADIR=$ENGINEDIR/data

MTTools=$( dirname $0 )
MTTools=$MTTools/"MTTools"
SUBWORDTools=$MTTools/"subword-nmt"

# Apply BPE on the input
$SUBWORDTools/apply_bpe.py -c $DATADIR/bpe.src < $INPUT > $INPUT.bpe

case "$NMT" in
        nematus)
            $MTTools/6_a_translate_nematus.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
        1)
            $MTTools/6_a_translate_nematus.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
        marian)
            $MTTools/6_b_translate_marian.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
        2)
            $MTTools/6_b_translate_marian.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
        opennmt)
            $MTTools/6_c_translate_opennmt.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
        3)
            $MTTools/6_c_translate_opennmt.sh $ENGINEDIR $INPUT.bpe $DEVICEID
            ;;
esac


