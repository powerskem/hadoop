# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export JAVA_HOME="/usr/lib/java"
export PATH="$PATH:$JAVA_HOME/bin"

# source the Hadoop runtime
if [ -f ./.hadooprc ]; then
    . ./.hadooprc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# enable bash_aliases
if [ -f ./.bash_aliases ]; then
    . .bash_aliases
fi
