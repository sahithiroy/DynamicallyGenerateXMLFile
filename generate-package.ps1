# Step 1: Get changed metadata files
$files = git diff --name-only origin/main...HEAD | `
    Select-String -Pattern '\.cls$|\.trigger$|\.page$|\.component$|\.object$'

# Step 2: Create a hashtable to hold metadata components
$components = @{}

foreach ($file in $files) {
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($file.ToString())
    $extension = [System.IO.Path]::GetExtension($file.ToString()).TrimStart('.')

    # Step 3: Match to Salesforce metadata types
    switch ($extension) {
        'cls'       { $type = 'ApexClass' }
        'trigger'   { $type = 'ApexTrigger' }
        'page'      { $type = 'ApexPage' }
        'component' { $type = 'ApexComponent' }
        'object'    { $type = 'CustomObject' }
        default     { continue }
    }

    # Step 4: Add to metadata map
    if (-not $components.ContainsKey($type)) {
        $components[$type] = @()
    }
    $components[$type] += $filename
}

# Step 5: Write XML file
$xml = @()
$xml += '<?xml version="1.0" encoding="UTF-8"?>'
$xml += '<Package xmlns="http://soap.sforce.com/2006/04/metadata">'

foreach ($type in $components.Keys) {
    $xml += "  <types>"
    foreach ($member in $components[$type] | Sort-Object -Unique) {
        $xml += "    <members>$member</members>"
    }
    $xml += "    <name>$type</name>"
    $xml += "  </types>"
}

$xml += '  <version>58.0</version>'
$xml += '</Package>'

# Save the file
$xml | Set-Content -Path ".\package.xml" -Encoding UTF8

Write-Host "`n✅ package.xml created in current folder."

