sandbox_env = {
    assert = assert,
    error = error,
    ipairs = ipairs,
    next = next,
    pairs = pairs,
    pcall = pcall,
    print = print,
    select = select,
    tonumber = tonumber,
    tostring = tostring,
    setmetatable = setmetatable,
    type = type,
    unpack = unpack,
    _VERSION = _VERSION,
    xpcall = xpcall,
    coroutine = { create = coroutine.create, resume = coroutine.resume, 
        running = coroutine.running, status = coroutine.status, 
        wrap = coroutine.wrap },
    string = { byte = string.byte, char = string.char, find = string.find, 
        format = string.format, gmatch = string.gmatch, gsub = string.gsub, 
        len = string.len, lower = string.lower, match = string.match, 
        rep = string.rep, reverse = string.reverse, sub = string.sub, 
        upper = string.upper },
    table = { insert = table.insert, maxn = table.maxn, remove = table.remove, 
        sort = table.sort },
    math = { abs = math.abs, acos = math.acos, asin = math.asin, 
        atan = math.atan, atan2 = math.atan2, ceil = math.ceil, cos = math.cos, 
        cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, 
        fmod = math.fmod, frexp = math.frexp, huge = math.huge, 
        ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, 
        min = math.min, modf = math.modf, pi = math.pi, pow = math.pow, 
        rad = math.rad, random = math.random, sin = math.sin, sinh = math.sinh, 
        sqrt = math.sqrt, tan = math.tan, tanh = math.tanh },
    os = { clock = os.clock, difftime = os.difftime, time = os.time },
    io = { read = io.read, write = io.write, flush = io.flush, type = io.type,
           stdin = io.stdin, stdout = io.stdout, stderr = io.stderr }
}
function run_sandbox(file)
    local f, msg = loadfile(file,'b',sandbox_env)
    if not f then return nil, msg end
    return pcall(f)
end
b,msg = run_sandbox('luac.out')
if not b then
    io.stderr:write("error: " .. msg .. "\n")
    os.exit(1)
end
