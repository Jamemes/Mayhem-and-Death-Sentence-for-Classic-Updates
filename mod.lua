HCWP = HCWP or ModInstance
HCWP.packages = HCWP.supermod._assets.script_loadable_packages
function HCWP:load_package(package)
	for _, spec in ipairs(HCWP.packages[package].assets) do
		local can_create_entry = nil
		local ext = Idstring(spec.extension)
		local path = Idstring(spec.dbpath)
		local file = spec.file
		
		if DB and DB.create_entry then
			DB:create_entry(ext, path, file)
			can_create_entry = true
		elseif blt and blt.db_create_entry then
			local recode = {
				[Idstring("sequence_manager"):key()] = "scriptdata",
				[Idstring("font"):key()] = "font"
			}
			blt:db_create_entry(ext, path, file, {recode_type = recode[ext:key()]})
			can_create_entry = true
		end

		if can_create_entry and not managers.dyn_resource:has_resource(ext, path, "packages/dyn_resources") then
			managers.dyn_resource:load(ext, path, "packages/dyn_resources", function() end)
		else
			break
		end
	end
end

function HCWP:unload_package(package)
	for _, spec in ipairs(HCWP.packages[package].assets) do
		if managers.dyn_resource:has_resource(Idstring(spec.extension), Idstring(spec.dbpath), "packages/dyn_resources") then
			managers.dyn_resource:unload(Idstring(spec.extension), Idstring(spec.dbpath), "packages/dyn_resources", false)
		else
			break
		end
	end
end

local difficulty = Global.game_settings and Global.game_settings.difficulty or "easy"
if difficulty == "sm_wish" and Global.load_level then
	HCWP:load_package("packages/sm_wish")
else
	HCWP:unload_package("packages/sm_wish")
end