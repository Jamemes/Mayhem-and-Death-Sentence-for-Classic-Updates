
Global.HCWP = Global.HCWP or {}
local data = NetworkPeer.send
function NetworkPeer:send(func_name, ...)
	local send_data = {...}

	if not Global.HCWP[self:ip()] and Global.game_settings.difficulty == "easy_wish" then
		if func_name == "join_request_reply" then
			send_data[5] = 5
		elseif func_name == "sync_game_settings" then
			send_data[3] = 5
		elseif func_name == "lobby_sync_update_difficulty" then
			send_data[1] = "overkill_145"
		end
	end

	data(self, func_name, unpack(send_data))

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