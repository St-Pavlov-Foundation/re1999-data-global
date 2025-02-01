module("modules.logic.social.defines.ChatEnum", package.seeall)

slot0 = _M
slot0.MsgType = {
	RoomSeekShare = 1,
	RoomShareCode = 2
}
slot0.MsgTypeOPLang = {
	[slot0.MsgType.RoomSeekShare] = "room_chatop_seek_share_title",
	[slot0.MsgType.RoomShareCode] = "room_chatop_share_code_title"
}

return slot0
