module("modules.logic.guide.controller.trigger.GuideTriggerRoomTradeLv", package.seeall)

slot0 = class("GuideTriggerRoomTradeLv", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnTradeLevelUpReply, slot0._checkStartGuide, slot0)
	ManufactureController.instance:registerCallback(ManufactureEvent.TradeLevelChange, slot0._checkStartGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	return slot1 == SceneType.Room and tonumber(slot2) <= slot0:getParam()
end

function slot0.getParam(slot0)
	return ManufactureModel.instance:getTradeLevel()
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:checkStartGuide(slot1)
end

function slot0._checkStartGuide(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot0:checkStartGuide(slot1)
	end
end

return slot0
