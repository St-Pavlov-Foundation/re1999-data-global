module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectPool", package.seeall)

slot0 = class("TeamChessEffectPool")
slot1 = 1
slot2 = {}
slot3 = 10
slot4 = nil

function slot0.dispose()
	if uv0 ~= nil then
		for slot3, slot4 in pairs(uv0) do
			slot4:dispose()
		end

		uv0 = {}
	end
end

function slot0.getEffect(slot0, slot1, slot2)
	if uv0 == nil then
		uv0 = {}
	end

	if uv0[slot0] == nil then
		uv0[slot0] = LuaObjPool.New(uv1, function ()
			return uv0._createWrap(uv1)
		end, function (slot0)
			if slot0 ~= nil then
				slot0:onDestroy()
			end
		end, function (slot0)
			if slot0 ~= nil then
				slot0:clear()
			end
		end)
	end

	if slot3:getObject() == nil then
		slot4 = uv2._createWrap(slot0)
	end

	slot4:setCallback(slot1, slot2)

	return slot4
end

function slot0.returnEffect(slot0)
	if slot0 == nil then
		return
	end

	if uv0[slot0.effectType] ~= nil then
		slot1:putObject(slot0)
	end
end

function slot0.setPoolContainerGO(slot0)
	uv0 = slot0
end

function slot0.getPoolContainerGO()
	return uv0
end

function slot0._createWrap(slot0)
	slot1 = gohelper.create3d(uv0.getPoolContainerGO(), slot0)
	slot2 = MonoHelper.addLuaComOnceToGo(slot1, TeamChessEffectWrap)

	slot2:init(slot1)
	slot2:setUniqueId(uv1)
	slot2:setEffectType(slot0)

	uv1 = uv1 + 1

	return slot2
end

return slot0
