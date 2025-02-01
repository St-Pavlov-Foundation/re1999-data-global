module("framework.core.callback.LuaGeneralCallback", package.seeall)

slot0 = class("LuaGeneralCallback")
slot0._pool = nil

function slot0.getPool()
	if not uv0._pool then
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
	slot0.id = 0
	slot0.callback = nil
	slot0.hasCbObj = false
	slot0.cbObjContainer = {}

	setmetatable(slot0.cbObjContainer, {
		__mode = "v"
	})

	slot0.cbObjContainer.value = nil
end

function slot0.setCbObj(slot0, slot1)
	slot0.hasCbObj = slot1 ~= nil

	if slot0.hasCbObj then
		slot0.cbObjContainer.value = slot1
	end
end

function slot0.invoke(slot0, ...)
	if slot0.hasCbObj and not slot0.cbObjContainer.value then
		return false
	end

	if not slot0.hasCbObj then
		slot0.callback(unpack({
			...
		}))
	else
		slot0.callback(slot0.cbObjContainer.value, unpack(slot1))
	end

	return true
end

function slot0.reset(slot0)
	slot0.id = 0
	slot0.callback = nil
	slot0.hasCbObj = false
	slot0.cbObjContainer.value = nil
end

function slot0.release(slot0)
	slot0:reset()
end

return slot0
