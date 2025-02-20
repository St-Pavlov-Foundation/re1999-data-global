module("modules.logic.scene.room.work.RoomSceneCharacterInteractionWork", package.seeall)

slot0 = class("RoomSceneCharacterInteractionWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._scene = slot1
	slot0._isChangeMode = slot2
end

function slot0.onStart(slot0)
	slot0:_randomPlaceCharacter()

	if RoomController.instance:isObMode() and not slot0._isChangeMode then
		slot0:_getCharacterInteractionInfo()
	else
		slot0:onDone(true)
		slot0:startBuilingInteraction()
	end
end

function slot0.startBuilingInteraction(slot0)
	if RoomController.instance:isObMode() then
		RoomInteractionController.instance:refreshCharacterBuilding()
		RoomInteractionController.instance:tryPlaceCharacterInteraction()
	end
end

function slot0._getCharacterInteractionInfo(slot0)
	RoomRpc.instance:sendGetCharacterInteractionInfoRequest(slot0._onGetInfo, slot0)
end

function slot0._onGetInfo(slot0)
	slot0:_trySetInteracts(slot0:_getConfigList(), RoomModel.instance:getInteractionCount())
	slot0:onDone(true)
	slot0:startBuilingInteraction()
end

function slot0._randomPlaceCharacter(slot0)
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		RoomCharacterController.instance:checkCharacterMax()

		if slot0._isChangeMode then
			RoomCharacterController.instance:tryCorrectAllCharacter(false)
		else
			RoomCharacterController.instance:tryCorrectAllCharacter(true)
		end
	end
end

function slot0.cfgSortFunc(slot0, slot1)
	if slot0.behaviour == slot1.behaviour and slot0.heroId == slot1.heroId and slot0.behaviour == RoomCharacterEnum.InteractionType.Dialog and slot0.faithDialog ~= slot1.faithDialog then
		if slot0.faithDialog == 0 then
			return false
		elseif slot1.faithDialog == 0 then
			return true
		else
			return slot0.faithDialog < slot1.faithDialog
		end
	end

	if slot0.id ~= slot1.id then
		return slot0.id < slot1.id
	end
end

function slot0._getConfigList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(RoomCharacterModel.instance:getList()) do
		tabletool.addValues(slot1, RoomConfig.instance:getCharacterInteractionConfigListByHeroId(slot7.heroId))
	end

	table.sort(slot1, uv0.cfgSortFunc)

	return slot1
end

function slot0._trySetInteracts(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1) do
		if slot8.behaviour ~= RoomCharacterEnum.InteractionType.Animal and RoomCharacterHelper.checkInteractionValid(slot8) and (slot2 < CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterInteractionLimitCount) or slot8.excludeDaily or RoomModel.instance:getInteractionState(slot8.id) == RoomCharacterEnum.InteractionState.Start) and slot0:_trySetInteract(slot8) and not slot8.excludeDaily and RoomModel.instance:getInteractionState(slot8.id) ~= RoomCharacterEnum.InteractionState.Start then
			slot2 = slot2 + 1
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function slot0._trySetInteract(slot0, slot1)
	if RoomModel.instance:getInteractionState(slot1.id) == RoomCharacterEnum.InteractionState.Complete then
		return false
	end

	if not RoomCharacterHelper.interactionIsDialogWithSelect(slot1.id) and RoomModel.instance:getInteractionState(slot1.id) == RoomCharacterEnum.InteractionState.Start then
		return false
	end

	if not RoomConditionHelper.isConditionStr(slot1.conditionStr) then
		return false
	end

	if slot1.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		return slot0:_trySetDialogInteract(slot1)
	elseif slot1.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- Nothing
	end
end

function slot0._trySetDialogInteract(slot0, slot1)
	if RoomCharacterModel.instance:getCharacterMOById(slot1.heroId):getCurrentInteractionId() or slot2:isTrainSourceState() then
		return false
	end

	if slot1.relateHeroId ~= 0 then
		if RoomCharacterModel.instance:getCharacterMOById(slot1.relateHeroId):getCurrentInteractionId() then
			return false
		end

		slot4 = {}

		for slot9, slot10 in ipairs(RoomCharacterModel.instance:getList()) do
			if slot10.heroId ~= slot1.heroId and slot10.heroId ~= slot1.relateHeroId then
				slot11 = slot10:getMoveTargetPoint().hexPoint
				slot4[slot11.x] = slot4[slot11.x] or {}
				slot4[slot11.x][slot11.y] = true
			end
		end

		slot6 = false
		slot12 = RoomMapBlockModel.instance:getFullBlockMOList()

		for slot11, slot12 in ipairs(GameUtil.randomTable(tabletool.copy(slot12))) do
			if (not slot4[slot12.hexPoint.x] or not slot4[slot13.x][slot13.y]) and slot0:_trySetTwoCharacterInOneBlock(slot2, slot3, slot13) then
				break
			end
		end

		if not slot6 then
			return false
		end

		slot3:setCurrentInteractionId(slot1.id)
	end

	slot2:setCurrentInteractionId(slot1.id)

	return true
end

function slot0._trySetTwoCharacterInOneBlock(slot0, slot1, slot2, slot3)
	if not RoomMapBlockModel.instance:getBlockMO(slot3.x, slot3.y) then
		return false
	end

	slot7 = slot2.heroId
	slot8 = slot2.skinId

	for slot12 = 0, 6 do
		if RoomCharacterHelper.canConfirmPlace(slot1.heroId, RoomCharacterHelper.getCharacterPosition3D(ResourcePoint(slot3, slot12), false), slot1.skinId, false) then
			for slot19 = 0, 6 do
				if slot19 ~= slot12 and RoomCharacterHelper.canConfirmPlace(slot7, RoomCharacterHelper.getCharacterPosition3D(ResourcePoint(slot3, slot19), false), slot8, false) then
					RoomCharacterController.instance:moveCharacterTo(slot1, slot14, false)
					RoomCharacterController.instance:moveCharacterTo(slot2, slot21, false)

					return true
				end
			end
		end
	end

	return false
end

function slot0.clearWork(slot0)
	slot0._scene = nil
end

return slot0
