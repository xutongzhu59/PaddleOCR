#python3 -m paddle.distributed.launch --log_dir=./debug/ --gpus 0  tools/train.py -c configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
#python3 -m paddle.distributed.launch --log_dir=./debug/ --gpus 0  tools/train.py -c configs/rec/en_PP-OCRv4_rec_customized.yml
python3 -m paddle.distributed.launch --log_dir=./debug/ --gpus 0  tools/train.py -c configs/cls/cls_mv3_customized.yml



