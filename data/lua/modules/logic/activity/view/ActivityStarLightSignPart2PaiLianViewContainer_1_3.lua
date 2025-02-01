module("modules.logic.activity.view.ActivityStarLightSignPart2PaiLianViewContainer_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPart2PaiLianViewContainer_1_3", ActivityStarLightSignPaiLianViewBaseContainer_1_3)

function slot0.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = ActivityStarLightSignItem_1_3
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -12.1
end

function slot0.onGetMainViewClassType(slot0)
	return ActivityStarLightSignPart2PaiLianView_1_3
end

return slot0
