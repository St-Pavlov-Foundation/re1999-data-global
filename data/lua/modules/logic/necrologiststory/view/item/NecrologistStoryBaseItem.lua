-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryBaseItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryBaseItem", package.seeall)

local NecrologistStoryBaseItem = class("NecrologistStoryBaseItem", LuaCompBase)

function NecrologistStoryBaseItem:ctor(storyView)
	self.storyView = storyView
end

function NecrologistStoryBaseItem:init(go)
	self.viewGO = go
	self.transform = go.transform
	self._height = 0
	self._posY = 0

	self:onInit()
end

function NecrologistStoryBaseItem:setCallback(playFinishCallback, playFinishCallbackObj, refreshHeightCallback, callbackObj)
	self.playFinishCallback = playFinishCallback
	self.playFinishCallbackObj = playFinishCallbackObj
	self.refreshHeightCallback = refreshHeightCallback
	self.callbackObj = callbackObj
end

function NecrologistStoryBaseItem:playStory(storyConfig, isSkip, ...)
	self._storyConfig = storyConfig

	self:setCallback(...)
	self.storyView:addControl(storyConfig, isSkip, true)
	self:onPlayStory(isSkip)
	self:refreshHeight()
end

function NecrologistStoryBaseItem:onPlayFinish(isAutoNext)
	self:refreshHeight()

	if self._storyConfig then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryItemFinish, self._storyConfig.id)
	end

	if self.playFinishCallback then
		self.playFinishCallback(self.playFinishCallbackObj, isAutoNext)
	end
end

function NecrologistStoryBaseItem:onClickNext()
	if self._storyConfig then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryItemClickNext, self._storyConfig.id)
	end
end

function NecrologistStoryBaseItem:refreshHeight()
	if gohelper.isNil(self.viewGO) then
		return
	end

	local caleHeight = self:caleHeight()

	self:setHeight(caleHeight)

	if self.refreshHeightCallback then
		self.refreshHeightCallback(self.callbackObj, self)
	end
end

function NecrologistStoryBaseItem:getItemType()
	return self._storyConfig.type
end

function NecrologistStoryBaseItem:getStoryConfig()
	return self._storyConfig
end

function NecrologistStoryBaseItem:getStoryId()
	return self._storyConfig.id
end

function NecrologistStoryBaseItem:getHeight()
	return self._height
end

function NecrologistStoryBaseItem:setHeight(height)
	self._height = height

	recthelper.setHeight(self.transform, height)
end

function NecrologistStoryBaseItem:getPosY()
	return self._posY
end

function NecrologistStoryBaseItem:setPosY(posY)
	if self._posY == posY then
		return
	end

	self._posY = posY

	recthelper.setAnchorY(self.transform, posY)
end

function NecrologistStoryBaseItem:onInit()
	return
end

function NecrologistStoryBaseItem:onPlayStory(isSkip)
	return
end

function NecrologistStoryBaseItem:caleHeight()
	return 0
end

function NecrologistStoryBaseItem.getResPath()
	logError("need override getResPath")
end

function NecrologistStoryBaseItem:isDone()
	return true
end

function NecrologistStoryBaseItem:justDone()
	return
end

function NecrologistStoryBaseItem:getTextStr()
	return
end

function NecrologistStoryBaseItem:destory()
	if gohelper.isNil(self.viewGO) then
		return
	end

	gohelper.destroy(self.viewGO)

	self.viewGO = nil
end

return NecrologistStoryBaseItem
