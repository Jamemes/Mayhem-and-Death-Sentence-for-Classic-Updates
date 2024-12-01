local function add_material_translation_map(path_string, tbl)
	for _, character in ipairs(tbl) do
		character_path = path_string .. character .. "/" .. character
		CopBase._material_translation_map[tostring(Idstring(character_path):key())] = Idstring(character_path .. "_contour")
		CopBase._material_translation_map[tostring(Idstring(character_path .. "_contour"):key())] = Idstring(character_path)
	end
end

add_material_translation_map("units/pd2_dlc_gitgud/characters/", {
	"ene_zeal_swat",
	"ene_zeal_swat_heavy",
	"ene_zeal_cloaker",
	"ene_zeal_tazer",
	"ene_zeal_swat_shield",
	"ene_zeal_bulldozer",
	"ene_zeal_bulldozer_2",
	"ene_zeal_bulldozer_3"
})