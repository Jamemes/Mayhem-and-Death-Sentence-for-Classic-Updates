local data = ClientNetworkSession.on_join_request_reply
function ClientNetworkSession:on_join_request_reply(reply, my_peer_id, my_character, level_index, difficulty_index, ...)
	difficulty_index = difficulty_index == 6 and 7 or difficulty_index
	
	data(self, reply, my_peer_id, my_character, level_index, difficulty_index, ...)
end