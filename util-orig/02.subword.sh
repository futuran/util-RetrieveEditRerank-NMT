DIR=../../data/aspec
OPNUM=32000

# subword用のコードは、対訳のある1Mからのみ抽出
mkdir -p $DIR/tmp
cat ${DIR}/aspec_train_h1m.en.tkn ${DIR}/aspec_train_h1m.ja.tkn > ${DIR}/tmp/aspec_train_h1m.all.tkn
poetry run subword-nmt learn-bpe -s ${OPNUM} < ${DIR}/tmp/aspec_train_h1m.all.tkn > ${DIR}/code.all

# aspec
for tvt in train_h1m train_t1m train dev test; do
    poetry run subword-nmt apply-bpe -c ${DIR}/code.all < ${DIR}/aspec_${tvt}.en.tkn > ${DIR}/aspec_${tvt}.en.tkn.bpe
    poetry run subword-nmt apply-bpe -c ${DIR}/code.all < ${DIR}/aspec_${tvt}.ja.tkn > ${DIR}/aspec_${tvt}.ja.tkn.bpe
done