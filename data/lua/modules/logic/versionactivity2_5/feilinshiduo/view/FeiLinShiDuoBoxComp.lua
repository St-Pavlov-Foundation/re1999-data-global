module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoBoxComp", package.seeall)

slot0 = class("FeiLinShiDuoBoxComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.boxTrans = slot0.go.transform
	slot0.moveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	slot0.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed

	slot0:resetData()
end

function slot0.resetData(slot0)
	slot0.isGround = true
	slot0.fallYSpeed = 0
	slot0.deltaMoveX = 0
	slot0.curInPlaneItem = nil
	slot0.planeStartPosX = 0
	slot0.planeEndPosX = 0
	slot0.isTopBox = false
	slot0.topBoxOffset = -10000
	slot0.topBoxDeltaMove = slot0.deltaMoveX
	slot0.bottomBoxMap = {}
end

function slot0.initData(slot0, slot1, slot2)
	slot0.itemInfo = slot1
	slot0.sceneViewCls = slot2
	slot0.boxElementMap = FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Box]
end

function slot0.addEventListeners(slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, slot0.cleanTopBoxBottomInfo, slot0)
end

function slot0.removeEventListeners(slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, slot0.resetData, slot0)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, slot0.cleanTopBoxBottomInfo, slot0)
end

function slot0.cleanTopBoxBottomInfo(slot0)
	if slot0.isTopBox then
		slot0.bottomBoxMap = {}
	end
end

function slot0.onTick(slot0)
	slot0:handleEvent()
end

function slot0.handleEvent(slot0)
	if not slot0.sceneViewCls then
		return
	end

	if FeiLinShiDuoGameModel.instance:getElementShowState(slot0.itemInfo) and not slot0:checkBoxInPlane() then
		slot0:checkBoxFall()
	end
end

function slot0.checkBoxFall(slot0, slot1)
	if slot0.deltaMoveX and slot0.itemInfo or slot0.isTopBox then
		if #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.boxTrans.localPosition.x, slot0.boxTrans.localPosition.y, slot0.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, nil, {
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		}) == 0 then
			slot0.isGround = false
			slot0.fallYSpeed = slot0.fallYSpeed + slot0.fallAddSpeed

			if not slot0.isTopBox then
				slot4 = slot0.boxTrans.localPosition.x

				if slot0.curInPlaneItem and FeiLinShiDuoGameModel.instance:getElementShowStateMap()[slot0.curInPlaneItem.id] and slot0.deltaMoveX ~= 0 then
					slot4 = slot0.deltaMoveX > 0 and slot0.planeEndPosX or slot0.planeStartPosX - slot0.itemInfo.width
				end

				transformhelper.setLocalPosXY(slot0.boxTrans, slot4, slot0.boxTrans.localPosition.y - slot0.fallYSpeed * Time.deltaTime)
			else
				slot5 = slot0.boxTrans.localPosition.x

				if #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.boxTrans.localPosition.x, slot1 and slot0.boxTrans.localPosition.y or slot0.boxTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth, slot0.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, slot0.boxElementMap) == 0 then
					slot5 = (FeiLinShiDuoGameModel.instance:getElementShowState(slot0.bottomBoxItemInfo) or slot0.boxTrans.localPosition.x) and (not slot0.bottomBoxItemInfo or Mathf.Abs(slot0.boxTrans.localPosition.x + slot0.itemInfo.width / 2 - (slot0.bottomBoxItemInfo.pos[1] + slot0.bottomBoxItemInfo.width / 2)) <= slot0.itemInfo.width / 2 + slot0.bottomBoxItemInfo.width / 2 or slot0.boxTrans.localPosition.x) and (slot0.topBoxDeltaMove > 0 and slot0.bottomBoxItemInfo.pos[1] + slot0.bottomBoxItemInfo.width or slot0.bottomBoxItemInfo.pos[1] - slot0.itemInfo.width)
				end

				transformhelper.setLocalPosXY(slot0.boxTrans, slot5, slot0.boxTrans.localPosition.y - slot0.fallYSpeed * Time.deltaTime)
			end
		else
			if not slot0.isGround then
				slot0.boxTrans.localPosition = slot0:fixStandPos(slot2)

				AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_activity_organ_open)
				FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.CleanTopBoxBottomInfo)
			end

			slot0.isGround = true
			slot0.fallYSpeed = 0
			slot0.deltaMoveX = 0
			slot0.isTopBox = false

			for slot6, slot7 in ipairs(slot2) do
				if slot7.type == FeiLinShiDuoEnum.ObjectType.Box then
					slot0.isTopBox = true
					slot0.topBoxOffset = slot7.pos[1] - slot0.boxTrans.localPosition.x
					slot0.bottomBoxItemInfo = slot7
					slot0.bottomBoxMap[slot0.bottomBoxItemInfo.id] = slot0.topBoxOffset

					break
				end
			end

			if not slot0.isTopBox then
				slot0.bottomBoxMap = {}
			end
		end

		FeiLinShiDuoGameModel.instance:updateBoxPos(slot0.itemInfo.id, {
			slot0.boxTrans.localPosition.x,
			slot0.boxTrans.localPosition.y
		})
	end
