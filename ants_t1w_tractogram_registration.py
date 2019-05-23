"""Compute ANTS registration given the warp. 
"""

import sys
import argparse
import subprocess


if __name__ == '__main__':

	parser = argparse.ArgumentParser()
	parser.add_argument('-movID', nargs='?', const=1, default='',
	                    help='Moving subject ID')
	parser.add_argument('-tck', nargs='?', const=1, default='',
	                    help='Tractogram to register')
	parser.add_argument('-warp_dir', nargs='?', const=1, default='',
	                    help='The warp directory')                       
	args = parser.parse_args()

	print("Tractogram registration...")
	tck_filename = args.tck
	warp = '%s/sub-%s_space_MNI_var-t1w4tck_warp.nii.gz' %(args.warp_dir, args.movID)
	out_filename = 'track.tck'
	subprocess.check_call(['tcknormalise', tck_filename, warp, out_filename, '-nthreads', '0', '-force', '-quiet'])
	print("ANTs registration done.")

	sys.exit()    
