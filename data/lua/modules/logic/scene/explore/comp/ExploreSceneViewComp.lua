module("modules.logic.scene.explore.comp.ExploreSceneViewComp", package.seeall)

slot0 = class("ExploreSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.ExploreView)

	slot0._uiRoot = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.PopUpTop), "ExploreUnitUI")
end

function slot0.getRoot(slot0)
	return slot0._uiRoot
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._uiRoot, slot1)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.ExploreView)
	gohelper.destroy(slot0._uiRoot)

	slot0._uiRoot = nil
end

return slot0
