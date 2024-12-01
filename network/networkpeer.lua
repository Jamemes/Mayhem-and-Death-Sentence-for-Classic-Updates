local is_new_diffs = Global.game_settings.difficulty == "easy_wish" or Global.game_settings.difficulty == "sm_wish"
local data = NetworkPeer.send
function NetworkPeer:send(func_name, ...)
	data(self, func_name, ...)
	if func_name == "join_request_reply" or func_name == "sync_game_settings" then
		data(self, "lobby_sync_update_difficulty", Global.game_settings.difficulty)
	end
end

local data = NetworkPeer.set_dlcs
function NetworkPeer:set_dlcs(dlcs)
	NetworkPeer._dlcs_str = dlcs
	
	data(self, dlcs)
end

local data = NetworkPeer.set_synched
function NetworkPeer:set_synched(state)
	if is_new_diffs and Network:is_server() and type(NetworkPeer._dlcs_str) == "string" and not string.find(NetworkPeer._dlcs_str, "CockswarmingParty") then
		managers.network:session():send_to_peers("kick_peer", self:id(), 4)
		managers.network:session():on_peer_kicked(self, self:id(), 4)

		return
	end
	
	data(self, state)
end