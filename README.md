# Html Table formatter plugin for Embulk

TODO: Write short description here and embulk-formatter-html_table.gemspec file.

## Overview

* **Plugin type**: formatter

## Configuration

- **option1**: description (integer, required)
- **option2**: description (string, default: `"myvalue"`)
- **option3**: description (string, default: `null`)

## Example

```yaml
out:
  type: any output input plugin type
  formatter:
    type: html_table
    option1: example1
    option2: example2
```


## Build

```
$ rake
```
