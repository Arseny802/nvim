vim.wo.number = true
vim.wo.relativenumber = false

vim.opt.shell = "/bin/zsh"

if vim.g.neovide then
    vim.g.neovide_scale_factor = 0.85
    vim.opt.linespace = 0

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    -- Helper function for transparency formatting
    local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
    end
    -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    vim.g.neovide_transparency = 0.92
    vim.g.transparency = 0.80
    vim.g.neovide_normal_opacity = 0.8
    vim.g.neovide_background_color = "#0f1117" .. alpha()

    vim.g.neovide_title_background_color = string.format(
        "%x",
        vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
    )

    vim.g.neovide_title_text_color = "pink"
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_floating_corner_radius = 0.0

    vim.g.neovide_show_border = false
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5

    -- vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
    vim.g.neovide_cursor_vfx_mode = "railgun"

    vim.g.neovide_cursor_unfocused_outline_width = 0.125
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 2.8
    vim.g.neovide_cursor_vfx_particle_density = 11.0
    vim.g.neovide_cursor_vfx_particle_curl = 2.0

end

