module("modules.logic.guide.controller.action.impl.GuideActionEnterScene", package.seeall)

slot0 = class("GuideActionEnterScene", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._sceneType = SceneType[string.split(slot0.actionParam, "#")[1]]

	if VirtualSummonScene.instance:isOpen() and slot0._sceneType ~= SceneType.Summon then
		VirtualSummonScene.instance:close(true)
	end

	if slot0._sceneType == SceneType.Summon then
		SummonController.instance:enterSummonScene()
	else
		slot0._sceneId = tonumber(slot2[2])
		slot0._sceneLevel = tonumber(slot2[3])

		if slot0._sceneLevel then
			GameSceneMgr.instance:startScene(slot0._sceneType, slot0._sceneId, slot0._sceneLevel)
		else
			GameSceneMgr.instance:startSceneDefaultLevel(slot0._sceneType, slot0._sceneId)
		end
	end

	slot0:onDone(true)
end

return slot0
