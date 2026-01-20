-- chunkname: @modules/logic/room/view/RoomInformPlayerViewContainer.lua

module("modules.logic.room.view.RoomInformPlayerViewContainer", package.seeall)

local RoomInformPlayerViewContainer = class("RoomInformPlayerViewContainer", BaseViewContainer)
local langParam = {
	[LangSettings.zh] = {
		cellSpaceH = 37,
		cellWidth = 280,
		lineCount = 4
	},
	[LangSettings.jp] = {
		cellSpaceH = 37,
		cellWidth = 390,
		lineCount = 3
	},
	[LangSettings.en] = {
		cellSpaceH = 60,
		cellWidth = 380,
		lineCount = 3
	}
}

function RoomInformPlayerViewContainer:buildViews()
	local _langParam = langParam[GameConfig:GetCurLangType()] or langParam[LangSettings.zh]
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "object/scroll_inform"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "object/scroll_inform/Viewport/#go_informContent/#go_informItem"
	scrollParam.cellClass = RoomInformReportTypeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = _langParam.lineCount
	scrollParam.cellWidth = _langParam.cellWidth
	scrollParam.cellHeight = 40
	scrollParam.cellSpaceH = _langParam.cellSpaceH
	scrollParam.cellSpaceV = 33
	scrollParam.startSpace = 0

	return {
		CommonViewFrame.New(),
		RoomInformPlayerView.New(),
		LuaListScrollView.New(RoomReportTypeListModel.instance, scrollParam)
	}
end

function RoomInformPlayerViewContainer:buildTabViews(tabContainerId)
	return
end

function RoomInformPlayerViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return RoomInformPlayerViewContainer
