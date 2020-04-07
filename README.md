# Probability-Density-Rank-based-Quantization
## Abstract
The distributions of input data are very important for learning machines, such as the Convex Universal Learning Machines (CULMs). The CULMs are a family of universal learning machines with convex optimization. However, the computational complexity is a crucial problem in CULMs because the dimension of the nonlinear mapping layer (the hidden layer) of the CULMs is usually rather large in complex system modeling. In this paper, we propose an efficient quantization method called Probability density Rank based Quantization (PRQ) to decrease the computational complexity of CULMs. The PRQ ranks the data according to the estimated probability densities, and then selects a subset whose elements are equally spaced in the ranked data sequence. We apply the PRQ to kernel ridge regression (KRR) and random Fourier feature recursive least squares (RFF-RLS), which are two typical algorithms of CULMs. The proposed method not only keeps the similarity of data distribution between the code book and data set, but also reduces the computational cost by using the kd-tree. Meanwhile, for a given data set, the method yields deterministic quantization results, and it can also exclude the outliers and avoid too many borders in the code book. This brings great convenience to practical applications of the CULMs. The proposed PRQ is evaluated on several real-world benchmark data sets. Experimental results show satisfactory performance of PRQ compared with some state-of-the-art methods.

## Dome 1：
We domestrate PRQ quantization process generating five code vectors:
![image](https://github.com/ZhengdQin/Probability-Density-Rank-based-Quantization/tree/master/demo1/PRQ.pdf)

## Dome 2:
we compare PRQ with several quantization algorithms on 2-D mixture Gaussian data, and show the corresponding MMD values.

## Language
Matlab
## Cite
If you use this code, please cite the following paper:

@article{qin2019probability,
  title={Probability Density Rank-Based Quantization for Convex Universal Learning Machines},
  author={Qin, Zhengda and Chen, Badong and Gu, Yuantao and Zheng, Nanning and Principe, Jose C},
  journal={IEEE transactions on neural networks and learning systems},
  year={2019},
  publisher={IEEE}
}
