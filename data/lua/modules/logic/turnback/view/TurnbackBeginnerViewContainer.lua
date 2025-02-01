module("modules.logic.turnback.view.TurnbackBeginnerViewContainer", package.seeall)

slot0 = class("TurnbackBeginnerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_category/#scroll_categoryitem"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = TurnbackCategoryItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 300
	slot2.cellHeight = 125
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 9.8
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(TurnbackBeginnerCategoryListModel.instance, slot2))
	table.insert(slot1, TurnbackBeginnerView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigationView
	}
end

return slot0
