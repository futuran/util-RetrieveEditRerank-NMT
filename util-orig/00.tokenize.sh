
MOSESDIR=/mnt/work/mosesdecoder/scripts/tokenizer

path=/mnt/work/20221004_RetrieveEditRerank-NMT/data/aspec/*
for file in $path; do
    if [[ $file = *.ja ]]; then
        echo $file
        mecab $file -O wakati > $file.tkn
    elif [[ $file = *.en ]]; then
        echo $file
        cat $file | perl ${MOSESDIR}/normalize-punctuation.perl en | \
            perl ${MOSESDIR}/remove-non-printing-char.perl | \
            perl ${MOSESDIR}/tokenizer.perl -threads 8 -a -l en > $file.tkn
    else
        continue
    fi
done