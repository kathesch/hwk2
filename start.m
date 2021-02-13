clear all; close all;

%% Read data from input *.xyz file

% Input file with atom/molecule coordinates
coordinates = fopen('FCC_Ar.xyz','r');

% First line of .xyz file
tline = fgetl(coordinates);

% Number of particles
nParticles = str2num(tline);

% Header with some extra information
header = fgetl(coordinates);

% Array to store atom coordinates
r = zeros(nParticles,3);

% Read coordinates into arrays
tline = fgetl(coordinates);
j = 1;
while ischar(tline) 
    % First entry contains atom label, skip and store rest
    A = sscanf(tline,'%*s %f %f %f \n');
    r(j,:) = A;
    tline = fgetl(coordinates);
    j = j+1;
end
fclose(coordinates);

%% Parameters for Argon
sigma = 3.4; %Angstrom
epsilon = 1.67*10^-21; %J
mass = 6.63*10^-26; %kg

%% LJ potential for solid Argon in terms of dimensionless coordinates
vLJ = LJ_Potential(r./sigma,nParticles)

%% Write data into an output *.xyz file

output = fopen('final_configurations.xyz','w');

% Write total number of particles in the system 
fprintf(output,'%d \n',nParticles);

% Write header information
fprintf(output,'%s \n',header);

%Write all the coordinate info
for j = 1:nParticles
    fprintf(output,'%s %f %f %f \n','Ar',r(j,:));
end

%Note: You can repeat this loop to make a movie to be visualized with VMD
%as we discussed in class; Have fun with it!

fclose(output);

