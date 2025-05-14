module("modules.logic.versionactivity2_4.pinball.view.PinballGameViewContainer", package.seeall)

local var_0_0 = class("PinballGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PinballGameSceneView.New(),
		PinballGameView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PinballGameHelp)

		var_2_0:setOverrideClose(arg_2_0.defaultOverrideCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.defaultOverrideCloseClick(arg_3_0)
	if PinballHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballAbort, MsgBoxEnum.BoxType.Yes_No, arg_3_0.sendEndGameReq, nil, nil, arg_3_0)
end

function var_0_0.sendEndGameReq(arg_4_0)
	if PinballModel.instance.oper == PinballEnum.OperType.Episode then
		arg_4_0:closeThis()

		return
	end

	PinballEntityMgr.instance:pauseTick()
	Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
end

return var_0_0
