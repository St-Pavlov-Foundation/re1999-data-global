module("modules.logic.scene.pushbox.comp.PushBoxSceneViewComp", package.seeall)

slot0 = class("PushBoxSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	ViewMgr.instance:closeView(ViewName.PushBoxView)
end

return slot0
