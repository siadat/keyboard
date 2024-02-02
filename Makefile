build: qmk_firmware
	poetry run qmk compile -kb voyager/gd32 -km default

qmk_firmware:
	poetry run qmk setup zsa/qmk_firmware --home ./qmk_firmware --branch firmware22
