module("modules.logic.guide.controller.trigger.GuideTriggerPlayerLv", package.seeall)

slot0 = class("GuideTriggerPlayerLv", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, slot0._onMainScene, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return tonumber(slot2) <= slot0:getParam()
end

function slot0.getParam(slot0)
	return PlayerModel.instance:getPlayinfo().level
end

function slot0._onMainScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:checkStartGuide()
	end
end

function slot0._checkStartGuide(slot0)
	slot0:checkStartGuide()
end

return slot0
