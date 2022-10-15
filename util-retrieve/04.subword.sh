CORPUS=$1
if [ "$CORPUS" = "" ]; then
    echo "Please designate CORPUS!!!"
    exit
fi
DIR=../../data/${CORPUS}
MODEL=$2
if [ "$MODEL" = "" ]; then
    echo "Please designate MODEL!!!"
    exit
fi

code=${DIR}/code.all
NAME=enh1m_to_jah2m

for k in 1 10 100; do
    dir=${DIR}.$MODEL/merge_$NAME.top$k
    for prefix in train_h100k #test dev train_h1m
    do
        subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$prefix.en.with_match.tkn > $dir/${CORPUS}_$prefix.en.tkn.bpe
        subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$prefix.ja.with_match.tkn > $dir/${CORPUS}_$prefix.ja.tkn.bpe
    done
done
