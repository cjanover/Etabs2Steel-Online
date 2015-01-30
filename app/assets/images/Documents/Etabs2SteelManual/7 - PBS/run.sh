#!/bin/bash
WORKDIR=$PBS_O_WORKDIR
GACC=ShakeOut_GACC_DT_0.005
BLDG=`basename $WORKDIR`
STEEL_VER=steel-v1_6

echo $BLDG
echo $WORKDIR

declare -a hosts
cat $PBS_NODEFILE > $WORKDIR/hosts
HOSTS=`cat $WORKDIR/hosts`
echo $HOSTS >$WORKDIR/h

read -a hosts < $WORKDIR/h
element_count=${#hosts[@]}
echo $element_count

rm -f $WORKDIR/*.lock

#Uncoment this line to clear all analysis results before starting. client.sh will only run ground motion if the output folder for that ground motion doesnt exist
rm -rf $WORKDIR/output/*
mkdir -p $WORKDIR/output

sleep 20

#If you want to run every ground motion uncoment this line. It will refresh jobfile with every groundmotion in ShakeOut_files. Otherwise fill jobfile with the motions you want to run
cp $WORKDIR/ShakeOut_files $WORKDIR/jobfile

index=0
while [ "$index" -lt "$element_count" ]
do
  ssh -XY ${hosts[$index]} $WORKDIR/./client.sh $BLDG $GACC $WORKDIR $STEEL_VER&
  echo running $index on ${hosts[$index]}
  let "index = $index + 1"
  sleep 0.1
done
wait
