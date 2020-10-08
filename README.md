[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.202-blue.svg)](https://doi.org/10.25663/brainlife.app.202)

# app-ants-mni
This App computes a non-linear registration of a .tck file in MNI space using the Advanced Normalization Tools (ANTs) algorithm. First, a non-linear warp is computed to register the T1 image to the template image, which is the MNI152 T1 at 1.25 mm. Then, the same transformation is applied to the .tck file. For this reason is important that the T1 image and the .tck file (and the mask, if provided) are in the same anatomical space.

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
