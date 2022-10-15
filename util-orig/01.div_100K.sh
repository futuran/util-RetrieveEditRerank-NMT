DIR=../../data/aspec
SIZE=100000

head -n $SIZE $DIR/aspec_train.en.tkn > $DIR/aspec_train_h100k.en.tkn
head -n $SIZE $DIR/aspec_train.ja.tkn > $DIR/aspec_train_h100k.ja.tkn

tail -n $SIZE $DIR/aspec_train.en.tkn > $DIR/aspec_train_t100k.en.tkn
tail -n $SIZE $DIR/aspec_train.ja.tkn > $DIR/aspec_train_t100k.ja.tkn