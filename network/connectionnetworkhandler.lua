local data = ConnectionNetworkHandler.lobby_sync_update_difficulty
function ConnectionNetworkHandler:lobby_sync_update_difficulty(difficulty)
	Global.game_settings.difficulty = difficulty
	
	if managers.menu_component then
		managers.menu_component:on_job_updated()
	end

	data(self, difficulty)
end

local data = ConnectionNetworkHandler.request_join
function ConnectionNetworkHandler:request_join(peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, auth_ticket, sender)
	local is_new_diffs = Global.game_settings.difficulty == "easy_wish" or Global.game_settings.difficulty == "sm_wish"
	if is_new_diffs and not string.find(dlcs, "CockswarmingParty") then
		gameversion = 0
	end
	
	data(self, peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, auth_ticket, sender)
end