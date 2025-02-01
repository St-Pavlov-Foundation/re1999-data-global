module("modules.logic.activity.view.chessmap.ActivityChessGameContainer", package.seeall)

slot0 = class("ActivityChessGameContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityChessGameScene.New())
	table.insert(slot1, ActivityChessGameMain.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.ChessGame109)

		slot0._navigateButtonView:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.setHelpVisible(slot0, slot1)
	slot0._navigateButtonView:setHelpVisible(slot1)
end

function slot0.overrideOnCloseClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, function ()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame, nil, true)
		Activity109Rpc.instance:sendGetAct109InfoRequest(Activity109ChessModel.instance:getActId())
	end)
end

return slot0
