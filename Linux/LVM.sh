pvcreate /dev/mapper/ESFANDIAR_01  
pvcreate /dev/mapper/ESFANDIAR_02  
pvcreate /dev/mapper/ESFANDIAR_03  
pvcreate /dev/mapper/ESFANDIAR_04  
pvcreate /dev/mapper/ESFANDIAR_05  
pvcreate /dev/mapper/ESFANDIAR_06  
pvcreate /dev/mapper/ESFANDIAR_07  
pvcreate /dev/mapper/ESFANDIAR_08  
pvcreate /dev/mapper/ESFANDIAR_09  
pvcreate /dev/mapper/ESFANDIAR_10  
pvscan
pvdisplay /dev/mapper/ESFANDIAR_01
##################################
vgcreate ESFANDIAR_VG /dev/mapper/ESFANDIAR_01
vgscan
vgdisplay ESFANDIAR_VG
##################################
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_02  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_03  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_04  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_05  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_06  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_07  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_08  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_09  
vgextend ESFANDIAR_VG /dev/mapper/ESFANDIAR_10  
##################################
lvcreate --size 19.99TB --name ESFANDIAR_LV ESFANDIAR_VG
lvscan
lvs
lvdisplay ESFANDIAR_VG/ESFANDIAR_LV


mkfs.ext4 /dev/ESFANDIAR_VG/ESFANDIAR_LV


lvextend --size +500M --resizefs ESFANDIAR_VG/ESFANDIAR_LV
