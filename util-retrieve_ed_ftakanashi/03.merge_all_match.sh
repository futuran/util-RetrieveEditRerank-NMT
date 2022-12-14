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

# 3 merge
for k in 1 2 3 4 5 8 10 16 100; do
    mkdir ${DIR}.$MODEL/merge_enh100k_to_enh100k.top$k
    for prefix in test dev train_h100k  ; do
        python 03.merge_all_match.py \
            -s ${DIR}/${CORPUS}_$prefix.en.tkn \
            -t ${DIR}/${CORPUS}_$prefix.ja.tkn \
            --match-file ${DIR}.$MODEL/match_enh100k_to_enh100k/${prefix}.match \
            -tmt ${DIR}/${CORPUS}_train.ja.tkn \
            -o   ${DIR}.$MODEL/merge_enh100k_to_enh100k.top$k/ \
            --topk $k --threshold 0.00 \
            --concat-symbol ' | '
        wait
    done
done
