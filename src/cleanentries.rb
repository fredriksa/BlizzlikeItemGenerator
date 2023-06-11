# Get displays for a type
# SELECT subclass, InventoryType, RequiredLevel, class, displayid FROM item_template WHERE class=4 AND subclass=3 AND InventoryType=3 AND RequiredLevel != 0;

# Define the input and output file paths
input_file_path = 'input.txt'
output_file_path = 'output.txt'

# Create a hash to store the last column values
last_column_values = {}

# Open the input file for reading
File.open(input_file_path, 'r') do |input_file|
  # Open the output file for writing
  File.open(output_file_path, 'w') do |output_file|
    # Iterate over each line in the input file
    input_file.each_line do |line|
      # Split the line by whitespace or any other delimiter
      columns = line.split

      # Get the last column value
      last_column = columns.last

      # Check if the last column value has been seen before
      if last_column_values.key?(last_column)
        # Last column value has been seen before, ignore the sequence
        next
      end

      # Store the last column value in the hash
      last_column_values[last_column] = true

      # Output the entire sequence to the output file
      output_file.puts(line)
    end
  end
end