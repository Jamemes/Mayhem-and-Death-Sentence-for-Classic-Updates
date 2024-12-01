local data = ElementFilter._check_difficulty
function ElementFilter:_check_difficulty()
	local diff = Global.game_settings and Global.game_settings.difficulty or "hard"

	if self._values.difficulty_overkill_290 and diff == "easy_wish" then
		return true
	end
	
	if self._values.difficulty_overkill_290 and diff == "sm_wish" then
		return true
	end

	return data(self)
end