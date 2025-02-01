module("modules.logic.character.view.CharacterTalentChessFilterViewContainer", package.seeall)

slot0 = class("CharacterTalentChessFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "container/Scroll View"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "container/Scroll View/Viewport/Content/#go_item"
	slot1.cellClass = CharacterTalentChessFilterItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 646
	slot1.cellHeight = 162
	slot1.cellSpaceV = 0

	return {
		LuaListScrollView.New(TalentStyleListModel.instance, slot1),
		CharacterTalentChessFilterView.New()
	}
end

return slot0
