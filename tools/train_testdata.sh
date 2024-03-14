#!/bin/bash
work_dir="`pwd`"

python tools/train.py -c configs/det/ch_PP-OCRv3/test.yml
python tools/export_model.py -c /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv3/test.yml
python tools/infer/predict_system.py --det_model_dir=output3/det_test/ --rec_model_dir=pretrain/en_PP-OCRv4_rec_infer/ --cls_model_dir=output/cls/v2 --image_dir=/data/ch4_test_images --draw_img_save_dir=output3/pred_0/test --use_angle_cls 1
python3 tools/end2end/convert_ppocr_label.py --mode=gt --label_path=/data/parcel/annotations/train_data_v3/det/train_labels_test.txt --save_folder=output3/gt_test
python3 tools/end2end/convert_ppocr_label.py --mode=pred --label_path=output3/pred_0/test/system_results.txt --save_folder=output3/pred_1/test
python3 tools/end2end/eval_end2end.py output3/gt_test output3/pred_1/test >> /home/mattie/PaddleOCR/trains3.log