end

function slot0.setMove(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot3 and slot3.isBox
	slot6 = slot3 and slot3.isTopBox

	if not slot0.isGround or slot0:checkBoxInPlane() then
		return
	end

	if slot0.deltaMoveX == 0 then
		slot0.deltaMoveX = slot2
	end

	if slot0.deltaMoveX ~= slot2 then
		return
	end

	slot0.isTopBox = slot6
	slot0.curInPlaneItem, slot8, slot9 = slot0:getBoxInColorPlane(slot0.boxTrans.localPosition.x + (slot0.deltaMoveX >= 0 and -FeiLinShiDuoEnum.HalfSlotWidth or slot0.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth), slot0.boxTrans.localPosition.y - 2, slot0.curInPlaneItem)
	slot0.planeStartPosX = slot8 or slot0.planeStartPosX
	slot0.planeEndPosX = slot9 or slot0.planeEndPosX

	if slot5 then
		slot10, slot11 = FeiLinShiDuoGameModel.instance:checkForwardCanMove(slot0.boxTrans.localPosition.x, slot0.boxTrans.localPosition.y, slot2, slot0.itemInfo, slot5)
		slot0.topBoxDeltaMove = slot0.deltaMoveX

		if slot10 then
			if slot0.isTopBox then
				slot0.bottomBoxTrans = slot1
				slot0.bottomBoxItemInfo = slot3.itemInfo

				if not slot0.bottomBoxMap[slot0.bottomBoxItemInfo.id] or slot0.topBoxOffset == -10000 then
					slot0.topBoxOffset = slot0.bottomBoxItemInfo.pos[1] - slot0.boxTrans.localPosition.x
					slot0.bottomBoxMap[slot0.bottomBoxItemInfo.id] = slot0.topBoxOffset
					slot12 = slot0.topBoxOffset
				end

				slot0.topBoxOffset = slot12

				transformhelper.setLocalPosXY(slot0.boxTrans, slot0.bottomBoxItemInfo.pos[1] - slot0.topBoxOffset, slot0.boxTrans.localPosition.y)
			else
				transformhelper.setLocalPosXY(slot0.boxTrans, slot1.localPosition.x + (slot0.deltaMoveX >= 0 and slot3.itemInfo.width or -slot0.itemInfo.width), slot0.boxTrans.localPosition.y)
			end
		else
			slot0.topBoxDeltaMove = slot0.isTopBox and -slot0.deltaMoveX or slot0.deltaMoveX

			transformhelper.setLocalPosXY(slot0.boxTrans, slot0.deltaMoveX > 0 and slot11 - slot0.itemInfo.width or slot11, slot0.boxTrans.localPosition.y)
		end
	elseif FeiLinShiDuoGameModel.instance:checkForwardCanMove(slot1.localPosition.x + slot0.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth + 1), slot1.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, slot0.deltaMoveX) and not slot4 then
		transformhelper.setLocalPosXY(slot0.boxTrans, slot1.localPosition.x + slot0.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 2 + (slot0.deltaMoveX >= 0 and 0 or -slot0.itemInfo.width), slot0.boxTrans.localPosition.y)
	end

	FeiLinShiDuoGameModel.instance:updateBoxPos(slot0.itemInfo.id, {
		slot0.boxTrans.localPosition.x,
		slot0.boxTrans.localPosition.y
	})
	slot0:boxTouchElement()
end

