module("modules.logic.fight.entity.pool.FightBuffHandlerPool", package.seeall)

slot0 = class("FightBuffHandlerPool")
slot1 = {}

function slot0.getHandlerInst(slot0, slot1)
	if not slot0 then
		logError("param of \"type\" = nil")
	end

	if not slot1 then
		logError("param of \"typeCls\" = nil")
	end

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

			return FightBuffHandler.New()
		end, uv1._releaseFunc, uv1._resetFunc)
	end

	slot3 = slot2:getObject()
	slot3.type = slot0

	return slot3
end

function slot0.putHandlerInst(slot0)
	uv0[slot0.type]:putObject(slot0)
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
