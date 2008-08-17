set CAMPING_HOME=%~dp0
set CLASSPATH=%JAVA_HOME%\lib\tools.jar;%CAMPING_HOME%\lib\cdk-20060714.jar;%CAMPING_HOME%\lib\structure-cdk-0.1.2.jar
REM start "campdepict" jruby %JRUBY_HOME%\bin\Camping campdepict.rb
jruby -J-server -J-Djruby.thread.pooling=true %JRUBY_HOME%\bin\camping campdepict.rb
