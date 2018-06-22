#!/bin/bash
sed -r 's/\@\@ //g' | ./detruecase.perl | ./detokenizer.perl -l $TRGLANG
