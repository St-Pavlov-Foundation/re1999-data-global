module("modules.ugui.dropdown.DropDownExtend", package.seeall)

slot0 = class("DropDownExtend", UserDataDispose)

function slot0.Get(slot0)
	return uv0.New(slot0)
end

slot0.DropListName = "Dropdown List"

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.goDrop = slot1
end

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.onDropShowCb = slot1
	slot0.onDropHideCb = slot2
	slot0.cbObj = slot3

	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, slot0._onTouchUp, slot0)
end

function slot0.addEventsListener(slot0)
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnStart, slot0.triggerShow, slot0)
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnDestroy, slot0.OnDropListDestroy, slot0)
end

function slot0.removeEventsListener(slot0)
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnStart, slot0.triggerShow, slot0)
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnDestroy, slot0.OnDropListDestroy, slot0)
end

function slot0._onTouchUp(slot0)
	slot0:addLiveComp(gohelper.findChild(slot0.goDrop, uv0.DropListName))
end

function slot0.addLiveComp(slot0, slot1)
	if slot1 == slot0.dropList then
		return
	end

	slot0.dropList = slot1

	if not gohelper.isNil(slot0.dropList) then
		slot0:addEventsListener()

		slot0.liveComp = MonoHelper.addLuaComOnceToGo(slot0.dropList, GameObjectLiveEventComp)
	end
end

function slot0.OnDropListDestroy(slot0, slot1)
	if slot0.dropList ~= slot1 then
		return
	end

	slot0.liveComp = nil

	slot0:removeEventsListener()
	TaskDispatcher.runDelay(slot0.afterDestroyDelay, slot0, 0.01)
end

function slot0.afterDestroyDelay(slot0)
	if gohelper.isNil(gohelper.findChild(slot0.goDrop, uv0.DropListName)) then
		slot0:triggerHide()

		return
	end

	slot0:addLiveComp(slot1)
end

function slot0.triggerHide(slot0)
	if slot0.onDropHideCb then
		slot0.onDropHideCb(slot0.cbObj)
	end
end

function slot0.triggerShow(slot0, slot1)
	if slot0.dropList ~= slot1 then
		return
	end

	if slot0.onDropShowCb then
		slot0.onDropShowCb(slot0.cbObj)
	end
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.afterDestroyDelay, slot0)

	slot0.liveComp = nil

	slot0:removeEventsListener()
	slot0:__onDispose()
end

return slot0
