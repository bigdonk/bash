#!/bin/bash
CHECK=0
while [ $CHECK == 0 ]; do
INVALID=0
echo
echo Eressea will be installed into HOME/eressea
echo  
echo Is this OK? [y/n]
read ANSWER
if [[ $ANSWER == "N" || $ANSWER == "n" ]]; then
  echo  
  echo Enter installation directory
  read DIRECTORY
  echo  
  echo Eressea installing into HOME/$DIRECTORY ..........
  echo  
elif [[ $ANSWER == "Y" || $ANSWER == "y" ]]; then
  echo  
  echo Eressea installing into HOME/eressea ..........
  echo  
  DIRECTORY=eressea
else
  INVALID=1
  DIRECTORY=abcdefghijk
  echo  
  echo Invalid entry
  echo  
fi
ERESSEA=$HOME/$DIRECTORY
if [ -d "$ERESSEA" ]; then
  echo  
  echo This directory already exists
  echo  
  echo Choose another directory
  echo  
elif [ $INVALID == 0 ]; then
  CHECK=1
fi
done
mkdir $ERESSEA && cd $ERESSEA
git clone --recursive git://github.com/bigdonk/rules.git
git clone --recursive git://github.com/bigdonk/echeck.git
git clone --recursive git://github.com/bigdonk/server.git git
cd git
./configure
s/build && s/runtests && s/install
echo  
echo The Eressea Server is now installed
echo  
CHECK2=0
while [ $CHECK2 == 0 ]; do
echo Game setup
echo Enter game number
echo -must be numeric
read GAME
echo  
echo Enter ruleset
echo e2 e3 e4
read RULE
echo  
if [ -d "$ERESSEA/game-$GAME" ]; then
  echo  
  echo This directory already exists
  echo  
  echo Choose another directory
  echo  
else
  CHECK2=1
fi
done
s/setup -g $GAME -n -r $RULE
echo game-$GAME with ruleset $RULE is now installed and ready to use
echo  
echo You must create a data file before running a turn
echo  
