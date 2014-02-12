if [ -d $HOME/android-sdk-linux ]; then
  export ANDROID_HOME=$HOME/android-sdk-linux
fi

if [ -n "$ANDROID_HOME" ]; then
  tryapath $ANDROID_HOME/tools
  tryapath $ANDROID_HOME/build-tools/*
  tryapath $ANDROID_HOME/platform-tools
fi
