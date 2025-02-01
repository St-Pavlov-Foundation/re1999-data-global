module("modules.logic.equip.view.EquipSkillTipViewContainer", package.seeall)

slot0 = class("EquipSkillTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_character/#scroll_character"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = EquipSkillCharacterItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 150
	slot1.cellHeight = 190
	slot1.cellSpaceH = 24.1
	slot1.cellSpaceV = 19.5
	slot1.startSpace = 0

	return {
		LuaListScrollView.New(EquipSkillCharacterListModel.instance, slot1),
		EquipSkillTipView.New()
	}
end

return slot0
