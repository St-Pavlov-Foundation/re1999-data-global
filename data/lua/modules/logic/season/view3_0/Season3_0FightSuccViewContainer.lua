module("modules.logic.season.view3_0.Season3_0FightSuccViewContainer", package.seeall)

local var_0_0 = class("Season3_0FightSuccViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season3_0FightSuccView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		-- block empty
	end
end

return var_0_0
