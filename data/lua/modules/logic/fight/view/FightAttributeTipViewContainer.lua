module("modules.logic.fight.view.FightAttributeTipViewContainer", package.seeall)

local var_0_0 = class("FightAttributeTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FightAttributeTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
