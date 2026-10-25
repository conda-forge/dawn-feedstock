@echo on

REM DAWN_FORCE_SYSTEM_COMPONENT_LOAD: load d3dcompiler_47.dll (FXC) from System32.
REM By default Dawn expects the Windows SDK copy next to webgpu_dawn.dll, which
REM cmake --install does not install, and every D3D device creation fails with
REM "DynamicLib.Open: d3dcompiler_47.dll Windows Error: 87".
cmake -S . -B build -G Ninja ^
    %CMAKE_ARGS% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PROJECT_Dawn_INCLUDE="%RECIPE_DIR%\system_deps.cmake" ^
    -DPython3_EXECUTABLE="%BUILD_PREFIX%\python.exe" ^
    -DBUILD_SHARED_LIBS=OFF ^
    -DDAWN_BUILD_MONOLITHIC_LIBRARY=SHARED ^
    -DDAWN_ENABLE_INSTALL=ON ^
    -DDAWN_FETCH_DEPENDENCIES=OFF ^
    -DDAWN_BUILD_SAMPLES=OFF ^
    -DDAWN_BUILD_TESTS=OFF ^
    -DDAWN_BUILD_BENCHMARKS=OFF ^
    -DDAWN_BUILD_PROTOBUF=OFF ^
    -DDAWN_USE_GLFW=OFF ^
    -DDAWN_WERROR=OFF ^
    -DDAWN_FORCE_SYSTEM_COMPONENT_LOAD=ON ^
    -DDAWN_JINJA2_DIR= ^
    -DDAWN_MARKUPSAFE_DIR= ^
    -DTINT_BUILD_CMD_TOOLS=OFF ^
    -DTINT_BUILD_TESTS=OFF ^
    -DTINT_BUILD_BENCHMARKS=OFF ^
    -DTINT_BUILD_IR_BINARY=OFF
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

cmake --install build
if errorlevel 1 exit 1
