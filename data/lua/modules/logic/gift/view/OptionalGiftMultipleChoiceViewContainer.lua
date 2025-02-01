module("modules.logic.gift.view.OptionalGiftMultipleChoiceViewContainer", package.seeall)

slot0 = class("OptionalGiftMultipleChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "root/#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = GiftMultipleChoiceListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 6
	slot2.cellWidth = 200
	slot2.cellHeight = 300
	slot2.cellSpaceH = 41
	slot2.cellSpaceV = 56
	slot2.startSpace = 11

	table.insert(slot1, LuaListScrollView.New(GiftMultipleChoiceListModel.instance, slot2))
	table.insert(slot1, OptionalGiftMultipleChoiceView.New())

	return slot1
end

return slot0
