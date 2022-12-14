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

for k in 1 2 3 4 5 8 10 16 100; do
    dir=${DIR}.$MODEL/merge_enh100k_to_enh100k.top$k
    for prefix in test dev train_h100k ; do
        poetry run subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$prefix.en.with_match.tkn > $dir/${CORPUS}_$prefix.en.tkn.bpe
        poetry run subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$prefix.ja.with_match.tkn > $dir/${CORPUS}_$prefix.ja.tkn.bpe
    done
done
