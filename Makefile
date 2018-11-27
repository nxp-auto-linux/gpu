all:
	./samples-build.sh fb
modules_install:
	./samples-build.sh fb
clean:
	./samples-build.sh clean
	rm -rf tmp
	rm -rf test/build
	rm -rf test/linux_build.log
	find . -name 'bin_r' -type d -prune -exec rm -rf {} \;
	
