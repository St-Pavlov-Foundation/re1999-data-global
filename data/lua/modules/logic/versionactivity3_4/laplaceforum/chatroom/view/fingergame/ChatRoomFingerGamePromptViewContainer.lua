-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGamePromptViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGamePromptViewContainer", package.seeall)

local ChatRoomFingerGamePromptViewContainer = class("ChatRoomFingerGamePromptViewContainer", BaseViewContainer)

function ChatRoomFingerGamePromptViewContainer:buildViews()
	local views = {
		ChatRoomFingerGamePromptView.New()
	}

	return views
end

return ChatRoomFingerGamePromptViewContainer
