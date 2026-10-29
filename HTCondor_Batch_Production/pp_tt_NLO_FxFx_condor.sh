#!/bin/bash
#===============================
# MG5 job running in /tmp then copying to EOS
#===============================

# Assign unique job ID
JOB_ID=$1
SEED=$(( (RANDOM + 1000 * $JOB_ID + 10#$(date +%N)) % 100000000 ))

#--- Define paths
EOS_DIR_OUT=/path/to/EOS_output_directory/
EOS_DIR=/path/to/MG5_aMC_directory
MGPATH=$EOS_DIR
TMP_DIR=/tmp/$USER/mg5_job_$JOB_ID
OUTPUT_DIR="pp_tt_012_jets_NLO_5F_FxFx_TuneCP5_pythia8_${JOB_ID}"
PROC_DIR="1condor_pp_tt_012_jets_NLO_5F_FxFx_TuneCP5_pythia8"

#--- Prepare environment
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MGPATH/HEPTools/lhapdf6_py3/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MGPATH/HEPTools/lhapdf6_py3/lib
export PYTHONPATH=$PYTHONPATH:$MGPATH/HEPTools/lhapdf6_py3/lib/python3.10/site-packages

#--- Create and move to temporary work directory
mkdir -p $TMP_DIR
cd $TMP_DIR || exit 1

echo "Working directory: $TMP_DIR"
echo "Job ID: $JOB_ID | Seed: $SEED"


# Step 1: Generate and output
$MGPATH/bin/mg5_aMC <<EOF
import model loop_sm-no_b_mass
generate p p > t t~ [QCD]
add process p p > t t~ j [QCD]
add process p p > t t~ j j [QCD]
output $OUTPUT_DIR
EOF

 # Step 2: Modify the shower card automatically
sed -i '33a\
#*********************************************************************\
Tune:pp 14\
Tune:ee 7\
MultipartonInteractions:ecmPow= 0.03344\
MultipartonInteractions:bProfile= 2\
MultipartonInteractions:pT0Ref= 1.41\
MultipartonInteractions:coreRadius= 0.7634\
MultipartonInteractions:coreFraction= 0.63\
ColourReconnection:range= 5.176\
SigmaTotal:zeroAXB= off\
SpaceShower:alphaSorder= 2\
SpaceShower:alphaSvalue= 0.118\
SigmaProcess:alphaSvalue= 0.118\
SigmaProcess:alphaSorder= 2\
MultipartonInteractions:alphaSvalue= 0.118\
MultipartonInteractions:alphaSorder= 2\
TimeShower:alphaSorder= 2\
TimeShower:alphaSvalue= 0.118\
SigmaTotal:mode = 0\
SigmaTotal:sigmaEl = 21.89\
SigmaTotal:sigmaTot = 100.309\
PDF:pSet= LHAPDF6:NNPDF31_nnlo_as_0118' $OUTPUT_DIR/Cards/shower_card.dat

# Step 3: Launch with desired parameters
$MGPATH/bin/mg5_aMC <<EOF
launch $OUTPUT_DIR
#1
madspin=ON
shower=PYTHIA8

set ebeam 6800
set pdlabel = lhapdf
set lhaid = 303600
set nevents 10000
set ickkw 3
set nsplit_jobs = 1
set njmax 2
set qcut 40
set mt = 172.5
set ymt = 172.5
set wt = AUto
set reweight_pdf = True
set store_rwgt_info = True
set jetradius = 1
set ptj = 20
set etaj = 2.5
set ptl = 20
set etal = 2.5
set etagamma = 2.5
edit madspin_card --line_position=16 set Nevents_for_max_weight 250
set iseed $SEED
EOF

echo "Job completed locally: $OUTPUT_DIR"

#===============================
# Step 4: Copy results back to EOS
#===============================
FINAL_DEST=$EOS_DIR_OUT/$PROC_DIR/$OUTPUT_DIR
mkdir -p $FINAL_DEST

echo "Copying results to EOS..."
cp -r $TMP_DIR/$OUTPUT_DIR/* $FINAL_DEST/

# Optionally compress
# tar -czf $FINAL_DEST/${OUTPUT_DIR}.tar.gz -C $TMP_DIR $OUTPUT_DIR

# Clean up
echo "Cleaning up temporary files..."
rm -rf $TMP_DIR

echo "Completed process: $OUTPUT_DIR with seed $SEED"
