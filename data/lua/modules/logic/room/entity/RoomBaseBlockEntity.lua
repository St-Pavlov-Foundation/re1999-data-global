module("modules.logic.room.entity.RoomBaseBlockEntity", package.seeall)

slot0 = class("RoomBaseBlockEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
	slot0._pathfindingEnabled = false
end

function slot0.init(slot0, slot1)
	slot0.goTrs = slot1.transform
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.containerGOTrs = slot0.containerGO.transform
	slot0.staticContainerGOTrs = slot0.staticContainerGO.transform

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:refreshLand()
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
end

function slot0.removeParamsAndPlayAnimator(slot0, slot1, slot2, slot3)
	if slot3 then
		for slot7 = 1, #slot1 do
			slot0.effect:playEffectAnimator(slot1[slot7], slot2)
		end
	end

	slot0.effect:removeParams(slot1, slot3)
end

function slot0.onStart(slot0)
end

function slot0.refreshName(slot0)
	slot0.go.name = RoomResHelper.getBlockName(slot0:getMO().hexPoint)

	if slot0.resourceui then
		slot0.resourceui:refreshName()
	end
end

function slot0.refreshLand(slot0)
	slot1 = slot0:getMO()
	slot2 = slot1:getDefineId()
	slot3 = slot1:getDefineWaterType()
	slot4 = slot0:checkBlockLandShow(slot1) ~= false
	slot6 = slot3 ~= slot0._lastWaterType
	slot0._refreshLandLastDefineId = slot2
	slot0._lastWaterType = slot3
	slot0._lastShowLand = slot4

	if slot2 ~= slot0._refreshLandLastDefineId or slot4 ~= slot0._lastShowLand then
		slot7, slot8 = nil

		if slot4 then
			slot7 = RoomResHelper.getBlockPath(slot2)
			slot8 = RoomResHelper.getBlockABPath(slot2)
		end

		slot0:_refreshParams(RoomEnum.EffectKey.BlockLandKey, slot7, nil, "0", slot8)
	end

	if slot5 or slot6 then
		slot0:_refreshRiver(slot1)
	end

	slot0:_refreshFullRiver(slot1)
	slot0:_refreshWaterGradient(slot1)
	slot0:_refreshEffect()
end

function slot0.checkBlockLandShow(slot0, slot1)
	return true
end

function slot0._refreshWaterGradient(slot0, slot1)
	if not slot1 or not slot1:hasRiver() then
		return
	end

	if slot0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey) then
		for slot8, slot9 in ipairs(slot2) do
			gohelper.setActive(slot9, not slot1:isInMapBlock() or slot1:isWaterGradient())
		end
	end
end

function slot0.isHasWaterGradient(slot0)
	slot1 = false

	if slot0:getMO() and slot2:hasRiver() and slot0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.WaterGradientGOKey) then
		slot1 = #slot3 > 0
	end

	return slot1
end

function slot0._refreshRiver(slot0, slot1)
	slot3, slot4, slot5, slot6 = nil
	slot7 = 0

	if (slot1 or slot0:getMO()):hasRiver() then
		if not slot2:isFullWater() then
			slot3, slot7, slot4, slot5, slot6 = RoomRiverBlockHelper.getRiverBlockTypeByMO(slot2)
		end
	elseif slot2.blockId > 0 then
		slot3, slot5 = slot0:_getRiverEffectRes(slot2:getDefineBlockType(), slot0:checkSideShow())
	else
		slot5 = RoomScenePreloader.InitLand
		slot3 = RoomScenePreloader.InitLand
	end

	slot0:_refreshParams(RoomEnum.EffectKey.BlockRiverFloorKey, slot4, slot7, nil, slot6)
	slot0:_refreshParams(RoomEnum.EffectKey.BlockRiverKey, slot3, slot7, nil, slot5)
end

function slot0._refreshFullRiver(slot0, slot1)
	if not (slot1 or slot0:getMO()):isFullWater() and not slot0._isLastFullRiver then
		return
	end

	slot0._isLastFullRiver = slot3
	slot4 = slot2:isHalfLakeWater()

	for slot8 = 1, 6 do
		slot9, slot10, slot11, slot12, slot13, slot14 = RoomBlockHelper.getResourcePath(slot2, slot8)
		slot15 = slot8 - 1

		slot0:_refreshParams(RoomEnum.EffectKey.BlockKeys[slot8], slot9, slot15, nil, slot12)
		slot0:_refreshParams(RoomEnum.EffectKey.BlockFloorKeys[slot8], slot10, slot15, nil, slot13)
		slot0:_refreshParams(RoomEnum.EffectKey.BlockFloorBKeys[slot8], slot11, slot15, nil, slot14)

		slot16 = nil

		if string.nilorempty(slot9) then
			slot16, slot12 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, RoomRiverEnum.LakeBlockType[RoomRiverEnum.LakeOutLinkType.HalfLake], slot2:getDefineWaterType())
		end

		slot0:_refreshParams(RoomEnum.EffectKey.BlockHalfLakeKeys[slot8], slot16, slot15, nil, slot12)
	end
