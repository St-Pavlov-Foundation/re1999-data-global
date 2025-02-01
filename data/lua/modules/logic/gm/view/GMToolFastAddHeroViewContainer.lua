module("modules.logic.gm.view.GMToolFastAddHeroViewContainer", package.seeall)

slot0 = class("GMToolFastAddHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "container/#go_addItem/scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "container/#go_addItem/scroll/#go_item"
	slot1.cellClass = GMFastAddHeroAddItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 794
	slot1.cellHeight = 100
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "container/#go_herolistcontainer/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem"
	slot2.cellClass = GMFastAddHeroHadHeroItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1500
	slot2.cellHeight = 80
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 10

	return {
		LuaListScrollView.New(GMAddItemModel.instance, slot1),
		LuaListScrollView.New(GMFastAddHeroHadHeroItemModel.instance, slot2),
		GMToolFastAddHeroView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

return slot0
