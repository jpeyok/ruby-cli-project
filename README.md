# ruby-cli-project

Simple project that scans a given directory for jpg files and outputs a csv containing GPS info for the found files, if any.
Writes results to `/output.csv`

# Example Usage
```
ruby main.rb extract_dir
ruby main.rb extract_dir './gps_images/'
ruby main.rb extract_dir '/Users/josh.peyok/Documents/'
```

# Future improvements
1. Adding tests
2. Allow user to specify directory for the output csv
3. Allow user to specify output file with options to Overwrite or Append
4. Expand capabilities to enable outputting in XML 
4. Expand capabilities to enable outputting in HTML