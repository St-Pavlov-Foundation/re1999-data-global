module("modules.logic.room.entity.RoomMapBlockEntity", package.seeall)

slot0 = class("RoomMapBlockEntity", RoomBaseBlockEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._placingHereRotation = nil
	slot0._pathfindingEnabled = true
	slot0._highlightDic = {}
end

function slot0.getTag(slot0)
	return SceneTag.RoomMapBlock
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	slot0:addAmbientAudio()
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)

	if RoomController.instance:isDebugPackageMode() then
		slot0:addComp("debugpackageui", RoomDebugPackageUIComp)
	end

	slot0:addComp("nightlight", RoomNightLightComp)
	slot0:addComp("birthday", RoomMapBlockBirthdayComp)
	slot0.nightlight:setEffectKey(RoomEnum.EffectKey.BlockLandKey)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.ResourceLight, slot0._refreshLightEffect, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.StartPlayAmbientAudio, slot0.playAmbientAudio, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, slot0.refreshPackage, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, slot0.refreshPackage, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, slot0.refreshPackage, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, slot0.refreshPackage, slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	uv0.super.setLocalPos(slot0, slot1, slot2, slot3)
	slot0:refreshName()
end

function slot0.onEffectRebuild(slot0)
	uv0.super.onEffectRebuild(slot0)
	slot0:_refreshLandLightEffect()
	slot0:_refreshLinkGO()
	slot0:_refreshWaterGradient(slot0:getMO())
end

function slot0.refreshBlock(slot0)
	uv0.super.refreshBlock(slot0)

	if slot0:getMO().blockState == RoomBlockEnum.BlockState.Temp then
		if not slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
			slot0.effect:addParams({
				[RoomEnum.EffectKey.BlockTempPlaceKey] = {
					res = RoomScenePreloader.ResEffectB
				}
			})
		end
	elseif slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockTempPlaceKey) then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BlockTempPlaceKey
		})

		slot0._placingHereRotation = nil
	end

	slot2 = false

	if RoomWaterReformModel.instance:isWaterReform() and slot1:hasRiver() then
		slot2 = RoomWaterReformModel.instance:isBlockInSelect(slot1)
	end

	if slot1:getOpState() == RoomBlockEnum.OpState.Back or slot2 then
		slot6 = nil

		if slot2 then
			slot6 = RoomScenePreloader.ResEffectD03
		elseif slot5 then
			slot6 = slot1:getOpStateParam() and RoomScenePreloader.ResEffectD03 or RoomScenePreloader.ResEffectD04
		end

		if slot6 and slot0._lastSelectEffPath ~= slot6 then
			slot0._lastSelectEffPath = slot6

			slot0.effect:addParams({
				[RoomEnum.EffectKey.BlockBackBlockKey] = {
					res = slot6
				}
			})
		end
	elseif slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBlockKey) then
		slot0._lastSelectEffPath = nil

		slot0:removeParamsAndPlayAnimator({
			RoomEnum.EffectKey.BlockBackBlockKey
		}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end

	slot0:_refreshLightEffect()
	slot0:refreshPackage()
	slot0.effect:refreshEffect()
	slot0:_refreshLinkGO()
	slot0.birthday:refreshBirthday()
end

function slot0.checkBlockLandShow(slot0, slot1)
	if slot1 and slot1.blockCleanType == RoomBlockEnum.CleanType.CleanLand then
		return false
	end

	return true
end

function slot0.refreshBackBuildingEffect(slot0, slot1)
	slot2 = false

	if RoomMapBlockModel.instance:isBackMore() and (slot1 or slot0:getMO()) and RoomMapBuildingModel.instance:getBuildingParam(slot3.hexPoint.x, slot3.hexPoint.y) then
		slot2 = true
	end

	if slot2 then
		if not slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
			slot0.effect:addParams({
				[RoomEnum.EffectKey.BlockBackBuildingKey] = {
					res = RoomScenePreloader.ResEffectD06
				}
			})
			slot0.effect:refreshEffect()
		end
	elseif slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.BlockBackBuildingKey) then
		slot0:removeParamsAndPlayAnimator({
			RoomEnum.EffectKey.BlockBackBuildingKey
		}, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function slot0._refreshLinkGO(slot0)
	if not slot0:getMO() then
		return
	end

	for slot6 = 1, #slot1:getResourceList() do
		if RoomResourceEnum.ResourceLinkGOPath[slot2[slot6]] and RoomResourceEnum.ResourceLinkGOPath[slot7][slot6] and slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomResourceEnum.ResourceLinkGOPath[slot7][slot6]) then
			slot9, slot10 = slot1:getNeighborBlockLinkResourceId(slot6, true)

			gohelper.setActive(slot8, slot7 == slot9)
		end
	end

	if RoomBlockEnum.BlockLinkEffectGOPath[slot1:getDefineBlockType()] and slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomBlockEnum.BlockLinkEffectGOPath[slot3]) then
		gohelper.setActive(slot4, slot1:hasNeighborSameBlockType())
	end
