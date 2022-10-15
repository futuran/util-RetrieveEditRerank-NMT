DIR=../../data/aspec

# subword用のコードは、対訳のある1Mからのみ抽出
mkdir -p $DIR/tmp
cat ${DIR}/aspec_train_h1m.en.tkn ${DIR}/aspec_train_h1m.ja.tkn > ${DIR}/tmp/aspec_train_h1m.all.tkn

# aspec
for tvt in train_h100k; do
    subword-nmt apply-bpe -c ${DIR}/code.all < ${DIR}/aspec_${tvt}.en.tkn > ${DIR}/aspec_${tvt}.en.tkn.bpe
    subword-nmt apply-bpe -c ${DIR}/code.all < ${DIR}/aspec_${tvt}.ja.tkn > ${DIR}/aspec_${tvt}.ja.tkn.bpe
done