-- chunkname: @modules/logic/voyage/view/VoyagePopupRewardViewContainer.lua

module("modules.logic.voyage.view.VoyagePopupRewardViewContainer", package.seeall)

local VoyagePopupRewardViewContainer = class("VoyagePopupRewardViewContainer", BaseViewContainer)

function VoyagePopupRewardViewContainer:ctor()
	VoyagePopupRewardViewContainer.super.ctor(self)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, self._beforeOpenView, self)
end

function VoyagePopupRewardViewContainer:buildViews()
	return {
		VoyagePopupRewardView.New()
	}
end

function VoyagePopupRewardViewContainer:_beforeOpenView(viewName, viewParam)
	if viewName == ViewName.VoyagePopupRewardView and viewParam and viewParam.openFromGuide then
		-- block empty
	end
end

return VoyagePopupRewardViewContainer
