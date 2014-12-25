#!/usr/bin/env ruby
require 'pry'
require 'json'
require 'unimidi'

# Prompt the user
input = UniMIDI::Input.gets

puts "send some MIDI to your input now..."

def have_midi_signal?(midi_data)
  midi_data.length == 3
end

def on_key_up?(midi_data)
  midi_data[2] == 0
end

def sustain_pedal?(midi_data)
  midi_data[0] == 176
end

while true
  m = input.gets
  midi_data = m[0][:data]
  if have_midi_signal?(midi_data) && !on_key_up?(midi_data) && !sustain_pedal?(midi_data)
    puts(m[0].to_json)
    `echo "#{m[0][:data]}\t#{m[0][:timestamp]}" >> ./log/#{Time.now.strftime('%Y_%m_%d')}.tsv`
  end
end
