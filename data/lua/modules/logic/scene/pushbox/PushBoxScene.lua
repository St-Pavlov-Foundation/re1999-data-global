module("modules.logic.scene.pushbox.PushBoxScene", package.seeall)

slot0 = class("PushBoxScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("director", PushBoxSceneDirector)
	slot0:_addComp("preloader", PushBoxScenePreloader)
	slot0:_addComp("camera", PushBoxSceneCameraComp)
	slot0:_addComp("gameMgr", PushBoxGameMgr)
	slot0:_addComp("view", PushBoxSceneViewComp)
end

return slot0
