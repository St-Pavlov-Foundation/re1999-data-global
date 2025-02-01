module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffViewContainer", package.seeall)

slot0 = class("RougeLimiterBuffViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_choosebuff/SmallBuffView"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes.BuffItem
	slot1.cellClass = RougeLimiterBuffListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 160
	slot1.cellHeight = 160
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot2 = {}

	table.insert(slot2, RougeLimiterBuffView.New())
	table.insert(slot2, RougeLimiterViewEmblemComp.New("#go_RightTop"))
	table.insert(slot2, LuaListScrollView.New(RougeLimiterBuffListModel.instance, slot1))

	return slot2
end

return slot0
