module("modules.logic.guide.controller.trigger.GuideTriggerEnterScene", package.seeall)

slot0 = class("GuideTriggerEnterScene", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == SceneType[slot2]
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

return slot0
