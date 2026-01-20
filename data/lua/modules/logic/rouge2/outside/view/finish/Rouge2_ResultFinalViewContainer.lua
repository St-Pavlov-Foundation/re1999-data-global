-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultFinalViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultFinalViewContainer", package.seeall)

local Rouge2_ResultFinalViewContainer = class("Rouge2_ResultFinalViewContainer", BaseViewContainer)

function Rouge2_ResultFinalViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_ResultFinalView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.scrollGOPath = "Right/#scroll_collection"
	scrollParam.prefabUrl = "Right/#scroll_collection/Viewport/Content/#go_collectionitem"
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.cellClass = Rouge2_ResultCollectionListItem
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 180
	scrollParam.startSpace = 6
	scrollParam.endSpace = 0
	scrollParam.lineCount = 5

	table.insert(views, LuaListScrollView.New(Rouge2_ResultCollectionListModel.instance, scrollParam))

	return views
end

function Rouge2_ResultFinalViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Rouge2_ResultFinalViewContainer
