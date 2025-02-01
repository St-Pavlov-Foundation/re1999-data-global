module("modules.logic.room.controller.RoomInteractionController", package.seeall)

slot0 = class("RoomInteractionController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	RoomMapInteractionModel.instance:clear()
end

function slot0.init(slot0)
	RoomMapInteractionModel.instance:initInteraction()
end

function slot0.tickRunInteraction(slot0)
	for slot5 = 1, #RoomMapInteractionModel.instance:getBuildingInteractionMOList() do
		if slot1[slot5].hasInteraction and slot0:showTimeByInteractionMO(slot6) then
			break
		end
	end
end

function slot0.gainAllCharacterFaith(slot0)
	for slot5 = 1, #RoomMapInteractionModel.instance:getBuildingInteractionMOList() do
		if slot1[slot5].hasInteraction and slot0:showTimeByInteractionMO(slot6) then
			slot6.hasInteraction = false

			break
		end
	end
end

function slot0.showTimeByInteractionMO(slot0, slot1, slot2)
	slot3, slot4 = slot1:getInteractionBuilingUidAndCarmeraId()

	if slot3 and slot4 then
		slot1.hasInteraction = false

		GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.CharacterBuildingShowTime, {
			buildingUid = slot3,
			buildingId = slot1.config.buildingId,
			heroId = slot1.config.heroId,
			id = slot1.config.id,
			cameraId = slot4,
			faithOp = slot2
		})

		return true
	end

	return false
end

function slot0.refreshCharacterBuilding(slot0)
	for slot5 = 1, #RoomMapInteractionModel.instance:getBuildingInteractionMOList() do
		if not slot1[slot5].hasInteraction then
			slot6.hasInteraction = slot6:isCanByRandom()
		end
	end
end

function slot0.tryPlaceCharacterInteraction(slot0)
	for slot5 = 1, #RoomMapInteractionModel.instance:getBuildingInteractionMOList() do
		if slot1[slot5].hasInteraction then
			slot9 = false

			for slot13, slot14 in ipairs(slot6:getBuildingUids()) do
				if slot0:_tryPlaceCharacterById(slot14, slot6.config.heroId, slot6:getBuildingNodeList()) then
					slot9 = true

					break
				end
			end

			slot6.hasInteraction = slot9
		end
	end
end

function slot0._tryPlaceCharacterById(slot0, slot1, slot2, slot3)
	if not RoomCharacterModel.instance:getCharacterMOById(slot2) then
		logNormal(string.format("找不到角色:%s", slot2))

		return nil
	end

	if not GameSceneMgr.instance:getCurScene() or not slot5.buildingmgr then
		return nil
	end

	if not slot5.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
		logNormal(string.format("找不到建筑:%s", slot1))

		return
	end

	for slot10, slot11 in ipairs(slot3) do
		slot12 = slot6:transformPoint(slot11[1], 0, slot11[3])

		if RoomCharacterHelper.getRecommendHexPoint(slot4.heroId, slot4.skinId, Vector2.New(slot12.x, slot12.z)) and slot14.position then
			slot12.y = slot14.position.y

			if Vector3.Distance(slot12, slot14.position) <= RoomCharacterEnum.BuilingInteractionNodeRadius then
				RoomCharacterController.instance:moveCharacterTo(slot4, slot14.position, false)

				if slot4:isTraining() then
					slot5.crittermgr:delaySetFollow(slot4.trainCritterUid, 0.1)
				end

				logNormal(string.format("[%s] 放置:(%s,%s,%s)", slot4.heroConfig.name, slot14.position.x, slot14.position.y, slot14.position.z))

				return true
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
