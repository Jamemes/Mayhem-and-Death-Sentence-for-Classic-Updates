Hooks:Add("LocalizationManagerPostInit", "hoxtons_#ockswarming_party_loc", function(...)
	LocalizationManager:add_localized_strings({
		menu_difficulty_easy_wish = "Mayhem",
		menu_difficulty_sm_wish = "Death Sentence",
		menu_risk_special_plus = "Mayhem. Extremely increased XP and cash.",
		menu_risk_last_chance = "Death Sentence. Unimaginably increased XP and cash.",
	})

	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_difficulty_easy_wish = "Хаос",
			menu_difficulty_sm_wish = "Смертный приговор",
			menu_risk_special_plus = "Хаос. Экстримально увеличены очки опыта и наличные.",
			menu_risk_last_chance = "Смертный приговор. Невообразимо увеличены очки опыта и наличные.",
		})
	end
end)

local data = MenuCrimeNetFiltersInitiator.add_filters
function MenuCrimeNetFiltersInitiator:add_filters(node)
	data(self, node)

	local opt = node:item("difficulty_filter")._all_options
	if opt[6]._parameters.text_id ~= "menu_difficulty_easy_wish" then
		local ew = deep_clone(opt[6])
		ew._parameters.text_id = "menu_difficulty_easy_wish"
		ew._parameters.value = 6
		table.insert(opt, 6, ew)
	end
	
	opt[7]._parameters.value = 7
	
	if not opt[8] or opt[8]._parameters.text_id ~= "menu_difficulty_sm_wish" then
		local ew = deep_clone(opt[6])
		ew._parameters.text_id = "menu_difficulty_sm_wish"
		ew._parameters.value = 8
		table.insert(opt, 8, ew)
	end
end