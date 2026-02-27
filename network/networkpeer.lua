local func_overrides = {
	join_request_reply = {5, 5},
	sync_game_settings = {3, 5},
	lobby_sync_update_difficulty = {1, "overkill_145"}
}

Global.HCWP = Global.HCWP or {}
local data = NetworkPeer.send
function NetworkPeer:send(func_name, ...)
	local send_data = {...}
	if not Global.HCWP[self:ip()] and Global.game_settings.difficulty == "easy_wish" and func_overrides[func_name] then
		send_data[func_overrides[func_name][1]] = func_overrides[func_name][2]
		data(self, func_name, unpack(send_data))
	else
		data(self, func_name, ...)
	end

	if not Global.HCWP[self:ip()] and Global.game_settings.difficulty == "sm_wish" and _G.LuaNetworking:IsHost() then
		if func_name == "lobby_info" then
			managers.network:session():send_to_peers("kick_peer", self:id(), 2)
			managers.network:session():on_peer_kicked(self, self:id(), 2)
		end
	end
end

local data = NetworkPeer.set_dlcs
function NetworkPeer:set_dlcs(dlcs)
	if string.find(tostring(dlcs), "CockswarmingParty") then
		Global.HCWP[self._user_id] = true
	else
		Global.HCWP[self._user_id] = nil
	end
	data(self, dlcs)
end