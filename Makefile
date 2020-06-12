all:
	${MAKE} -C data $@

clean:
	${MAKE} -C data $@
	${MAKE} -C models $@
