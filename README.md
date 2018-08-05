# Pattern Recognition Exercises

These are my solutions to the exercises for the pattern recognition class in SS2018 at TU Munich.

## Exercise 2
This exercise is about performance metrics in pattern recognition. The exercise discusses *Receiver Operating Characteristic (ROC) Curve*, *Precision Recall Curve (PRC)* and cost based evaluation of a binary classifier on 2 gaussian class distributions.

## Exercise 3
Bayesian classification and feature analysis are the topics for this exercise.

We were presented with data of disease symptoms and the assigned classes of disease. We first had to visually analyse the data by plotting histograms and identified the underlying distribution functions. Either by extracting the relevant parameters (e.g. mean and standard deviation) or by treating the histogram as the underlying *probability density function (pdf)*.

The next task was to implement a bayesian classifier that uses the distribution functions from task 1 and considers the known class distributions (given in the problem description) as prior information.

The bayesian classifier is optimal with respect to the conditional risk. The last task was to visualise the conditional risk that we face for a sample based on the *zero-one loss* with respect to two of the parameters (the result is one pretty surface plot).

## Exercise 6
This exercise was kind of lame. There wasn't much todo besides filling out three very small blocks of code but the underlying concepts are quite interesting.

The idea of exercise 6 is to use a concept called bayesian inference or bayesian learning to efficiently estimate a *psychometric function* - a type of function that models the relationship between a physical stimulus and forced-choice responses of human testees (Wikipedia) - applied to human vision examination. Psychometric functions are represented by a threshold T, which is the magnitude of the stimulus where the probability of a correct response is greater than 75 %. The aim is to find the threshold with the maximal probability given the set of responses.

$$max~p(T|\vec{R}).$$

We start with a set of psychometric functions with thresholds in a discrete range and simulate a forced-test with a stimulus placed at the threshold of a randomly selected function in the set. We calculate the probability of the response R given the threshold for each model

$$p(R|T)$$

and apply Bayes' theorem

$$p(T|R) = \frac{p(R|T) \cdot p(T)}{p(R)}.$$

The denominator is only required for normalisation and can be replaced by normalising the term in the numerator to a sum of 1. We could stop here and find the maximum of $p(T|R)$ but the strength of bayesian inference lies in recursive application of Bayes' theorem. $p(T)$ is unknown in the first iteration and can only be guessed (e.g. by assuming a uniform distribution). In the next iteration however, we can use the result of the previous step as prior information to the next step but we have to make a few modifications to the formula first

$$p(T|R) = \frac{p_n(R|T) \cdot p_{n-1}(T)}{p_n(R)} \Leftarrow p_n(R|T) = p_{n-1}(R|T) \cdot p(R_n|T)$$

where $p_n$ is the probability in the n-th iteration and $R_n$ is the response in the n-th iteration. $p_n(R|T)$ is the likelihood of all responses that were acquired until this iteration. We do some math and get the following expressions.

$$p(T|R) = \frac{p_{n-1}(R|T) \cdot p(R_n|T) \cdot p_{n-1}(T)}{p_n(R)} \leftarrow p_{n-1}(R|T) = \frac{p_{n-1}(T|R) \cdot p_{n-1}(R)}{p_{n-1}(T)}\Leftrightarrow$$

$$p(T|R) = \frac{p_{n-1}(T|R) \cdot p_{n-1}(R) \cdot p(R_n|T)}{p_n(R)} \Leftarrow \frac{p_{n-1}(R)}{p_n(R)} = \frac{1}{p(R_n)} \Leftrightarrow$$

We use the *law of total probability* to derive the marginal probability $p(R_n)$

$$p(T|R) = \frac{p_{n-1}(T|R) \cdot p(R_n|T)}{p(R_n)} \Leftarrow p(R_n) = \sum_T p(R_n|T) \cdot p_{n-1}(T)$$

or we could just neglect $p(R_n)$, because it's the same for all models, and normalise $p(T|R)$ to a sum of 1, which we do in the exercise because it leads to the same result anyway.

We do this recursion for a number of iterations that is acceptable - we do 200 in the exercise - and plot the result.

## Exercise 8
This exercise featured one of the most popular clustering algorithms called *k-means* or *vector quantisation*.

Clustering algorithms aim to reveal structure in the data by finding suitable class centres that result in a low reconstruction or classification error of the test data. The topic for this exercise was to implement k-means which is an iterative clustering algorithm that is guaranteed to converge eventually.

We start by defining a set of starting class centres - or codebook vectors. I randomly select some of the data points for that purpose. The next step is to find the nearest codebook vector for each data point which associates it with one of the codebook vectors. The last step is to move each codebook vector into the centroid - the mean in the feature space - of the associated data points. The algorithm finishes when no codebook vector has moved more than a threshold.
