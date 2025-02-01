module("modules.logic.scene.rouge.RougeScene", package.seeall)

slot0 = class("RougeScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("camera", RougeSceneCameraComp)
	slot0:_addComp("director", RougeSceneDirector)
	slot0:_addComp("model", RougeSceneModel)
	slot0:_addComp("map", RougeSceneMap)
	slot0:_addComp("view", RougeSceneViewComp)
	slot0:_addComp("bgm", RougeSceneBgmComp)
end

return slot0
