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

PREFIX=enh100k_to_enh100k # for ED
# PREFIX=enh1m_to_jah2m # for LaBSE

for topk in 1 10 100; do
    dir=${DIR}.$MODEL.oracle/${PREFIX}_top$topk/
    for tvt in train_h100k dev test; do
            poetry run subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$tvt.oracle.src.tkn > $dir/${CORPUS}_$tvt.oracle.src.tkn.bpe &
            poetry run subword-nmt apply-bpe -c $code < $dir/${CORPUS}_$tvt.oracle.trg.tkn > $dir/${CORPUS}_$tvt.oracle.trg.tkn.bpe &
    done
done
