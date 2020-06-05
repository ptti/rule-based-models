SAMPLES?=24
TMAX?=365
N?=10000
I0?=50
MODELS=../models
SCRIPTS=../scripts
KASIM=KaSim -mode batch -u time -p 1 --no-log

all:
	${MAKE} MODEL=masks masks.tsv
	${MAKE} MODEL=masks ARGS="-var mu 0" nomasks.tsv
	${MAKE} MODEL=fomites fomites.tsv
	${MAKE} MODEL=fomites ARGS="-var omega 0" nowash.tsv
	${MAKE} MODEL=mosquitoes vector.tsv
	${MAKE} MODEL=mosquitoes KAPPA=${MODELS}/mosquito-habitat.ka habitat.tsv
	${MAKE} MODEL=testing testing.tsv
	${MAKE} MODEL=testing ARGS="-var m 250" lowtest.tsv
	${MAKE} MODEL=tracing tracing.tsv
	${MAKE} MODEL=tracing ARGS="-var r 1 -var s 1" perfect.tsv
	${MAKE} MODEL=school school.tsv
	${MAKE} MODEL=school ARGS="-var school 0" noschool.tsv
	${MAKE} tti-0.tsv

clean:
	rm -rf *.tsv traj
	rm -f *-0.yaml *-0-events.yaml
	rm -f deadlock.ka
	rm -f inputs*.ka

%.tsv: ${MODELS}/${MODEL}.ka
	mkdir -p traj
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o traj/${@:%.tsv=%}-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} ${ARGS} $< ${KAPPA}
	${SCRIPTS}/envelope -k -d, -o $@ -i traj/${@:%.tsv=%}-[0-9]*.dat

tti-0.tsv: ${MODELS}/tti.yaml
	ptti -y $<
policy-testing.tsv: .policies-testing
	${SCRIPTS}/envelope -k -d, -o $@ -i policies/testing-[0-9]*.dat
.policies-testing: ${MODELS}/policies.ka
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o policies/testing-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} -var thetaD 0 -var thetaI 0 $< && touch $@

policy-testing-release.tsv: .policies-testing-release
	${SCRIPTS}/envelope -k -d, -o $@ -i policies/testing-release-[0-9]*.dat
.policies-testing-release: ${MODELS}/policies.ka
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o policies/testing-release-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} -var thetaD 0 $< && touch $@

policy-diagnosis.tsv: .policies-diagnosis
	${SCRIPTS}/envelope -k -d, -o $@ -i policies/diagnosis-[0-9]*.dat
.policies-diagnosis: ${MODELS}/policies.ka
	mkdir -p policies
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o policies/diagnosis-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} -var thetaT 0 -var thetaI 0 $< && touch $@

policy-diagnosis-release.tsv: .policies-diagnosis-release
	${SCRIPTS}/envelope -k -d, -o $@ -i policies/diagnosis-release-[0-9]*.dat
.policies-diagnosis-release: ${MODELS}/policies.ka
	mkdir -p policies
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o policies/diagnosis-release-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} -var thetaT 0 $< && touch $@

policy-nothing.tsv: .policies-nothing
	${SCRIPTS}/envelope -k -d, -o $@ -i policies/nothing-[0-9]*.dat
.policies-nothing: ${MODELS}/policies.ka
	mkdir -p policies
	seq ${SAMPLES} | parallel ${KASIM} -seed '{}' -o policies/nothing-'{}'.dat -l ${TMAX} -var N ${N} -var INIT_I ${I0} -var thetaD 0 -var thetaT 0 -var thetaI 0 $< && touch $@
