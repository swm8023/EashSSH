#!/bin/bash

path=$(dirname "$BASH_SOURCE")
cfgfile=$path"/../cfg/hosts"

function get_host_byid() 
{
    getname=$1
    while read line
    do
        host_id=`echo $line | cut -d " " -f1`
        host_ip=`echo $line | cut -d " " -f2`
        host_port=`echo $line | cut -d " " -f3`
        host_user=`echo $line | cut -d " " -f4`
        host_pass=`echo $line | cut -d " " -f5`
        if [ $host_id == $getname ] 
        then
            return 0
        fi
    done < $cfgfile
    return 1
}

# ssh_login id
function ssh_login() 
{
    get_host_byid $1
    if (($? == 0))
    then
        ssh_login_wrapper $host_ip $host_port $host_user $host_pass
    else
        echo "hostid $1 not exist"
    fi
}

# ssh_cmd id cmd
function ssh_cmd() 
{
    get_host_byid $1
    if (($? == 0))
    then
        ssh_cmd_wrapper $host_ip $host_port $host_user $host_pass $2
    else
        echo "hostid $1 not exist"
    fi
}

# ssh_scp id dir fromfile dirfile
function ssh_scp() 
{
    get_host_byid $1
    if (($? == 0))
    then
        ssh_scp_wrapper $host_ip $host_port $host_user $host_pass $2 $3 $4
    else
        echo "hostid $1 not exist"
    fi
}

function ssh_list()
{
    getname=$1
    while read line
    do
        host_id=`echo $line | cut -d " " -f1`
        host_ip=`echo $line | cut -d " " -f2`
        host_user=`echo $line | cut -d " " -f4`
        echo $host_id","$host_ip","$host_user
    done < $cfgfile
    return 1   
}
# ssh_login.exp ip port user pass
function ssh_login_wrapper()
{
    $path/ssh_login.exp "$1" "$2" "$3" "$4"
}

# ssh_cmd.exp ip port user pass cmd
function ssh_cmd_wrapper()
{
    $path/ssh_cmd.exp "$1" "$2" "$3" "$4" "$5"
}

# ssh_cmd.exp ip port user pass dir[toloc|tofar] fromfile tofile
function ssh_scp_wrapper()
{
    $path/ssh_scp.exp "$1" "$2" "$3" "$4" "$5" "$6" "$7"
}
