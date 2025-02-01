module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameViewContainer", package.seeall)

slot0 = class("Activity1_3ChessGameViewContainer", BaseViewContainer)
slot1 = "ChessGameViewColseBlockKey"
slot2 = 0.5

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameView = Activity1_3ChessGameView.New()

	table.insert(slot1, slot0._gameView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(slot1, TabViewGroup.New(2, "gamescene"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Chess)

		slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot2
		}
	elseif slot1 == 2 then
		return {
			Activity1_3ChessGameScene.New()
		}
	end
end

function slot0.onContainerOpen(slot0)
end

function slot0.onContainerClose(slot0)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._gameView:initCamera()
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.onContainerUpdateParam(slot0)
	TaskDispatcher.runDelay(slot0._setUnitCameraNextFrame, slot0, 0.1)
end

function slot0._setUnitCameraNextFrame(slot0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function slot0.overrideOnCloseClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.closeFunc, nil, , slot0)
end

function slot0.closeFunc(slot0)
	Stat1_3Controller.instance:bristleStatAbort()
	UIBlockMgr.instance:startBlock(uv0)
	slot0._gameView:playCloseAniamtion()
	TaskDispatcher.runDelay(slot0._delayCloseFunc, slot0, uv1)
end

function slot0._delayCloseFunc(slot0)
	UIBlockMgr.instance:endBlock(uv0)
	slot0:closeThis()
end

return slot0
