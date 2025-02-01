module("modules.logic.dungeon.view.DungeonMapViewContainer", package.seeall)

slot0 = class("DungeonMapViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonMapHoleView.New())

	slot0._mapScene = DungeonMapScene.New()
	slot0._mapTaskInfo = DungeonMapTaskInfo.New()

	table.insert(slot1, DungeonMapView.New())
	table.insert(slot1, slot0._mapTaskInfo)
	table.insert(slot1, DungeonMapSceneElements.New())
	table.insert(slot1, slot0._mapScene)
	table.insert(slot1, DungeonMapEpisode.New())
	table.insert(slot1, DungeonMapElementReward.New())
	table.insert(slot1, DungeonMapEquipEntry.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, DungeonMapOtherBtnView.New())
	table.insert(slot1, DungeonMapActDropView.New())
	table.insert(slot1, DungeonMapToughBattleActView.New())
	table.insert(slot1, BalanceUmbrellaDungeonMapView.New())
	table.insert(slot1, InvestigateDungeonMapView.New())

	return slot1
end

function slot0.getMapScene(slot0)
	return slot0._mapScene
end

function slot0.getMapTaskInfo(slot0)
	return slot0._mapTaskInfo
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)
	}, HelpEnum.HelpId.Dungeon)

	slot0._navigateButtonView:setOverrideClose(slot0.overrideClose, slot0)

	if slot2 == DungeonEnum.ChapterType.Equip then
		slot0._navigateButtonView.helpId = nil

		slot0._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerInit(slot0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, slot0.refreshHelpBtnIcon, slot0)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

function slot0.onContainerDestroy(slot0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, slot0.refreshHelpBtnIcon, slot0)
end

function slot0.refreshHelpBtnIcon(slot0)
	slot0._navigateButtonView:changerHelpId(HelpEnum.HelpId.Dungeon)
end

function slot0.overrideCloseElement(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.closeMapInteractiveItem)
end

function slot0._overrideHelp(slot0)
	ViewMgr.instance:openView(ViewName.DungeonRewardTipView)
end

function slot0.overrideClose(slot0)
	slot0:closeThis()
end

function slot0.refreshHelp(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setParam({
			true,
			true,
			DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)
		})
	end
end

function slot0.onContainerUpdateParam(slot0)
	slot0._mapScene:setSceneVisible(true)
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)

	if slot0._mapScene then
		slot0._mapScene:setSceneVisible(slot1)
	end
end

return slot0
