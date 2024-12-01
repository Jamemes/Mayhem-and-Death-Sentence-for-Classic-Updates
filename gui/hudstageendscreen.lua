Hooks:PostHook(HUDStageEndScreen, "init", "CUS_init_new_difficulties_endscreen", function(self)
	local difficulty_stars = managers.job:has_active_job() and managers.job:current_difficulty_stars() or 0
	local risks = {
		"risk_murder_squad",
		"risk_murder_squad"
	}
	for i, name in ipairs(risks) do
		local texture, rect = tweak_data.hud_icons:get_icon_data(name)
		if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
			texture = i == 2 and "guis/textures/pd2/hud_difficultymarkers_2" or texture
			rect = i == 2 and {30, 32, 30, 30} or rect
		end
		
		local active = i == 1 and difficulty_stars >= 5 or difficulty_stars == 6
		local color = active and tweak_data.screen_colors.risk or tweak_data.screen_colors.text
		local alpha = active and 1 or 0.25
		local risk = self._paygrade_panel:bitmap({
			name = i == 1 and "risk_easy_wish" or "risk_sm_wish",
			texture = texture,
			texture_rect = rect,
			x = 0,
			y = 0,
			alpha = alpha,
			color = color
		})
	end
	
	local pg_text = self._foreground_layer_safe:child("pg_text")
	local risk_swat = self._paygrade_panel:child("risk_swat")
	local risk_fbi = self._paygrade_panel:child("risk_fbi")
	local risk_death_squad = self._paygrade_panel:child("risk_death_squad")
	local risk_murder_squad = self._paygrade_panel:child("risk_murder_squad")
	local risk_easy_wish = self._paygrade_panel:child("risk_easy_wish")
	local risk_sm_wish = self._paygrade_panel:child("risk_sm_wish")
	if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
		risk_murder_squad:set_image("guis/textures/pd2/hud_difficultymarkers_2", 90, 0, 30, 30)
	end
	
	risk_sm_wish:set_x(risk_murder_squad:x())
	risk_easy_wish:set_x(risk_death_squad:x())
	risk_murder_squad:set_x(risk_fbi:x())
	risk_death_squad:set_x(risk_swat:x())
	risk_fbi:set_right(risk_death_squad:left())
	risk_swat:set_right(risk_fbi:left())
	
	risk_fbi:set_rotation(360)
	risk_swat:set_rotation(360)

	pg_text:set_left(pg_text:left() - 65)
end)