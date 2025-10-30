module("modules.logic.versionactivity3_0.karong.view.KaRongDrawViewContainer", package.seeall)

local var_0_0 = class("KaRongDrawViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._view = KaRongDrawView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0._view,
		KaRongTalkView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		false,
		false
	})

	var_2_0:setOverrideClose(arg_2_0._onNavigateCloseCallBack, arg_2_0)

	return {
		var_2_0
	}
end

function var_0_0._onNavigateCloseCallBack(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, arg_3_0._closeView, nil, nil, arg_3_0)
end

function var_0_0._closeView(arg_4_0)
	arg_4_0._view:stat(KaRongDrawEnum.GameResult.Abort)
	arg_4_0:closeThis()
end

return var_0_0
