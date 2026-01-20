-- chunkname: @modules/logic/scene/udimo/entitycomp/fsm/states/UdimoInteractState.lua

module("modules.logic.scene.udimo.entitycomp.fsm.states.UdimoInteractState", package.seeall)

local UdimoInteractState = class("UdimoInteractState", UdimoBaseState)

function UdimoInteractState:onFSMStart()
	self:_clearData()
end

function UdimoInteractState:_clearData()
	self.param = nil
end

function UdimoInteractState:onEnter(param)
	self._entity = self.fsm:getEntity()

	if self._entity then
		self._entity:checkAndAdjustPos()
		self._entity:refreshOrderLayer()

		local udimoId = self._entity:getId()

		UdimoController.instance:playUdimoAnimation(udimoId, UdimoEnum.SpineAnim.Idle, true, true)
	end

	UdimoController.instance:playNextFriendInteractEmoji(param and param.friendId)
end

function UdimoInteractState:onUpdate()
	local emojiId = self.param and self.param.emojiId

	if not emojiId or not self._entity then
		return
	end

	self.param.emojiId = nil

	self._entity:playEmoji(emojiId, self._playEmojiFinish, self)
end

function UdimoInteractState:_playEmojiFinish()
	local friendId = self.param and self.param.friendId

	UdimoController.instance:playNextFriendInteractEmoji(friendId)
end

function UdimoInteractState:onExit()
	self:_clearData()
end

function UdimoInteractState:onFSMStop()
	self:_clearData()
end

function UdimoInteractState:onClear()
	self:_clearData()
end

return UdimoInteractState
