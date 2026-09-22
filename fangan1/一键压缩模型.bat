@echo off
chcp 65001 >nul
title 模型压缩工具 - 钢结构构件系统
echo ============================================
echo    3D模型一键压缩工具
echo    把要压缩的 .glb 文件拖到这个窗口里
echo    压缩后会直接生成同名小文件
echo ============================================
echo.
set /p input="请把 .glb 文件拖到这里然后按回车: "

set "input=%input:"=%"

for %%F in ("%input%") do (
    set "filepath=%%~dpF"
    set "filename=%%~nxF"
    set "name=%%~nF"
)

echo.
echo 正在压缩: %filename%
echo 请稍等...
echo.

cd /d "%filepath%"
npx --yes @gltf-transform/cli@latest optimize "%filename%" "%name%_tmp.glb" --compress draco --texture-compress webp

if exist "%name%_tmp.glb" (
    move /Y "%name%_tmp.glb" "%filename%" >nul
    echo.
    echo ============================================
    echo  压缩完成! 原文件已替换为压缩版: %filename%
    echo  把它复制到 gangjiegou\models 文件夹即可
    echo ============================================
) else (
    echo.
    echo 压缩失败，请检查文件是否为正确的 .glb 模型
)
echo.
pause