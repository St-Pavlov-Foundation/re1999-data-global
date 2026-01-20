-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapGuideView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapGuideView", package.seeall)

local Rouge2_MapGuideView = class("Rouge2_MapGuideView", BaseView)

function Rouge2_MapGuideView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapGuideView:addEvents()
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.OnPopGuideView, self._onPopGuideView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateBagInfo, self.onUpdateBagInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onCreateMapDoneFlowDone, self.onCreateMapDoneFlowDone, self)
end

function Rouge2_MapGuideView:removeEvents()
	return
end

function Rouge2_MapGuideView:_editableInitView()
	return
end

function Rouge2_MapGuideView:onCreateMapDoneFlowDone()
	self:tryTriggerActiveSkillGuide()
end

function Rouge2_MapGuideView:onChangeMapInfo()
	self:tryTriggerActiveSkillGuide()
end

function Rouge2_MapGuideView:onOpen()
	self.close = false
end

function Rouge2_MapGuideView:_onPopGuideView(techniqueId)
	Rouge2_Controller.instance:openTechniqueView(tonumber(techniqueId))
end

function Rouge2_MapGuideView:checkCanTriggerGuide()
	if self.close then
		return
	end

	local isTop = Rouge2_MapHelper.checkMapViewOnTop()

	if not isTop then
		return
	end

	local isInteract = Rouge2_MapModel.instance:isInteractiving()

	if isInteract then
		return
	end

	local isPop = Rouge2_PopController.instance:isPopping()

	if isPop then
		return
	end

	return true
end

function Rouge2_MapGuideView:tryTriggerActiveSkillGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32057)

	if isGuideFinish then
		return
	end

	local hasAnyNotUseSkill = Rouge2_BackpackModel.instance:hasAnyNotUseActiveSkill()

	if not hasAnyNotUseSkill then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideGetActiveSkill)

	return true
end

function Rouge2_MapGuideView:tryTriggerBXSBoxGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32059)
	local isUseBXS = Rouge2_Model.instance:isUseBXSCareer()
	local isMiddle = Rouge2_MapModel.instance:isMiddle()

	if isGuideFinish or not isUseBXS or isMiddle then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideBXSBox)

	return true
end

function Rouge2_MapGuideView:tryTriggerMiddleLayerGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32060)
	local isMiddleLayer = Rouge2_MapModel.instance:isMiddle()

	if isGuideFinish or not isMiddleLayer then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideMiddleLayer)

	return true
end

function Rouge2_MapGuideView:tryTriggerPathSelectLayerGuide()
	local isGuideFinish = GuideModel.instance:isGuideFinish(32055)
	local isPathSelect = Rouge2_MapModel.instance:isPathSelect()

	if isGuideFinish or not isPathSelect then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuidePathSelectLayer)

	return true
end

function Rouge2_MapGuideView:tryTriggerMapGuides()
	if not self:checkCanTriggerGuide() then
		return
	end

	if self:tryTriggerActiveSkillGuide() then
		return
	end

	if self:tryTriggerBXSBoxGuide() then
		return
	end

	if self:tryTriggerMiddleLayerGuide() then
		return
	end

	if self:tryTriggerPathSelectLayerGuide() then
		return
	end
end

function Rouge2_MapGuideView:onPopViewDone()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onClearInteract()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onCloseViewFinish(viewName)
	if viewName == self.viewName then
		return
	end

	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onUpdateBagInfo()
	self:tryTriggerMapGuides()
end

function Rouge2_MapGuideView:onClose()
	self.close = true
end

function Rouge2_MapGuideView:onDestroyView()
	return
end

return Rouge2_MapGuideView
