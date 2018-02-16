# REQUIREMENTS: isoinfo, 7zip, wget, mkisofs, awk.

FREEBSD_VERSION ?= 11.1
RELEASE_TYPE ?= RELEASE
ARCH ?= amd64

ISO_VARIANT := bootonly

ISO_FILENAME_PREFIX := FreeBSD-${FREEBSD_VERSION}-${RELEASE_TYPE}-${ARCH}-${ISO_VARIANT}
ORIGINAL_ISO := ${ISO_FILENAME_PREFIX}.iso
CUSTOM_ISO := ${ISO_FILENAME_PREFIX}-duckinator.iso

iso: ${CUSTOM_ISO}

${CUSTOM_ISO}: downloads/${ORIGINAL_ISO}
	mkdir -p workdir
	cd workdir
	pwd
	exit 1
	7z x ../downloads/${ORIGINAL_ISO}
	cp ../etc/* ./etc
	cd ..
	mkisofs -J -R -no-emul-boot -V "$(./get-iso-title downloads/${ORIGINAL_ISO})" -p "duckinator" -b boot/cdboot -o ${CUSTOM_ISO} ./workdir

downloads/${ORIGINAL_ISO}:
	wget "https://download.freebsd.org/ftp/releases/${ARCH}/${ARCH}/ISO-IMAGES/${FREEBSD_VERSION}/${ORIGINAL_ISO}" -O downloads/${ORIGINAL_ISO}

clean:
	rm -rf workdir
	rm -f ${CUSTOM_ISO}

.PHONY: clean iso
