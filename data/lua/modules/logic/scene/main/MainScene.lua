module("modules.logic.scene.main.MainScene", package.seeall)

slot0 = class("MainScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("director", MainSceneDirector)
	slot0:_addComp("level", MainSceneLevelComp)
	slot0:_addComp("camera", MainSceneCameraComp)
	slot0:_addComp("view", MainSceneViewComp)
	slot0:_addComp("gyro", MainSceneGyroComp)
	slot0:_addComp("bgm", CommonSceneBgmComp)
	slot0:_addComp("yearAnimation", MainSceneYearAnimationComp)
end

return slot0
