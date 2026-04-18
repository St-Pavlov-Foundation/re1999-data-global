-- chunkname: @modules/logic/survival/view/role/SurvivalRoleLevelUpViewContainer.lua

module("modules.logic.survival.view.role.SurvivalRoleLevelUpViewContainer", package.seeall)

local SurvivalRoleLevelUpViewContainer = class("SurvivalRoleLevelUpViewContainer", BaseViewContainer)

function SurvivalRoleLevelUpViewContainer:buildViews()
	local views = {
		SurvivalRoleLevelUpView.New()
	}

	return views
end

return SurvivalRoleLevelUpViewContainer
