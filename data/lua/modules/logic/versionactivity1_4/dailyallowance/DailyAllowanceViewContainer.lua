module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceViewContainer", package.seeall)

local var_0_0 = class("DailyAllowanceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DailyAllowanceView.New()
	}
end

return var_0_0
