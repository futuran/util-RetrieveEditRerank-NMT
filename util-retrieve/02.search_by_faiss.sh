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

MATCH_DIR=${DIR}.$MODEL/match_enh1m_to_jah2m
mkdir -p $MATCH_DIR

# 2 search by faiss
for prefix in train_h100k #dev test train_h1m
do
    if [ $prefix = 'test' ]; then
        PM='--include-perfect-match'
    else
        PM=''
    fi

    # 検索対象は目的言語側のみ
    python 02.search_by_faiss.py \
        -q    ${DIR}.$MODEL/emb/${prefix}.en.emb \
        -qt   ${DIR}/${CORPUS}_$prefix.en.tkn \
        -tms  ${DIR}.$MODEL/emb/train.ja.emb \
        -tmst ${DIR}/${CORPUS}_train.en.tkn \
        -o    $MATCH_DIR/${prefix}.match \
        -k 100 -d 768 $PM
        # tms:  TM-Souceの名前だがNFRの名残であり、これは検索対象
        # tmst: TM-Sourceのテキストの意味。これはperfect-match排除のためなのでsrc言語に
    wait

    # # 検索対象は原言語側のみ
    # python 02.search_by_faiss.py \
    #     -q    ${DIR}.$MODEL/emb/${prefix}.en.emb \
    #     -qt   ${DIR}/${CORPUS}_$prefix.en.tkn \
    #     -tms  ${DIR}.$MODEL/emb/train.en.emb \
    #     -tmst ${DIR}/${CORPUS}_train.en.tkn \
    #     -o    ${DIR}.$MODEL/match_srcsrc/${prefix}.match \
    #     -k 100 -d 768 $PM
    # wait

    # # 検索対象は双方
    # python 02.search_by_faiss.py \
    #     -q    ${DIR}.$MODEL/emb/${prefix}.en.emb \
    #     -qt   ${DIR}/${CORPUS}_$prefix.en.tkn \
    #     -tms  ${DIR}.$MODEL/emb/train.en.emb \
    #     -tmt  ${DIR}.$MODEL/emb/train.ja.emb \
    #     -tmst ${DIR}/${CORPUS}_train.en.tkn \
    #     -o    ${DIR}.$MODEL/match_srcall/${prefix}.match \
    #     -k 100 -d 768 $PM
    # wait

done

