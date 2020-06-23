SAMPLES?=24
TMAX?=365
N?=10000
I0?=50
MAXMEM?=2097152
PROCS?=
MODELS=../models
SCRIPTS=../scripts
KASIM=KaSim -mode batch -u time -p 1 --no-log

all:
	${MAKE} MODEL=masks masks.tsv
	${MAKE} MODEL=masks ARGS="-var sp 0" nomasks.tsv
	${MAKE} MODEL=fomites fomites.tsv
	${MAKE} MODEL=fomites ARGS="-var omega 0" nowash.tsv
	${MAKE} MODEL=mosquitoes vector.tsv
	${MAKE} MODEL=mosquitoes KAPPA=${MODELS}/mosquito-habitat.ka habitat.tsv
	${MAKE} MODEL=testing testing.tsv
	${MAKE} MODEL=testing ARGS="-var m 250" lowtest.tsv
	${MAKE} MODEL=tracing tracing.tsv
	${MAKE} MODEL=tracing ARGS="-var r 1 -var s 1" perfect.tsv
	${MAKE} MODEL=maskademic maskademic.tsv
	${MAKE} MODEL=school school.tsv
	${MAKE} MODEL=school ARGS="-var school 0" noschool.tsv
	${MAKE} MODEL=super ARGS="-p 0.1" super.tsv
	${MAKE} MODEL=super ARGS="-var k_gather 0" nosuper.tsv
	${MAKE} tti-0.tsv

clean:
	rm -rf *.tsv traj
	rm -f *-0.yaml *-0-events.yaml
	rm -f deadlock.ka
	rm -f inputs*.ka

%.tsv: ${MODELS}/${MODEL}.ka
	mkdir -p traj
	ulimit -v ${MAXMEM}; seq ${SAMPLES} | parallel --will-cite ${PROCS} ${KASIM} -seed '{}' -o traj/${@:%.tsv=%}-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} ${ARGS} $< ${KAPPA} || true
	${SCRIPTS}/envelope -k -d, -o $@ -i traj/${@:%.tsv=%}-[0-9]*.dat

tti-0.tsv: ${MODELS}/tti.yaml
	ptti -y $<
