SKIPUNZIP=0
## Variables
#
# MAGISK_VER (string): the version string of current installed Magisk (e.g. v20.0)
# MAGISK_VER_CODE (int): the version code of current installed Magisk (e.g. 20000)
# BOOTMODE (bool): true if the module is being installed in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module’s installation zip
# ARCH (string): the CPU architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device (e.g. 21 for Android 5.0)
# 

## Function
# ui_print <msg>
#   print <msg> to console
#   Avoid using 'echo' as it will not display in custom recovery's console
# abort <msg>
#   print error message <msg> to console and terminate installation
#   Avoid using 'exit' as it will skip the termination cleanup steps
# set_perm <target> <owner> <group> <permission> [context]
#   if [context] is not set, the default is "u:object_r:system_file:s0"
#   this function is a shorthand for the following commands:
#      chown owner.group target
#      chmod permission target
#      chcon context target
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#   if [context] is not set, the default is "u:object_r:system_file:s0"
#   for all files in <directory>, it will call:
#      set_perm file owner group filepermission context
#   for all directories in <directory> (including itself), it will call:
#      set_perm dir owner group dirpermission context

## print word
ui_print "Thx to people for trying this module . . . "
ui_print ""
ui_print "after reboot check log inside internal/modul_mantul/ZyC_Turbo.log, after reboot find notes_en.txt/notes_en.id and read it xD"
ui_print ""
ui_print ""
ui_print "enjoy . . ."

### fix module command
bin=xbin
if [ ! -d system/xbin ]; then
bin=bin
mkdir $MODPATH/system/$bin
mv $MODPATH/system/xbin/* $MODPATH/system/$bin
rm -rf $MODPATH/system/xbin/*
rmdir $MODPATH/system/xbin
else
rm -rf $MODPATH/system/bin/*
rmdir $MODPATH/system/bin
fi

### For GMS doze fix
if [ ! -e  /system/etc/sysconfig/google.xml ]; then
rm -rf $MODPATH/system/etc/sysconfig/*
rmdir $MODPATH/system/etc/sysconfig
else
# mkdir /system/etc/sysconfig
if [ -e /system/etc/sysconfig/google.xml.ori ];then
    cp -af /system/etc/sysconfig/google.xml.ori $MODPATH/system/etc/sysconfig/google.xml.ori
    cp -af /system/etc/sysconfig/google.xml.ori $MODPATH/system/etc/sysconfig/google.xml
else 
    cp -af /system/etc/sysconfig/google.xml $MODPATH/system/etc/sysconfig/google.xml.ori
    cp -af /system/etc/sysconfig/google.xml $MODPATH/system/etc/sysconfig/google.xml 
fi
# rm -rf $MODPATH/system/etc/sysconfig/*
fi
if [ ! -e  /system/product/etc/sysconfig/google.xml ]; then
rm -rf $MODPATH/system/product/*
rmdir $MODPATH/system/product
else
if [ -e /system/product/etc/sysconfig/google.xml.ori ];then
    cp -af /system/product/etc/sysconfig/google.xml.ori $MODPATH/system/product/etc/sysconfig/google.xml.ori
    cp -af /system/product/etc/sysconfig/google.xml.ori $MODPATH/system/product/etc/sysconfig/google.xml 
else
    cp -af /system/product/etc/sysconfig/google.xml $MODPATH/system/product/etc/sysconfig/google.xml.ori
    cp -af /system/product/etc/sysconfig/google.xml $MODPATH/system/product/etc/sysconfig/google.xml 
fi
# rm -rf $MODPATH/system/product/*
fi
if [ ! -e  /system/system/product/etc/sysconfig/google.xml ]; then
rm -rf $MODPATH/system/system/*
rmdir $MODPATH/system/system
else
if [ -e /system/system/product/etc/sysconfig/google.xml.ori ];then
    cp -af /system/system/product/etc/sysconfig/google.xml.ori $MODPATH/system/system/product/etc/sysconfig/google.xml.ori
    cp -af /system/system/product/etc/sysconfig/google.xml.ori $MODPATH/system/system/product/etc/sysconfig/google.xml
else
    cp -af /system/system/product/etc/sysconfig/google.xml $MODPATH/system/system/product/etc/sysconfig/google.xml.ori
    cp -af /system/system/product/etc/sysconfig/google.xml $MODPATH/system/system/product/etc/sysconfig/google.xml
fi
# rm -rf $MODPATH/system/system/*
fi

### fix folder permission
set_perm_recursive $MODPATH                   0 0 0755 0777
set_perm_recursive $MODPATH/system/$bin       0 0 0755 0777
set_perm_recursive $MODPATH/system/etc/ZyC_Ai 0 0 0755 0777
set_perm $MODPATH/system.prop 0 0 0644
if [ -e  /system/etc/sysconfig/google.xml ]; then
    set_perm_recursive $MODPATH/system/etc/sysconfig 0 0 0755 0644
fi
if [ -e  /system/product/etc/sysconfig/google.xml ]; then
    set_perm_recursive $MODPATH/system/product 0 0 0755 0644
fi
if [ -e  /system/system/product/etc/sysconfig/google.xml ]; then
    set_perm_recursive $MODPATH/system/system 0 0 0755 0644
fi

## remove some useless files
if [ -e  $MODPATH/.gitattributes ]; then
    rm -rf $MODPATH/.gitattributes
fi
if [ -e  $MODPATH/.gitignore ]; then
    rm -rf $MODPATH/.gitignore
fi
if [ -e  $MODPATH/readme.md ]; then
    rm -rf $MODPATH/readme.md
fi
if [ -e  $MODPATH/updater.sh ]; then
    rm -rf $MODPATH/updater.sh
fi

## magisk path
echo "$NVBASE/modules" > $MODPATH/system/etc/ZyC_Ai/magisk_path.txt

## copy system.prop
[ -e $NVBASE/modules/ZyC_Turbo/system.prop ] && [ -e $MODPATH/system.prop ] && cp -af $NVBASE/modules/ZyC_Turbo/system.prop $MODPATH/system.prop

## copy some files instead
[ -e $NVBASE/modules/ZyC_Turbo/system/etc/ZyC_Ai/mod_path.txt ] && cp -af $NVBASE/modules/ZyC_Turbo/system/etc/ZyC_Ai/mod_path.txt $MODPATH/system/etc/ZyC_Ai/mod_path.txt