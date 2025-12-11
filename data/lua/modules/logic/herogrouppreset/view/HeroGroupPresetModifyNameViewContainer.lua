module("modules.logic.herogrouppreset.view.HeroGroupPresetModifyNameViewContainer", package.seeall)

local var_0_0 = class("HeroGroupPresetModifyNameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		HeroGroupPresetModifyNameView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.playOpenTransition(arg_3_0)
	arg_3_0:onPlayOpenTransitionFinish()
end

return var_0_0
