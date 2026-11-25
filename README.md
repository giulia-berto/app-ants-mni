[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.202-blue.svg)](https://doi.org/10.25663/brainlife.app.202)

# app-ants-mni

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Registers a .tck tractogram and its T1-weighted image to the MNI152 1.25 mm template with an ANTs SyN non-linear warp, outputting the warped tractogram, the warped T1 and the warp fields.**

Skull-strips the T1 with FSL bet (or applies the provided brain mask), computes an ANTs SyN warp from the T1 to the MNI152 T1 1.25 mm brain template, applies it to the tractogram with MRtrix3 tcktransform and to the T1. Use it to bring tractograms into MNI space for template-based bundle segmentation. All inputs must be in the same anatomical space and come from the same subject; the App checks the subject IDs and stops if they differ.

| | |
|---|---|
| 📥 **Inputs** | `neuro/track/tck` · `neuro/anat/t1w` · `neuro/mask` (optional) |
| 📤 **Outputs** | `neuro/track/tck` · `neuro/transform/nifti` · `neuro/anat/t1w` |
| 🐳 **Container** | `giuliaberto/ants2-mrtrix3-fsl6:1.1` |
| ⚙️ **Resources** | 16 CPUs · 1 h walltime |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.202](https://doi.org/10.25663/brainlife.app.202) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `0` | `neuro/track/tck` | yes | Tractogram to register |
| `1` | `neuro/anat/t1w` (acpc_aligned) | yes | T1 to use for the transformation |
| `2` | `neuro/mask` (acpc_aligned) | no | Brain mask (if not provided, the BET algorithm will be used) |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `track_aligned` | `neuro/track/tck` | Tractogram registered in MNI space |
| `warps` | `neuro/transform/nifti` | warp and inverse-warp used for the registration |
| `t1_aligned` | `neuro/anat/t1w` | T1 registered in MNI space |

📚 **References used by this App:**
- Avants BB, Epstein CL, Grossman M, Gee JC. Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain. Medical Image Analysis 12(1):26-41 (2008).
- Avesani P et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. Sci Data 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

<!-- brainlife-app:end -->

This App computes a non-linear registration of a .tck file in MNI space using the Advanced Normalization Tools (ANTs) algorithm. First, a non-linear warp is computed to register the T1 image to the template image, which is the MNI152 T1 at 1.25 mm. Then, the same transformation is applied to the .tck file. For this reason it is important that the T1 image and the .tck file (and the mask, if provided) are in the same anatomical space.

### Authors
- Giulia Bertò (giulia.berto.4@gmail.com)

### Contributors
- Paolo Avesani (avesani@fbk.eu)

### Funding Acknowledgement
We kindly ask that you acknowledge the funding below in your publications and code reusing this code. \
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-AOC-1916518](https://img.shields.io/badge/NSF_AOC-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)

### Citation
We kindly ask that you cite the following article when publishing papers and code using this code: \
Avants, B.B., Epstein, C.L., Grossman, M., Gee, J.C., 2008. [Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain.](https://www.sciencedirect.com/science/article/pii/S1361841507000606) Med. Image Anal. 12 (1), 26–41. doi: 10.1016/j.media.2007.06.004.

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
