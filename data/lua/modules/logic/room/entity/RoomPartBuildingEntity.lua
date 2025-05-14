module("modules.logic.room.entity.RoomPartBuildingEntity", package.seeall)

local var_0_0 = class("RoomPartBuildingEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
	arg_1_0._isWorking = nil
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomPartBuilding
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = arg_3_0.containerGO

	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._scene = GameSceneMgr.instance:getCurScene()

	arg_3_0:_refreshWorkingState()
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)

	if RoomController.instance:isObMode() then
		arg_4_0:addComp("collider", RoomColliderComp)
		arg_4_0:addComp("atmosphere", RoomAtmosphereComp)
	end

	arg_4_0:addComp("nightlight", RoomNightLightComp)
	arg_4_0:addComp("skin", RoomInitBuildingSkinComp)
	arg_4_0:addComp("alphaThresholdComp", RoomAlphaThresholdComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, arg_5_0.refreshBuilding, arg_5_0)
	RoomController.instance:registerCallback(RoomEvent.ProduceLineLevelUp, arg_5_0.refreshBuilding, arg_5_0)
	RoomController.instance:registerCallback(RoomEvent.UpdateProduceLineData, arg_5_0._refreshWorkingState, arg_5_0)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, arg_5_0._onLateInitDone, arg_5_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, arg_5_0._characterListShowChanged, arg_5_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_5_0._onSwithMode, arg_5_0)
end

function var_0_0._onLateInitDone(arg_6_0)
	arg_6_0._lateInitDone = true

	arg_6_0:_refreshAudio()
end

function var_0_0.refreshBuilding(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:_getPartBuildingRes()

	if string.nilorempty(var_7_0) then
		arg_7_0.effect:removeParams({
			RoomEnum.EffectKey.BuildingGOKey
		})
	else
		arg_7_0.effect:addParams({
			[RoomEnum.EffectKey.BuildingGOKey] = {
				pathfinding = true,
				res = var_7_0,
				alphaThreshold = arg_7_1,
				alphaThresholdValue = arg_7_2
			}
		})
	end

	arg_7_0.effect:refreshEffect()
	arg_7_0:_refreshMaxLevel()
	arg_7_0:_refreshAudio()
end

function var_0_0._levelUp(arg_8_0)
	arg_8_0:refreshBuilding()
end

function var_0_0.onEffectRebuild(arg_9_0)
	arg_9_0:_refreshWorkingEffect()
	arg_9_0:_refreshAudio()
end

function var_0_0.tweenAlphaThreshold(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if not arg_10_0.alphaThresholdComp then
		return
	end

	arg_10_0.alphaThresholdComp:tweenAlphaThreshold(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
end

function var_0_0._characterListShowChanged(arg_11_0, arg_11_1)
	arg_11_0:setEnable(not RoomController.instance:isEditMode() and not arg_11_1)
end

function var_0_0._onSwithMode(arg_12_0)
	arg_12_0:setEnable(not RoomController.instance:isEditMode())
end

function var_0_0.setEnable(arg_13_0, arg_13_1)
	if arg_13_0.collider then
		arg_13_0.collider:setEnable(arg_13_1 and true or false)
	end
end

function var_0_0._getPartBuildingRes(arg_14_0)
	local var_14_0
	local var_14_1 = RoomSkinModel.instance:getShowSkin(arg_14_0.id)

	if RoomSkinModel.instance:isDefaultRoomSkin(arg_14_0.id, var_14_1) then
		var_14_0 = RoomInitBuildingHelper.getModelPath(arg_14_0.id)
	else
		var_14_0 = RoomConfig.instance:getRoomSkinModelPath(var_14_1) or RoomSkinModel.instance:getEquipRoomSkin(arg_14_0.id)
	end

	return var_14_0
end

function var_0_0._refreshWorkingState(arg_15_0)
	local var_15_0 = RoomProductionHelper.isPartWorking(arg_15_0.id)

	if arg_15_0._isWorking == false and var_15_0 == true then
		arg_15_0:_playChangeAudio()
	end

	arg_15_0._isWorking = var_15_0

	arg_15_0:_refreshWorkingEffect()
	arg_15_0:_refreshAudio()
end

function var_0_0._playChangeAudio(arg_16_0)
	local var_16_0 = RoomConfig.instance:getProductionPartConfig(arg_16_0.id)

	if var_16_0.changeAudio ~= 0 then
		AudioMgr.instance:trigger(var_16_0.changeAudio, arg_16_0.go)
	end
end

function var_0_0._refreshWorkingEffect(arg_17_0)
	local var_17_0 = arg_17_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartWorkingPath)
	local var_17_1 = arg_17_0.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EffectPath.PartFullPath)

	if var_17_0 then
		gohelper.setActive(var_17_0, arg_17_0._isWorking)
	end

	if var_17_1 then
		gohelper.setActive(var_17_1, not arg_17_0._isWorking)
	end
end

function var_0_0.beforeDestroy(arg_18_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, arg_18_0.refreshBuilding, arg_18_0)
	RoomController.instance:unregisterCallback(RoomEvent.ProduceLineLevelUp, arg_18_0.refreshBuilding, arg_18_0)
	RoomController.instance:unregisterCallback(RoomEvent.UpdateProduceLineData, arg_18_0._refreshWorkingState, arg_18_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, arg_18_0._onLateInitDone, arg_18_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, arg_18_0._characterListShowChanged, arg_18_0)
	RoomController.instance:unregisterCallback(arg_18_0._onSwithMode, arg_18_0)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._compList) do
		if iter_18_1.beforeDestroy then
			iter_18_1:beforeDestroy()
		end
	end

	arg_18_0._lateInitDone = nil

	arg_18_0:_stopAudio()
