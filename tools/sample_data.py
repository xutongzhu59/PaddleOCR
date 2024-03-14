import os
import random

input_label_path = '/data/parcel/annotations/train_data_v3/det/train_fuzhou_sampled_p1_det_labels.txt'
# sample_list = {"100_1":100, "100_2": 100, "100_3": 100, "1k_1": 1000, "1k_2": 1000, "5k": 5000, "1w": 10000}
# sample_list = {"100_1":100, "100_2": 100, "100_3": 100}
sample_list = {"500": 500}
with open(input_label_path, 'r') as f:
    labels = f.readlines()

for key in sample_list:
    out = random.sample(labels, sample_list[key])
    with open(input_label_path.replace(os.path.basename(input_label_path), f'train_labels_{key}.txt'), 'w') as out_f:
        out_f.write(''.join(out))

    for line in out:
        img_path = line.strip().split('\t')[0]
        new_path = img_path.replace('train/', f'train_{key}/')
        if not os.path.exists(os.path.dirname(new_path)):
            os.makedirs(os.path.dirname(new_path))
        os.system(f'cp {img_path} {new_path}')

# for key in sample_list:
#     with open(input_label_path.replace(os.path.basename(input_label_path), f'train_labels_{key}.txt'), 'r') as f:
#         lines = f.readlines()
#
#         for line in lines:
#             img_path = line.strip().split('\t')[0]
#             new_path = img_path.replace('train/', f'train_{key}/')
#             if not os.path.exists(os.path.dirname(new_path)):
#                 os.makedirs(os.path.dirname(new_path))
#             os.system(f'cp {img_path} {new_path}')



