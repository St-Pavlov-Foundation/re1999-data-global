-- chunkname: @modules/logic/story/view/StorySelectListItem.lua

module("modules.logic.story.view.StorySelectListItem", package.seeall)

local StorySelectListItem = class("StorySelectListItem")
local fadeInTime = 0.6
local fadeOutTime = 0.9
local selectScale = 1.25
local selectTweenTime = 0.5
local optionMoveOffDistance = 300
local optionMoveOffTime = 0.5

function StorySelectListItem:init(go, param)
	self.viewGO = gohelper.cloneInPlace(go)

	gohelper.setActive(self.viewGO, true)

	self.viewParam = param
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "btnselect")
	self._gobgdark = gohelper.findChild(self.viewGO, "bgdark")
	self._txtcontentdark = gohelper.findChildText(self.viewGO, "bgdark/txtcontentdark")
	self._goicon = gohelper.findChild(self.viewGO, "bgdark/icon")
	self._gobg = gohelper.findChild(self.viewGO, "bgdark/bg")

	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self:_refreshItem()
end

function StorySelectListItem:removeEvents()
	self._btnselect:RemoveClickListener()
end

function StorySelectListItem:getOptionIndex()
	return self.viewParam.index
end

function StorySelectListItem:_btnselectOnClick()
	local log = {}

	log.stepId = self.viewParam.stepId
	log.index = self.viewParam.index

	StoryModel.instance:addLog(log)
	StoryController.instance:dispatchEvent(StoryEvent.OnSelectOptionView, self.viewParam.index)
end

function StorySelectListItem:onSelectOptionView()
	ZProj.TweenHelper.DOFadeCanvasGroup(self.viewGO, 1, 0, fadeOutTime, self._onSelectOption, self)
	ZProj.TweenHelper.DOScale(self.viewGO.transform, selectScale, selectScale, 1, selectTweenTime)
end

function StorySelectListItem:_onSelectOption()
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, self.viewParam.index)
	StoryController.instance:playStep(self.viewParam.id)
	self:destroy()
end

function StorySelectListItem:onSelectOtherOptionView()
	ZProj.UGUIHelper.SetGrayscale(self._goicon, true)
	ZProj.UGUIHelper.SetGrayscale(self._gobg, true)
	ZProj.UGUIHelper.SetGrayscale(self._txtcontentdark.gameObject, true)
	ZProj.TweenHelper.DOLocalMoveX(self.viewGO.transform, optionMoveOffDistance, optionMoveOffTime)
	ZProj.TweenHelper.DOFadeCanvasGroup(self.viewGO, 1, 0, fadeOutTime, self._OnSelectOtherOption, self)
end

function StorySelectListItem:_OnSelectOtherOption()
	StoryController.instance:dispatchEvent(StoryEvent.FinishSelectOptionView, self.viewParam.index)
	self:destroy()
end

function StorySelectListItem:reset(param)
	self.viewParam = param

	self:_refreshItem()
end

function StorySelectListItem:_refreshItem()
	ZProj.TweenHelper.KillByObj(self.viewGO)
	ZProj.TweenHelper.DOFadeCanvasGroup(self.viewGO, 0, 1, fadeInTime)

	local num = tonumber(self.viewParam.name)
	local isLuaLang = num and string.len(self.viewParam.name) == string.len(tostring(num))

	self._txtcontentdark.text = isLuaLang and luaLang(self.viewParam.name) or self.viewParam.name
end

function StorySelectListItem:destroy()
	self:removeEvents()
	ZProj.TweenHelper.KillByObj(self.viewGO)
	gohelper.destroy(self.viewGO)
end

return StorySelectListItem
