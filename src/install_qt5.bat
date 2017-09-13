:: install_qt <platform>
@echo off
call %~dp0install_base %1

echo Installing Qt5...

:: Configure necessary dependencies
call %PDK_INSTALL_PLATFORM_DIR%\configure_cpp_compiler.bat

set QMAKESPEC=win32-msvc2015

mkdir %PDK_INSTALL_TEMP_DIR%\qt5

pushd %PDK_INSTALL_TEMP_DIR%\qt5

:: Configure Qt
call %~dp0qt5\configure -prefix %PDK_INSTALL_PLATFORM_DIR%\qt5 -debug-and-release -confirm-license -opensource -static -static-runtime -nomake tests -nomake examples -openssl-linked

:: Build Qt
call jom

:: Install Qt
call jom install

popd

:: Save configure script
set _PDK_QT5_CONFIGURE_SCRIPT=%PDK_INSTALL_PLATFORM_DIR%\configure_qt5.bat

echo set PDK_QT5_ROOT=%PDK_INSTALL_PLATFORM_DIR%\qt5>%_PDK_QT5_CONFIGURE_SCRIPT%||goto :error
echo exit /b ^0>>%_PDK_QT5_CONFIGURE_SCRIPT%||goto :error

echo Done!

exit

:error
exit %errorlevel%
