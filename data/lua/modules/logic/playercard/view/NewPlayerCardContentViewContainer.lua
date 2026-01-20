-- chunkname: @modules/logic/playercard/view/NewPlayerCardContentViewContainer.lua

module("modules.logic.playercard.view.NewPlayerCardContentViewContainer", package.seeall)

local NewPlayerCardContentViewContainer = class("NewPlayerCardContentViewContainer", BaseViewContainer)

function NewPlayerCardContentViewContainer:buildViews()
	local views = {}

	table.insert(views, NewPlayerCardContentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	self:buildThemeScrollView(views)

	return views
end

function NewPlayerCardContentViewContainer:buildThemeScrollView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "bottom/#scroll_theme"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "bottom/#scroll_theme/viewport/Content/#go_themeitem"
	scrollParam.cellClass = PlayerCardThemeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 404
	scrollParam.cellHeight = 172
	scrollParam.cellSpaceH = -26
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 49
	scrollParam.endSpace = 0
	self.scrollView = LuaListScrollView.New(PlayerCardThemeListModel.instance, scrollParam)

	table.insert(views, self.scrollView)
end

function NewPlayerCardContentViewContainer:buildTabViews(tabContainerId)
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

function NewPlayerCardContentViewContainer:_overrideClose()
	local isopen = PlayerCardModel.instance:getIsOpenSkinView()

	if not isopen then
		self:closeThis()
	else
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBottomView)
	end
end

return NewPlayerCardContentViewContainer
