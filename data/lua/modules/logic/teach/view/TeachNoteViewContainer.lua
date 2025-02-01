module("modules.logic.teach.view.TeachNoteViewContainer", package.seeall)

slot0 = class("TeachNoteViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_reward/#scroll_rewarditem"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = TeachNoteRewardListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 620
	slot2.cellHeight = 81
	slot2.cellSpaceH = 50
	slot2.cellSpaceV = 0
	slot2.minUpdateCountInFrame = 10

	table.insert(slot1, LuaListScrollView.New(TeachNoteRewardListModel.instance, slot2))
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, TeachNoteView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		true
	}, 116, slot0._closeCallback, nil, , slot0)

	return {
		slot0.navigationView
	}
end

function slot0._closeCallback(slot0)
	TeachNoteModel.instance:setJumpEpisodeId(nil)

	JumpModel.instance.jumpFromFightSceneParam = nil

	TeachNoteModel.instance:setJumpEnter(false)
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.TeachNote.play_ui_closehouse)
end

return slot0
