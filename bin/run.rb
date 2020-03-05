require_relative '../config/environment'
require "pry"

# binding.pry
$exit_program_boolean = false

#program starts
# start_program

# check to see if exit was pressed

while $exit_program_boolean == false do
    # exit was not pressed
    start_program
end 