local output
output = matches[1]
output = output:gsub("<", "less than")
output = output:gsub(">", "greater than")
if(output:match("%S")) then -- if string is not just whitespace
  ttsQueue(output)
end
