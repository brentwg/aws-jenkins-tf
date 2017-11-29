#!/bin/bash

# Add instance to the ECS cluster
echo "Adding instance to the ECS cluster"
echo "ECS_CLUSTER=${ecs_cluster_name}" >> /etc/ecs/ecs.config

# Update YUM repo
yum check-update

# Install NFS client required packages
echo "Installing NFS client required packages"
yum -y install nfs-utils bind-utils

# Create EFS mount mount point
echo "Creating the EFS mount point"
cd /; mkdir ${efs_mountpoint}

# Wait for EFS DNS to propagate
echo "Checking to see if EFS DNS is ready"
nslookup ${efs_filesystem_id}.efs.${aws_region}.amazonaws.com 
while [ $? -ne 0 ] 
do 
  sleep 10 
  echo "Waiting for EFS dns to propagate" 
  nslookup ${efs_filesystem_id}.efs.${aws_region}.amazonaws.com 
done

# Check to see if EFS is already mounted
echo "Checking to see if EFS is already mounted"
df -k | grep "${efs_filesystem_id}"

# If it is, don't remount...
echo "Mounting EFS file system, if necessary"
if [ $? -eq 0 ]; then
  echo "NFS mount ${efs_filesystem_id}.efs.${aws_region}.amazonaws.com already exists. No need to mount"
else
  mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 ${efs_filesystem_id}.efs.${aws_region}.amazonaws.com:/ ${efs_mountpoint}
fi

# Check for correct mount point directory ownership
echo "Checking to see that mount point ownership is correct"
ls -ln / | grep "${efs_mountpoint}" | grep "${efs_mountpoint_owner}"
if [ $? -eq 0 ]; then
  echo "${efs_mountpoint_owner} already own ${efs_mountpoint}"
else
  chown ${efs_mountpoint_owner} ${efs_mountpoint} 
fi

# Check if /etc/fstab has been modified
echo "Modifying /etc/fstab, if necessary"
cat /etc/fstab | grep "${efs_filesystem_id}"
if [ $? -eq 0 ]; then
  echo "NFS mount ${efs_filesystem_id}.efs.${aws_region}.amazonaws.com already exists. No need to modify /etc/fstab"
else
  echo "${efs_filesystem_id}.efs.${aws_region}.amazonaws.com:/ ${efs_mountpoint} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab
fi
