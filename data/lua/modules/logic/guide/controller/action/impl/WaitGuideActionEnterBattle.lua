module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterBattle", package.seeall)

slot0 = class("WaitGuideActionEnterBattle", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._battleId = tonumber(slot0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._checkInBattle, slot0)
	slot0:_checkInBattle(GameSceneMgr.instance:getCurSceneType(), nil)
end

function slot0._checkInBattle(slot0, slot1, slot2)
	if slot1 == SceneType.Fight then
		if slot0._battleId and slot0._battleId == FightModel.instance:getFightParam().battleId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkInBattle, slot0)
			slot0:onDone(true)
		end
	end
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._checkInBattle, slot0)
end

return slot0
