module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGameEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameEventview = AiZiLaGameEventView.New()

	table.insert(var_1_0, arg_1_0._gameEventview)

	return var_1_0
end

function var_0_0.playViewAnimator(arg_2_0, arg_2_1)
	arg_2_0._gameEventview:playViewAnimator(arg_2_1)
end

return var_0_0
