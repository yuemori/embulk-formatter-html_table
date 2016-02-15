# Html Table formatter plugin for Embulk

This plugin is formatter to html_table for Embulk

## Overview

* **Plugin type**: formatter

## Configuration

- **encoding**: encoding (string, default: `"UTF-8"`)
- **newline**: newline (string, default: `"LF"`)
- **to_br**: convert newline to `<BR>` (boolean, default: `true`)
- **timestamp_format**: timestamp to string format (string, default: `"%Y-%m-%d %H-%M-%S"`)

## Example

Config:

```yaml
out:
  type: any output input plugin type
  formatter:
    type: html_table
    encoding: "UTF-8"
    newline: "LF"
    to_br: true
    timestamp_format: "%Y-%m-%d %H-%M-%S"
```

Input:

```
id,account,time,purchase,comment
1,32864,2015-01-27 19:23:49,20150127,embulk
2,14824,2015-01-27 19:01:23,20150127,embulk jruby
3,27559,2015-01-28 02:20:02,20150128,"Embulk ""csv"" parser plugin"
4,11270,2015-01-29 11:54:36,20150129,NULL
```

Output:

```
<table>
<tr><th>id</th><th>account</th><th>time</th><th>purchase</th><th>comment</th></tr>
<tr><td>1</td><td>32864</td><td>2015-01-27 19-23-49</td><td>2015-01-27 00-00-00</td><td>embulk</td></tr>
<tr><td>2</td><td>14824</td><td>2015-01-27 19-01-23</td><td>2015-01-27 00-00-00</td><td>embulk jruby</td></tr>
<tr><td>3</td><td>27559</td><td>2015-01-28 02-20-02</td><td>2015-01-28 00-00-00</td><td>Embulk "csv" parser plugin</td></tr>
<tr><td>4</td><td>11270</td><td>2015-01-29 11-54-36</td><td>2015-01-29 00-00-00</td><td>NULL</td></tr>
</table>
```

## Build

```
$ rake
```
