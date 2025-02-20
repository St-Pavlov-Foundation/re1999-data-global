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

function slot0.openInteractBuildingView(slot0, slot1)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot2:checkSameType(RoomBuildingEnum.BuildingType.Interact) then
		RoomCameraController.instance:saveCameraStateByKey(ViewName.RoomInteractBuildingView)

		slot0._followBuildingUid = slot1

		ViewMgr.instance:openView(ViewName.RoomInteractBuildingView, {
			buildingUid = slot1
		})
		RoomCameraController.instance:tweenCameraByBuildingUid(slot1, RoomEnum.CameraState.InteractBuilding, slot2:getInteractMO() and slot3.config and slot3.config.cameraId or 0, slot0._cameraInteractFinishCallback, slot0)

		if RoomCameraController.instance:getRoomScene() and slot5.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding) then
			slot6.cameraFollowTargetComp:setFollowGOPath(RoomEnum.EntityChildKey.ThirdPersonCameraGOKey)

			slot7, slot8, slot9 = slot6.cameraFollowTargetComp:getPositionXYZ()

			slot5.cameraFollow:setFollowTarget(slot6.cameraFollowTargetComp)
			slot5.cameraFollow:setIsPass(true, slot8)
		end
	end
end

function slot0._cameraInteractFinishCallback(slot0)
	if slot0._followBuildingUid == nil then
		return
	end

	slot0._followBuildingUid = nil

	if RoomCameraController.instance:getRoomScene() and slot1.camera:getCameraState() == RoomEnum.CameraState.InteractBuilding and ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView) then
		slot1.cameraFollow:setIsPass(false)
		slot1.fovblock:setLookBuildingUid(RoomEnum.CameraState.InteractBuilding, slot0._followBuildingUid)
	end
end

slot0.instance = slot0.New()

return slot0
