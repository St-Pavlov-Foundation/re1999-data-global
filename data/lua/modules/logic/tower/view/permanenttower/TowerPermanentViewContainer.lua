module("modules.logic.tower.view.permanenttower.TowerPermanentViewContainer", package.seeall)

slot0 = class("TowerPermanentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._scrollListView = LuaMixScrollView.New(TowerPermanentModel.instance, slot0:getListContentParam())

	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot1, slot0._scrollListView)

	slot0.TowerPermanentPoolView = TowerPermanentPoolView.New()

	table.insert(slot1, TowerPermanentView.New())

	slot0.TowerPermanentInfoView = TowerPermanentInfoView.New()

	table.insert(slot1, slot0.TowerPermanentPoolView)
	table.insert(slot1, slot0.TowerPermanentInfoView)

	return slot1
end

function slot0.getListContentParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "Left/#scroll_category"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "Left/#scroll_category/Viewport/#go_Content/#go_item"
	slot1.cellClass = TowerPermanentItem
	slot1.scrollDir = ScrollEnum.ScrollDirV

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerPermanent)

		return {
			slot0.navigateView
		}
	end
end

function slot0.getTowerPermanentPoolView(slot0)
	return slot0.TowerPermanentPoolView
end

function slot0.getTowerPermanentInfoView(slot0)
	return slot0.TowerPermanentInfoView
end

return slot0
