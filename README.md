# Hellgrid

Utility which will output a table containing gem versions used across your projects.

[![Build & Test](https://github.com/FundingCircle/hellgrid/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/FundingCircle/hellgrid/actions/workflows/build-and-test.yml)

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

```bash
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
```

To have the gems as columns, use the `-t` flag:

```bash
hellgrid -t /path/to/root/dir
```

Should result in:

```bash
   x    | diff-lcs |  rake  | rspec | rspec-core | rspec-expectations | rspec-mocks | rspec-support
--------+----------+--------+-------+------------+--------------------+-------------+---------------
  bar   |  1.2.5   | 10.0.0 | 2.0.0 |   2.0.0    |       2.0.0        |    2.0.0    |       x
  foo   |  1.2.5   | 11.1.0 | 3.0.0 |   3.0.4    |       3.0.4        |    3.0.4    |     3.0.4
```

## License

Copyright © 2016 Funding Circle.

Distributed under the BSD 3-Clause License.
