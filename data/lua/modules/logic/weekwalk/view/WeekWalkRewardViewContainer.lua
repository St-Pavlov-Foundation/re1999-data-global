module("modules.logic.weekwalk.view.WeekWalkRewardViewContainer", package.seeall)

slot0 = class("WeekWalkRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/#scroll_reward"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = WeekWalkRewardItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1500
	slot2.cellHeight = 160
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	WeekWalkTaskListModel.instance.openRewardTime = Time.time

	table.insert(slot1, LuaListScrollView.New(WeekWalkTaskListModel.instance, slot2))
	table.insert(slot1, WeekWalkRewardView.New())

	return slot1
end

return slot0
