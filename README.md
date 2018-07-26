# Pattern Recognition Exercises

These are my solutions to the exercises for the pattern recognition class in SS2018 at TU Munich.

## Exercise 2
This exercise is about performance metrics in pattern recognition. The exercise discusses *Receiver Operating Characteristic (ROC) Curve*, *Precision Recall Curve (PRC)* and cost based evaluation of a binary classifier on 2 gaussian class distributions.

## Exercise 3
Bayesian classification and feature analysis are the topics for this exercise.

We were presented with data of disease symptoms and the assigned classes of disease. We first had to visually analyse the data by plotting histograms and identified the underlying distribution functions. Either by extracting the relevant parameters (e.g. mean and standard deviation) or by treating the histogram as the underlying *probability density function (pdf)*.

The next task was to implement a bayesian classifier that uses the distribution functions from task 1 and considers the known class distributions (given in the problem description) as prior information.

The bayesian classifier is optimal with respect to the conditional risk. The last task was to visualise the conditional risk that we face for a sample based on the *zero-one loss* with respect to two of the parameters (the result is one pretty surface plot).
