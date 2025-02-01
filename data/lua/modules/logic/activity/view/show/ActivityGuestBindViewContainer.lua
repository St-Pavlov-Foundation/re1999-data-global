module("modules.logic.activity.view.show.ActivityGuestBindViewContainer", package.seeall)

slot0 = class("ActivityGuestBindViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.cellClass = ActivityGuestBindViewItem
	slot1.scrollGOPath = "leftbottom/#scroll_reward"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 172
	slot1.cellHeight = 185
	slot1.cellSpaceH = 35
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 0

	return {
		ActivityGuestBindView.New(),
		LuaListScrollView.New(ActivityGuestBindViewListModel.instance, slot1)
	}
end

return slot0
