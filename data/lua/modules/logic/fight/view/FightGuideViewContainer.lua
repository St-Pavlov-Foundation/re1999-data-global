module("modules.logic.fight.view.FightGuideViewContainer", package.seeall)

local var_0_0 = class("FightGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightGuideView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
