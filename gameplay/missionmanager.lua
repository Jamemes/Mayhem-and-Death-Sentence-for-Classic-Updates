local difficulty = Global.game_settings and Global.game_settings.difficulty or "easy"
Hooks:PostHook(MissionManager, "init", "CUS_load_zeals_classic_updates", function()
	if difficulty == "sm_wish" and DB:has("texture", "units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/swat_heavy_head_df") and PackageManager:package_exists("packages/sm_wish") and not PackageManager:loaded("packages/sm_wish") then
		PackageManager:load("packages/sm_wish")
	end
end)