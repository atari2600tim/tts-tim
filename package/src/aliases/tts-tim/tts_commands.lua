local arg = matches[2]
local output
local rate
if arg == "stop" then
  ttsClearQueue()
  ttsSkip()
  output = "Stopped"
  echo(output)
  ttsSpeak(output)
elseif arg == "repeat" then
  output = table.concat(getLines(getLineNumber()-5, getLineNumber())," ")
  echo("TTS repeating last lines: "..output)
  ttsQueue(output)
  -- TODO currently this shows commands I typed and all that I could filter out

elseif arg == "faster" then
  rate = ttsGetRate()
  if rate == 1 then
    output = "1 is fastest speed"
    echo(output)
    ttsQueue(output)
  else
    output = "speeding up from "..rate.." to "..(rate+0.1)
    ttsSetRate(rate+0.1)
    echo(output)
    ttsQueue(output)
  end
elseif arg == "slower" then
  rate = ttsGetRate()
  if rate == -1 then
    output = "-1 is slowest speed"
    echo(output)
    ttsQueue(output)
  else
    output = "slowing down from "..rate.." to "..(rate-0.1)
    ttsSetRate(rate-0.1)
    echo(output)
    ttsQueue(output)
  end

elseif arg == "higher" then
  rate = ttsGetPitch()
  if rate == 1 then
    output = "1 is highest pitch"
    echo(output)
    ttsQueue(output)
  else
    output = "raising pitch from "..rate.." to "..(rate+0.1)
    ttsSetPitch(rate+0.1)
    echo(output)
    ttsQueue(output)
  end
elseif arg == "lower" then
  rate = ttsGetPitch()
  if rate == -1 then
    output = "-1 is lowest pitch"
    echo(output)
    ttsQueue(output)
  else
    output = "lowering pitch from "..rate.." to "..(rate-0.1)
    ttsSetPitch(rate-0.1)
    echo(output)
    ttsQueue(output)
  end
  
elseif arg == "louder" then
  rate = ttsGetVolume()
  if rate == 1 then
    output = "1 is highest volume"
    echo(output)
    ttsQueue(output)
  else
    output = "raising volume from "..rate.." to "..(rate+0.1)
    ttsSetVolume(rate+0.1)
    echo(output)
    ttsQueue(output)
  end
elseif arg == "softer" then
  rate = ttsGetVolume()
  if rate == -1 then
    output = "-1 is lowest volume"
    echo(output)
    ttsQueue(output)
  else
    if risk == nil then
      -- see https://github.com/Mudlet/Mudlet/issues/4698
      output = "Changing volume crashes Tim's computer.  Type 'tts risk' to unlock volume anyway"
      ttsQueue(output)
      echo(output)
      return
    end
    output = "lowering volume from "..rate.." to "..(rate-0.1)
    ttsSetVolume(rate-0.1)
    echo(output)
    ttsQueue(output)
  end
elseif arg == "risk" then
  risk = true
  output = "Unlocking volume"
  ttsQueue(output)
  echo(output)

elseif arg == "voice" then
  local voiceList = ttsGetVoices()
  local oldVoice = ttsGetCurrentVoice()
  local sz = table.getn(voiceList)
  local count = 1
  if sz == 0 then
    output = "Your list of available voices is empty."
    ttsQueue(output)
    echo(output)
    return
  end
  for _,v in pairs(voiceList) do
    if oldVoice == v then
      ttsSetVoiceByIndex((count % sz) +1)
    end
    count = count + 1
  end
  if count > sz   + 1 then
    ttsSetVoiceByIndex(math.floor(math.random()*sz)+1)
    output = "Your voice was set to "..oldVoice.." which is not in the list of "..sz.." available voices.\n"
    output = output.."This seems odd. Switching to "..ttsGetCurrentVoice().."."
  else
    output = "There are "..sz.." voices available.  Old voice was "..oldVoice..", new voice is "..ttsGetCurrentVoice().."."
  end
  echo(output)
  ttsQueue(output)

elseif arg == "skip" then
  if ttsGetState() == "ttsSpeechReady" and table.getn(ttsGetQueue()) > 0 then
    echo("avoiding a skip bug\n")
    return -- cheap hack, see https://github.com/Mudlet/Mudlet/issues/4737
  end
  ttsSkip()
elseif arg == "pause" then
  ttsPause()
elseif arg == "resume" or arg == "unpause" then
  ttsResume()

elseif arg == "dev" then
  local voiceList = ttsGetVoices()
  local oldVoice = ttsGetCurrentVoice()
  local sz = table.getn(voiceList)
  output = "ttsGetCurrentVoice: "..ttsGetCurrentVoice()
  output = output.."\nttsGetVoices() shows "..sz.." voices available:\n  "
  output = output..table.concat(voiceList,"\n  ")
  output = output.."\nttsGetQueue() has "..table.getn(ttsGetQueue()).." lines"
  output = output.."\nttsGetCurrentLine() has "..(ttsGetCurrentLine() or "nil")
  output = output.."\nttsGetState() has "..ttsGetState()
  echo(output)
  --ttsQueue(output)

elseif arg == "status" then
  output = "Current speed is "..ttsGetRate()..". Pitch is "..ttsGetPitch()..". Volume is "..ttsGetVolume()..". Voice is "..ttsGetCurrentVoice().."."
  echo(output)
  ttsQueue(output)
elseif arg == "help" then
  output = "TTS commands are help, stop, skip, repeat, faster, slower, louder, softer, higher, lower, pause, resume, voice, status.\n"
  echo(output)
  ttsQueue(output)
end
