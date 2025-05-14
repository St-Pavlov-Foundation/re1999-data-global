module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultViewContainer", package.seeall)

local var_0_0 = class("Role37PuzzleResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Role37PuzzleResultView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
