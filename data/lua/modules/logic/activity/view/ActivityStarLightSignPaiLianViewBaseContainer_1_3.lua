module("modules.logic.activity.view.ActivityStarLightSignPaiLianViewBaseContainer_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPaiLianViewBaseContainer_1_3", Activity101SignViewBaseContainer)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = ActivityStarLightSignItem_1_3
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -12
end

function slot0.onGetMainViewClassType(slot0)
	assert(false, "please override thid function")
end

function slot0.onBuildViews(slot0)
	return {
		slot0.__mainView
	}
end

return slot0
