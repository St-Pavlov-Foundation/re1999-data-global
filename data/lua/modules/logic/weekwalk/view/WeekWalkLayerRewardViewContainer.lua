module("modules.logic.weekwalk.view.WeekWalkLayerRewardViewContainer", package.seeall)

slot0 = class("WeekWalkLayerRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/#scroll_reward"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = WeekWalkLayerRewardItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1500
	slot2.cellHeight = 160
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 1
	slot2.startSpace = 0

	for slot7 = 1, 10 do
	end

	table.insert(slot1, WeekWalkLayerRewardView.New())
	table.insert(slot1, LuaListScrollViewWithAnimator.New(WeekWalkTaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.07
	}))

	return slot1
end

return slot0
