module("modules.logic.character.view.CharacterSkinTagViewContainer", package.seeall)

slot0 = class("CharacterSkinTagViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinTagView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "bg/#scroll_prop"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "bg/#scroll_prop/viewport/content/item"
	slot2.cellClass = CharacterSkinTagItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 528
	slot2.cellHeight = 60
	slot2.startSpace = 20
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2

	table.insert(slot1, LuaListScrollView.New(CharacterSkinTagListModel.instance, slot2))

	return slot1
end

return slot0
