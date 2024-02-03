.PHONY: build_sina build_default update_qmk

QMK_FIRMWARE_BRANCH = firmware22

build_sina: qmk_firmware qmk_firmware/keyboards/voyager/keymaps/sina
	poetry run qmk compile -kb voyager/gd32 -km sina

update_qmk: qmk_firmware
	cd qmk_firmware && git pull origin HEAD

# This is useful for verifying that the environment is set up correctly and that the keyboard can be built
build_default: qmk_firmware
	poetry run qmk compile -kb voyager/gd32 -km default

qmk_firmware/keyboards/voyager/keymaps/sina: qmk_firmware oryx_output
	cp -r oryx_output/voyager_*_source qmk_firmware/keyboards/voyager/keymaps/sina

qmk_firmware:
	poetry run qmk setup zsa/qmk_firmware --home ./qmk_firmware --branch $(QMK_FIRMWARE_BRANCH)

oryx_output:
	wget https://oryx.zsa.io/source/LX76A -O oryx_output.zip
	unzip oryx_output.zip -d oryx_output
	rm oryx_output.zip

clean:
	rm -rf qmk_firmware/keyboards/voyager/keymaps/sina
