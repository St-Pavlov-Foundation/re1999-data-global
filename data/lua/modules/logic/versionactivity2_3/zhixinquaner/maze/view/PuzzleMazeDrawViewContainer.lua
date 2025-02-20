module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeDrawViewContainer", package.seeall)

slot0 = class("PuzzleMazeDrawViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._view = PuzzleMazeDrawView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		slot0._view,
		PuzzleMazeSimulatePlaneComp.New(),
		ZhiXinQuanErTalkView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot2:setOverrideClose(slot0._onNavigateCloseCallBack, slot0)

	return {
		slot2
	}
end

function slot0._onNavigateCloseCallBack(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeQuitGame, MsgBoxEnum.BoxType.Yes_No, slot0._closeView, nil, , slot0)
end

function slot0._closeView(slot0)
	slot0._view:stat(PuzzleEnum.GameResult.Abort)
	slot0:closeThis()
end

return slot0
