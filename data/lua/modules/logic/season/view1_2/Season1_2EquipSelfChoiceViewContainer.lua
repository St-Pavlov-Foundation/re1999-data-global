module("modules.logic.season.view1_2.Season1_2EquipSelfChoiceViewContainer", package.seeall)

slot0 = class("Season1_2EquipSelfChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = Season1_2EquipTagSelect.New()

	slot2:init(Activity104EquipSelfChoiceController.instance, "root/#drop_filter", "#433834")

	return {
		Season1_2EquipSelfChoiceView.New(),
		slot2,
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, slot0:createEquipItemsParam())
	}
end

function slot0.createEquipItemsParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "root/mask/#scroll_item"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season1_2EquipSelfChoiceItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 180
	slot1.cellHeight = 235
	slot1.cellSpaceH = 7.4
	slot1.cellSpaceV = 32.5
	slot1.startSpace = 56

	return slot1
end

return slot0
