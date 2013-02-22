s = ".sdrawkcab si gnirts sihT"
s.reverse                            # => "This string is backwards."
puts s                                    # => ".sdrawkcab si gnirts sihT"

s = "order. wrong the in are words These"
puts s.split(/(\s+)/).reverse!.join('')   # => "These words are in the wrong order."
puts s.split(/\b/).reverse!.join('')      # => "These words are in the wrong. order"

