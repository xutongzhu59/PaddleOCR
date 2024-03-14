# recommended paddle.__version__ == 2.0.0
python3 -m paddle.distributed.launch --log_dir=./debug/ --gpus 0  tools/train.py -c configs/cls/cls_mv3_customized.yml