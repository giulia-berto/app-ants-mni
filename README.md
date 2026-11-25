<h1 align="center">ANTs tractogram registration in MNI space</h1>

<p align="center">
  Registers a .tck tractogram and its T1-weighted image to the MNI152 1.25 mm template with an ANTs SyN non-linear warp, outputting the warped tractogram, the warped T1 and the warp fields.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.202"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.202-blue.svg" alt="Run on brainlife.io"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Registers a .tck tractogram and its T1-weighted image to the MNI152 1.25 mm template with an ANTs SyN non-linear warp, outputting the warped tractogram, the warped T1 and the warp fields.**

Skull-strips the T1 with FSL bet (or applies the provided brain mask), computes an ANTs SyN warp from the T1 to the MNI152 T1 1.25 mm brain template, applies it to the tractogram with MRtrix3 tcktransform and to the T1. Use it to bring tractograms into MNI space for template-based bundle segmentation. All inputs must be in the same anatomical space and come from the same subject; the App checks the subject IDs and stops if they differ.

| | |
|---|---|
| **Inputs** | `neuro/track/tck` · `neuro/anat/t1w` · `neuro/mask` (optional) |
| **Outputs** | `neuro/track/tck` · `neuro/transform/nifti` · `neuro/anat/t1w` |
| **Container** | `giuliaberto/ants2-mrtrix3-fsl6:1.1` |
| **Resources** | 16 CPUs · 1 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.202](https://doi.org/10.25663/brainlife.app.202) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `0` | `neuro/track/tck` | yes | Tractogram to register |
| `1` | `neuro/anat/t1w` (acpc_aligned) | yes | T1 to use for the transformation |
| `2` | `neuro/mask` (acpc_aligned) | no | Brain mask (if not provided, the BET algorithm will be used) |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `track_aligned` | `neuro/track/tck` | Tractogram registered in MNI space |
| `warps` | `neuro/transform/nifti` | warp and inverse-warp used for the registration |
| `t1_aligned` | `neuro/anat/t1w` | T1 registered in MNI space |

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.202](https://doi.org/10.25663/brainlife.app.202), choose `neuro/track/tck`, `neuro/anat/t1w`, `neuro/mask` from your project and press **Execute**. The results are saved to your project as `neuro/track/tck`, `neuro/transform/nifti`, `neuro/anat/t1w`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `giuliaberto/ants2-mrtrix3-fsl6:1.1`), [`jq`](https://jqlang.github.io/jq/).

1. Clone this repository.
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "track": "/path/to/0/track",
       "t1": "/path/to/1/t1",
       "mask": "/path/to/2/mask"
   }
   ```

3. Run `./main`.

## Troubleshooting

- **Inputs subject IDs incorrectly inserted. Check them again.**: Select inputs from the same subject.
- **Transformation failed.**: Check the T1 image and brain extraction.

## On [Brainlife.io](http://brainlife.io/)

You can submit this App online at https://doi.org/10.25663/brainlife.app.202 via the “Execute” tab.

Inputs: \
A .tck file and a T1 image, in the same anatomical space. Optionally, you can provide also a brain mask, in the same anatomical space. If the mask is not provided, the Brain Extraction Tool (BET) algorithm will be used for brain extraction.

Outputs: \
This App produces 3 outputs. The main output of this App is (i) the .tck file in MNI space. Other outputs are (ii) the warp and the inverse-warp used for the registration, and (iii) the T1 in MNI space.

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- ANTs tractogram registration in MNI space. brainlife.io App. [doi:10.25663/brainlife.app.202](https://doi.org/10.25663/brainlife.app.202)
- Avants BB, Epstein CL, Grossman M, Gee JC. Symmetric diffeomorphic image registration with cross-correlation: evaluating automated labeling of elderly and neurodegenerative brain. Medical Image Analysis 12(1):26-41 (2008).
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Tournier et al. MRtrix3: A fast, flexible and open software framework for medical image processing and visualisation. *NeuroImage* 202:116137 (2019). [doi:10.1016/j.neuroimage.2019.116137](https://doi.org/10.1016/j.neuroimage.2019.116137)
- Avants et al. A reproducible evaluation of ANTs similarity metric performance in brain image registration. *NeuroImage* 54:2033-2044 (2011). [doi:10.1016/j.neuroimage.2010.09.025](https://doi.org/10.1016/j.neuroimage.2010.09.025)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Giulia Bertò

**Contributors**

- Paolo Avesani

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io, which runs this App, is publicly funded by Wellcome, the U.S. National Institutes of Health and the U.S. National Science Foundation; acknowledging that support helps keep it running.</sub>
