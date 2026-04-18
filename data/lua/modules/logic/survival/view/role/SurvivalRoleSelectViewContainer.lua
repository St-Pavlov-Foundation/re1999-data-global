-- chunkname: @modules/logic/survival/view/role/SurvivalRoleSelectViewContainer.lua

module("modules.logic.survival.view.role.SurvivalRoleSelectViewContainer", package.seeall)

local SurvivalRoleSelectViewContainer = class("SurvivalRoleSelectViewContainer", BaseViewContainer)

function SurvivalRoleSelectViewContainer:buildViews()
	local views = {
		SurvivalRoleSelectView.New(),
		TabViewGroup.New(1, "#go_btns")
	}

	return views
end

function SurvivalRoleSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return SurvivalRoleSelectViewContainer
