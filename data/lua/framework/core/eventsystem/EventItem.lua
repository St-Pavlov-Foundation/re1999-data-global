module("framework.core.eventsystem.EventItem", package.seeall)

slot0 = class("EventItem")
slot0.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
slot1 = _G.callWithCatch
slot2 = xpcall

function slot0.getPool()
	if uv0._pool == nil then
		uv0._pool = LuaObjPool.New(32, uv0._poolNew, uv0._poolRelease, uv0._poolReset)
	end

	return uv0._pool
end

function slot0._poolNew()
	return uv0.New()
end

function slot0._poolRelease(slot0)
	slot0:release()
end

function slot0._poolReset(slot0)
	slot0:reset()
end

function slot0.ctor(slot0)
	slot0:reset()
end

function slot0.release(slot0)
	slot0:reset()
end

function slot0.ctor(slot0)
	slot0.cbObjContainer = {}

	setmetatable(slot0.cbObjContainer, {
		__mode = "v"
	})
	slot0:reset()
end

function slot0.reset(slot0)
	slot0.eventName = nil
	slot0.callback = nil
	slot0.cbObjContainer.value = nil
	slot0.hasCbObj = false
	slot0.status = LuaEventSystem.Idle
	slot0.priority = LuaEventSystem.Low
	slot0.removeAll = nil
end

function slot0.setCbObj(slot0, slot1)
	slot0.hasCbObj = slot1 ~= nil

	if slot0.hasCbObj then
		slot0.cbObjContainer.value = slot1
	end
end

function slot0.getCbObj(slot0)
	if slot0.hasCbObj then
		return slot0.cbObjContainer.value
	end

	return nil
end

function slot0.dispatch(slot0, ...)
	if slot0.hasCbObj and not slot0.cbObjContainer.value then
		return false
	end

	if not slot0.hasCbObj then
		uv0(slot0.callback, ...)
	elseif (... ~= nil and select("#", ...) or 0) > 0 then
		uv1(slot0.callback, __G__TRACKBACK__, slot0.cbObjContainer.value, select(1, ...))
	else
		uv1(slot0.callback, __G__TRACKBACK__, slot0.cbObjContainer.value)
	end

	return true
end

return slot0
