Configuration
=============

Configuration for the creation of markdown files is done by a file named
`docjs.yml` or `docjs.json`. This file is required and its absence will cause
an error.

## Options

`input_dir` | `array(string)` | `string` | `Required`

A directory or list of directories where to look for the javascript files. All
directories are searched recursively unless the 'recursive_search' option is set
to `false`.

____

`output_dir` | `string` | `Required`

A directory where the markdown files will be generated

____

`recursive_search` | `bool` | `Default: true`

Whether to recurse through the subdirectories in `input_dir`

____

`follow_structure` | `bool` | `Default: true`

Whether to follow the structure of the `input_dir` directory or to just create
files to `output_dir`, using its path to create the filenames.
