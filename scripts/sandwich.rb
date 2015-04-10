#!/usr/bin/env ruby

require 'tts'

if ARGV[0] == 'sudo'
[
  "Listen, I want to make you a sandwich.",
  "I really do.",
  "But I can't.",
  "It has nothing to do with user priveleges."
].each { |sentence| sentence.play }
else
  "Make it yourself.".play
end