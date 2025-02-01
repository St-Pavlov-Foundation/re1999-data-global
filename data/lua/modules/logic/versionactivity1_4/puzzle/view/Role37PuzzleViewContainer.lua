module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleViewContainer", package.seeall)

slot0 = class("Role37PuzzleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Record/#scroll_record"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "Record/#scroll_record/Viewport/Content/RecordItem"
	slot2.cellClass = PuzzleRecordItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, Role37PuzzleView.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		slot0._navigateButtonView:setOverrideClose(slot0.overrideCloseFunc, slot0)
		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.Role37PuzzleViewHelp)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.overrideCloseFunc(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, slot0.closeFunc, nil, , slot0)
end

function slot0.closeFunc(slot0)
	slot0:closeThis()
end

function slot0.onContainerInit(slot0)
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
end

return slot0
