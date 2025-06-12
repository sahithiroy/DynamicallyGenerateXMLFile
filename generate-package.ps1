# Step 1: Get changed metadata files including LWC
$files = git diff --name-only HEAD~1 HEAD | `
    Select-String -Pattern '\.cls$|\.trigger$|\.page$|\.component$|\.object$|lwc\/[^\/]+\/'

# Step 2: Create a hashtable to hold metadata components
$components = @{}

foreach ($file in $files) {
    $path = $file.ToString()

    # Handle LWC folders separately
    if ($path -match 'lwc\/([^\/]+)\/') {
        $type = 'LightningComponentBundle'
        $filename = $matches[1]
    }
    else {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($path)
        $extension = [System.IO.Path]::GetExtension($path).TrimStart('.')

        switch ($extension) {
            'cls'       { $type = 'ApexClass' }
            'trigger'   { $type = 'ApexTrigger' }
            'page'      { $type = 'ApexPage' }
            'component' { $type = 'ApexComponent' }
            'object'    { $type = 'CustomObject' }
            default     { continue }
        }
    }

    if (-not $components.ContainsKey($type)) {
        $components[$type] = @()
    }
    $components[$type] += $filename
}

# Step 3: Build and save package.xml
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
Write-Host "`n✅ package.xml created including LWC components."

