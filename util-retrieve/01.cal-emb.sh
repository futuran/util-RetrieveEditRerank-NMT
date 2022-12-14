CORPUS=$1
if [ "$CORPUS" = "" ]; then
    echo "Please designate CORPUS!!!"
    exit
fi

DIR=../../data/${CORPUS}

# 1 cal embs
mkdir -p ${DIR}.labse/emb
mkdir -p ${DIR}.msbert/emb
mkdir -p ${DIR}.sbert/emb

for prefix in train_h100k; do # ;test dev train train_h1m train_t1m ; do
    python 01.cal-emb.py    -s  ${DIR}/${CORPUS}_$prefix.en.tkn \
                            -t  ${DIR}/${CORPUS}_$prefix.ja.tkn \
                            -so ${DIR}.labse/emb/${prefix}.en.emb \
                            -to ${DIR}.labse/emb/${prefix}.ja.emb \
                            --model-dir 'LaBSE' \
                            --normalize-vectors

    python 01.cal-emb.py    -s  ${DIR}/${CORPUS}_$prefix.en.tkn \
                            -t  ${DIR}/${CORPUS}_$prefix.ja.tkn \
                            -so ${DIR}.msbert/emb/${prefix}.en.emb \
                            -to ${DIR}.msbert/emb/${prefix}.ja.emb \
                            --model-dir 'paraphrase-multilingual-mpnet-base-v2' \
                            --normalize-vectors

    python 01.cal-emb.py    -s  ${DIR}/${CORPUS}_$prefix.en.tkn \
                            -t  ${DIR}/${CORPUS}_$prefix.ja.tkn \
                            -so ${DIR}.sbert/emb/${prefix}.en.emb \
                            -to ${DIR}.sbert/emb/${prefix}.ja.emb \
                            --model-dir 'all-mpnet-base-v2' \
                            --normalize-vectors

    wait
done
