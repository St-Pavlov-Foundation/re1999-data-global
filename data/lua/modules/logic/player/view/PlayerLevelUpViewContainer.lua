module("modules.logic.player.view.PlayerLevelUpViewContainer", package.seeall)

local var_0_0 = class("PlayerLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PlayerLevelUpView.New()
	}
end

return var_0_0
