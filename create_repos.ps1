$token = $env:GITHUB_TOKEN
$org = "2026-27-DWM-UAL"
$templateRepo = "classroom50"
$studentsFile = "alumnos.csv"

$students = Import-Csv $studentsFile

foreach ($student in $students) {

    $id = $student.username
    if ($id -eq "") { continue }

    $repoName = "PRACTICAS-$id"

    Write-Host "Creando repositorio con plantilla para $id..."

    $generateBody = @{
        owner = $org
        name = $repoName
        include_all_branches = $true
        private = $true
    } | ConvertTo-Json

    Invoke-RestMethod `
        -Method Post `
        -Uri "https://api.github.com/repos/$org/$templateRepo/generate" `
        -Headers @{ Authorization = "token $token" } `
        -Body $generateBody

    Write-Host "Repositorio $repoName creado con plantilla."
    Write-Host "-------------------------------------------"
}

Write-Host "Proceso completado."
