module("modules.logic.summon.view.SummonPoolHistoryViewContainer", package.seeall)

slot0 = class("SummonPoolHistoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonPoolHistoryView.New())
	table.insert(slot1, slot0:_createScrollView())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0._createScrollView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "allbg/left/scroll_pooltype"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "allbg/left/pooltypeitem"
	slot1.cellClass = SummonPoolHistoryTypeItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 380
	slot1.cellHeight = 116
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 8
	slot1.startSpace = 0

	for slot6 = 1, 10 do
	end

	return LuaListScrollViewWithAnimator.New(SummonPoolHistoryTypeListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.03
	})
end

return slot0
