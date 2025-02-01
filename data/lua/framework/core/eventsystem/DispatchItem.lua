module("framework.core.eventsystem.DispatchItem", package.seeall)

slot0 = class("DispatchItem")

function slot0.createPool()
	uv0._pool = LuaObjPool.New(32, uv0._poolNew, uv0._poolRelease, uv0._poolReset)
end

function slot0.getPool()
	if uv0._pool == nil then
		uv0.createPool()
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

function slot0.reset(slot0)
	slot0.eventName = nil
	slot0.eventArgs = nil
end

return slot0
