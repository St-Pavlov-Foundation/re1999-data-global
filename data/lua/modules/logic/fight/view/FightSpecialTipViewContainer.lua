module("modules.logic.fight.view.FightSpecialTipViewContainer", package.seeall)

local var_0_0 = class("FightSpecialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightSpecialTipView.New()
	}
end

function var_0_0.onContainerCloseFinish(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return var_0_0
