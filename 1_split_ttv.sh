#!/bin/bash
# Randomizes the data and splits the file into three different sets: train, test and val
SRC=$1
TRG=$2
SRCLANG=$3
TRGLANG=$4

DATADIR=$5

TESTCOUNT=$6
VALCOUNT=$7

TTCOUNT=$(( $TESTCOUNT + $VALCOUNT ))

echo "Splitting into train test and val..."
echo $SRC
echo $TRG

mkdir -p ${DATADIR}/${SRCLANG}-${TRGLANG}
mkdir -p ${DATADIR}/${SRCLANG}-${TRGLANG}/data
mkdir -p ${DATADIR}/${SRCLANG}-${TRGLANG}/model

head -n $TESTCOUNT $SRC > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/test.src
head -n $TESTCOUNT $TRG > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/test.trg

head -n $TTCOUNT $SRC | tail -n $VALCOUNT > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/val.src
head -n $TTCOUNT $TRG | tail -n $VALCOUNT > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/val.trg

TRAINSTART=$(( $TTCOUNT + 1 ))
tail -n +${TRAINSTART} $SRC > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/train.src
tail -n +${TRAINSTART} $TRG > ${DATADIR}/${SRCLANG}-${TRGLANG}/data/train.trg

echo "Done."





