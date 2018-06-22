# A Sandbox for Oracle Cloud Infrastructure
**Purpose:** 
I have made this sample to support you to try out new en stuff and learn more. It is not for production is only for training and trying out. 
Instead of to build and environment each time via the UI. Then save time by using the basic foundation to setup what is need to trying out and learn.

## Overview of the simple foundation
The foundation have some basic component.
* 1 Bastion Host (openssh)
* 1 Management Host
* 1 Virtual Cloud Network (VCN)
* 2 Subnet, 1 Public Subnet and 1 Private Subnet
* Route Table
* Security List
* Internet Gateway

![alt tag](http://www.biks.net/wp-content/uploads/2018/06/oci_demo_env-1.png "Overview")

## You like to start?
1st you need is to edit the ent.bat file, works for windows. Change the values so it fit you cloud.

2nd you need to create a key for the user, and add the public part of it you user API key in the console. Put the pem key in the .oci folder

3rd create ssh keys, so can access the instances after they have been creatd. Put thee ssh keys in the .ssh folder

Now you should be ready to go


### If like to do more changes?
Then please have a look in the variables.tf file. Here you can change more settings.