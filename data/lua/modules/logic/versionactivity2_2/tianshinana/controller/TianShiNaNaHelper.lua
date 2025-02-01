module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaHelper", package.seeall)

slot0 = class("TianShiNaNaHelper")
slot1 = Vector2()
slot2 = Vector3()
slot3 = Vector3()
slot4 = Quaternion()

function slot0.nodeToV3(slot0)
	uv0.x = (slot0.x + slot0.y) * TianShiNaNaEnum.GridXOffset
	uv0.y = (slot0.y - slot0.x) * TianShiNaNaEnum.GridYOffset
	uv0.z = (slot0.y - slot0.x) * TianShiNaNaEnum.GridZOffset

	return uv0
end

function slot0.v3ToNode(slot0)
	slot1 = slot0.x / TianShiNaNaEnum.GridXOffset
	slot2 = slot0.y / TianShiNaNaEnum.GridYOffset
	uv0.x = Mathf.Round((slot1 - slot2) / 2)
	uv0.y = Mathf.Round((slot1 + slot2) / 2)

	return uv0
end

function slot0.getV2(slot0, slot1)
	uv0.x = slot0 or 0
	uv0.y = slot1 or 0

	return uv0
end

function slot0.getV3(slot0, slot1, slot2)
	uv0.x = slot0 or 0
	uv0.y = slot1 or 0
	uv0.z = slot2 or 0

	return uv0
end

function slot0.getRoundDis(slot0, slot1, slot2, slot3)
	return math.abs(slot0 - slot2) + math.abs(slot1 - slot3)
end

function slot0.getMinDis(slot0, slot1, slot2, slot3)
	return math.max(math.abs(slot0 - slot2), math.abs(slot1 - slot3))
end

function slot0.isPosSame(slot0, slot1)
	return slot0.x == slot1.x and slot0.y == slot1.y
end

function slot0.havePos(slot0, slot1)
	for slot5, slot6 in pairs(slot0) do
		if uv0.isPosSame(slot1, slot6) then
			return true
		end
	end

	return false
end

function slot0.getClickNodePos(slot0)
	slot2 = recthelper.screenPosToWorldPos(slot0 or GamepadController.instance:getMousePosition(), CameraMgr.instance:getMainCamera(), uv0)
	slot3 = TianShiNaNaModel.instance.nowScenePos
	slot2.x = slot2.x - slot3.x
	slot2.y = slot2.y - slot3.y

	return uv1.v3ToNode(slot2)
end

function slot0.getSortIndex(slot0, slot1)
	return 500 + (slot0 - slot1) * 2
end

function slot0.getDir(slot0, slot1, slot2)
	if slot1.x < slot0.x then
		return TianShiNaNaEnum.OperDir.Left
	elseif slot0.x < slot1.x then
		return TianShiNaNaEnum.OperDir.Right
	elseif slot1.y < slot0.y then
		return TianShiNaNaEnum.OperDir.Back
	elseif slot0.y < slot1.y then
		return TianShiNaNaEnum.OperDir.Forward
	else
		return slot2 or TianShiNaNaEnum.OperDir.Right
	end
end

function slot0.lerpQ(slot0, slot1, slot2)
	slot2 = Mathf.Clamp(slot2, 0, 1)
	slot3 = uv0

	if Quaternion.Dot(slot0, slot1) < 0 then
		slot3.x = slot0.x + slot2 * (-slot1.x - slot0.x)
		slot3.y = slot0.y + slot2 * (-slot1.y - slot0.y)
		slot3.z = slot0.z + slot2 * (-slot1.z - slot0.z)
		slot3.w = slot0.w + slot2 * (-slot1.w - slot0.w)
	else
		slot3.x = slot0.x + (slot1.x - slot0.x) * slot2
		slot3.y = slot0.y + (slot1.y - slot0.y) * slot2
		slot3.z = slot0.z + (slot1.z - slot0.z) * slot2
		slot3.w = slot0.w + (slot1.w - slot0.w) * slot2
	end

	return uv0
end

function slot0.lerpV3(slot0, slot1, slot2)
	slot2 = Mathf.Clamp(slot2, 0, 1)
	uv0.x = slot0.x + (slot1.x - slot0.x) * slot2
	uv0.y = slot0.y + (slot1.y - slot0.y) * slot2
	uv0.z = slot0.z + (slot1.z - slot0.z) * slot2

	return uv0
