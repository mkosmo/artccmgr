# ARTCC Manager

Master: [![Build Status](https://travis-ci.org/ZHU-ARTCC/artccmgr.svg?branch=master)](https://travis-ci.org/ZHU-ARTCC/artccmgr)

This is the home of the ZHU ARTCC Manager website development effort.

Prerequisites (subject to change):

* Ruby 2.4.3
* Rails 5.2.0.rc1

### Environment variables

The following are used for links generated in emails sent to users:
* ARTCC_HOSTNAME - The hostname of the web site (i.e. www.zhuartcc.org)
* ARTCC_PORT - The port the site is running on if non-standard (default: 80)
* ARTCC_PROTOCOL - The protocol used for the site (default: http)
* ARTCC_EMAIL - The 'from' email address used in correspondence by default
