module("modules.logic.season.view.SeasonCelebrityCardGetlViewContainer", package.seeall)

local var_0_0 = class("SeasonCelebrityCardGetlViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SeasonCelebrityCardGetlView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		-- block empty
	end
end

return var_0_0
