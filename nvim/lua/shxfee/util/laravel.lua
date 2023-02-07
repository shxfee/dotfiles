local vim = vim
local fn = vim.fn

local M = {}

-- Read laravel env into a table
function M.read_env()
  local readable, file = pcall(fn.readfile, '.env')
  if not readable then return {} end

  return file
end


-- Check if pwd is a laravel project
-- Check for the existance of laravel package in vendor directory
function M.is_laravel()
  return fn.filereadable('vendor/laravel/framework/composer.json') ~= 0
end


-- Parse Env into a lua table
function M.get_env()
  local env = {}

  for _, line in ipairs(M.read_env()) do
    local splits = vim.split(line, '=')

    if (splits[1] ~= nil) then
      env[splits[1]] = splits[2]
    end
  end

  return env
end


-- Get the global DB connection string for DADBOD
function M.get_db_connection_string()
  if not M.is_laravel() then return nil end

  local e = M.get_env()
  local con = "mysql://%s:%s@localhost/%s"

  return string.format(
    con,
    e.DB_USERNAME,
    e.DB_PASSWORD,
    e.DB_DATABASE
  )
end


-- Set the global DB connection string for DADBOD
function M.set_db_connection_string()
  vim.g.db = M.get_db_connection_string()
end


-- Open adminer on the browser
function M.open_adminer()
  if not M.is_laravel() then return nil end

  local c = '!cmd.exe /C start '
  local e = M.get_env()

  local a =  'http://localhost/adminer?username='.. e.DB_USERNAME .. '^&db=' .. e.DB_DATABASE
  c = c .. fn.shellescape(a)

  pcall(fn.execute, c)
end


-- Open the application on the browser
function M.open_app()
  if not M.is_laravel() then return nil end

  local c = '!cmd.exe /C start '
  local e = M.get_env()

  local a =  'http://localhost/'

  if e.APP_URL ~= nil then
    a = e.APP_URL
  end

  c = c .. fn.shellescape(a)

  pcall(fn.execute, c)
end

return M
