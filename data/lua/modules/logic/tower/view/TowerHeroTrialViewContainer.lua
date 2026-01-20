-- chunkname: @modules/logic/tower/view/TowerHeroTrialViewContainer.lua

module("modules.logic.tower.view.TowerHeroTrialViewContainer", package.seeall)

local TowerHeroTrialViewContainer = class("TowerHeroTrialViewContainer", BaseViewContainer)

function TowerHeroTrialViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerHeroTrialView.New())

	return views
end

return TowerHeroTrialViewContainer
