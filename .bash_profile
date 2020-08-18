
# Setting PATH for Python 3.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# added by Anaconda3 4.4.0 installer
export PATH="/Users/taku_tsunoi/anaconda/bin:$PATH"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

eval "$(rbenv init -)"
export PATH=$PATH:.rbenv/versions/2.7.0/lib/ruby/gems/2.7.0/gems/rspec-core-3.9.1/exe

export PATH="$HOME/.cargo/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/taku_tsunoi/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/taku_tsunoi/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taku_tsunoi/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/taku_tsunoi/Downloads/google-cloud-sdk/completion.bash.inc'; fi
