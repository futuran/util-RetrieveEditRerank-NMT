DIR=../../data/aspec
SIZE=1000000

head -n $SIZE $DIR/aspec_train.en.tkn > $DIR/aspec_train_h1m.en.tkn
head -n $SIZE $DIR/aspec_train.ja.tkn > $DIR/aspec_train_h1m.ja.tkn

tail -n $SIZE $DIR/aspec_train.en.tkn > $DIR/aspec_train_t1m.en.tkn
tail -n $SIZE $DIR/aspec_train.ja.tkn > $DIR/aspec_train_t1m.ja.tkn