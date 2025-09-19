module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultViewContainer", package.seeall)

local var_0_0 = class("MoLiDeErResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MoLiDeErResultView.New())

	return var_1_0
end

return var_0_0
