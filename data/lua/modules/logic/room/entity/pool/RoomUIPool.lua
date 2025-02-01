module("modules.logic.room.entity.pool.RoomUIPool", package.seeall)

slot0 = _M
slot1 = false
slot2, slot3 = nil
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = {}
slot8 = nil

function slot0.init(slot0)
	uv0._reset()

	uv1 = slot0
	uv2 = true

	TaskDispatcher.runRepeat(uv0._onTickSortSibling, nil, 2)
end

function slot0.getInstance(slot0, slot1)
	if not uv0 then
		return
	end

	if not (uv1[slot0] or GameSceneMgr.instance:getCurScene().preloader:getResource(slot0)) then
		logError(string.format("找不到资源:%s", slot0))

		return
	end

	if not uv2[slot0] then
		uv2[slot0] = {}
	end

	if not uv3[slot0] then
		uv3[slot0] = {}
	end

	slot5 = nil

	if #slot3 > 0 then
		gohelper.addChild(uv4.getInstanceContainerGO(), slot3[#slot3])

		slot5.name = slot1 or "ui"

		table.remove(slot3, #slot3)
	else
		slot5 = gohelper.clone(slot2, uv4.getInstanceContainerGO(), slot1 or "ui")
	end

	table.insert(slot4, slot5)
	table.insert(uv5, slot5)
	transformhelper.setLocalScale(slot5.transform, 0.01, 0.01, 0.01)

	return slot5
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

	gohelper.addChild(uv3.getPoolContainerGO(), slot1)

	for slot7, slot8 in ipairs(slot3) do
		if slot8 == slot1 then
			table.remove(slot3, slot7)

			break
		end
	end

	tabletool.removeValue(uv4, slot1)
	table.insert(slot2, slot1)
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
	TaskDispatcher.cancelTask(uv3._onTickSortSibling, nil)
end

function slot0._reset()
	uv0 = false
	uv1 = nil
	uv2 = nil
	uv3 = {}
	uv4 = {}

	for slot3, slot4 in pairs(uv5) do
		uv5[slot3] = nil
	end

	for slot3, slot4 in pairs(uv6) do
		uv6[slot3] = nil
	end

	uv5 = {}
	uv6 = {}
end

function slot0.getPoolContainerGO()
	if not uv0 then
		uv0 = gohelper.findChild(GameSceneMgr.instance:getCurScene().go.canvasGO, "uipoolcontainer")

		gohelper.setActive(uv0, false)
	end

	return uv0
end

function slot0.getInstanceContainerGO()
	if not uv0 then
		uv0 = gohelper.findChild(GameSceneMgr.instance:getCurScene().go.canvasGO, "uiinstancecontainer")
	end

	return uv0
end

function slot0._onTickSortSibling()
	if #uv0 <= 1 then
		return
	end

	slot0, slot1, slot2 = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	for slot6, slot7 in ipairs(uv0) do
		slot8, slot9, slot10 = transformhelper.getPos(slot7.transform)
		slot11 = slot0 - slot8
		slot12 = slot1 - slot9
		slot13 = slot2 - slot10
		uv1[slot7] = slot11 * slot11 + slot12 * slot12 + slot13 * slot13
	end

	table.sort(uv0, uv2._sortByDistance)

	for slot6, slot7 in ipairs(uv0) do
		gohelper.setSibling(slot7, slot6 - 1)
	end
end

function slot0._sortByDistance(slot0, slot1)
	return uv0[slot1] < uv0[slot0]
end

return slot0
