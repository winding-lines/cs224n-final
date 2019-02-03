if [ ! -f bin/activate ]; then
    echo Create a virtual environment by running
    echo python3 -m venv .
    exit 1
fi

. ./bin/activate
pip install --upgrade pip
pip install -r requirements.txt

if [ ! -f SQuAD-1.1/train-v1.1.json ] ; then
    mkdir SQuAD-1.1
    cd SQuAD-1.1
    curl -O https://rajpurkar.github.io/SQuAD-explorer/dataset/dev-v1.1.json
    curl -O https://rajpurkar.github.io/SQuAD-explorer/dataset/train-v1.1.json
    cd ..
fi

if [ ! -d output ]; then
    mkdir output
fi

python example-run-squad.py --bert_model bert-base-uncased --output_dir output --do_predict --predict_file SQuAD-1.1/dev-v1.1.json --do_train --train_file SQuAD-1.1/train-v1.1.json --num_train_epochs 1.0 --no_cuda