end

function slot0.refreshPackage(slot0)
	if not RoomController.instance:isDebugPackageMode() or not RoomDebugController.instance:isDebugPackageListShow() then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		slot0.effect:refreshEffect()

		return
	end

	slot2 = slot0:getMO().packageId

	if not RoomDebugPackageListModel.instance:getFilterPackageId() or slot3 == 0 or not slot2 or slot2 == 0 then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BlockPackageEffectKey
		})
		slot0.effect:refreshEffect()

		return
	end

	if not slot1:getMainRes() or slot4 < 0 then
		slot4 = RoomResourceEnum.ResourceId.Empty
	end

	if RoomDebugController.instance:isEditPackageOrder() then
		if slot4 ~= (RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty) or slot3 ~= slot2 then
			slot0.effect:removeParams({
				RoomEnum.EffectKey.BlockPackageEffectKey
			})
		else
			slot0.effect:addParams({
				[RoomEnum.EffectKey.BlockPackageEffectKey] = {
					res = RoomScenePreloader.ResDebugPackageColorDict[slot4]
				}
			})
		end
	elseif slot3 ~= slot2 then
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorOther
			}
		})
	else
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BlockPackageEffectKey] = {
				res = RoomScenePreloader.ResDebugPackageColorDict[slot4]
			}
		})
	end

	slot0.effect:refreshEffect()
end

function slot0.refreshTempOccupy(slot0)
	uv0.super.refreshTempOccupy(slot0)
	slot0:_refreshLandLightEffect()
end

function slot0.playSmokeEffect(slot0)
	if not slot0:getMO() then
		return
	end

	slot0.effect:addParams({
		[RoomEnum.EffectKey.BlockSmokeEffectKey] = {
			res = RoomScenePreloader.BlockTypeSmokeDict[slot1:getDefineBlockType()] or RoomScenePreloader.ResSmoke,
			containerGO = slot0.staticContainerGO
		}
	}, 2)
	slot0.effect:refreshEffect()
end

function slot0.playVxWaterEffect(slot0)
	if slot0.effect:getEffectGO(RoomEnum.EffectKey.BlockVxWaterKey) then
		gohelper.setActive(slot1, false)
		gohelper.setActive(slot1, true)
	end

	slot0.effect:addParams({
		[RoomEnum.EffectKey.BlockVxWaterKey] = {
			res = RoomScenePreloader.ResVXWater,
			containerGO = slot0.containerGO
		}
	}, 3)
	slot0.effect:refreshEffect()
end

function slot0._refreshLightEffect(slot0)
	slot0:_refreshLandLightEffect()
end

function slot0._refreshLandLightEffect(slot0)
	if not slot0:getMO() or not slot1:isHasLight() then
		return
	end

	slot2 = slot1.hexPoint

	GameSceneMgr.instance:getCurScene().mapmgr:getPropertyBlock():SetVector("_Highlight", Vector4.New(0.3, 0.19, 0.06, 0))

	slot5 = slot1:getRiverCount()
	slot6 = false
	slot7 = slot1:isFullWater()
	slot8 = RoomEnum.EffectPath.ResourcePointLightPaths
	slot9 = RoomEnum.EffectKey.BlockKeys
	slot10 = RoomEnum.EffectKey.BlockLandKey
	slot11 = RoomConfig.instance
	slot13 = RoomEnum.EffectPath.LightMeshPath
	slot16 = RoomEnum.EffectKey.BlockHalfLakeKeys
	slot18 = slot1:isHalfLakeWater() and RoomResourceModel.instance:isLightResourcePoint(slot2.x, slot2.y, 0) == RoomResourceEnum.ResourceId.River

	for slot22 = 1, 6 do
		if slot14:isLightResourcePoint(slot2.x, slot2.y, RoomRotateHelper.rotateDirection(slot22, slot1:getRotate())) and slot24 == slot15 then
			slot6 = true
		end

		if slot7 and slot1:getResourceId(slot23) == slot15 then
			slot0:_setLightEffectByPath(slot9[slot22], slot13, slot24, slot4)

			if slot5 < 6 then
				slot0:_setLightEffectByPath(slot10, slot8[slot22], slot24, slot4)
			end
		elseif slot11:isLightByResourceId(slot25) then
			slot0:_setLightEffectByPath(slot10, slot8[slot22], slot24, slot4)
		end

		if slot17 and slot25 ~= slot15 then
			slot0:_setLightEffectByPath(slot16[slot22], slot13, slot18, slot4)
		end
	end

	if not slot7 and slot5 > 0 and slot5 < 6 then
		slot0:_setLightEffectByPath(RoomEnum.EffectKey.BlockRiverKey, slot13, slot6, slot4)
	end
