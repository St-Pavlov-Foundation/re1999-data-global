module("modules.logic.guide.controller.trigger.GuideTriggerEnterEpisode", package.seeall)

slot0 = class("GuideTriggerEnterEpisode", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == tonumber(slot2)
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	if slot1 == SceneType.Fight and FightModel.instance:getFightParam().episodeId then
		slot0:checkStartGuide(slot3.episodeId)
	end
end

return slot0
