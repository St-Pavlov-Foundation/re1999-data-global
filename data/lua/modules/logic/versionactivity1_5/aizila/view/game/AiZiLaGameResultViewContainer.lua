module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGameResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._resultView = AiZiLaGameResultView.New()

	table.insert(var_1_0, arg_1_0._resultView)

	return var_1_0
end

return var_0_0
