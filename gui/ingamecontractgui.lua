local function get_skull_index(panel, id)
	for i = 0, panel:num_children() - 1 do
		if panel:child(i) and panel:child(i):name() == id then
			return i
		end
	end
end

Hooks:PostHook(IngameContractGui, "init", "HVT_init_new_difficulties_ingame", function(self, ...)
	local text_panel = self._panel:child(1)
	local id = get_skull_index(text_panel, "risk_stats_panel")
	local risk_text = text_panel:child("risk_text")
	local risk_stats_panel = text_panel:child("risk_stats_panel")
	local risk_murder_squad = text_panel:child(id + 4)
	if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
		risk_murder_squad:set_image("guis/textures/pd2/hud_difficultymarkers_2", 90, 0, 30, 30)
	end
	
	local risks = {
		"risk_murder_squad",
		"risk_murder_squad"
	}
	local job_id = managers.job:current_job_id()
	local difficulty_stars = managers.job:current_difficulty_stars()
	local rsx = 15
	local max_x = 0
	local max_y = 0
	local font_size = tweak_data.menu.pd2_small_font_size
	local font = tweak_data.menu.pd2_small_font
	for i, name in ipairs(risks) do
		local texture, rect = tweak_data.hud_icons:get_icon_data("risk_murder_squad")
		
		if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
			texture = i == 2 and "guis/textures/pd2/hud_difficultymarkers_2" or texture
			rect = i == 2 and {30, 32, 30, 30} or rect
		end
		
		if i == 1 then
			active = 5 <= difficulty_stars
			current = 5 == difficulty_stars
		elseif i == 2 then
			active = 6 <= difficulty_stars
			current = 6 == difficulty_stars
		end
		
		local color = active and tweak_data.screen_colors.risk or Color.white
		local alpha = active and 1 or 0.25
		local risk = text_panel:bitmap({
			name = i == 1 and "risk_easy_wish" or "risk_sm_wish",
			texture = texture,
			texture_rect = rect,
			x = 0,
			y = 0,
			alpha = alpha,
			color = color
		})
		risk:set_x(risk_murder_squad:right() + rsx - 15)
		risk:set_top(math.round(risk_murder_squad:top()))
		rsx = rsx + risk:w() + 2
		local difficulty_name = i == 1 and "overkill_290" or i == 2 and "sm_wish"
		local stat = managers.statistics:completed_job(job_id, difficulty_name)
		local risk_stat = risk_stats_panel:text({
			name = i == 1 and "risk_easy_wish" or "risk_sm_wish",
			font = font,
			font_size = font_size,
			text = tostring(stat),
			align = "center"
		})
		local x, y, w, h = risk_stat:text_rect()
		risk_stat:set_size(w, h)
		risk_stat:set_world_center_x(risk:world_center_x() - 1)
		risk_stat:set_x(math.round(risk_stat:x()))
		color = active and tweak_data.screen_colors.risk or Color.white
		alpha = current and 1 or active and 0.5 or 0.25
		risk_stat:set_color(color)
		risk_stat:set_alpha(alpha)
		max_y = math.max(max_y, risk:bottom())
		max_x = math.max(max_x, risk:right() + 5)
		max_x = math.max(max_x, risk_stat:right() + risk_stats_panel:left() + 10)
	end
	
	local ew_stat = risk_stats_panel:child("risk_murder_squad")
	ew_stat:set_text(managers.statistics:completed_job(job_id, "easy_wish"))
	
	local sm_wish = text_panel:child("risk_sm_wish")
	risk_text:set_w(300)
	risk_text:set_left(sm_wish:right() + 12)
	if difficulty_stars == 4 or difficulty_stars == 6 then
		local stat = managers.statistics:completed_job(job_id, tweak_data:index_to_difficulty(difficulty_id))
		risk_text:set_text(managers.localization:to_upper_text(difficulty_stars == 4 and "menu_risk_special_plus" or "menu_risk_last_chance") .. " " .. managers.localization:to_upper_text("menu_stat_job_completed", {
			stat = tostring(stat)
		}) .. " ")
	end
end)