module("modules.logic.fight.view.FightStatViewContainer", package.seeall)

slot0 = class("FightStatViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "view/scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "view/scroll/item"
	slot1.cellClass = FightStatItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1660
	slot1.cellHeight = 146
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 6.5
	slot0.fightStatView = FightStatView.New()

	return {
		slot0.fightStatView,
		LuaListScrollView.New(FightStatModel.instance, slot1)
	}
end

return slot0
