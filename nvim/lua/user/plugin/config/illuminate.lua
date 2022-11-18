local ok, illuminate = pcall(require, "illuminate")
if not ok then
    return
end

illuminate.configure()
