module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoGameModel", package.seeall)

slot0 = class("FeiLinShiDuoGameModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()

	slot0.curGameConfig = {}
	slot0.isBlindnessMode = false
end

function slot0.reInit(slot0)
	slot0.elementMap = {}
	slot0.elementList = {}
	slot0.interElementList = {}
	slot0.interElementMap = {}
	slot0.elementShowStateMap = {}
	slot0.touchElementState = {}
	slot0.playerCurMoveSpeed = 0
	slot0.doorOpenStateMap = {}
	slot0.curColor = FeiLinShiDuoEnum.ColorType.None
	slot0.isInColorChanging = false
	slot0.isPlayerInIdleState = true
end

function slot0.initConfigData(slot0, slot1)
	slot0:reInit()

	slot5 = slot1
	slot0.mapConfigData = addGlobalModule("modules.configs.feilinshiduo.lua_feilinshiduo_map_" .. tostring(slot5))
	slot0.mapConfig = slot0.mapConfigData.mapConfig

	for slot5, slot6 in ipairs(slot0.mapConfig) do
		if not slot0.elementMap[slot6.type] then
			slot0.elementMap[slot6.type] = {}
		end

		if not slot7[slot6.id] then
			slot7[slot6.id] = {
				id = slot6.id,
				type = slot6.type,
				pos = string.splitToNumber(slot6.pos, "#"),
				color = slot6.color,
				refId = slot6.refId,
				scale = string.splitToNumber(slot6.scale, "#"),
				params = slot6.params,
				subGOPosList = GameUtil.splitString2(slot6.subGOPosList, true),
				groupName = FeiLinShiDuoEnum.ParentName[slot6.type],
				width = tonumber(slot6.width),
				height = tonumber(slot6.height)
			}
		end

		table.insert(slot0.interElementList, slot7[slot6.id])
		table.insert(slot0.elementList, slot7[slot6.id])

		slot0.elementShowStateMap[slot6.id] = true
		slot0.interElementMap[slot6.id] = slot7[slot6.id]
	end
end

function slot0.setCurMapId(slot0, slot1)
	slot0.curMapId = slot1
end

function slot0.getCurMapId(slot0)
	return slot0.curMapId
end

function slot0.setGameConfig(slot0, slot1)
	slot0.curGameConfig = slot1
end

function slot0.getCurGameConfig(slot0)
	return slot0.curGameConfig
end

function slot0.getElementList(slot0)
	return slot0.elementList
end

function slot0.getInterElementList(slot0)
	return slot0.interElementList
end

function slot0.getInterElementMap(slot0)
	return slot0.interElementMap
end

function slot0.getElementMap(slot0)
	return slot0.elementMap
end

function slot0.getMapConfigData(slot0)
	return slot0.mapConfigData
end

function slot0.setCurPlayerMoveSpeed(slot0, slot1)
	slot0.playerCurMoveSpeed = slot1
end

function slot0.getCurPlayerMoveSpeed(slot0)
	return slot0.playerCurMoveSpeed
end

function slot0.setBlindnessModeState(slot0, slot1)
	slot0.isBlindnessMode = slot1
end

function slot0.getBlindnessModeState(slot0)
	return slot0.isBlindnessMode
end

slot1 = Vector3()
slot2 = Vector3()

function slot0.checkTouchElement(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}

	for slot11, slot12 in pairs(slot4 or slot0.interElementList) do
		uv0.x = slot12.pos[1]
		uv0.y = slot12.pos[2]
		uv1.x = uv0.x + slot12.width
		uv1.y = uv0.y + slot12.height
		slot13 = true

		if slot3 and #slot3 > 0 then
			for slot17, slot18 in ipairs(slot3) do
				if slot12.type == slot18 then
					slot13 = false

					break
				end
			end
		end

		if slot12.type == FeiLinShiDuoEnum.ObjectType.Stairs and slot5 and uv0.x <= slot1 and slot1 <= uv1.x and uv0.y < slot2 and slot2 < uv1.y - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
			slot13 = false
		end

		if slot0.elementShowStateMap[slot12.id] and uv0.x <= slot1 and slot1 <= uv1.x and uv0.y <= slot2 and slot2 <= uv1.y and slot13 then
			table.insert(slot6, slot12)
		end
	end

	return slot6
end

function slot0.checkItemTouchElemenet(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot0.elementShowStateMap[slot3.id] then
		return {}
	end

	slot8 = FeiLinShiDuoEnum.touchCheckRange

	for slot13, slot14 in pairs(slot5 or slot0.interElementList) do
		if slot0.elementShowStateMap[slot14.id] then
			slot15 = false

			if slot4 == FeiLinShiDuoEnum.checkDir.Left then
				if slot2 < slot14.pos[2] + slot14.height - slot8 and slot14.pos[2] + slot8 < slot2 + slot3.height and slot14.pos[1] < slot1 and Mathf.Abs(slot14.pos[1] - slot1) <= slot14.width then
					slot15 = true
				end
			elseif slot4 == FeiLinShiDuoEnum.checkDir.Top then
				if slot1 < slot14.pos[1] + slot14.width - slot8 and slot14.pos[1] + slot8 < slot1 + slot3.width and slot2 < slot14.pos[2] and Mathf.Abs(slot14.pos[2] - slot2) <= slot3.height then
					slot15 = true
				end
			elseif slot4 == FeiLinShiDuoEnum.checkDir.Right then
				if slot2 < slot14.pos[2] + slot14.height - slot8 and slot14.pos[2] + slot8 < slot2 + slot3.height and slot1 < slot14.pos[1] and Mathf.Abs(slot14.pos[1] - slot1) <= slot3.width then
					slot15 = true
				end
			elseif slot4 == FeiLinShiDuoEnum.checkDir.Bottom and slot1 < slot14.pos[1] + slot14.width - slot8 and slot14.pos[1] + slot8 < slot1 + slot3.width and slot14.pos[2] < slot2 and Mathf.Abs(slot14.pos[2] - slot2) <= slot14.height then
				slot15 = true
			end

			if slot14.type == FeiLinShiDuoEnum.ObjectType.Stairs and Mathf.Abs(slot3.pos[1] + slot3.width / 2 - (slot14.pos[1] - slot14.width / 2)) < slot3.width / 2 + slot14.width / 2 and slot14.pos[2] < slot2 and slot2 <= slot14.pos[2] + slot14.height - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
				slot15 = false
			end

			if slot6 and #slot6 > 0 then
				for slot19, slot20 in pairs(slot6) do
					if slot14.type == slot20 then
						slot15 = false

						break
					end
				end
			end

			if slot15 then
				table.insert(slot7, slot14)
			end
		end
	end

	return slot7
end

function slot0.updateBoxPos(slot0, slot1, slot2)
	if not slot0.elementMap or next(slot0.elementMap) == nil then
		return
	end

	slot0.elementMap[FeiLinShiDuoEnum.ObjectType.Box][slot1].pos = slot2
end

slot3 = Vector3()
slot4 = Vector3()

function slot0.getFixStandePos(slot0, slot1, slot2, slot3)
	if slot1 and #slot1 > 0 then
		for slot7, slot8 in ipairs(slot1) do
			if slot8.pos[2] <= slot3 and (slot8.type == FeiLinShiDuoEnum.ObjectType.ColorPlane or slot8.type == FeiLinShiDuoEnum.ObjectType.Wall or slot8.type == FeiLinShiDuoEnum.ObjectType.Box or slot8.type == FeiLinShiDuoEnum.ObjectType.Trap) then
				uv0.x = slot8.pos[1]
				uv0.y = slot8.pos[2]
				uv1.x = uv0.x + slot8.width
				uv1.y = uv0.y + slot8.height

				if uv0.y <= slot3 and slot3 <= uv1.y then
					return uv0, uv1
				end
			end
		end
	end
end

function slot0.setElememntShowStateByColor(slot0, slot1)
	slot0.curColor = slot1

	for slot5, slot6 in ipairs(slot0.elementList) do
		if slot1 == FeiLinShiDuoEnum.ColorType.Yellow and slot6.color == FeiLinShiDuoEnum.ColorType.Red then
			slot0.elementShowStateMap[slot6.id] = false
		else
			slot0.elementShowStateMap[slot6.id] = slot6.color ~= slot1 or slot1 == FeiLinShiDuoEnum.ColorType.None
		end
	end
end

function slot0.showAllElementState(slot0)
	for slot4, slot5 in ipairs(slot0.elementList) do
		slot0.elementShowStateMap[slot5.id] = true
	end
end

function slot0.getCurColor(slot0)
	return slot0.curColor
end

function slot0.getElementShowStateMap(slot0)
	return slot0.elementShowStateMap
end

function slot0.getElementShowState(slot0, slot1)
	return slot0.elementShowStateMap[slot1.id]
end

function slot0.setDoorOpenState(slot0, slot1, slot2)
	slot0.doorOpenStateMap[slot1] = slot2
end

function slot0.getDoorOpenStateMap(slot0)
	return slot0.doorOpenStateMap
end

function slot0.setIsPlayerInColorChanging(slot0, slot1)
	slot0.isInColorChanging = slot1
end

function slot0.getIsPlayerInColorChanging(slot0)
	return slot0.isInColorChanging
end

function slot0.setPlayerIsIdleState(slot0, slot1)
	slot0.isPlayerInIdleState = slot1
end

function slot0.getPlayerIsIdleState(slot0)
	return slot0.isPlayerInIdleState
end

function slot0.checkForwardCanMove(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}

	if (not slot5 or slot0:checkItemTouchElemenet(slot1, slot2, slot4, slot3 > 0 and FeiLinShiDuoEnum.checkDir.Right or FeiLinShiDuoEnum.checkDir.Left)) and slot0:checkTouchElement(slot1, slot2) and #slot6 > 0 then
		for slot10, slot11 in ipairs(slot6) do
			if slot11.type == FeiLinShiDuoEnum.ObjectType.Wall or slot11.type == FeiLinShiDuoEnum.ObjectType.ColorPlane then
				return false, slot3 > 0 and slot11.pos[1] or slot11.pos[1] + slot11.width
			elseif slot11.type == FeiLinShiDuoEnum.ObjectType.Door and not slot0.doorOpenStateMap[slot11.id] then
				if slot4 and slot4.type == FeiLinShiDuoEnum.ObjectType.Box and Mathf.Abs(slot11.pos[1] + slot11.width / 2 - (slot1 + (slot3 > 0 and slot4.width or 0))) <= FeiLinShiDuoEnum.touchElementRange then
					return false, slot11.pos[1] + slot11.width / 2 - slot3 * FeiLinShiDuoEnum.doorTouchCheckRang / 2
				elseif not slot4 and Mathf.Abs(slot11.pos[1] + slot11.width / 2 - slot1) <= FeiLinShiDuoEnum.touchElementRange then
					return false, slot11.pos[1] + slot11.width / 2 - slot3 * FeiLinShiDuoEnum.doorTouchCheckRang / 2
				end
			elseif slot11.type == FeiLinShiDuoEnum.ObjectType.Box then
				slot12, slot13 = slot0:checkForwardCanMove(slot11.pos[1] + slot3, slot11.pos[2], slot3, slot11, true)

				return slot12, slot13 and (slot3 > 0 and slot11.pos[1] or slot11.pos[1] + slot11.width)
			end
		end
	end

	return true
end

slot0.instance = slot0.New()

return slot0
