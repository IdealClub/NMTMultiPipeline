#!/bin/bash

MTTools=$( dirname $0 )

if [ -z $TRGLANG ]
then
    TRGLANG=en
fi
sed -r 's/\@\@ //g' | $MTTools/detruecase.perl | $MTTools/detokenizer.perl -l $TRGLANG
