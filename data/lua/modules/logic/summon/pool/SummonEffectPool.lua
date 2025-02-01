module("modules.logic.summon.pool.SummonEffectPool", package.seeall)

slot0 = _M
slot1 = 1
slot2 = {}
slot3 = {}
slot4 = {}
slot5, slot6 = nil

function slot0.onEffectPreload(slot0)
	slot0:Retain()

	uv0[slot0.ResPath] = slot0

	uv1.returnEffect(uv1.getEffect(slot0.ResPath))
end

function slot0.dispose()
	for slot3, slot4 in pairs(uv0) do
		slot4:Release()
	end

	for slot3, slot4 in pairs(uv1) do
		for slot8, slot9 in ipairs(slot4) do
			slot9:markCanDestroy()
			gohelper.destroy(slot9.containerGO)
		end
	end

	for slot3, slot4 in pairs(uv2) do
		slot4:markCanDestroy()
		gohelper.destroy(slot4.containerGO)
	end

	uv0 = {}
	uv1 = {}
	uv2 = {}

	gohelper.destroy(uv3)

	uv3 = nil
	uv4 = nil
	uv5 = 1
end

function slot0.getEffect(slot0, slot1)
	slot3 = uv1.getPoolContainerGO()
	slot4 = nil

	if uv0[slot0] then
		if uv2[slot0] and #slot5 > 0 then
			slot6 = #slot5

			for slot10, slot11 in ipairs(slot5) do
				if slot1 == nil and slot11.hangPointGO == slot3 or slot1 ~= nil and slot11.hangPointGO == slot1 then
					slot6 = slot10

					break
				end
			end

			slot4 = table.remove(slot5, slot6)
		else
			uv1._instantiateEffectGO(slot2, uv1._createWrap(slot0))
		end

		slot4:setHangPointGO(slot1 or slot3)
	else
		logError("Summon Effect need preload: " .. slot0)

		return nil
	end

	uv3[slot4.uniqueId] = slot4

	slot4:setActive(true)

	return slot4
end

function slot0.returnEffect(slot0)
	if gohelper.isNil(slot0.containerGO) then
		return
	end

	slot0:stop()
	slot0:unloadIcon()
	slot0:setActive(false)

	uv0[slot0.uniqueId] = nil

	if not uv1[slot0.path] then
		uv1[slot0.path] = {}
	end

	table.insert(slot1, slot0)
end

function slot0.returnEffectToPoolContainer(slot0)
	slot0:setHangPointGO(uv0.getPoolContainerGO())
end

function slot0.getPoolContainerGO()
	if not uv0 then
		uv0 = gohelper.create3d(VirtualSummonScene.instance:getRootGO(), "EffectPool")
		uv1 = uv0.transform
	end

	return uv0
end

function slot0._instantiateEffectGO(slot0, slot1)
	slot1:setEffectGO(gohelper.clone(slot0:GetResource(), slot1.containerGO))
end

function slot0._createWrap(slot0)
	slot1 = string.split(slot0, "/")
	slot4 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(uv0.getPoolContainerGO(), slot1[#slot1]), SummonEffectWrap)

	slot4:setUniqueId(uv1)
	slot4:setPath(slot0)

	uv1 = uv1 + 1

	return slot4
end

return slot0
