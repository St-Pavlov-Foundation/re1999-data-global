module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultContainer", package.seeall)

local var_0_0 = class("Activity1_3ChessResultContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._resultview = Activity1_3ChessResultView.New()
	var_1_0[#var_1_0 + 1] = arg_1_0._resultview

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

return var_0_0
