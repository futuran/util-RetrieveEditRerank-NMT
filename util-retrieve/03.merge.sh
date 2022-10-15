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

NAME=enh1m_to_jah2m

# 3 merge
for k in 1 10 100; do
    mkdir ${DIR}.$MODEL/merge_$NAME.top$k
    for prefix in train_h100k  #test dev train_h1m
    do
        python 03.merge.py \
            -s ${DIR}/${CORPUS}_$prefix.en.tkn \
            -t ${DIR}/${CORPUS}_$prefix.ja.tkn \
            --match-file ${DIR}.$MODEL/match_$NAME/${prefix}.match \
            -tmt ${DIR}/${CORPUS}_train.ja.tkn \
            -o   ${DIR}.$MODEL/merge_$NAME.top$k/ \
            --topk $k --threshold 0.00 \
            --concat-symbol ' | '
        wait
    done
done
