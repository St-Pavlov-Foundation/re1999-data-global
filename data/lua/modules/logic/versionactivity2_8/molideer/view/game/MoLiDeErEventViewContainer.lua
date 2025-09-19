module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventViewContainer", package.seeall)

local var_0_0 = class("MoLiDeErEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MoLiDeErEventView.New())

	return var_1_0
end

return var_0_0
