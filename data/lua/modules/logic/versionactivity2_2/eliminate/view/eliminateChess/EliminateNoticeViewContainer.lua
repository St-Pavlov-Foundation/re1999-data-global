module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeViewContainer", package.seeall)

local var_0_0 = class("EliminateNoticeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, EliminateNoticeView.New())

	return var_1_0
end

return var_0_0
