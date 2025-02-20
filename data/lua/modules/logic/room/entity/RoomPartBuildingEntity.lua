module("modules.logic.room.entity.RoomPartBuildingEntity", package.seeall)

slot0 = class("RoomPartBuildingEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
	slot0._isWorking = nil
end

function slot0.getTag(slot0)
	return SceneTag.RoomPartBuilding
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:_refreshWorkingState()
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		slot0:addComp("collider", RoomColliderComp)
		slot0:addComp("atmosphere", RoomAtmosphereComp)
	end

	slot0:addComp("nightlight", RoomNightLightComp)
	slot0:addComp("skin", RoomInitBuildingSkinComp)
	slot0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, slot0.refreshBuilding, slot0)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, slot0.refreshBuilding, slot0)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, slot0._refreshWorkingState, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, slot0._onLateInitDone, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, slot0._onSwithMode, slot0)
end

function slot0._onLateInitDone(slot0)
	slot0._lateInitDone = true

	slot0:_refreshAudio()
end

function slot0.refreshBuilding(slot0, slot1, slot2)
	if string.nilorempty(slot0:_getPartBuildingRes()) then
		slot0.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		slot0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = slot3,
				alphaThreshold = slot1,
				alphaThresholdValue = slot2
			}
		})
	end

	slot0.effect:refreshEffect()
	slot0:_refreshMaxLevel()
	slot0:_refreshAudio()
end

function slot0._levelUp(slot0)
	slot0:refreshBuilding()
end

function slot0.onEffectRebuild(slot0)
	slot0:_refreshWorkingEffect()
	slot0:_refreshAudio()
end

function slot0.tweenAlphaThreshold(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0.alphaThresholdComp then
		return
	end

	slot0.alphaThresholdComp:tweenAlphaThreshold(slot1, slot2, slot3, slot4, slot5)
end

function slot0._characterListShowChanged(slot0, slot1)
	slot0:setEnable(not RoomController.instance:isEditMode() and not slot1)
end

function slot0._onSwithMode(slot0)
	slot0:setEnable(not RoomController.instance:isEditMode())
end

function slot0.setEnable(slot0, slot1)
	if slot0.collider then
		slot0.collider:setEnable(slot1 and true or false)
	end
end

function slot0._getPartBuildingRes(slot0)
	slot1 = nil

	return (not RoomSkinModel.instance:isDefaultRoomSkin(slot0.id, RoomSkinModel.instance:getShowSkin(slot0.id)) or RoomInitBuildingHelper.getModelPath(slot0.id)) and (RoomConfig.instance:getRoomSkinModelPath(slot2) or RoomSkinModel.instance:getEquipRoomSkin(slot0.id))
end

function slot0._refreshWorkingState(slot0)
	slot1 = RoomProductionHelper.isPartWorking(slot0.id)

	if slot0._isWorking == false and slot1 == true then
		slot0:_playChangeAudio()
	end

	slot0._isWorking = slot1

	slot0:_refreshWorkingEffect()
	slot0:_refreshAudio()
end

function slot0._playChangeAudio(slot0)
	if RoomConfig.instance:getProductionPartConfig(slot0.id).changeAudio ~= 0 then
		AudioMgr.instance:trigger(slot1.changeAudio, slot0.go)
	end
end

function slot0._refreshWorkingEffect(slot0)
	slot2 = slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartFullPath)

	if slot0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartWorkingPath) then
		gohelper.setActive(slot1, slot0._isWorking)
	end

	if slot2 then
		gohelper.setActive(slot2, not slot0._isWorking)
	end
end

function slot0.beforeDestroy(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, slot0.refreshBuilding, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, slot0.refreshBuilding, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, slot0._refreshWorkingState, slot0)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, slot0._onLateInitDone, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, slot0._characterListShowChanged, slot0)

	slot4 = slot0._onSwithMode
	slot5 = slot0

	RoomController.instance:unregisterCallback(slot4, slot5)

	for slot4, slot5 in ipairs(slot0._compList) do
		if slot5.beforeDestroy then
			slot5:beforeDestroy()
		end
	end

	slot0._lateInitDone = nil

	slot0:_stopAudio()
end

function slot0.getCharacterMeshRendererList(slot0)
	return slot0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function slot0._refreshMaxLevel(slot0)
	if not RoomConfig.instance:getProductionPartConfig(slot0.id) then
		slot0._maxLevel = 0

		return
	end

	slot3 = 0

	for slot7, slot8 in ipairs(slot1.productionLines) do
		slot9 = 0

		if RoomController.instance:isVisitMode() then
			slot9 = RoomMapModel.instance:getOtherLineLevelDict()[slot8] or 0
		elseif RoomController.instance:isDebugMode() then
			slot3 = 1

			break
		else
			slot9 = RoomProductionModel.instance:getLineMO(slot8) and slot10.level or 0
		end

		if slot3 < slot9 then
			slot3 = slot9
		end
	end

	slot0._maxLevel = slot3
end

function slot0._refreshAudio(slot0)
	if not slot0._lateInitDone then
		return
	end

	if string.nilorempty(slot0:_getPartBuildingRes()) then
		slot0:_stopAudio()

		return
	end

	if not slot0._maxLevel or slot0._maxLevel <= 0 then
		slot0:_stopAudio()

		return
	end

	slot2 = ZProj.AudioEmitter.Get(slot0.go)

	if RoomConfig.instance:getProductionPartConfig(slot0.id).audio ~= 0 then
		if slot0._audioId ~= slot3.audio then
			slot2:Emitter(slot3.audio)

			slot0._audioId = slot3.audio
		end

		if slot2.playingId > 0 then
			slot4 = 0

			if slot0._isWorking then
				slot4 = RoomProductionHelper.getSkinLevel(slot0.id, slot0._maxLevel)
			end

			AudioMgr.instance:setRTPCValueByPlayingID(AudioMgr.instance:getIdFromString(AudioEnum.RoomRTPC.HomePivotRank), math.min(slot4, 3), slot2.playingId)
		end
	end
end

function slot0._stopAudio(slot0)
	if ZProj.AudioEmitter.Get(slot0.go).playingId > 0 then
		AudioMgr.instance:stopPlayingID(slot1.playingId)
	end

	slot0._audioId = nil
end

return slot0
