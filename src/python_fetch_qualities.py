import mysql.connector

# Define the MySQL server connection settings
host = '127.0.0.1'
database = 'acore_world'
username = 'root'
password = 'ascent'
port = 3307

# Establish a connection to the MySQL server
connection = mysql.connector.connect(
    host=host,
    database=database,
    user=username,
    password=password,
    port=port
)


# Create a cursor object to execute SQL queries
cursor = connection.cursor()

# Read input from the file
with open('input.txt', 'r') as file:
    rows = [eval(line.strip()) for line in file]

# Query the SQL server to get the maximum quality for each displayId
query = "SELECT displayid, MAX(Quality) FROM item_template GROUP BY displayid"
cursor.execute(query)
result = cursor.fetchall()

# Create a dictionary to store the displayId and maximum quality values
display_id_quality = {row[0]: row[1] for row in result}

# Add a new entry with the maximum quality value at the end of each row
file = open('output.txt', 'w')

for row in rows:
    display_id = row[-1]  # Get the displayId from the last element of the row

    # Check if displayId exists in the dictionary
    if display_id[-1] in display_id_quality:
        quality = display_id_quality[display_id[-1]]

        # Quality must be at least uncommon.
        if quality < 2:
            quality = 2
        elif quality > 5: # Quality can't be higher than legendary
            quality = 5


        rowStr = ' '.join(str(element) for element in row)  # Join tuple elements with a space
        rowStr = rowStr[:-1]  # Remove the last two characters
        rowStr += ", " + str(quality) + "],"
        row = rowStr
        file.write(str(row) + '\n')

print("!! DONE")

# Close the cursor and connection
cursor.close()
connection.close()