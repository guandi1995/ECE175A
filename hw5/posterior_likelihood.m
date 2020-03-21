function likelihood=posterior_likelihood(x1,x2,cov,mu)

constant=1./(2*pi*sqrt(det(cov)));
%gaussian distribution
likelihood=constant*exp(-0.5*([x1;x2]-mu)'*inv(cov)*([x1;x2]-mu));
end