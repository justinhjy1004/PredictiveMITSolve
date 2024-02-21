# PredictiveMITSolve

This documents the purpose/function of each script. We classify the scripts based on the broad categorical purpose it was created for. Scripts starting with *C* were written by Charles and *J* by Justin.

### Data Cleaning/Wrangling

**J00_encode.py**

Input File: `./Data/MITSolve2023.csv`
Output File; `./Data/encoded.parquet`

Rename and embed relevant columns in MIT Solve's 2023 Challenges using Sentence BERT as the emedding method.

**J01_CalculatingColumnAndPSSimilarities.ipynb**

Input Files: `./Data/encoded.parquet`, `./Data/ProblemStatements.csv`
Output File; `./Data/AggregatedColumnPairwiseSimilarity.csv`, `./Data/AggregatedColumnPairwiseSimilarity.csv`, `./Data/SimilarityToPS.csv`

The Notebook is mainly for 
1. Calculate Column Pairwise Similarity 
1. Agregate aforementioned pairwise similarity by solution
1. Calculate similarity to Problem Statement in MIT Solve

**J02_SemiFinalistEvaluation.R**

Input Files: `./Data/2023_Evaluation/Climate Adaptation.xlsx`, `./Data/2023_Evaluation/Financial Inclusion.xlsx`, `./Data/2023_Evaluation/Health in Fragile Contexts.xlsx`, `./Data/2023_Evaluation/Learning for Civic Action.xlsx`
Output File; `./Data/2023Eval.csv`

Merge all 2023 *SEMIFINALIST* evaluation ratings into a single data file. The dimensions taken were "alignment", "impact", "feasibility", "innovation", "inclusivity". 

### Data Analysis