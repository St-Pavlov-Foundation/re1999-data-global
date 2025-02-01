module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsViewContainer", package.seeall)

slot0 = class("RoleStoryDispatchTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Layout/left/#go_herocontainer/Mask/#scroll_hero"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "Layout/left/#go_herocontainer/Mask/#scroll_hero/Viewport/Content/#go_heroitem"
	slot2.cellClass = RoleStoryDispatchLeftHeroItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 4
	slot2.cellWidth = 130
	slot2.cellHeight = 130
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 12
	slot0.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryDispatchHeroListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, RoleStoryDispatchTipsView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.currencyView = CurrencyView.New({
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	})
	slot0.currencyView.foreHideBtn = true

	return {
		slot0.currencyView
	}
end

return slot0
