# otm-tools
Tools for Open Traffic Models

# INSTALLATION #

**Step 1.** Install the [JAVA 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html) JDK on your computer.
[This](https://www.java.com/en/download/help/version_manual.xml) will show you how to check your current version of JAVA.

**Step 2.** Request a copy of the BeATS simulator by [email](mailto:gomes@me.berkeley.edu). You will receive an invitation to join a Dropbox folder containing the BeATS simulator jar file. You should have Dropbox sync this folder with your computer so that you always have the latest version of the simulator. 

**Step 3.** Download or clone the beats-tools repository to your computer. For this you need a bitbucket account and access to the repo. If you do not have access, send me an [email](mailto:gomes@me.berkeley.edu).

**Step 4. (Matlab) ** Point Matlab to Java 8. The current version of Matlab uses Java 7, however BeATS requires Java 8. Follow these instructions to fix this: 

* **MacOS** - Create an environment variable called `MATLAB_JAVA` in `~/.bash_profile` and set it equal to the full path of your Java installation's JRE folder. You can do so by adding the below line of code to `~/.bash_profile`, making any necessary changes to fit your computer:
```BASH
export MATLAB_JAVA="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home/jre"
```
Reboot your computer.<br><br>
Note: You will only be able to use Matlab + Java 8 by opening the Matlab app via Terminal. If you open Matlab from the GUI, it will run with Java 7. <br><br>To check which version of Java your Matlab session is using, type into Matlab's command line prompt: `version -java`

* [Windows](https://www.mathworks.com/matlabcentral/answers/130359-how-do-i-change-the-java-virtual-machine-
jvm-that-matlab-is-using-on-windows) 

* [Linux](https://www.mathworks.com/matlabcentral/answers/130360-how-do-i-change-the-java-virtual-machine-jvm-that-matlab-is-using-for-linux)

**Step 5. (Matlab) ** Point Matlab to the BeATS jar file. Follow these [instructions](https://www.mathworks.com/help/matlab/matlab_external/static-path.html) to include the BeATS jar file in Matlab's static class path. You will need to restart Matlab after doing this. 

**Step 6. (Python) ** TBD

**Step 7. (Matlab) ** Add beats-tools/matlab **with subfolders** to Matlab's path. See instructions [here](https://www.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html). 

**Step 8. (Matlab) ** Run tests: beats-tools/matlab/tests.m. If this runs without error, you have succeeded in installing the package.
