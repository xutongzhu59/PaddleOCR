#!/bin/bash
work_dir="`pwd`"

#my_list=("cls_v2_only" "100_1" "100_2" "100_3" "1k_1" "1k_2" "5k" "1w")
#my_list=("100_1" "100_2" "100_3")
#my_list=("500")
my_list=("100_3")

for item in "${my_list[@]}"
do
    sed -i "7s#.*#  save_model_dir: ./output3/det_${item}#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/scaling.yml
    sed -i "15s#.*#  save_inference_dir: ./output3/det_${item}#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/scaling.yml
    sed -i "73s#.*#      - /data/parcel/annotations/train_data_v3/det/train_labels_${item}.txt#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/scaling.yml
    sed -i "141s#.*#      - /data/parcel/annotations/train_data_v3/det/train_labels_${item}.txt#" /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/scaling.yml
    python tools/train.py -c configs/det/ch_PP-OCRv4/scaling.yml
    python tools/export_model.py -c /home/mattie/PaddleOCR/configs/det/ch_PP-OCRv4/scaling.yml
    rm -rf output3/pred_0/${item}
    rm -rf output3/pred_1/${item}
    python tools/infer/predict_system.py --det_model_dir=output3/det_${item}/ --rec_model_dir=pretrain/en_PP-OCRv4_rec_infer/ --cls_model_dir=output/cls/v2 --image_dir=/data/parcel/annotations/train_data_v3/det/fuzhou_sampled_p1_det_images_train_${item} --draw_img_save_dir=output3/pred_0/${item} --use_angle_cls 1 --rec_char_dict_path=ppocr/utils/en_dict.txt
    python3 tools/end2end/convert_ppocr_label.py --mode=gt --label_path=/data/parcel/annotations/train_data_v3/det/train_labels_${item}.txt --save_folder=output3/gt_${item}
    python3 tools/end2end/convert_ppocr_label.py --mode=pred --label_path=output3/pred_0/${item}/system_results.txt --save_folder=output3/pred_1/${item}
    python3 tools/end2end/eval_end2end.py output3/gt_${item} output3/pred_1/${item} >> /home/mattie/PaddleOCR/trains3.log
done


