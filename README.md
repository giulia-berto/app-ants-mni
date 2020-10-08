[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.202-blue.svg)](https://doi.org/10.25663/brainlife.app.202)

# app-ants-mni
This App computes a non-linear registration of a .tck file in MNI space using Advanced Normalization Tools (ANTs). First, a non-linear warp is computed to register the T1 image to the template image, which is the MNI152 T1 at 1.25 mm. Then, the same transformation is applied to the .tck file. For this reason is important that the T1 image and the .tck file (and the mask if provided) are in the same anatomical space.

