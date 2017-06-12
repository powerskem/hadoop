#!/bin/bash

for cf in $(cat config_files) ; do
  if [ -f $cf ] ; then
    echo "Checking $cf ........."
    case "$cf" in
        etc/hadoop/conf/hdfs-site.xml)
            if [ $(hostname) == "hdcentos" ] ; then
                echo -e "\tdiff $cf /$cf"
                diff $cf /$cf
            else
                echo -e "\tdiff etc/hadoop/conf/hdfs-site_fordatanodes.xml /$cf"
                diff etc/hadoop/conf/hdfs-site_fordatanodes.xml /$cf
            fi
            ;;
        etc/hadoop/conf/slaves)
            if [ $(hostname) == "hdcentos" ] ; then
                echo -e "\tdiff $cf /$cf"
                diff $cf /$cf
            else
                echo -e "\tdiff etc/hadoop/conf/slaves_other_nodes /$cf"
                diff etc/hadoop/conf/slaves_other_nodes /$cf
            fi
            ;;
        *)
                echo -e "\tdiff $cf /$cf"
                diff $cf /$cf
                ;;
    esac

    echo -e "\n"

  fi

done

