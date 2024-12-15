#!/bin/sh

linux_image()
{
	if grep -Eq "^BR2_LINUX_KERNEL_UIMAGE=y$" ${BR2_CONFIG}; then
		echo "uImage"
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGE=y$" ${BR2_CONFIG}; then
		echo "Image"
	elif grep -Eq "^BR2_LINUX_KERNEL_IMAGEGZ=y$" ${BR2_CONFIG}; then
		echo "Image.gz"
	else
		echo "zImage"
	fi
}

generic_getty()
{
	if grep -Eq "^BR2_TARGET_GENERIC_GETTY=y$" ${BR2_CONFIG}; then
		echo ""
	else
		echo "s/\s*console=\S*//"
	fi
}

PARTUUID="$($HOST_DIR/bin/uuidgen)"

install -d "$TARGET_DIR/boot/extlinux/"
# WiFi and Bluetooth firmwares
install -d "$TARGET_DIR/lib/firmware/brcm"
install -D -m 0755 "board/transpeed/8kh618/firmware/brcm/brcmfmac4334-sdio.bin" \
	"$TARGET_DIR/lib/firmware/brcm/brcmfmac4334-sdio.transpeed,8k618-t.bin"
install -D -m 0755 "board/transpeed/8kh618/firmware/brcm/BCM4334B0.hcd" \
	"$TARGET_DIR/lib/firmware/brcm/BCM4334B0.hcd"
install -D -m 0755 "board/transpeed/8kh618/firmware/brcm/brcmfmac4334-sdio.txt" \
	"$TARGET_DIR/lib/firmware/brcm/brcmfmac4334-sdio.txt"

####
sed -e "$(generic_getty)" \
	-e "s/%LINUXIMAGE%/$(linux_image)/g" \
	-e "s/%PARTUUID%/$PARTUUID/g" \
	"board/orangepi/common/extlinux.conf" > "$TARGET_DIR/boot/extlinux/extlinux.conf"

sed "s/%PARTUUID%/$PARTUUID/g" "board/orangepi/common/genimage.cfg" > "$BINARIES_DIR/genimage.cfg"
