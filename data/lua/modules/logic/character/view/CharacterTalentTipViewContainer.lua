module("modules.logic.character.view.CharacterTalentTipViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterTalentTipView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
