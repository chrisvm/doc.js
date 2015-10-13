Configuration
=============

Configuration for the creation of markdown files is done by a file named
`docjs.yml` or `docjs.json`. This file is required and its absence will cause
an error.

*Note: Implementation for `.json` config file support is not finished*


## Options

`input_dir` | `array(string)` | `string`

A directory or list of directories where to look for the javascript files. All
directories are searched recursively unless the 'recursive_search' option is set
to `false`.

____

`output_dir` | `string`

A directory where the markdown files will be generated

____

`recursive_search` | `bool`

Whether to recurse through the subdirectories in `input_dir`

## Tests

- `conf_input_dir_dir_check`: method which checks if the configuration option
`input_dir` is a list of strings or a string
