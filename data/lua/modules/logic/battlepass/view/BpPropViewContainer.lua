-- chunkname: @modules/logic/battlepass/view/BpPropViewContainer.lua

module("modules.logic.battlepass.view.BpPropViewContainer", package.seeall)

local BpPropViewContainer = class("BpPropViewContainer", BaseViewContainer)

function BpPropViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CommonPropListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 50
	scrollParam.startSpace = 35
	scrollParam.endSpace = 56

	table.insert(views, LuaListScrollView.New(CommonPropListModel.instance, scrollParam))
	table.insert(views, CommonPropView.New())

	return views
end

return BpPropViewContainer
