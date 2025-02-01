module("modules.logic.guide.controller.action.impl.WaitGuideActionAnyTouch", package.seeall)

slot0 = class("WaitGuideActionAnyTouch", BaseGuideAction)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
end

function slot0.clearWork(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
end

function slot0._onTouchScreen(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	TaskDispatcher.runDelay(function ()
		uv0:onDone(true)
	end, nil, 0.1)
end

return slot0