function slot0.getBoxInColorPlane(slot0, slot1, slot2, slot3)
	if slot3 then
		slot4, slot5 = slot0:getPlaneWidthRange(slot3.id)

		if slot4 <= slot1 and slot1 <= slot5 then
			return slot3, slot4, slot5
		end
	end

	slot6 = FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}
	slot7 = slot4[FeiLinShiDuoEnum.ObjectType.Box] or {}
	slot9 = slot4[FeiLinShiDuoEnum.ObjectType.Trap] or {}
	slot10 = slot4[FeiLinShiDuoEnum.ObjectType.Stairs] or {}

	for slot14, slot15 in pairs(slot4[FeiLinShiDuoEnum.ObjectType.Wall] or {}) do
		table.insert({}, slot15)
	end

	for slot14, slot15 in pairs(slot6) do
		table.insert(slot5, slot15)
	end

	for slot14, slot15 in pairs(slot7) do
		table.insert(slot5, slot15)
	end

	for slot14, slot15 in pairs(slot9) do
		table.insert(slot5, slot15)
	end

	for slot14, slot15 in pairs(slot10) do
		table.insert(slot5, slot15)
	end

	for slot14, slot15 in pairs(slot5) do
		slot16, slot17 = slot0:getPlaneWidthRange(slot15.id)

		if slot16 <= slot1 and slot1 <= slot17 and slot15.pos[2] < slot2 and slot2 <= slot15.pos[2] + slot15.height then
			return slot15, slot16, slot17
		end
	end
end

function slot0.getPlaneWidthRange(slot0, slot1)
	slot3 = FeiLinShiDuoGameModel.instance:getInterElementMap()[slot1] or {}

	return slot3.pos[1], slot3.pos[1] + slot3.width
end

function slot0.fixStandPos(slot0, slot1)
	slot2, slot3 = FeiLinShiDuoGameModel.instance:getFixStandePos(slot1, slot0.boxTrans.localPosition.x, slot0.boxTrans.localPosition.y)

	if slot2 and slot3 then
		return Vector3(slot0.boxTrans.localPosition.x, slot3.y, 0)
	end

	return slot0.boxTrans.localPosition
end

function slot0.boxTouchElement(slot0)
	if slot0.isGround and slot0.deltaMoveX ~= 0 then
		if #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.boxTrans.localPosition.x + slot0.deltaMoveX, slot0.boxTrans.localPosition.y, slot0.itemInfo, slot0.deltaMoveX > 0 and FeiLinShiDuoEnum.checkDir.Right or FeiLinShiDuoEnum.checkDir.Left) > 0 then
			for slot6, slot7 in pairs(slot2) do
				if slot7.type == FeiLinShiDuoEnum.ObjectType.Box then
					slot0.sceneViewCls:getBoxComp(slot7.id):setMove(slot0.boxTrans, slot0.deltaMoveX, {
						touchElementData = slot7,
						isBox = true,
						isTopBox = false,
						itemInfo = slot0.itemInfo
					})
				end
			end
		end

		if #FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(slot0.boxTrans.localPosition.x, slot0.boxTrans.localPosition.y, slot0.itemInfo, FeiLinShiDuoEnum.checkDir.Top) > 0 then
			for slot7, slot8 in pairs(slot3) do
				if slot8.type == FeiLinShiDuoEnum.ObjectType.Box then
					slot0.sceneViewCls:getBoxComp(slot8.id):setMove(slot0.boxTrans, slot0.deltaMoveX, {
						touchElementData = slot8,
						isBox = true,
						isTopBox = true,
						itemInfo = slot0.itemInfo
					})
				end
			end
		end
	end
end

function slot0.checkBoxInPlane(slot0)
	slot2 = {}

	for slot7, slot8 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}) do
		table.insert(slot2, slot8)
	end

	for slot7, slot8 in pairs(slot2) do
		if FeiLinShiDuoGameModel.instance:getElementShowState(slot8) and FeiLinShiDuoGameModel.instance:getElementShowState(slot0.itemInfo) and Mathf.Abs(slot0.itemInfo.pos[1] + slot0.itemInfo.width / 2 - (slot8.pos[1] + slot8.width / 2)) < slot0.itemInfo.width / 2 + slot8.width / 2 - 2 * FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(slot0.itemInfo.pos[2] - slot8.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
			return true
		end
	end

	return false
end

function slot0.getShowState(slot0)
	return FeiLinShiDuoGameModel.instance:getElementShowState(slot0.itemInfo)
end

return slot0
