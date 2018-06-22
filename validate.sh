#!/bin/sh
# Distributed under MIT license

# this script evaluates the current model on the val set
# using detokenized BLEU (equivalent to evaluation with
# mteval-v13a.pl).

# If BLEU improves, the model is copied to model.npz.best_bleu

# Exported variables: 
# ENGINEDIR
# DEVICEID

DATADIR=$ENGINEDIR/data
MODELDIR=$ENGINEDIR/model

DEVICE=$2

MTTools=$( dirname $0 )
MTTools=$MTTools/"MTTools"
SUBWORDTools=$MTTools/"subword-nmt"

NEMATUS=$MTTools/nematus/nematus

VAL=$DATADIR/val.tc.bpe.src
REF=$DATADIR/val.tc.bpe.trg
MODEL=$MODELDIR/model.npz

# decode
# for new Tensorflow backend, use a command like this:
# CUDA_VISIBLE_DEVICES=$device python $nematus_home/nematus/translate.py \

THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$DEVICEID,gpuarray.preallocate=0.1 time python2 $NEMATUS/translate.py \
     -m $MODEL.dev.npz \
     -i $VAL -o $DATADIR/out.val -k 5 -n -p 1 --suppress-unk

$MTTools/postprocess.sh < $DATADIR/out.val > $DATADIR/$VAL.output.postprocessed.val


## get BLEU
BEST=`cat ${MODEL}_best_bleu || echo 0`
$MTTools/nematus/data/multi-bleu-detok.perl $REF < $DATADIR/$VAL.output.postprocessed.val >> ${MODEL}_bleu_scores
BLEU=$MTTools/nematus/data/multi-bleu-detok.perl $DATADIR/$REF < $DATADIR/$VAL.output.postprocessed.dev | cut -f 3 -d ' ' | cut -f 1 -d ','`
BETTER=`echo "$BLEU > $BEST" | bc`

echo "BLEU = $BLEU"

if [ "$BETTER" = "1" ]; then
  echo "new best; saving"
  echo $BLEU > ${MODEL}_bleu_scores
  cp ${MODEL}.dev.npz ${MODEL}.best_bleu
  cp ${MODEL}.dev.npz.json ${MODEL}.best_bleu.json
fi

