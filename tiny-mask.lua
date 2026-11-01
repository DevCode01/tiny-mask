#!/usr/bin/env lua
-- Sudoku solver via constraint-propagation backtracking.

local SAMPLE = {
  "530070000",
  "600195000",
  "098000060",
  "800060003",
  "400803001",
  "700020006",
  "060000280",
  "000419005",
  "000080079",
}

local function load_grid(path)
  local grid = {}
  if path then
    local f = io.open(path, "r")
    if not f then
      io.stderr:write("Cannot open " .. path .. "\n")
      os.exit(1)
    end
    for line in f:lines() do
      line = line:gsub("%s+", "")
      if #line == 9 then
        table.insert(grid, line)
      end
    end
    f:close()
  else
    grid = SAMPLE
  end
  if #grid ~= 9 then
    io.stderr:write("Invalid puzzle: expected 9 rows of 9 digits\n")
    os.exit(1)
  end

  local board = {}
  for r = 1, 9 do
    board[r] = {}
    for c = 1, 9 do
      local ch = grid[r]:sub(c, c)
      board[r][c] = tonumber(ch) or 0
    end
  end
  return board
end

local function print_board(board)
  for r = 1, 9 do
    local row = {}
    for c = 1, 9 do
      table.insert(row, tostring(board[r][c]))
      if c % 3 == 0 and c < 9 then table.insert(row, "|") end
    end
    print(table.concat(row, " "))
    if r % 3 == 0 and r < 9 then
      print("------+-------+------")
    end
  end
end

local function is_valid(board, row, col, num)
  for i = 1, 9 do
    if board[row][i] == num then return false end
    if board[i][col] == num then return false end
  end
  local box_row = math.floor((row - 1) / 3) * 3
  local box_col = math.floor((col - 1) / 3) * 3
  for r = box_row + 1, box_row + 3 do
    for c = box_col + 1, box_col + 3 do
      if board[r][c] == num then return false end
    end
  end
  return true
end

local function find_empty(board)
  for r = 1, 9 do
    for c = 1, 9 do
      if board[r][c] == 0 then return r, c end
    end
  end
  return nil
end

local attempts = 0

local function solve(board)
  local row, col = find_empty(board)
  if not row then return true end

  for num = 1, 9 do
    attempts = attempts + 1
    if is_valid(board, row, col, num) then
      board[row][col] = num
      if solve(board) then return true end
      board[row][col] = 0
    end
  end
  return false
end

local function count_filled(board)
  local n = 0
  for r = 1, 9 do
    for c = 1, 9 do
      if board[r][c] ~= 0 then n = n + 1 end
    end
  end
  return n
end

local path = arg[1]
local board = load_grid(path)

print("Puzzle (" .. count_filled(board) .. "/81 filled):")
print_board(board)
print("")

local start = os.clock()
if solve(board) then
  local elapsed = os.clock() - start
  print(string.format("Solved in %d backtracking attempts (%.4fs):", attempts, elapsed))
  print_board(board)
else
  print("No solution exists for this puzzle.")
  os.exit(1)
end
