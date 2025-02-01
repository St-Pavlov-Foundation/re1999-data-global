module("modules.logic.room.entity.RoomBuildingOccupyEntity", package.seeall)

slot0 = class("RoomBuildingOccupyEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.Untagged
end

function slot0.init(slot0, slot1)
	slot0.goTrs = slot1.transform
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.StaticContainerGOKey)

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.onEffectRebuild(slot0)
end

function slot0._isShowNeighbor(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getTempBuildingParam(slot1, slot2) then
		return false
	end

	return true
end

function slot0._getContainerGO(slot0, slot1)
	if slot1 then
		return slot0.containerGO
	end

	return slot0.staticContainerGO
end

function slot0._refreshNeighbor(slot0, slot1, slot2, slot3)
	for slot8 = 1, 6 do
		slot9 = HexPoint.directions[slot8]
		slot11 = (slot1 and RoomEnum.EffectKey.BuildingOccupyCanSideKeys or RoomEnum.EffectKey.BuildingOccupyNotSideKeys)[slot8]

		if slot0:_isShowNeighbor(slot9.x + slot3.x, slot9.y + slot3.y) and not slot0.effect:isHasEffectGOByKey(slot11) then
			slot0.effect:addParams({
				[slot11] = {
					res = slot1 and RoomScenePreloader.ResEffectF or RoomScenePreloader.ResEffectE,
					containerGO = slot0:_getContainerGO(slot1),
					localRotation = Vector3(0, (slot8 - 1 + 3) * 60, 0)
				}
			})
		end

		slot0.effect:setActiveByKey(slot11, slot10)
	end
end

function slot0._refreshOccupy(slot0, slot1)
	if not slot0.effect:isHasKey(slot1 and RoomEnum.EffectKey.BuildingOccupyCanJudgeKey or RoomEnum.EffectKey.BuildingOccupyNotJudgeKey) then
		slot0.effect:addParams({
			[slot2] = {
				res = slot1 and RoomScenePreloader.ResEffectD01 or RoomScenePreloader.ResEffectD02,
				containerGO = slot0:_getContainerGO(slot1)
			}
		})
	end
end

function slot0._isJudge(slot0, slot1, slot2, slot3)
	if slot3 == false then
		return false
	end

	if RoomMapBlockModel.instance:getBlockMO(slot1, slot2) then
		return RoomBuildingHelper.isJudge(slot4.hexPoint, slot4.id)
	end

	return false
end

function slot0.refreshTempOccupy(slot0)
	slot2 = false

	if slot0:getBuildingParam() then
		slot2 = RoomMapBuildingModel.instance:isTempOccupy(slot1.hexPoint)
	end

	if slot2 then
		if slot0._lastIsJudge ~= slot0:_isJudge(slot1.hexPoint.x, slot1.hexPoint.y, slot1.checkBuildingAreaSuccess) then
			slot0._lastIsJudge = slot3

			gohelper.setActive(slot0.containerGO, slot3)
			gohelper.setActive(slot0.staticContainerGO, not slot3)
		end

		slot0:_refreshNeighbor(slot3, slot1.blockRotate, slot1.hexPoint)
		slot0:_refreshOccupy(slot3)

		slot4 = HexMath.hexToPosition(slot1.hexPoint, RoomBlockEnum.BlockSize)

		transformhelper.setLocalPos(slot0.goTrs, slot4.x, 0, slot4.y)
	elseif slot0._lastIsJudge ~= nil then
		slot0._lastIsJudge = nil

		gohelper.setActive(slot0.containerGO, false)
		gohelper.setActive(slot0.staticContainerGO, false)
	end

	slot0.effect:refreshEffect()
end

function slot0.getBuildingParam(slot0)
	return RoomMapBuildingModel.instance:getTempBuildingParamByPointIndex(slot0.id)
end

function slot0.getMO(slot0)
	return RoomMapBuildingModel.instance:getTempBuildingMO()
end

return slot0
