function s = kalmanfunction(s)

 % This is the code which implements the discrete Kalman filter:
   
    iteration = size(s.z,2);
   % Prediction for state vector and covariance:
   for i =1:iteration
   s.x(:,i+1) = s.A*s.x(:,i);
   s.P = s.A * s.P * s.A' + s.W;
   % Compute Kalman gain factor:
   K = s.P*s.C'*inv(s.C*s.P*s.C'+s.Q);
   % Correction based on observation:
   s.x(:,i+1) = s.x(:,i+1) + K*(s.z(:,i)-s.C*s.x(:,i+1));
   s.P = s.P - K*s.C*s.P;
   end
  
end

function s = kalmanfunction(s)

 % This is the code which implements the discrete Kalman filter:
   
    iteration = size(s.z,2);
   % Prediction for state vector and covariance:
   for i =1:iteration
   s.x(:,i+1) = s.A*s.x(:,i);
   s.P = s.A * s.P * s.A' + s.W;
   % Compute Kalman gain factor:
   K = s.P*s.C'*inv(s.C*s.P*s.C'+s.Q);
   % Correction based on observation:
   s.x(:,i+1) = s.x(:,i+1) + K*(s.z(:,i)-s.C*s.x(:,i+1));
   s.P = s.P - K*s.C*s.P;
   end
  
end