end

function slot0._refreshParams(slot0, slot1, slot2, slot3, slot4, slot5)
	if string.nilorempty(slot2) then
		if slot0.effect:isHasKey(slot1) then
			slot0._riverBlockRemoveParams = slot0._riverBlockRemoveParams or {}

			table.insert(slot0._riverBlockRemoveParams, slot1)
		end
	elseif not slot0.effect:isSameResByKey(slot1, slot2) then
		slot0._riverBlockAddParams = slot0._riverBlockAddParams or {}
		slot6 = {
			res = slot2,
			layer = UnityLayer.SceneOpaque,
			pathfinding = slot0._pathfindingEnabled,
			localRotation = Vector3(0, 60 * slot3, 0)
		}

		if slot3 then
			-- Nothing
		end

		if slot4 then
			slot6.deleteChildPath = slot4
		end

		if not string.nilorempty(slot5) then
			slot6.ab = slot5
		end

		slot0:onReviseResParams(slot6)

		slot0._riverBlockAddParams[slot1] = slot6
	end
end

function slot0._refreshEffect(slot0)
	if slot0._riverBlockRemoveParams then
		slot0.effect:removeParams(slot0._riverBlockRemoveParams)

		slot0._riverBlockRemoveParams = nil
	end

	if slot0._riverBlockAddParams then
		slot0.effect:addParams(slot0._riverBlockAddParams)

		slot0._riverBlockAddParams = nil
	end

	slot0.effect:refreshEffect()
end

function slot0.onReviseResParams(slot0, slot1)
end

function slot0.onEffectRebuild(slot0)
end

function slot0.refreshRotation(slot0, slot1)
	slot1 = false
	slot3 = slot0:getMO():getRotate()

	if slot0._rotationTweenId then
		ZProj.TweenHelper.KillById(slot0._rotationTweenId)
	end

	if slot1 then
		slot0._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(slot0.containerGOTrs, 0, slot3 * 60, 0, 0.1, nil, slot0, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(slot0.containerGOTrs, 0, slot3 * 60, 0)
	end
end

function slot0.refreshBlock(slot0)
	slot0:refreshLand()
	slot0.effect:refreshEffect()
end

function slot0.refreshTempOccupy(slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
end

function slot0.beforeDestroy(slot0)
	slot0:_returnAnimator()

	if slot0._rotationTweenId then
		ZProj.TweenHelper.KillById(slot0._rotationTweenId)
	end

	for slot4, slot5 in ipairs(slot0._compList) do
		if slot5.beforeDestroy then
			slot5:beforeDestroy()
		end
	end
end

function slot0.setBatchEnabled(slot0, slot1)
	if slot0.go:GetComponentsInChildren(typeof(UrpCustom.BatchRendererEntity), true) then
		slot3 = {}
		slot7 = slot3

		RoomHelper.cArrayToLuaTable(slot2, slot7)

		for slot7 = 1, #slot3 do
			slot3[slot7].enabled = slot1
		end
	end
end

function slot0.playAnim(slot0, slot1, slot2)
	if not slot0._animator then
		slot0._animator = gohelper.onceAddComponent(slot0.go, typeof(UnityEngine.Animator))
	end

	if not slot0._animatorPlayer then
		slot0._animatorPlayer = gohelper.onceAddComponent(slot0.go, typeof(SLFramework.AnimatorPlayer))
	end

	slot0._animator.runtimeAnimatorController = slot0._scene.preloader:getResource(slot1)

	slot0._animatorPlayer:Play(slot2, slot0._returnAnimator, slot0)
end

function slot0._returnAnimator(slot0)
	if slot0._animatorPlayer then
		gohelper.removeComponent(slot0.go, typeof(SLFramework.AnimatorPlayer))

		slot0._animatorPlayer = nil
	end

	if slot0._animator then
		gohelper.removeComponent(slot0.go, typeof(UnityEngine.Animator))

		slot0._animator = nil
	end
end

function slot0.checkSideShow(slot0)
	if not slot0:getMO() then
		return false
	end

	slot2 = false

	if slot1.blockState == RoomBlockEnum.BlockState.Map then
		slot2 = true
		slot4 = slot1.hexPoint:getNeighbors()

		for slot8 = 1, 6 do
			slot9 = HexPoint.directions[slot8]

			if not RoomMapBlockModel.instance:getBlockMO(slot9.x + slot3.x, slot9.y + slot3.y) or slot10.blockState ~= RoomBlockEnum.BlockState.Map then
				slot2 = false

				break
			end
		end
	end

	return slot2
end

function slot0._getRiverEffectRes(slot0, slot1, slot2)
	return RoomResHelper.getBlockLandPath(slot1, slot2)
end

function slot0.getMO(slot0)
end

function slot0.getMainEffectKey(slot0)
	return RoomEnum.EffectKey.BlockLandKey
end

return slot0
