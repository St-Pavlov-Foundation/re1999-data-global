module("modules.logic.season.view.SeasonFightSuccViewContainer", package.seeall)

local var_0_0 = class("SeasonFightSuccViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SeasonFightSuccView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		-- block empty
	end
end

return var_0_0
