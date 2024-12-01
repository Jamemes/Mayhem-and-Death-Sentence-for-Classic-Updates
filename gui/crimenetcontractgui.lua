local data = CrimeNetContractGui.init
function CrimeNetContractGui:init(ws, fullscreen_ws, node)
	data(self, ws, fullscreen_ws, node)

	if node:item("difficulty") then
		local opt = node:item("difficulty")._all_options
		if opt[5]._parameters.text_id ~= "menu_difficulty_easy_wish" then
			local ew = deep_clone(opt[5])
			ew._parameters.text_id = "menu_difficulty_easy_wish"
			ew._parameters.value = 6
			table.insert(opt, 5, ew)
		end
		
		opt[6]._parameters.value = 7
		
		if not opt[7] or opt[7]._parameters.text_id ~= "menu_difficulty_sm_wish" then
			local ew = deep_clone(opt[5])
			ew._parameters.text_id = "menu_difficulty_sm_wish"
			ew._parameters.value = 8
			table.insert(opt, 7, ew)
		end
	end
	
	local job_data = self._node:parameters().menu_component_data
	local risk_text = self._contract_panel:child("risk_text")
	local risk_stats_panel = self._contract_panel:child("risk_stats_panel")
	local risk_murder_squad = self._contract_panel:child("risk_murder_squad")

	if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
		risk_murder_squad:set_image("guis/textures/pd2/hud_difficultymarkers_2", 90, 0, 30, 30)
	end
	
	local risks = {
		"risk_murder_squad",
		"risk_murder_squad"
	}
	local rsx = 15
	local max_x = 0
	local max_y = 0
	for i, name in ipairs(risks) do
		local texture, rect = tweak_data.hud_icons:get_icon_data("risk_murder_squad")
		
		if DB:has("texture", "guis/textures/pd2/hud_difficultymarkers_2") then
			texture = i == 2 and "guis/textures/pd2/hud_difficultymarkers_2" or texture
			rect = i == 2 and {30, 32, 30, 30} or rect
		end
		
		local color = Color.white
		local alpha = 0.25
		local risk = self._contract_panel:bitmap({
			name = name..i,
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
		local stat = managers.statistics:completed_job(job_data.job_id, difficulty_name)
		local risk_stat = risk_stats_panel:text({
			name = name..i,
			font = tweak_data.menu.pd2_small_font,
			font_size = tweak_data.menu.pd2_small_font_size,
			text = tostring(stat),
			align = "center"
		})
		self:make_fine_text(risk_stat)
		risk_stat:set_world_center_x(risk:world_center_x() - 1)
		risk_stat:set_x(math.round(risk_stat:x()))
		color = Color.white
		alpha = 0.5
		risk_stat:set_color(color)
		risk_stat:set_alpha(alpha)
		max_y = math.max(max_y, risk:bottom())
		max_x = math.max(max_x, risk:right() + 5)
		max_x = math.max(max_x, risk_stat:right() + risk_stats_panel:left() + 10)
	end
	
	local ew_stat = risk_stats_panel:child("risk_murder_squad")
	ew_stat:set_text(managers.statistics:completed_job(job_data.job_id, "easy_wish"))
	
	local sm_wish = self._contract_panel:child("risk_murder_squad2")
	risk_text:set_w(300)
	risk_text:set_left(sm_wish:right() + 12)
end

local function set(difficulty_id, diff, panel)
	local death_wish = panel:child("risk_murder_squad1")
	death_wish:set_color(diff >= 7 and tweak_data.screen_colors.risk or Color.white)
	death_wish:set_alpha(diff >= 7 and 1 or 0.25)
	
	local sm_wish = panel:child("risk_murder_squad2")
	sm_wish:set_color(diff == 8 and tweak_data.screen_colors.risk or Color.white)
	sm_wish:set_alpha(diff == 8 and 1 or 0.25)
	
	local risk_stats_panel = panel:child("risk_stats_panel")
	local dw_stat = risk_stats_panel:child("risk_murder_squad1")
	dw_stat:set_color(diff >= 7 and tweak_data.screen_colors.risk or Color.white)
	dw_stat:set_alpha(difficulty_id == diff and diff == 7 and 1 or 0.5)
	
	local sm_stat = risk_stats_panel:child("risk_murder_squad2")
	sm_stat:set_color(diff == 8 and tweak_data.screen_colors.risk or Color.white)
	sm_stat:set_alpha(difficulty_id == diff and diff == 8 and 1 or 0.5)
end

function CrimeNetContractGui:set_difficulty_id(difficulty_id)
	local job_data = self._node:parameters().menu_component_data
	job_data.difficulty_id = difficulty_id
	job_data.difficulty = tweak_data.difficulties[difficulty_id]
	local menu_risk_id = "menu_risk_pd"
	if job_data.difficulty == "hard" then
		menu_risk_id = "menu_risk_swat"
	elseif job_data.difficulty == "overkill" then
		menu_risk_id = "menu_risk_fbi"
	elseif job_data.difficulty == "overkill_145" then
		menu_risk_id = "menu_risk_special"
	elseif job_data.difficulty == "easy_wish" then
		menu_risk_id = "menu_risk_special_plus"
	elseif job_data.difficulty == "overkill_290" then
		menu_risk_id = "menu_risk_elite"
	elseif job_data.difficulty == "sm_wish" then
		menu_risk_id = "menu_risk_last_chance"
	end
	local stat = managers.statistics:completed_job(job_data.job_id, tweak_data:index_to_difficulty(difficulty_id))
	local risk_text = self._contract_panel:child("risk_text")
	risk_text:set_text(managers.localization:to_upper_text(menu_risk_id) .. " " .. managers.localization:to_upper_text("menu_stat_job_completed", {
		stat = tostring(stat)
	}) .. " ")
	
	self:set_all()
	set(difficulty_id, difficulty_id, self._contract_panel)
end

Hooks:PostHook(CrimeNetContractGui, "count_difficulty_stars", "HVT_count_difficulty_skulls", function(self, t, ...)
	local job_data = self._node:parameters().menu_component_data
	local stat = managers.statistics:completed_job(job_data.job_id, tweak_data:index_to_difficulty(job_data.difficulty_id))
	local risk_text = self._contract_panel:child("risk_text")
	
	if job_data.difficulty == "easy_wish" or job_data.difficulty == "sm_wish" then
		risk_text:set_text(managers.localization:to_upper_text(job_data.difficulty == "easy_wish" and "menu_risk_special_plus" or "menu_risk_last_chance") .. " " .. managers.localization:to_upper_text("menu_stat_job_completed", {
			stat = tostring(stat)
		}) .. " ")
	end
	
	set(job_data.difficulty_id, self._current_difficulty_star + 2, self._contract_panel)
end)