# Build yCrash agent in Windows

Please follow the below instructions to compile and build yCrash agent in Windows.

1. Download and install MSYS2. It is a collection of tools and libraries providing you with an easy-to-use environment for building, installing and running native Windows software. Ue the below link to download installer

      [https://github.com/msys2/msys2-installer/releases/download/2021-07-25/msys2-x86_64-20210725.exe](https://github.com/msys2/msys2-installer/releases/download/2021-07-25/msys2-x86_64-20210725.exe)

2. Once the installer is downloaded, run it in your Windows machine. It required 64-bit Windows 7 or newer.
3. Enter the path where you want to install the MSYS2 and click on the Next button

    <img src="/docs/images/installation-folder.png" width="600" height="300" />

4. On the next screen press Next button

    <img src="/docs/images/start-menu-shortcut.png" width="600" height="300" />
    
5. In the last step, when the installation is finished, select **Run MSYS2 now** and click on the Finish button.
6. Run the below command to update the package database and base packages when the MSYS2 window is opened again.

    ```
    pacman -Syu
    ```
    <img src="/docs/images/update-db-package.png" width="600" height="300" />
    
7. Close the window and search for MSYS2 MSYS in the start menu and open MSYS2 again.

    <img src="/docs/images/windows-start.png" width="600" height="400" />

8. Now update the rest of the base packages using command

    ```
    pacman -Su
    ```
    <img src="/docs/images/update-package.png" width="600" height="300" />
    
9. Install mingw-w64 GCC to compile the yCrash agent.

    ```
     pacman -S --needed base-devel mingw-w64-x86_64-toolchain
    ```
    <img src="/docs/images/compile.png" width="600" height="500" />
    
10. Close the window and reopen it similar to step #7
11. Once the MSYS2 window is open, run the below command to install mingw-w64-go packages.

    ```
    pacman -S mingw-w64-x86_64-go
    ```
12. Close the MSYS2 window once the installation is completed.
13. Set MSYS2 installation path in the Windows environment variable
    
    ```
    C:\msys64\mingw64\bin
    ```
    
14. Open Windows command prompt and run the below command to check gcc version

    ```
    gcc --version
    ```

15. Now let's set the GOPATH environment variable. I assume you have installed MYSY2 in the C:/msys64 folder. Create a new folder Go. Execute the below command to set the GOPATH environment variable.
    
    ```
    set GOPATH=C:\msys64\mingw64\Go
    ```
    <img src="/docs/images/set-gopath.png" width="600" height="200" />
    
16. Next set GOROOT environment variable. I assume you have installed Go in the C:\Program Files\Go folder. Execute the below command to set the GOROOT environment variable.
    
    ```
    set GOROOT=C:\Program Files\Go
    ```
    <img src="/docs/images/set-goroot.png" width="600" height="200" />
    
17. Now you are ready to compile and build yCrash agent on Windows using the below command

    ```
    go build
    ```
   
    On completion of build you will see ```yc.exe``` file under ```ycrash-agent/yc``` folder. You can find different yCrash agent arguments in the [official documentation](https://docs.ycrash.io/ycrash-agent/all-agent-arguments.html#all-arguments).
    
    
    
    
