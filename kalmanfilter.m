%%%%kalman filter
clear;
%clc;
currentFolder = pwd;
path = "/Users/zouyao/Documents/NEUfiles/MachineLearning/Exam2/Q2train.csv";
testpath = "/Users/zouyao/Documents/NEUfiles/MachineLearning/Exam2/Q2test.csv";
data = csvread(path);
datatest = csvread(testpath);
figure(1)
plot(data(:,2),data(:,3),'--o');
xlabel('measurement h')
ylabel('measurement b')
grid on

index =1;


K = 10.^linspace(-5,5);
S = 10.^linspace(-5,5);
for n = 1:size(K,2)
    for m = 1:size(S,2)
W = K(n)*eye(6);
Q = S(m)*eye(2);
t = 2;
H = [1 t 1/2*t^2; 0 1 t; 0 0 1];
B = [1 t 1/2*t^2; 0 1 t; 0 0 1];



A = [H zeros(3,3); zeros(3,3) B];
C = [1 0 0 0 0 0; 0 0 0 1 0 0];

    kalmanData.A = A;
    kalmanData.C = C;
    kalmanData.W = W;
    kalmanData.Q = Q;
    kalmanData.t = t;
    kalmanData.x = [0 0 0 0 0 0]';
    kalmanData.z =[0 0]';
    kalmanData.P=eye(6);
    kalmanData.z = data(:,2:3)';
    kalmanData = kalmanfunction(kalmanData);
    
    estimator = 1/2*(kalmanData.x(:,2:end)+kalmanData.x(:,1:end-1));
    error = sqrt((estimator(1,2:end)'-datatest(1:end-1,2)).^2 + (estimator(4,2:end)'-datatest(1:end-1,3)).^2);
    meanserror(n,m) = sum(error)/99;
    end
end
meanserror = meanserror';
figure
[K,S] = meshgrid(K,S);
K=log10(K);
S=log10(S);
minerror = min(meanserror,[],'all');
[findI,findJ] = find(meanserror(:,:)==minerror);
contour(K,S,meanserror,100);
hold on
plot(K(1,findJ),S(findI,1),'r*');
xlabel("measurement K in log10")
ylabel("measurement S in log10")
legend('contour of the error','min error point')



W = 1*eye(6);
Q = 1*eye(2);
t = 2;
H = [1 t 1/2*t^2; 0 1 t; 0 0 1];
B = [1 t 1/2*t^2; 0 1 t; 0 0 1];



A = [H zeros(3,3); zeros(3,3) B];
C = [1 0 0 0 0 0; 0 0 0 1 0 0];

    kalmanData.A = A;
    kalmanData.C = C;
    kalmanData.W = W;
    kalmanData.Q = Q;
    kalmanData.t = t;
    kalmanData.x = [0 0 0 0 0 0]';
    kalmanData.z =[0 0]';
    kalmanData.P=eye(6);
    kalmanData.z = data(:,2:3)';
    kalmanData = kalmanfunction(kalmanData);

estimator = 1/2*(kalmanData.x(:,2:end)+kalmanData.x(:,1:end-1));

figure
scatter(data(:,2),data(:,3));
hold on
scatter(datatest(:,2),datatest(:,3));

plot(kalmanData.x(1,:),kalmanData.x(4,:),'--o');
plot(estimator(1,:),estimator(4,:),'--*');
xlabel("measurement h ")
ylabel("measurement b")
legend('training data','testing data','kalman output','estimated time sequence')
title('for K = 1 and S =1')


