local fidget_status_ok, fidget = pcall(require, "fidget")
if not fidget_status_ok then
    return
end

fidget.setup{
    text = {
        spinner = "pipe",         -- animation shown when tasks are ongoing
        done = "✓",               -- character shown when all tasks are complete
        commenced = "Started",    -- message shown when task starts
        completed = "Completed",  -- message shown when task completes
    },
}
