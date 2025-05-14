module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGameOpenEffectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameEffectView = AiZiLaGameOpenEffectView.New()

	table.insert(var_1_0, arg_1_0._gameEffectView)

	return var_1_0
end

function var_0_0.playViewAnimator(arg_2_0, arg_2_1)
	arg_2_0._gameEffectView:playViewAnimator(arg_2_1)
end

function var_0_0.startViewOpenBlock(arg_3_0)
	return
end

function var_0_0.startViewCloseBlock(arg_4_0)
	return
end

return var_0_0
