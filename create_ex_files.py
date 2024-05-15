import argparse
import os

def create_sql_files(directory, number_of_files):
  if not os.path.exists(directory):
    print(f"Error: Directory '{directory}' does not exist.")
    return

  for _ in range(number_of_files):
    base_filename = "EX"
    extension = ".sql"
    counter = 1

    # Generate unique filename with increasing counter
    filename = os.path.join(directory, f"{base_filename}{counter}{extension}")
    while os.path.exists(filename):
      counter += 1
      filename = os.path.join(directory, f"{base_filename}{counter}{extension}")

    with open(filename, mode='w') as file:
      # Optionally write some content to the files (e.g., filename)
      file.write(f"{filename}\n")

  print(f"{number_of_files} SQL files created in directory: {directory}")

if __name__ == "__main__":
  parser = argparse.ArgumentParser(description="Create SQL files in a directory.")
  parser.add_argument("-d", "--directory", required=True, help="Path to the directory")
  parser.add_argument("-n", "--number", type=int, required=True, help="Number of SQL files to create")

  args = parser.parse_args()
  create_sql_files(args.directory, args.number)
