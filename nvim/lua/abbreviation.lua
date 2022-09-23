local function i_abbreviation_str(lch, rch)
  return 'iab ' .. lch .. ' ' .. rch
end

local function all_abbreviations(list)
  for lch, rch in pairs(list) do
    vim.cmd(i_abbreviation_str(lch, rch))
  end
end

local function ft_abbreviation(ft, lch, rch)
  vim.cmd('autocmd FileType ' .. ft .. ' <silent> ', i_abbreviation_str(lch, rch))
end

local function all_ft_abbreviations(ft, list)
  for lch, rch in pairs(list) do
    ft_abbreviation(ft, lch, rch)
  end
end

--------------------
-- typo
--------------------
local list = {
  retrun = "return",
  improt = "import",
}

all_abbreviations(list)

--------------------
-- short cut
--------------------

-- sql
local list = {
  from = "FROM",
  where = "WHERE",
  order = "ORDER",
  by = "BY",
}

all_ft_abbreviations("sql", list)
