# XLM-RoBERTaに基づくフレーズ抽出モデル訓練のためのデータセット作成
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

mkdir -p ${DIR}.$MODEL.oracle
mkdir -p ${DIR}.$MODEL.NBoW

# PREFIX=enh100k_to_enh100k # for ED
PREFIX=enh1m_to_jah2m # for LaBSE

for topk in 1 10 100; do
    echo $topk
    mkdir ${DIR}.$MODEL.oracle/${PREFIX}_top$topk/
    mkdir ${DIR}.$MODEL.NBoW/${PREFIX}_top$topk/
    for tvt in dev test train_h100k
    do
        poetry run python 01.preprocess_NeuralBoW.py   -prefix         ${CORPUS}_$tvt \
                                            -in_dir         ${DIR}.$MODEL/merge_${PREFIX}.top100/ \
                                            -in_suffix_src  en.with_match.tkn \
                                            -in_suffix_trg  ja.with_match.tkn \
                                            -out_oracle_dir ${DIR}.$MODEL.oracle/${PREFIX}_top$topk/ \
                                            -out_NBoW_dir   ${DIR}.$MODEL.NBoW/${PREFIX}_top$topk/ \
                                            -out_suffix_src oracle.src.tkn \
                                            -out_suffix_trg oracle.trg.tkn \
                                            -topk           $topk
    done
done
