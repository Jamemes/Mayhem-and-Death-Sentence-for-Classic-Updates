local data = GenericDLCManager.dlcs_string
function GenericDLCManager:dlcs_string()
	local s = data(self)
	s = s .. "CockswarmingParty "

	return s
end