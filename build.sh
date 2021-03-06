#! /bin/sh
echo "begin update kernel src"
cd linux/archlinux-linux
git fetch
cd ../src/archlinux-linux
git add . && git reset --hard && git pull
cd ../../..
echo "begin update and export the linux pkg"
asp update linux
asp export linux
echo "begin modify the PKGBUILD and the config"
sed -i 's/pkgbase=linux$/pkgbase=linux-wsl/' linux/PKGBUILD
sed -i 's/make all$/make all -j24/' linux/PKGBUILD
sed -i 's/make htmldocs$/make htmldocs -j24/' linux/PKGBUILD
cp wsl/config linux/config
echo "generate checksum"
cd linux
updpkgsums
echo "begin build kernel"
makepkg -s

