module("modules.logic.room.entity.pool.RoomGOPool", package.seeall)

slot0 = _M
slot1 = false
slot2, slot3 = nil
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = nil

function slot0.init(slot0, slot1)
	uv0._reset()

	uv1 = slot0
	uv2 = slot1
	uv3 = true
end

function slot0.addPrefab(slot0, slot1, slot2)
	if uv0 then
		uv0[slot0] = slot1
		uv1[slot0] = slot2
	end
end

function slot0.getInstance(slot0, slot1, slot2, slot3)
	if not uv0 then
		return
	end

	if not (uv1[slot0] or GameSceneMgr.instance:getCurScene().preloader:getResource(slot0, slot3)) then
		logError(string.format("找不到资源: %s", slot0))

		return
	end

	if not uv2[slot0] then
		uv2[slot0] = slot3 or slot0
	end

	if not uv3[slot0] then
		uv3[slot0] = {}
	end

	if not uv4[slot0] then
		uv4[slot0] = {}
	end

	slot7 = nil

	if #slot5 > 0 then
		gohelper.addChild(slot1, slot5[#slot5])

		slot7.name = slot2 or "instance"

		table.remove(slot5, #slot5)
	else
		slot7 = gohelper.clone(slot4, slot1, slot2 or "instance")
	end

	table.insert(slot6, slot7)

	return slot7
end

function slot0.returnInstance(slot0, slot1)
	if not uv0 then
		return
	end

	if not uv1[slot0] then
		uv1[slot0] = {}
	end

	if not uv2[slot0] then
		uv2[slot0] = {}
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8 == slot1 then
			table.remove(slot3, slot7)

			break
		end
	end

	if uv3[slot0] and uv3[slot0] >= 0 and uv3[slot0] <= #slot2 then
		gohelper.addChild(uv4.getPoolContainerGO(), slot1)
		gohelper.destroy(slot1)
	else
		gohelper.addChild(uv4.getPoolContainerGO(), slot1)
		table.insert(slot2, slot1)
	end
end

function slot0.clearPool()
	uv0 = {}

	for slot4, slot5 in pairs(uv0) do
		for slot9, slot10 in ipairs(slot5) do
			gohelper.destroy(slot10)
		end
	end
end

function slot0.existABPath(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(uv0) do
		if slot6 == slot0 then
			slot1 = false

			if uv1.existResPath(slot5) == true then
				return true
			end
		end
	end

	return slot1
end

function slot0.existResPath(slot0)
	if uv0[slot0] and #slot1 > 0 then
		return true
	end

	if uv1[slot0] and #slot2 > 0 then
		return true
	end

	return false
end

function slot0.dispose()
	uv0 = false

	for slot3, slot4 in pairs(uv1) do
		for slot8, slot9 in ipairs(slot4) do
			gohelper.destroy(slot9)
		end
	end

	for slot3, slot4 in pairs(uv2) do
		for slot8, slot9 in ipairs(slot4) do
			gohelper.destroy(slot9)
		end
	end

	uv3._reset()
end

function slot0._reset()
	uv0 = false
	uv1 = nil
	uv2 = nil
	uv3 = {}
	uv4 = {}
	uv5 = {}
end

function slot0.getPoolContainerGO()
	if not uv0 then
		uv0 = GameSceneMgr.instance:getCurScene().go.poolContainerGO

		gohelper.setActive(uv0, false)
	end

	return uv0
end

return slot0