end

function slot0.getCanOperDirs(slot0, slot1)
	slot2 = {
		[TianShiNaNaEnum.OperDir.Left] = TianShiNaNaModel.instance:isNodeCanPlace(slot0.x - 1, slot0.y, slot1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Right] = TianShiNaNaModel.instance:isNodeCanPlace(slot0.x + 1, slot0.y, slot1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Forward] = TianShiNaNaModel.instance:isNodeCanPlace(slot0.x, slot0.y + 1, slot1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Back] = TianShiNaNaModel.instance:isNodeCanPlace(slot0.x, slot0.y - 1, slot1 == TianShiNaNaEnum.CubeType.Type1)
	}

	if slot1 == TianShiNaNaEnum.CubeType.Type2 then
		slot2[TianShiNaNaEnum.OperDir.Left] = slot2[TianShiNaNaEnum.OperDir.Left] and TianShiNaNaModel.instance:isNodeCanPlace(slot0.x - 2, slot0.y)
		slot2[TianShiNaNaEnum.OperDir.Right] = slot2[TianShiNaNaEnum.OperDir.Right] and TianShiNaNaModel.instance:isNodeCanPlace(slot0.x + 2, slot0.y)
		slot2[TianShiNaNaEnum.OperDir.Forward] = slot2[TianShiNaNaEnum.OperDir.Forward] and TianShiNaNaModel.instance:isNodeCanPlace(slot0.x, slot0.y + 2)
		slot2[TianShiNaNaEnum.OperDir.Back] = slot2[TianShiNaNaEnum.OperDir.Back] and TianShiNaNaModel.instance:isNodeCanPlace(slot0.x, slot0.y - 2)
	end

	slot2[TianShiNaNaEnum.OperDir.Left] = slot2[TianShiNaNaEnum.OperDir.Left] or nil
	slot2[TianShiNaNaEnum.OperDir.Right] = slot2[TianShiNaNaEnum.OperDir.Right] or nil
	slot2[TianShiNaNaEnum.OperDir.Forward] = slot2[TianShiNaNaEnum.OperDir.Forward] or nil
	slot2[TianShiNaNaEnum.OperDir.Back] = slot2[TianShiNaNaEnum.OperDir.Back] or nil

	return slot2
end

function slot0.getOperDir(slot0, slot1)
	if slot0 >= 0 and slot1 <= 0 then
		return TianShiNaNaEnum.OperDir.Right
	elseif slot0 <= 0 and slot1 >= 0 then
		return TianShiNaNaEnum.OperDir.Left
	elseif slot0 >= 0 and slot1 >= 0 then
		return TianShiNaNaEnum.OperDir.Forward
	elseif slot0 <= 0 and slot1 <= 0 then
		return TianShiNaNaEnum.OperDir.Back
	end
end

function slot0.isRevertDir(slot0, slot1, slot2)
	if slot0 == TianShiNaNaEnum.OperDir.Left and slot1 > 0 then
		return true
	elseif slot0 == TianShiNaNaEnum.OperDir.Right and slot1 < 0 then
		return true
	elseif slot0 == TianShiNaNaEnum.OperDir.Forward and slot2 < 0 then
		return true
	elseif slot0 == TianShiNaNaEnum.OperDir.Back and slot2 > 0 then
		return true
	end
end

function slot0.getOperOffset(slot0)
	uv0:Set(0, 0)

	if slot0 == TianShiNaNaEnum.OperDir.Left then
		uv0.x = -1
	elseif slot0 == TianShiNaNaEnum.OperDir.Right then
		uv0.x = 1
	elseif slot0 == TianShiNaNaEnum.OperDir.Forward then
		uv0.y = 1
	elseif slot0 == TianShiNaNaEnum.OperDir.Back then
		uv0.y = -1
	end

	return uv0
end

function slot0.getLimitTimeStr()
	if not ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.TianShiNaNa) then
		return ""
	end

	if slot0:getRealEndTimeStamp() - ServerTime.now() > 0 then
		return TimeUtil.SecondToActivityTimeFormat(slot1)
	end

	return ""
end

function slot0.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.TianShiNaNaBanOper)
end

return slot0
