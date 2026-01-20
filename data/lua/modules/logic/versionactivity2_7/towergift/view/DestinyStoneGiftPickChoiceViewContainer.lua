-- chunkname: @modules/logic/versionactivity2_7/towergift/view/DestinyStoneGiftPickChoiceViewContainer.lua

module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceViewContainer", package.seeall)

local DestinyStoneGiftPickChoiceViewContainer = class("DestinyStoneGiftPickChoiceViewContainer", BaseViewContainer)

function DestinyStoneGiftPickChoiceViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_stone"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_stone/Viewport/Content/stoneitem"
	scrollParam.cellClass = DestinyStoneGiftPickChoiceListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 408
	scrollParam.cellHeight = 208
	scrollParam.cellSpaceH = 16
	scrollParam.cellSpaceV = 16
	scrollParam.startSpace = 10
	scrollParam.endSpace = 30

	table.insert(views, LuaListScrollView.New(DestinyStoneGiftPickChoiceListModel.instance, scrollParam))
	table.insert(views, DestinyStoneGiftPickChoiceView.New())

	return views
end

return DestinyStoneGiftPickChoiceViewContainer
