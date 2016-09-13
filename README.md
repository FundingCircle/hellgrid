# Hellgrid

Utility which will output a table containing gem versions used across your projects.

![Build Status](https://circleci.com/gh/FundingCircle/hellgrid.svg?style=shield&circle-token=:circle-token)

## Install

```bash
gem install hellgrid
```

## Usage

Let say that you have a directory `/path/to/root/dir` somewhere in which the Ruby projects `foo` and `bar` could be found.

Executing:
```bash
hellgrid /path/to/root/dir
```

To search recursively (should you have nested projects), use the `-r ` flag:
```
hellgrid -r /path/to/root/dir
```

Should result in:
```bash
             x             |  bar   |  foo
---------------------------+--------+--------
         diff-lcs          | 1.2.5  | 1.2.5
           rspec           | 2.0.0  | 3.0.0
        rspec-core         | 2.0.0  | 3.0.4
    rspec-expectations     | 2.0.0  | 3.0.4
        rspec-mocks        | 2.0.0  | 3.0.4
           rake            | 10.0.0 | 11.1.0
       rspec-support       |   x    | 3.0.4
          hellgrid         |   x    |   x
```
