local data = ConnectionNetworkHandler.request_join
function ConnectionNetworkHandler:request_join(peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, auth_ticket, sender)
	if Global.game_settings.difficulty == "sm_wish" and not string.find(dlcs, "CockswarmingParty") then
		gameversion = 0
	end
	
	data(self, peer_name, preferred_character, dlcs, xuid, peer_level, gameversion, join_attempt_identifier, auth_ticket, sender)
end