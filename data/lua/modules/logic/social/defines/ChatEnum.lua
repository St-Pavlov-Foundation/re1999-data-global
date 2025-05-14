module("modules.logic.social.defines.ChatEnum", package.seeall)

local var_0_0 = _M

var_0_0.MsgType = {
	RoomSeekShare = 1,
	RoomShareCode = 2
}
var_0_0.MsgTypeOPLang = {
	[var_0_0.MsgType.RoomSeekShare] = "room_chatop_seek_share_title",
	[var_0_0.MsgType.RoomShareCode] = "room_chatop_share_code_title"
}

return var_0_0
