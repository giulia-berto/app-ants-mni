#!/bin/bash

SUB_MOVE=$1
T1W_MOVE=$2
SUB_STAT=$3
T1W_STAT=$4

T1W_M=sub-${SUB_MOVE}_space-dwi_T1w.nii.gz
T1W_ANT_PRE=sub-${SUB_MOVE}_space_${SUB_STAT}_var-t1w_

#------------------------------------------------------------------------------
# ANTS Registration of structural images
#------------------------------------------------------------------------------

BRAIN_MASK=`jq -r '.mask' config.json`

# Brain extraction 
if [ $BRAIN_MASK == null ]; then
	echo "Brain extraction using BET"
	bet $T1W_MOVE $T1W_M
else
	echo "Brain extraction using mask provided"
	fslmaths $T1W_MOVE -mas $BRAIN_MASK $T1W_M
fi
T1W_S=$T1W_STAT #already without skull

# Warp Computation
ANTS 3 -m CC[${T1W_S},${T1W_M},1,5] -t SyN[0.5] \
    -r Gauss[2,0] -o $T1W_ANT_PRE -i 30x90x20 --use-Histogram-Matching

#antsRegistrationSyNQuick.sh -d 3 \
#     -f $T1W_STAT -m $T1W_MOVE -t s -o $T1W_ANT_PRE


#------------------------------------------------------------------------------
# Renaming files
#------------------------------------------------------------------------------

mv ${T1W_ANT_PRE}Warp.nii.gz ${T1W_ANT_PRE}warp.nii.gz
mv ${T1W_ANT_PRE}InverseWarp.nii.gz ${T1W_ANT_PRE}invwarp.nii.gz
mv ${T1W_ANT_PRE}Affine.txt ${T1W_ANT_PRE}affine.txt

#mv ${T1W_ANT_PRE}1Warp.nii.gz ${T1W_ANT_PRE}warp.nii.gz
#mv ${T1W_ANT_PRE}1InverseWarp.nii.gz ${T1W_ANT_PRE}invwarp.nii.gz
#mv ${T1W_ANT_PRE}0GenericAffine.mat ${T1W_ANT_PRE}affine.mat

#------------------------------------------------------------------------------
# Convert the warp for tck
#------------------------------------------------------------------------------

WARP_PRE=sub-${SUB_MOVE}_space_${SUB_STAT}_var-ant_warp
WARP_INI=sub-${SUB_MOVE}_space_${SUB_STAT}_var-ant_warp-i[].nii.gz
WARP_TMP=sub-${SUB_MOVE}_space_${SUB_STAT}_var-ant_warp-t[].nii.gz
WARP_T1W=sub-${SUB_MOVE}_space_${SUB_STAT}_var-t1w4tck_warp.nii.gz

T1W_AFF=${T1W_ANT_PRE}affine.txt
T1W_IWARP=${T1W_ANT_PRE}invwarp.nii.gz
T1W_IWARP_FIX=${T1W_ANT_PRE}InverseWarp.nii.gz

warpinit ${T1W_S} ${WARP_INI} -force -quiet
cp $T1W_IWARP $T1W_IWARP_FIX
for i in 0 1 2; do
    WarpImageMultiTransform 3 \
        ${WARP_PRE}-i${i}.nii.gz ${WARP_PRE}-t${i}.nii.gz \
        -R $T1W_S -i $T1W_AFF $T1W_IWARP_FIX
done
rm -f $T1W_IWARP_FIX
warpcorrect $WARP_TMP $WARP_T1W -force -quiet
rm ${WARP_PRE}-*
rm $T1W_M
rm $T1W_IWARP
