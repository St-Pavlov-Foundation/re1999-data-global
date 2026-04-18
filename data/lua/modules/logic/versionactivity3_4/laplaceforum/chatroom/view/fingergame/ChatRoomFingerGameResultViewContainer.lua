-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGameResultViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGameResultViewContainer", package.seeall)

local ChatRoomFingerGameResultViewContainer = class("ChatRoomFingerGameResultViewContainer", BaseViewContainer)

function ChatRoomFingerGameResultViewContainer:buildViews()
	local views = {
		ChatRoomFingerGameResultView.New()
	}

	return views
end

return ChatRoomFingerGameResultViewContainer
