module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelContainer", package.seeall)

slot0 = class("V1a4_BossRush_ResultPanelContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.cellClass = V1a4_BossRush_ResultPanelItem
	slot1.scrollGOPath = "Root/Right/Slider/#go_Slider/#scroll_progress"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "Root/Right/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst"
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 200
	slot1.cellHeight = 200
	slot1.cellSpaceH = 150
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 150
	slot0._listScrollParam = slot1
	slot0._scrollView = LuaListScrollView.New(V1a4_BossRush_ResultPanelListModel.instance, slot1)

	return {
		V1a4_BossRush_ResultPanel.New(),
		slot0._scrollView
	}
end

function slot0.getListScrollParam(slot0)
	return slot0._listScrollParam
end

function slot0.getScrollView(slot0)
	return slot0._scrollView
end

function slot0.getCsListScroll(slot0)
	return slot0:getScrollView():getCsListScroll()
end

function slot0.onContainerCloseFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
end

return slot0
