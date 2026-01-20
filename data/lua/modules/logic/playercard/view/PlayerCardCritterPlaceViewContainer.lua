-- chunkname: @modules/logic/playercard/view/PlayerCardCritterPlaceViewContainer.lua

module("modules.logic.playercard.view.PlayerCardCritterPlaceViewContainer", package.seeall)

local PlayerCardCritterPlaceViewContainer = class("PlayerCardCritterPlaceViewContainer", BaseViewContainer)

function PlayerCardCritterPlaceViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerCardCritterPlaceView.New())

	local scrollParam1 = self:getScrollParam1()
	local scrollParam2 = self:getScrollParam2()
	local critterPlaceListView1 = LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, scrollParam1)
	local critterPlaceListView2 = LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, scrollParam2)

	table.insert(views, critterPlaceListView1)
	table.insert(views, critterPlaceListView2)
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function PlayerCardCritterPlaceViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigateView
		}
	end
end

function PlayerCardCritterPlaceViewContainer:getScrollParam1()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_critterview1/critterscroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	scrollParam.cellClass = PlayerCardCritterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 150
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 30
	scrollParam.startSpace = 30

	return scrollParam
end

function PlayerCardCritterPlaceViewContainer:getScrollParam2()
	local scrollPath = "#go_critterview2/critterscroll"
	local scrollWidth = self:_getScrollWidth(scrollPath)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = scrollPath
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	scrollParam.cellClass = PlayerCardCritterPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 150
	scrollParam.lineCount = self:_getLineCount(scrollWidth, scrollParam.cellWidth)
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 10

	return scrollParam
end

function PlayerCardCritterPlaceViewContainer:_getScrollWidth(path)
	local scrollTrans = gohelper.findChildComponent(self.viewGO, path, gohelper.Type_Transform)

	if scrollTrans then
		return recthelper.getWidth(scrollTrans)
	end

	local scale = 1080 / UnityEngine.Screen.height
	local screenWidth = math.floor(UnityEngine.Screen.width * scale + 0.5)

	return screenWidth
end

function PlayerCardCritterPlaceViewContainer:_getLineCount(scrollWidth, cellWidth)
	local lineCount = math.floor(scrollWidth / cellWidth)

	lineCount = math.max(lineCount, 1)

	return lineCount
end

return PlayerCardCritterPlaceViewContainer
