# rank-aggregation
Comparison of several algorithms for rank aggregation from pairwise preferences

We implement and compare several algorithms for ranking using pairwise preferences. One is given pairwise comparisons amongst a set of, for example pairwise preferences on candidates in an election, results of a sequence of pairwise games etc. The goal is to learn an ‘optimal’ ranking (assuming one exists), for various pairwise comparison models. We compare the number of pairwise comparisons each algorithm requires for learning an ‘optimal’ ranking. Please see the report for further details.

The main executable file is execute_ranking.m. By default, it runs on synthetic (randomly generated) data. To run the code on real datasets, the variable 'real' has to be set to 1 and 'importfile.m' has to be modified to extract the pairwise comparison data in the appropriate format from the source file.
