-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryTextItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryTextItem", package.seeall)

local NecrologistStoryTextItem = class("NecrologistStoryTextItem", NecrologistStoryBaseItem)

function NecrologistStoryTextItem:onInit()
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "content/txtContent")
	self.txtComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtContent.gameObject, NecrologistStoryTextComp)
end

function NecrologistStoryTextItem:onPlayStory(isSkip)
	self:refreshText(isSkip)
end

function NecrologistStoryTextItem:refreshText(isSkip)
	local storyConfig = self:getStoryConfig()
	local desc, hasLink = NecrologistStoryHelper.getDescByConfig(storyConfig)

	self.hasLink = hasLink
	self.txtContent.raycastTarget = hasLink

	if self.hasLink and not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText) then
		isSkip = false

		local mo = NecrologistStoryModel.instance:getCurStoryMO()

		mo:setIsAuto(false)
	end

	if isSkip then
		self.txtComp:setTextNormal(desc)
	else
		self.txtComp:setTextWithTypewriter(desc, self.refreshHeight, self.onTextFinish, self)
	end
end

function NecrologistStoryTextItem:onTextFinish()
	if self.hasLink then
		self:createLinksRect()
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnLinkText)
	end

	self:onPlayFinish()
end

function NecrologistStoryTextItem:createLinksRect()
	local list = NecrologistStoryHelper.calculateLinksRectData(self.txtContent)
	local tmpGO = self.txtContent.gameObject

	for i, v in ipairs(list) do
		local centerPos, width, height, linkId = unpack(v)
		local name = "link" .. linkId
		local linkGO = gohelper.findChild(tmpGO, name)

		linkGO = linkGO or gohelper.create2d(tmpGO, name)

		recthelper.setAnchor(linkGO.transform, centerPos.x, centerPos.y)
		recthelper.setSize(linkGO.transform, width, height)
	end
end

function NecrologistStoryTextItem:caleHeight()
	return self.txtContent.preferredHeight
end

function NecrologistStoryTextItem:isDone()
	return self.txtComp:isDone()
end

function NecrologistStoryTextItem:justDone()
	if self.hasLink and not GuideModel.instance:isGuideFinish(GuideEnum.GuideId.NecrologistStoryLinkText) then
		return
	end

	self.txtComp:onTextFinish()
end

function NecrologistStoryTextItem:getTextStr()
	return self.txtComp and self.txtComp:getTextStr()
end

return NecrologistStoryTextItem
