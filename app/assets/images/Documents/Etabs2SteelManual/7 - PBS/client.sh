#!/bin/bash

#takes three arguments
# 1) Name of the folder containing model information
# 2) Name of the ground acceleration dataset to run
# 3) Path to Working Directory
# 4) Name of the version of steel to run

BLDG=$1

COMMON=$3
STEEL_NAME=$4
SCRATCH=/scratch/cjanover/Models/Pushover/$BLDG
DATADIR=/home/cjanover/Steel/GACC/$2
STEEL=/home/cjanover/Steel/Steel_Software/Compiled/$STEEL_NAME

declare -a jobs

JOBFILE=$COMMON/jobfile
nremjobs=1

while [ "$nremjobs" -gt 0 ]
do
{
  lockfile -r-1 $JOBFILE.lock
  jobid=`head -1 $JOBFILE`
  T=`wc -l $JOBFILE | awk '{print $1}'`
  let "T = $T -1"
  tail -$T $JOBFILE > $JOBFILE.new
  mv $JOBFILE.new $JOBFILE
  rm -f $JOBFILE.lock

  if [ ! -d $COMMON/output/$jobid ]; then
    mkdir -p $SCRATCH/$jobid
    cp -r $COMMON/input/* $SCRATCH/$jobid
    cp -r $DATADIR/$jobid.bz2.tar $SCRATCH/$jobid
    cp $DATADIR/zeros $SCRATCH/$jobid
    cp $STEEL $SCRATCH/$jobid

    cd $SCRATCH/$jobid
    tar -xjf $jobid.bz2.tar
    rm $jobid.bz2.tar

    NP1=`wc for090 | awk '{print $2}'`
    NP3=`wc zeros | awk '{print $2}'`

    let "NP2 = $NP1 + $NP3"

    sed 's/'"$NP1"'/'"$NP2"'/g' <for090 > junk
    cat junk zeros > for002

    sed 's/'"$NP1"'/'"$NP2"'/g' <for092 > junk
    cat junk zeros > for003

    rm for09*

    sed 's/ASNI4/'"$NP2"'/' < for001 > hestur
    mv hestur for001

    sed 's/ASNI3/'"$NP2"'/' < for001 > hestur
    mv hestur for001

    echo $NP2 > DSTPSTOT

    RAN=`date +%N | cut -c1-2`
    ISEED=1000$RAN
    echo $ISEED > for029

    ./$STEEL_NAME

    rm -f $STEEL_NAME junk zeros

    gzip *
    cp -r $SCRATCH/$jobid $COMMON/output/$jobid
    sleep 10
    cd
    rm -rf $SCRATCH/$jobid
  fi

  lockfile -r-1 $JOBFILE.lock
  nremjobs=`wc -l $JOBFILE | awk '{print $1}'`
  rm -f $JOBFILE.lock
  echo $nremjobs
}
done


