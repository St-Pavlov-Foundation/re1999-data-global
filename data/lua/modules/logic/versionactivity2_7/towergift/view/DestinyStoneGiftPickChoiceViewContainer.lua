module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceViewContainer", package.seeall)

local var_0_0 = class("DestinyStoneGiftPickChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_stone"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#scroll_stone/Viewport/Content/stoneitem"
	var_1_1.cellClass = DestinyStoneGiftPickChoiceListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 4
	var_1_1.cellWidth = 408
	var_1_1.cellHeight = 208
	var_1_1.cellSpaceH = 16
	var_1_1.cellSpaceV = 16
	var_1_1.startSpace = 10
	var_1_1.endSpace = 30

	table.insert(var_1_0, LuaListScrollView.New(DestinyStoneGiftPickChoiceListModel.instance, var_1_1))
	table.insert(var_1_0, DestinyStoneGiftPickChoiceView.New())

	return var_1_0
end

return var_0_0
