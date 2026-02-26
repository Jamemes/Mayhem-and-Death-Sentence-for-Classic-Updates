local data = HUDBlackScreen.set_job_data
function HUDBlackScreen:set_job_data()
	data(self)
	
	local job_panel = self._blackscreen_panel:child("job_panel")
	if job_panel:num_children() > 1 then
		local risk_panel = job_panel:child(0)
		local risk_text = job_panel:child(1)
		
		local dw_skull = tweak_data.gui.blackscreen_risk_textures.overkill_290
		local skulls = risk_panel:num_children()
		
		if skulls >= 4 then
			if DB:has("texture", "guis/textures/pd2/risklevel_deathwish_easywish_blackscreen") then
				risk_panel:child(3):set_image("guis/textures/pd2/risklevel_deathwish_easywish_blackscreen")
			else
				risk_panel:child(3):set_image("guis/textures/pd2/risklevel_deathwish_blackscreen")
			end
		end
		
		if skulls >= 6 then
			if DB:has("texture", "guis/textures/pd2/risklevel_deathwish_sm_blackscreen") then
				risk_panel:child(5):set_image("guis/textures/pd2/risklevel_deathwish_sm_blackscreen")
			else
				risk_panel:child(5):set_image("guis/textures/pd2/risklevel_deathwish_blackscreen")
			end
		end
		
		if skulls == 4 then
			risk_text:set_text(managers.localization:to_upper_text("menu_difficulty_easy_wish"))
		elseif skulls == 6 then
			risk_text:set_text(managers.localization:to_upper_text("menu_difficulty_sm_wish"))
		end
	end
end