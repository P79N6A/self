```bash
VBoxManage list hdd
VBoxManage modifymedium $UUID --resize 30000

fdisk -l
/dev/sda1 * 1 64 512000 83 Linux
/dev/sda2 64 392 2632704 8e Linux LVM

# fdisk /dev/sda
  n {new partition}
  p {primary partition}
  3 {partition number}

  t {change partition id}
  3 {partition number}
  8e {Linux LVM partition}
  w

reboot

pvcreate /dev/sda3

vgextend vg_test /dev/sda3

lvextend -L +10G /dev/vg_test/lv_root »òÕß lvextend /dev/vg_test/lv_root /dev/sda3

resize2fs /dev/vg_test/lv_root

```
