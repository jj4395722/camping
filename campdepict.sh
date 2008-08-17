#! /bin/sh -v
export CAMPING_HOME=`pwd`
export CLASSPATH=$CAMPING_HOME/lib/cdk-20060714.jar:$CAMPING_HOME/lib/structure-cdk-0.1.2.jar:$CLASSPATH
jruby $JRUBY_HOME/bin/camping campdepict.rb
# jruby -J-server -J-Djruby.thread.pooling=true $JRUBY_HOME/bin/camping campdepict.rb
