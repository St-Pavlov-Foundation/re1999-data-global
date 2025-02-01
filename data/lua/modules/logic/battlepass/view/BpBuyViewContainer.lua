module("modules.logic.battlepass.view.BpBuyViewContainer", package.seeall)

slot0 = class("BpBuyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "bg/#scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "bg/#scroll/item"
	slot2.cellClass = BpBuyBonusItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 146
	slot2.cellHeight = 146
	slot2.cellSpaceH = 35
	slot2.cellSpaceV = 33
	slot2.startSpace = 0
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(BpBuyViewModel.instance, slot2))
	table.insert(slot1, BpBuyView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0)
	return {
		CurrencyView.New({
			string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.BpBuyLevelCost), "#")[2]
		})
	}
end

return slot0
