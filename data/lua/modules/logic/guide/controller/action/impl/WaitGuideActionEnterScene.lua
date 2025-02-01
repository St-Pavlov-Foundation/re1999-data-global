module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterScene", package.seeall)

slot0 = class("WaitGuideActionEnterScene", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._sceneType = SceneType[slot0.actionParam]

	if GameSceneMgr.instance:getCurSceneType() == slot0._sceneType and not GameSceneMgr.instance:isLoading() then
		slot0:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(slot0._sceneType, slot0._onEnterScene, slot0)
	end
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot2 == 1 then
		GameSceneMgr.instance:unregisterCallback(slot0._sceneType, slot0._onEnterScene, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(slot0._sceneType, slot0._onEnterScene, slot0)
end

return slot0
