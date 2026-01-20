-- chunkname: @modules/logic/bossrush/view/v1a6/taskachievement/V1a6_BossRush_BonusViewContainer.lua

module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusViewContainer", package.seeall)

local V1a6_BossRush_BonusViewContainer = class("V1a6_BossRush_BonusViewContainer", BaseViewContainer)

function V1a6_BossRush_BonusViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, V1a6_BossRush_TabViewGroup.New(2, "#go_bonus"))
	table.insert(views, V1a6_BossRush_BonusView.New())

	return views
end

function V1a6_BossRush_BonusViewContainer:_getTabView(tabViewEnum)
	local achievementScrollParam = ListScrollParam.New()

	achievementScrollParam.cellClass = tabViewEnum.CellClass
	achievementScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	achievementScrollParam.prefabUrl = self._viewSetting.otherRes[tabViewEnum.ResIndex]
	achievementScrollParam.scrollGOPath = "Right/#scroll_ScoreList"
	achievementScrollParam.scrollDir = ScrollEnum.ScrollDirV
	achievementScrollParam.lineCount = 1
	achievementScrollParam.cellWidth = 964
	achievementScrollParam.cellHeight = 162
	achievementScrollParam.cellSpaceH = 0
	achievementScrollParam.cellSpaceV = 0
	achievementScrollParam.startSpace = 0
	achievementScrollParam.sortMode = ScrollEnum.ScrollSortDown

	local scrollView = LuaListScrollViewWithAnimator.New(tabViewEnum.ListModel, achievementScrollParam, self.delayTimes)
	local viewClass = tabViewEnum.ViewClass.New()
	local multiView = MultiView.New({
		viewClass,
		scrollView
	})
	local tabView = {
		viewClass = viewClass,
		scrollView = scrollView,
		multiView = multiView
	}

	return tabView
end

function V1a6_BossRush_BonusViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		self.delayTimes = {}

		for i = 1, 10 do
			local delayTime = (i - 1) * 0.07

			self.delayTimes[i] = delayTime
		end

		self._tabView = {}

		local tabViewEnum = BossRushModel.instance:getActivityBonus()
		local multiViews = {}

		for tab, _tabViewEnum in ipairs(tabViewEnum) do
			local tabView = self:_getTabView(_tabViewEnum)

			self._tabView[tab] = tabView

			table.insert(multiViews, tabView.multiView)
		end

		return multiViews
	end
end

function V1a6_BossRush_BonusViewContainer:getScrollAnimRemoveItem(tab)
	local tabView = self._tabView[tab]

	if tabView and tabView.scrollView and not gohelper.isNil(tabView.scrollView._csListScroll) then
		return ListScrollAnimRemoveItem.Get(tabView.scrollView)
	end
end

function V1a6_BossRush_BonusViewContainer:getTabView(tab)
	local tabView = self._tabView[tab]

	return tabView and tabView.viewClass
end

function V1a6_BossRush_BonusViewContainer:selectTabView(selectId)
	V1a6_BossRush_BonusModel.instance:setTab(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

return V1a6_BossRush_BonusViewContainer
