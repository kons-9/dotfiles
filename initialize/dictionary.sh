wget https://skk-dev.github.io/dict/SKK-JISYO.L.gz
gunzip SKK-JISYO.L.gz
mkdir -p $XDG_DATA_HOME/skk
mv SKK-JISYO.L $XDG_DATA_HOME/skk/SKK-JISYO.L
