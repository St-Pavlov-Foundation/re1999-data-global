-- chunkname: @modules/logic/activity/view/show/ActivityGuestBindViewContainer.lua

module("modules.logic.activity.view.show.ActivityGuestBindViewContainer", package.seeall)

local ActivityGuestBindViewContainer = class("ActivityGuestBindViewContainer", BaseViewContainer)

function ActivityGuestBindViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()
	local scrollModel = ActivityGuestBindViewListModel.instance

	scrollParam.cellClass = ActivityGuestBindViewItem
	scrollParam.scrollGOPath = "leftbottom/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 172
	scrollParam.cellHeight = 185
	scrollParam.cellSpaceH = 35
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local views = {
		ActivityGuestBindView.New(),
		(LuaListScrollView.New(scrollModel, scrollParam))
	}

	return views
end

return ActivityGuestBindViewContainer
