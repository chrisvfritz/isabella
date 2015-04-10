#!/usr/bin/env ruby

require 'tts'

"The current time is #{Time.now.strftime('%-l:%M %p')}.".play
