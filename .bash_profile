export STUFF_HOME="/Users/wruggian/dev/stuff/src/WhereWruggianKeepsHisStuff/usr";

if [ -f "$STUFF_HOME/.bashrc" ];
then
  source $STUFF_HOME/.bashrc
else
  echo "Unable to find stuff at $STUFF_HOME"
fi

