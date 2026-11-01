# Tiny Mask

**Lua** · **v0.1.0**

_Sudoku solver using constraint-checked backtracking_

---

## Features

- Loads a 9x9 puzzle from a file (0 = empty) or uses a built-in sample
- Backtracking search with row/column/box validity checks
- Reports attempt count and solve time

## Installation

```bash
git clone https://github.com/DevCode01/tiny-mask.git
cd tiny-mask
```

## Usage

```bash
lua tiny-mask.lua
```

## How it works

Empty cells (0) are filled one at a time via depth-first backtracking: for each empty cell, try digits 1-9, check row/column/3x3-box constraints, recurse, and undo on failure. Reports the number of digit-placement attempts and wall-clock solve time.

## Options

- `<file>` - path to a 9-line, 9-digit-per-line puzzle (0 = empty); uses a built-in sample if omitted

## Example

```bash
$ lua tiny-mask.lua
Puzzle (30/81 filled):
5 3 0 | 0 7 0 | 0 0 0
6 0 0 | 1 9 5 | 0 0 0
0 9 8 | 0 0 0 | 0 6 0
------+-------+------
8 0 0 | 0 6 0 | 0 0 3
4 0 0 | 8 0 3 | 0 0 1
7 0 0 | 0 2 0 | 0 0 6
------+-------+------
0 6 0 | 0 0 0 | 2 8 0
0 0 0 | 4 1 9 | 0 0 5
0 0 0 | 0 8 0 | 0 7 9

Solved in 37652 backtracking attempts (0.0134s):
5 3 4 | 6 7 8 | 9 1 2
6 7 2 | 1 9 5 | 3 4 8
1 9 8 | 3 4 2 | 5 6 7
------+-------+------
8 5 9 | 7 6 1 | 4 2 3
4 2 6 | 8 5 3 | 7 9 1
7 1 3 | 9 2 4 | 8 5 6
------+-------+------
9 6 1 | 5 3 7 | 2 8 4
2 8 7 | 4 1 9 | 6 3 5
3 4 5 | 2 8 6 | 1 7 9
```

## Testing

```bash
bash tests/run.sh
```

Includes a functional check against real captured output, plus the build/syntax check.

## License

MIT
