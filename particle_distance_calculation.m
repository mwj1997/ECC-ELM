function [D]=particle_distance_calculation(particle_sigma)

% Function: calculate the distance between each particle
% Inputs:
%       particle_sigma          - the sigma vector of particles
% Outputs:
%       D                       - the distance martix

n_particle=size(particle_sigma,1);
for i=1:n_particle
    for j=1:n_particle
        D(i,j)=sqrt((particle_sigma(j,:)-particle_sigma(i,:))*(particle_sigma(j,:)-particle_sigma(i,:))');
    end
end