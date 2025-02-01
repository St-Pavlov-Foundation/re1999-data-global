module("modules.logic.season.view.SeasonEquipSelfChoiceViewContainer", package.seeall)

slot0 = class("SeasonEquipSelfChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonEquipSelfChoiceView.New(),
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, slot0:createEquipItemsParam())
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/mask/#scroll_item"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = SeasonEquipSelfChoiceItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 7
	slot1.cellWidth = 197
	slot1.cellHeight = 272
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 1.67

	return slot1
end

return slot0
