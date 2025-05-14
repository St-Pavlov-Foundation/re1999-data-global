module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultViewContainer", package.seeall)

local var_0_0 = class("V1a6_BossRush_ResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_BossRush_ResultView.New()
	}
end

return var_0_0
