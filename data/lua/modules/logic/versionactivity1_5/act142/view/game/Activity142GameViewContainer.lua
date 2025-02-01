module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameViewContainer", package.seeall)

slot0 = class("Activity142GameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._gameView = Activity142GameView.New()

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
			false
		})

		slot2:setHelpId(HelpEnum.HelpId.Activity142)
		slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot2
		}
	elseif slot1 == 2 then
		return {
			Activity142GameScene.New()
		}
	end
end

function slot0.overrideOnCloseClick(slot0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.yesCloseView, nil, , slot0)
end

function slot0.yesCloseView(slot0)
	Activity142StatController.instance:statAbort()
	slot0:closeThis()
end

return slot0
