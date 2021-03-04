local arg = matches[2]
if arg == "stop" then
  ttsClearQueue()
  ttsSkip()
  echo("TTS stopped")
  ttsQueue("stopped")
elseif arg == "repeat" then
  local lastlines = table.concat(getLines(getLineNumber()-5, getLineNumber())," ")
  echo("TTS repeating last lines: "..lastlines)
  ttsQueue(lastlines)
elseif arg == "help" then
  local helptext = "TTS commands are stop, repeat, help\n"
  echo(helptext)
  ttsQueue(helptext)
end
