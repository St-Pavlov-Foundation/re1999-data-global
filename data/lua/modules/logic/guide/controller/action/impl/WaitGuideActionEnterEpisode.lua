module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterEpisode", package.seeall)

slot0 = class("WaitGuideActionEnterEpisode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._episodeId = tonumber(slot0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._checkInEpisode, slot0)
	slot0:_checkInEpisode(GameSceneMgr.instance:getCurSceneType(), nil)
end

function slot0._checkInEpisode(slot0, slot1, slot2)
	if slot1 == SceneType.Fight then
		if not slot0._episodeId or slot0._episodeId == FightModel.instance:getFightParam().episodeId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkInEpisode, slot0)
			slot0:onDone(true)
		end
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkInEpisode, slot0)
end

return slot0
