pvcreate /dev/mapper/PV_NAME_01  
pvcreate /dev/mapper/PV_NAME_02  
pvscan
pvdisplay /dev/mapper/PV_NAME_01
##################################
vgcreate VG_NAME /dev/mapper/ESFANDIAR_01
vgscan
vgdisplay VG_NAME
##################################
vgextend VG_NAME /dev/mapper/PV_NAME_01  
vgextend VG_NAME /dev/mapper/PV_NAME_02  
##################################
lvcreate --size xTB --name LV_NAME VG_NAME
lvscan
lvs
lvdisplay VG_NAME/LV_NAME

mkfs.ext4 /dev/VG_NAME/LV_NAME

lvextend --size +500M --resizefs VG_NAME/LV_NAME
