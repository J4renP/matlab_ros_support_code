%% Part C of Homework 09
% Jaren Josh & Joel
%% Initial ROS setup
clc
clear
rosshutdown;

masterhostIP = "192.168.42.128"; % assigning IP address to a variable allows more compatibility when sharing files with teammates
rosinit(masterhostIP)

%% Reset robot arm
% Here we will reset to the ready position
goHome('qr');
resetWorld;

%% The actual exciting stuff (picking up the 1st item)
models = getModels; % Load gazebo models through an action client

% First we will attempt to pick up green can 1
model_name = models.ModelNames{20};

[mat_R_T_G, mat_R_T_M] = get_robot_object_pose_wrt_base_link(model_name) % Call function to determine object pose, but with respect to what we need it to be

% Use a topdown picking strategy
strategy = 'topdown';
ret = pick(strategy, mat_R_T_M); % Call function to move grippers onto object and close grippers


% Define positions of the different bins
blueBin = [0.4, -0.45, 0.25, -pi/2, -pi 0];
greenBin = [-0.4, -0.45, 0.25, -pi/2, -pi 0];

% if statement checks to make sure robot is not trying to move where it already is
if ~ret
    place_pose = set_manual_goal(greenBin);
    strategy = 'topdown';
    ret = moveToBin(strategy,mat_R_T_M,place_pose);
end
% Boom! you just moved the first item


%% moving red can 2 to validate picking up green can 2
% (can be deleted whenever codes are combined)
goHome('qr')
model_name = models.ModelNames{25};
[mat_R_T_G, mat_R_T_M] = get_robot_object_pose_wrt_base_link(model_name)
ret = pick(strategy, mat_R_T_M);
if ~ret
    place_pose = set_manual_goal(greenBin)
    strategy = 'topdown';
    ret = moveToBin(strategy,mat_R_T_M,place_pose)
end

%% 2nd item
% the functions here are the same as seen above. Thus, we'll move a little faster through this section

% we will pick up green can 3
model_name = models.ModelNames{22}

% call function to determine the desired object's pose
[mat_R_T_G, mat_R_T_M] = get_robot_object_pose_wrt_base_link(model_name)

strategy = 'topdown';
ret = pick(strategy, mat_R_T_M);

if ~ret
    place_pose = set_manual_goal(greenBin)
    strategy = 'topdown';
    ret = moveToBin(strategy,mat_R_T_M,place_pose)
end
% Let's go! You just moved the second item into the bin

%% 3rd item
% again, these are the same functions used previously
goHome('qr')

% next we will pick up green can 4
model_name = models.ModelNames{23}

[mat_R_T_G, mat_R_T_M] = get_robot_object_pose_wrt_base_link(model_name)

strategy = 'topdown';
ret = pick(strategy, mat_R_T_M);

if ~ret
    place_pose = set_manual_goal(greenBin)
    strategy = 'topdown';
    ret = moveToBin(strategy,mat_R_T_M,place_pose)
end
% You just picked up the last item. Congrats!