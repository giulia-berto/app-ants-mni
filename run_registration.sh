#!/bin/bash

t1=$1
tck=$2

atlas=MNI152_T1_1.25mm_brain.nii.gz

if [ -f track_aligned/track.tck ]; then 
    echo "Tractogram already registered in MNI space."
else 
    echo "Computing warp to MNI space..."
    ./ants_t1w_transformation.sh $t1 $atlas

    mv space_MNI_var-t1w_affine.txt warp_dir
	mv space_MNI_var-t1w_warp.nii.gz warp_dir
	mv space_MNI_var-t1w4tck_warp.nii.gz warp_dir

	if [ -z "$(ls -A -- warp_dir)" ]; then    
		echo "Transformation failed."
		exit 1
	else    
		echo "Transformation done."
	fi	

	echo "Registering the tractogram to MNI space..."
	tcktransform $tck warp_dir/space_MNI_var-t1w4tck_warp.nii.gz \
	             track_aligned/track.tck -nthreads 0 -force -quiet

	if [ -z "$(ls -A -- track_aligned)" ]; then    
		echo "Tractogram registration failed."
		exit 1
	else    
		echo "Tractogram registration done."
	fi

fi

if [ -f t1_aligned/t1.nii.gz ]; then
	echo "T1 already registered in MNI space."
else
	echo "Registering the T1 to MNI space..."
	WarpImageMultiTransform 3  \
	    	$t1 \
	    	t1_aligned/t1.nii.gz \
	    	warp_dir/space_MNI_var-t1w_warp.nii.gz \
	    	warp_dir/space_MNI_var-t1w_affine.nii.txt  --use-NN

	if [ -z "$(ls -A -- t1_aligned)" ]; then    
		echo "T1 registration failed."
		exit 1
	else    
		echo "T1 registration done."
	fi    	
fi