end

function var_0_0.getCharacterMeshRendererList(arg_19_0)
	return arg_19_0.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function var_0_0._refreshMaxLevel(arg_20_0)
	local var_20_0 = RoomConfig.instance:getProductionPartConfig(arg_20_0.id)

	if not var_20_0 then
		arg_20_0._maxLevel = 0

		return
	end

	local var_20_1 = var_20_0.productionLines
	local var_20_2 = 0

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		local var_20_3 = 0

		if RoomController.instance:isVisitMode() then
			var_20_3 = RoomMapModel.instance:getOtherLineLevelDict()[iter_20_1] or 0
		elseif RoomController.instance:isDebugMode() then
			var_20_2 = 1

			break
		else
			local var_20_4 = RoomProductionModel.instance:getLineMO(iter_20_1)

			var_20_3 = var_20_4 and var_20_4.level or 0
		end

		if var_20_2 < var_20_3 then
			var_20_2 = var_20_3
		end
	end

	arg_20_0._maxLevel = var_20_2
end

function var_0_0._refreshAudio(arg_21_0)
	if not arg_21_0._lateInitDone then
		return
	end

	local var_21_0 = arg_21_0:_getPartBuildingRes()

	if string.nilorempty(var_21_0) then
		arg_21_0:_stopAudio()

		return
	end

	if not arg_21_0._maxLevel or arg_21_0._maxLevel <= 0 then
		arg_21_0:_stopAudio()

		return
	end

	local var_21_1 = ZProj.AudioEmitter.Get(arg_21_0.go)
	local var_21_2 = RoomConfig.instance:getProductionPartConfig(arg_21_0.id)

	if var_21_2.audio ~= 0 then
		if arg_21_0._audioId ~= var_21_2.audio then
			var_21_1:Emitter(var_21_2.audio)

			arg_21_0._audioId = var_21_2.audio
		end

		if var_21_1.playingId > 0 then
			local var_21_3 = 0

			if arg_21_0._isWorking then
				var_21_3 = RoomProductionHelper.getSkinLevel(arg_21_0.id, arg_21_0._maxLevel)
			end

			local var_21_4 = math.min(var_21_3, 3)

			AudioMgr.instance:setRTPCValueByPlayingID(AudioMgr.instance:getIdFromString(AudioEnum.RoomRTPC.HomePivotRank), var_21_4, var_21_1.playingId)
		end
	end
end

function var_0_0._stopAudio(arg_22_0)
	local var_22_0 = ZProj.AudioEmitter.Get(arg_22_0.go)

	if var_22_0.playingId > 0 then
		AudioMgr.instance:stopPlayingID(var_22_0.playingId)
	end

	arg_22_0._audioId = nil
end

return var_0_0
