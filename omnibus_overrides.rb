# THIS IS NOW HAND MANAGED, JUST EDIT THE THING
#
# Only deliberate pins remain here; every other component now falls through to
# the omnibus-software default (latest). Removed (now using omnibus-software
# defaults): libffi (3.6.0, >= the 3.4.7 EL10 fix), zlib (1.3.2).

# grab the current train release from rubygems.org
train_stable = /^train \((.*)\)/.match(`gem list ^train$ --remote`)[1]
override "train", version: "v#{train_stable}"

# Platform runtimes -- pinned to a specific major on purpose:
override "ruby", version: "3.1.7"                 # stay on Ruby 3.1.x (omnibus-software defaults to 3.4)
override "ruby-msys2-devkit", version: "3.1.7-1"  # match the Ruby 3.1.7 pin (Windows devkit)
override :openssl, version: "3.2.6"               # major component (omnibus-software defaults to 3.6.3)
