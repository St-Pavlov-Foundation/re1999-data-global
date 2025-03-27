module("modules.logic.versionactivity2_4.pinball.view.PinballGameViewContainer", package.seeall)

slot0 = class("PinballGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PinballGameSceneView.New(),
		PinballGameView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PinballGameHelp)

		slot2:setOverrideClose(slot0.defaultOverrideCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.defaultOverrideCloseClick(slot0)
	if PinballHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PinballAbort, MsgBoxEnum.BoxType.Yes_No, slot0.sendEndGameReq, nil, , slot0)
end

function slot0.sendEndGameReq(slot0)
	if PinballModel.instance.oper == PinballEnum.OperType.Episode then
		slot0:closeThis()

		return
	end

	PinballEntityMgr.instance:pauseTick()
	Activity178Rpc.instance:sendAct178EndEpisode(VersionActivity2_4Enum.ActivityId.Pinball, PinballModel.instance.gameAddResDict, PinballModel.instance.leftEpisodeId)
end

return slot0
