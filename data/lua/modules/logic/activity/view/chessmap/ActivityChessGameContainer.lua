module("modules.logic.activity.view.chessmap.ActivityChessGameContainer", package.seeall)

local var_0_0 = class("ActivityChessGameContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ActivityChessGameScene.New())
	table.insert(var_1_0, ActivityChessGameMain.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.ChessGame109)

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.setHelpVisible(arg_3_0, arg_3_1)
	arg_3_0._navigateButtonView:setHelpVisible(arg_3_1)
end

function var_0_0.overrideOnCloseClick(arg_4_0)
	local function var_4_0()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame, nil, true)

		local var_5_0 = Activity109ChessModel.instance:getActId()

		Activity109Rpc.instance:sendGetAct109InfoRequest(var_5_0)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_4_0)
end

return var_0_0
