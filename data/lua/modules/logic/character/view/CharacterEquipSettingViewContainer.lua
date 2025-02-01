module("modules.logic.character.view.CharacterEquipSettingViewContainer", package.seeall)

slot0 = class("CharacterEquipSettingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_equip"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = CharacterEquipSettingItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 228
	slot2.cellHeight = 218
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2.22
	slot2.startSpace = 0

	table.insert(slot1, CharacterEquipSettingView.New())
	table.insert(slot1, LuaListScrollView.New(CharacterEquipSettingListModel.instance, slot2))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
