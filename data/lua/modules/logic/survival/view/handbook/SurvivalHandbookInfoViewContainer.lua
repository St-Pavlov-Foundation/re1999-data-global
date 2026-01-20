-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookInfoViewContainer.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookInfoViewContainer", package.seeall)

local SurvivalHandbookInfoViewContainer = class("SurvivalHandbookInfoViewContainer", BaseViewContainer)

function SurvivalHandbookInfoViewContainer:buildViews()
	local views = {
		SurvivalHandbookInfoView.New()
	}

	return views
end

function SurvivalHandbookInfoViewContainer:buildTabViews(tabContainerId)
	return
end

function SurvivalHandbookInfoViewContainer:onContainerOpenFinish()
	return
end

return SurvivalHandbookInfoViewContainer
