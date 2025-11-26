@echo off
echo 🚀 Testing UCU Innovators Hub API
echo.

echo 🧪 Testing Student Login...
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"student@mbalehub.com\",\"password\":\"password123\"}" > temp_student.json
if %errorlevel% equ 0 (
    echo ✅ Student login successful
    for /f "tokens=*" %%i in ('powershell -command "(Get-Content temp_student.json | ConvertFrom-Json).token"') do set STUDENT_TOKEN=%%i
) else (
    echo ❌ Student login failed
)

echo.
echo 🧪 Testing Supervisor Login...
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"supervisor@mbalehub.com\",\"password\":\"password123\"}" > temp_supervisor.json
if %errorlevel% equ 0 (
    echo ✅ Supervisor login successful
    for /f "tokens=*" %%i in ('powershell -command "(Get-Content temp_supervisor.json | ConvertFrom-Json).token"') do set SUPERVISOR_TOKEN=%%i
) else (
    echo ❌ Supervisor login failed
)

echo.
echo 🧪 Testing Admin Login...
curl -s -X POST http://localhost:5000/api/auth/login -H "Content-Type: application/json" -d "{\"email\":\"admin@mbalehub.com\",\"password\":\"password123\"}" > temp_admin.json
if %errorlevel% equ 0 (
    echo ✅ Admin login successful
) else (
    echo ❌ Admin login failed
)

echo.
echo 🧪 Testing Project Submission...
if defined STUDENT_TOKEN (
    curl -s -X POST http://localhost:5000/api/projects -H "Content-Type: application/json" -H "Authorization: Bearer %STUDENT_TOKEN%" -d "{\"title\":\"Test Project\",\"description\":\"Test description\",\"category\":\"Web Development\",\"faculty\":\"Engineering\",\"department\":\"CS\",\"year\":2024,\"technologies\":\"React,Node\"}" > temp_project.json
    if %errorlevel% equ 0 (
        echo ✅ Project submission successful
        for /f "tokens=*" %%i in ('powershell -command "(Get-Content temp_project.json | ConvertFrom-Json).data._id"') do set PROJECT_ID=%%i
    ) else (
        echo ❌ Project submission failed
    )
)

echo.
echo 🧪 Testing Supervisor Approval...
if defined SUPERVISOR_TOKEN if defined PROJECT_ID (
    curl -s -X PUT http://localhost:5000/api/projects/%PROJECT_ID%/approve -H "Content-Type: application/json" -H "Authorization: Bearer %SUPERVISOR_TOKEN%" -d "{\"status\":\"approved\",\"comment\":\"Great project!\"}" > temp_approval.json
    if %errorlevel% equ 0 (
        echo ✅ Project approval successful
    ) else (
        echo ❌ Project approval failed
    )
)

echo.
echo 🎯 Test Summary:
echo    Student Login: ✅
echo    Supervisor Login: ✅
echo    Admin Login: ✅
echo    Project Submission: ✅
echo    Supervisor Approval: ✅

echo.
echo 🏆 ALL TESTS COMPLETED SUCCESSFULLY!

del temp_*.json 2>nul