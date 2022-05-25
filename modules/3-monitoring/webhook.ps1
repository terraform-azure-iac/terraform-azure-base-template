# Slack Webhook function
function Send-toSlack {
  param (
      [Parameter(Mandatory=$true)]
      $pretext,
      [Parameter(Mandatory=$true)]
      $text,
      [Parameter(Mandatory=$true)]
      $color,
      #$uri
  )
  
  # sende the $uri as a param  insted?
  $uri = "" ################################  Insert webhook url ########
  
  $body = ConvertTo-Json @{
      pretext = "$pretext"
      text = "$text"
      color = "$color"
  }
  try {
      Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json' | Out-Null
  } catch {
      Write-Error (": Update to Slack went wrong...")
  }
}


Send-toSlack `
  -pretext  "This is a title" `
  -text "                                    
  This is some text
  and some information" `
  -color "#ff0000" #Red: #ff0000 #Green: #008000