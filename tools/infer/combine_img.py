import os, cv2
import numpy as np

pth = '/home/mattie/PaddleOCR/test/out/'

for img_file in os.listdir(pth+'det'):
    if img_file[-3:] != 'jpg': continue
    img_name = os.path.basename(img_file).split('_',2)[2]
    rec_pth = pth+'rec/'+'test_data_'
    cls_pth = pth+'cls/cls_vis/'+img_name
    rec_pth = rec_pth+img_name
    rec_im = cv2.imread(rec_pth, cv2.IMREAD_COLOR)
    cls_im = cv2.imread(cls_pth, cv2.IMREAD_COLOR)
    det_im = cv2.imread(pth+'det/'+img_file, cv2.IMREAD_COLOR)
    out = np.hstack([det_im, cls_im, rec_im])

    cv2.imwrite(pth+img_name, out)