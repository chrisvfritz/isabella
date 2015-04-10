#!/usr/bin/env ruby

require 'tts'

JOKES = [
  {
    setup: "What's the difference between an etymologist and an entomologist?",
    punchline: "An etymologist would know the difference."
  },{
    setup: "How does Orion keep his pants up?",
    punchline: "With an asteroid belt."
  },{
    setup: "Two guys walk into a bar.",
    punchline: "The third guy ducks."
  },{
    setup: "If you need money, just borrow it from a pessimist.",
    punchline: "They don't expect it back."
  },{
    setup: "My mother told me it's polite to go to other people's funerals.",
    punchline: "Otherwise, they won't go to yours."
  }
]

joke = ARGV[0].empty? ? JOKES.sample : JOKES.find{|j| j[:setup].downcase =~ /#{ARGV[0].downcase}/ }

joke[:setup].play
sleep 1
joke[:punchline].play
