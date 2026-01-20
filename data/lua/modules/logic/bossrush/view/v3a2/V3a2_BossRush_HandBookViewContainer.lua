-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_HandBookViewContainer.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_HandBookViewContainer", package.seeall)

local V3a2_BossRush_HandBookViewContainer = class("V3a2_BossRush_HandBookViewContainer", BaseViewContainer)

function V3a2_BossRush_HandBookViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "boss/#scroll_boss"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = BossRushEnum.ResPath.v3a2_bossrush_handbookitem
	scrollParam.cellClass = V3a2_BossRush_HandBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 370
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	self._scrollview = LuaListScrollView.New(V3a2_BossRush_HandBookListModel.instance, scrollParam)

	table.insert(views, V3a2_BossRush_HandBookView.New())
	table.insert(views, V3a2_BossRush_HandBookEnemyInfoView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))
	table.insert(views, self._scrollview)

	return views
end

function V3a2_BossRush_HandBookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V3a2_BossRush_HandBookViewContainer