end

function slot0._setLightEffectByPath(slot0, slot1, slot2, slot3, slot4)
	if slot0.effect:getMeshRenderersByPath(slot1, slot2) and #slot5 > 0 and slot0:_isUpdateLight(slot1, slot2, slot3) then
		for slot9, slot10 in ipairs(slot5) do
			if slot3 then
				slot10:SetPropertyBlock(slot4)
			else
				slot10:SetPropertyBlock(nil)
			end
		end
	end
end

function slot0._isUpdateLight(slot0, slot1, slot2, slot3)
	slot5 = true

	if slot0._highlightDic[slot1] then
		if slot4.isLight == slot3 and slot4.path == slot2 and slot4.effectRes == slot0.effect:getEffectRes(slot1) then
			slot5 = false
		end
	else
		slot0._highlightDic[slot1] = {}
	end

	if slot5 then
		slot4.isLight = slot3
		slot4.path = slot2
		slot4.effectRes = slot0.effect:getEffectRes(slot1)
	end

	return slot5
end

function slot0.beforeDestroy(slot0)
	if slot0.ambientAudioId and slot0.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, slot0.go)
	end

	uv0.super.beforeDestroy(slot0)
	slot0:removeEvent()
end

function slot0.removeEvent(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ResourceLight, slot0._refreshLightEffect, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.StartPlayAmbientAudio, slot0.playAmbientAudio, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, slot0.refreshPackage, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, slot0.refreshPackage, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, slot0.refreshPackage, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, slot0.refreshPackage, slot0)
end

function slot0.getMO(slot0)
	if RoomMapBlockModel.instance:getFullBlockMOById(slot0.id) then
		slot1.replaceDefineId = nil
		slot1.replaceRotate = nil

		if slot1.hexPoint then
			if not RoomMapBuildingModel.instance:getBuildingParam(slot1.hexPoint.x, slot1.hexPoint.y) and not RoomBuildingController.instance:isPressBuilding() then
				slot3 = slot2:getTempBuildingParam(slot1.hexPoint.x, slot1.hexPoint.y)
			end

			slot1.replaceDefineId = slot3 and slot3.blockDefineId
			slot1.replaceRotate = slot3 and slot3.blockDefineId and slot3.blockRotate
		end
	end

	return slot1
end

function slot0.addAmbientAudio(slot0)
	gohelper.addAkGameObject(slot0.go)

	slot2 = {}

	for slot6 = 1, 6 do
		if slot0:getMO():getResourceId(slot6) ~= RoomResourceEnum.ResourceId.None and slot7 ~= RoomResourceEnum.ResourceId.Empty then
			slot2[slot7] = slot2[slot7] or 0
			slot2[slot7] = slot2[slot7] + 1
		end
	end

	slot4 = 0
	slot5 = 0

	for slot9, slot10 in pairs(slot2) do
		if 0 < slot10 then
			slot3 = slot10
			slot4 = RoomResourceEnum.ResourceAudioPriority[slot9] or 0
			slot5 = slot9
		elseif slot10 == slot3 and (RoomResourceEnum.ResourceAudioPriority[slot9] or slot4 < 0) then
			slot3 = slot10
			slot4 = RoomResourceEnum.ResourceAudioPriority[slot9] or 0
			slot5 = slot9
		end
	end

	slot0.ambientAudioId = RoomResourceEnum.ResourceAudioId[slot5]
end

function slot0.playAmbientAudio(slot0)
	if slot0.ambientAudioId and slot0.ambientAudioId ~= AudioEnum.None then
		AudioMgr.instance:trigger(slot0.ambientAudioId, slot0.go)
	end
end

function slot0.getCharacterMeshRendererList(slot0)
	return slot0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BlockLandKey)
end

function slot0.getGameObjectListByName(slot0, slot1)
	return slot0.effect:getGameObjectsByName(RoomEnum.EffectKey.BlockLandKey, slot1)
end

return slot0
