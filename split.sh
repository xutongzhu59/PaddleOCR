#!/bin/bash
work_dir="`pwd`"

root=/data/parcel/annotations/train_data_v2
a_list=("cls" "rec")
b_list=("100_1" "100_2" "100_3" "1k_1" "1k_2" "5k" "1w")

for a in "${a_list[@]}"
do
  for b in "${b_list[@]}"
  do

    sed -i "7s#.*#  save_model_dir: ./output/det_${b}#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    sed -i "15s#.*#  save_inference_dir: ./output/det_${b}#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    sed -i "73s#.*#      - /data/parcel/annotations/train_data/det/train_labels_${b}.txt#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    sed -i "141s#.*#      - /data/parcel/annotations/train_data/det/test_labels_${b}.txt#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    python tools/train.py -c configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    python tools/export_model.py -c /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/ch_PP-OCRv4_det_student_customized.yml
    python tools/infer/predict_system.py --det_model_dir=output/det_${b}/ --rec_model_dir=pretrain/en_PP-OCRv4_rec_infer/ --cls_model_dir=output/cls/v2 --image_dir=/data/parcel/annotations/train_data/det/phase_1+2_data_det_images/ --draw_img_save_dir=output/pred_0/${b} --use_angle_cls 1 --rec_char_dict_path=ppocr/utils/en_dict.txt
    python3 tools/end2end/convert_ppocr_label.py --mode=pred --label_path=output/pred_0/${b}/system_results.txt --save_folder=output/pred_1/${b}
    python3 tools/end2end/eval_end2end.py output/gt_ output/pred_1/${b} >> /home/mattie/PaddleOCR/trains.log
  done
done


