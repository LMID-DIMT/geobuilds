#!/bin/bash

JAVA_DIR=jdk1.8.0_191

echo "export JAVA_HOME=/usr/local/$JAVA_DIR
export JRE_HOME=/usr/local/$JAVA_DIR/jre
export PATH=$PATH:/usr/local/$JAVA_DIR/bin:/usr/local/$JAVA_DIR/jre/bin" >> ~/.bashrc
