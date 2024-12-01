local data = ElementPointOfNoReturn.on_executed
function ElementPointOfNoReturn:on_executed(instigator)
	local diff = Global.game_settings and Global.game_settings.difficulty or "hard"

	if self._values.enabled and (diff == "easy_wish" or diff == "sm_wish") then
		managers.groupai:state():set_point_of_no_return_timer(self._values.time_overkill_290, self._id)
	end
	
	data(self)
end