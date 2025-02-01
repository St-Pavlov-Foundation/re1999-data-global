module("modules.logic.scene.rouge.comp.RougeSceneViewComp", package.seeall)

slot0 = class("RougeSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	if not ViewMgr.instance:isOpen(ViewName.RougeMapView) then
		ViewMgr.instance:openView(ViewName.RougeMapView)
	end

	ViewMgr.instance:openView(ViewName.RougeMapTipView)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	ViewMgr.instance:closeAllPopupViews()
	ViewMgr.instance:closeView(ViewName.RougeMapTipView)
end

return slot0
