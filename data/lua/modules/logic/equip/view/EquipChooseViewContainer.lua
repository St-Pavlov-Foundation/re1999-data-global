module("modules.logic.equip.view.EquipChooseViewContainer", package.seeall)

slot0 = class("EquipChooseViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_equip"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = EquipChooseItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 232
	slot1.cellHeight = 232
	slot1.cellSpaceH = 15
	slot1.cellSpaceV = 15
	slot1.startSpace = 60

	return {
		LuaListScrollView.New(EquipChooseListModel.instance, slot1),
		EquipChooseView.New()
	}
end

return slot0
