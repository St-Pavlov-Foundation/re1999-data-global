module("modules.logic.playercard.view.PlayerCardShowViewContainer", package.seeall)

slot0 = class("PlayerCardShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardShowView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_card"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes.carditem
	slot2.cellClass = PlayerCardCardItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 482
	slot2.cellHeight = 186
	slot2.startSpace = 150
	slot0._scrollView = LuaListScrollView.New(PlayerCardProgressModel.instance, slot2)

	table.insert(slot1, slot0._scrollView)

	return slot1
end

return slot0
