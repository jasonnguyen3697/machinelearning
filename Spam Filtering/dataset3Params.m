function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_test = [0.01 0.03 0.1 0.3 1 3];
sigma_test = [0.01 0.03 0.1 0.3 1];
error = [];
C1 = 0;
sigma1 = 0;
for i = 1:length(C_test)
  C1 = C_test(i);
  for j = 1:length(sigma_test)
    sigma1 = sigma_test(j);
    model = svmTrain(X, y, C1, @(x1, x2)gaussianKernel(x1, x2, sigma1), 1e-4, 30);
    predictions = svmPredict(model, Xval);
    error(j + (length(sigma_test)*(i-1))) = mean(double(predictions ~= yval))
  endfor
endfor

[x, ix] = min(error)
sigma = sigma_test(mod(ix, length(sigma_test)))
C = C_test(floor(ix/length(sigma_test))+1);





% =========================================================================

end
