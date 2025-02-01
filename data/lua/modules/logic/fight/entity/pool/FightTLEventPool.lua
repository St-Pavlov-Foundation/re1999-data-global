module("modules.logic.fight.entity.pool.FightTLEventPool", package.seeall)

slot0 = class("FightTLEventPool")
slot1 = {}

function slot0.getHandlerInst(slot0, slot1)
	if not uv0[slot0] then
		uv0[slot0] = LuaObjPool.New(32, function ()
			if uv0 then
				if uv0.New then
					return uv0.New()
				else
					logError("FightTLEvent class.ctor is nil: " .. uv1)
				end
			else
				logError("FightTLEvent class is nil: " .. uv1)
			end

			return FightTLEvent.New()
		end, uv1._releaseFunc, uv1._resetFunc)
	end

	slot3 = slot2:getObject()
	slot3.type = slot0

	return slot3
end

function slot0.dispose()
	for slot3, slot4 in pairs(uv0) do
		slot4:dispose()
	end

	uv0 = {}
end

function slot0.putHandlerInst(slot0)
	if uv0[slot0.type] then
		slot1:putObject(slot0)
	else
		if slot0.reset then
			slot0:reset()
		end

		if slot0.dispose then
			slot0:dispose()
		end
	end
end

function slot0._releaseFunc(slot0)
	if slot0.dispose then
		slot0:dispose()
	end
end

function slot0._resetFunc(slot0)
	if slot0.reset then
		slot0:reset()
	end
end

return slot0
