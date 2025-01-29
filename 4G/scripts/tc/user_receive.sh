#!/bin/bash

# Parameters
port=5000  # Port to listen for file size, binary data, and end marker
received_file="received_signal.bin"
> "$received_file"  # Clear or create the file

# Step 1: Listen for the file size
#echo "Waiting for the file size on port $port..."
#file_size=$(nc -u -l -p "$port")

#echo "Expected file size: $file_size bytes"

# Step 2: Start listening for the binary data



while true; do
  nc -u -l -p "$port" | while read line; do
    if [ "$line" = "nSTOPn" ]; then
      echo "Received STOP command, exiting...\n"
      exit 0
    fi
    echo "$line" >> "$received_file"
  done
done



echo "Receiving binary data..."
nc -u -l -p "$port" > "$received_file" 

  # Capture the process ID of netcat receiving the file

# Step 3: Monitor the file size as it is being written
received_size=0
while [ "$received_size" -lt "$file_size" ]; do
  sleep 1  # Check the file size every second
  received_size=$(stat --printf="%s" "$received_file")
  echo "Received $received_size / $file_size bytes..."
done

# Step 4: Listen for the "END_OF_TRANSMISSION" marker to stop the reception
echo "Waiting for end of transmission marker..."
while true; do
  marker=$(nc -u -l -p "$port")
  if [[ "$marker" == "END_OF_TRANSMISSION" ]]; then
    echo "End of transmission detected."
    break
  fi
done

# Step 5: Kill the netcat process receiving the binary data
kill $nc_pid

echo "File received successfully. Saved to '$received_file'."

