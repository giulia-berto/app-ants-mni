[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.202-blue.svg)](https://doi.org/10.25663/brainlife.app.202)

# app-ants-mni
This App computes a non-linear registration of a .tck file in MNI space using the Advanced Normalization Tools (ANTs) algorithm. First, a non-linear warp is computed to register the T1 image to the template image, which is the MNI152 T1 at 1.25 mm. Then, the same transformation is applied to the .tck file. For this reason it is important that the T1 image and the .tck file (and the mask, if provided) are in the same anatomical space.

### Authors
- Giulia Bertò (giulia.berto.4@gmail.com)

### Contributors
- Paolo Avesani (avesani@fbk.eu)

### Funding Acknowledgement
brainlife.io is publicly funded and for the sustainability of the project it is helpful to Acknowledge the use of the platform. We kindly ask that you acknowledge the funding below in your publications and code reusing this code.

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations
We kindly ask that you cite the following articles when publishing papers and code using this code. 

1. Avants, B.B., Epstein, C.L., Grossman, M., Gee, J.C., 2008. [Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain.](https://www.sciencedirect.com/science/article/pii/S1361841507000606) Med. Image Anal. 12 (1), 26–41. doi: 10.1016/j.media.2007.06.004.

2. Avesani, P., McPherson, B., Hayashi, S. et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6, 69 (2019). [https://doi.org/10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Running the app
### On [Brainlife.io](http://brainlife.io/) 
You can submit this App online at https://doi.org/10.25663/brainlife.app.202 via the “Execute” tab.

Inputs: \
A .tck file and a T1 image, in the same anatomical space. Optionally, you can provide also a brain mask, in the same anatomical space. If the mask is not provided, the Brain Extraction Tool (BET) algorithm will be used for brain extraction.

Outputs: \
This App produces 3 outputs. The main output of this App is (i) the .tck file in MNI space. Other outputs are (ii) the warp and the inverse-warp used for the registration, and (iii) the T1 in MNI space.

### Running locally
1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files:
```
{
    "track": "./track.tck",
    "t1": "./t1.nii.gz",
    "mask": "./mask.nii.gz"
}
```
3. Launch the App by executing `main`.
```
./main
```

#### Dependencies
This App only requires [singularity](https://sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies:
* ANTs >=2: https://github.com/ANTsX/ANTs
* FSL >=5: https://fsl.fmrib.ox.ac.uk/fsl/fslwiki
* MRtrix >=3: https://www.mrtrix.org/

#### MIT Copyright (c) 2020 Bruno Kessler Foundation (FBK)
