module("modules.logic.room.entity.comp.RoomAtmosphereComp", package.seeall)

local var_0_0 = class("RoomAtmosphereComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._buildingId = arg_1_0.entity.id

	if arg_1_0.entity.getMO then
		arg_1_0._buildingId = arg_1_0.entity:getMO().buildingId
	end

	arg_1_0._atmosphereDict = {}

	arg_1_0:setIsBlockAtmosphere(false)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = RoomConfig.instance:getBuildingAtmospheres(arg_2_0._buildingId)

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_3 = RoomConfig.instance:getAtmosphereAllEffectPathList(iter_2_1)

		for iter_2_2, iter_2_3 in ipairs(var_2_3) do
			if not var_2_1[iter_2_3] then
				var_2_0[#var_2_0 + 1] = iter_2_3
				var_2_1[iter_2_3] = true
			end
		end
	end

	GameSceneMgr.instance:getCurScene().loader:makeSureLoaded(var_2_0, arg_2_0.beginCheckAtmosphere, arg_2_0)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, arg_3_0.onBlockAtmosphere, arg_3_0)
	arg_3_0:addEventCb(RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, arg_3_0.onResumeAtmosphere, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0.onCloseView, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0.refreshManufactureState, arg_3_0)
	arg_3_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0.refreshManufactureState, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(RoomMapController.instance, RoomEvent.BlockAtmosphereEffect, arg_4_0.onBlockAtmosphere, arg_4_0)
	arg_4_0:removeEventCb(RoomMapController.instance, RoomEvent.ResumeAtmosphereEffect, arg_4_0.onResumeAtmosphere, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_4_0.onOpenViewFinish, arg_4_0)
	arg_4_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onCloseView, arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_4_0.refreshManufactureState, arg_4_0)
	arg_4_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_4_0.refreshManufactureState, arg_4_0)
end

function var_0_0.onBlockAtmosphere(arg_5_0)
	arg_5_0:setIsBlockAtmosphere(true)
	TaskDispatcher.cancelTask(arg_5_0.repeatCheckAtmosphere, arg_5_0)
	arg_5_0:stopAllAtmosphere()
end

function var_0_0.onResumeAtmosphere(arg_6_0)
	arg_6_0:setIsBlockAtmosphere(false)
	arg_6_0:beginCheckAtmosphere()
end

function var_0_0.onOpenViewFinish(arg_7_0, arg_7_1)
	if RoomEnum.AtmosphereAudioFadeView[arg_7_1] then
		arg_7_0:setAtmosphereAudioIsFade(true)
	end
end

function var_0_0.onCloseView(arg_8_0, arg_8_1)
	if RoomEnum.AtmosphereAudioFadeView[arg_8_1] then
		arg_8_0:setAtmosphereAudioIsFade(false)
	end
end

function var_0_0.setAtmosphereAudioIsFade(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._atmosphereDict) do
		local var_9_0 = arg_9_0:_getAtmosphereFlow(iter_9_0)

		if var_9_0 then
			var_9_0:setAllWorkAudioIsFade(arg_9_1)
		end
	end
end

function var_0_0.setIsBlockAtmosphere(arg_10_0, arg_10_1)
	arg_10_0._isBlockAtmosphere = arg_10_1
end

function var_0_0._getAtmosphere(arg_11_0, arg_11_1)
	if not arg_11_0._atmosphereDict then
		arg_11_0._atmosphereDict = {}
	end

	local var_11_0 = arg_11_0._atmosphereDict[arg_11_1]

	if not var_11_0 then
		var_11_0 = {}

		arg_11_0:_resetAtmosphere(var_11_0)

		arg_11_0._atmosphereDict[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0._getAtmosphereFlow(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:_getAtmosphere(arg_12_1)
	local var_12_1 = var_12_0.flow

	if not var_12_1 and arg_12_2 then
		var_12_1 = RoomAtmosphereFlowSequence.New(arg_12_1)

		local var_12_2 = RoomConfig.instance:getAtmosphereEffectIdList(arg_12_1)

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			local var_12_3 = RoomAtmosphereEffectWork.New(iter_12_1, arg_12_0.go)

			var_12_1:addWork(var_12_3)
		end

		var_12_0.flow = var_12_1

		var_12_1:registerDoneListener(arg_12_0.atmosphereSequenceFinish, arg_12_0)
	end

	return var_12_1
end

function var_0_0._getAtmosphereResidentEffGO(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RoomConfig.instance:getAtmosphereResidentEffect(arg_13_1)

	if not var_13_0 or var_13_0 == 0 then
		return
	end

	local var_13_1 = arg_13_0:_getAtmosphere(arg_13_1)
	local var_13_2 = var_13_1.residentEffGO

	if gohelper.isNil(var_13_2) and arg_13_2 then
		local var_13_3 = RoomConfig.instance:getRoomEffectPath(var_13_0)
		local var_13_4

		if not GameResMgr.IsFromEditorDir then
			var_13_4 = FightHelper.getEffectAbPath(var_13_3)
		end

		var_13_2 = RoomGOPool.getInstance(var_13_3, arg_13_0.go, "residentEffect_" .. var_13_0, var_13_4)
		var_13_1.residentEffGO = var_13_2
	end

	return var_13_2
end

function var_0_0._resetAtmosphere(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_1.cyclesTimes = 0
	arg_14_1.isPlaying = false
	arg_14_1.isFlowPlaying = false
end

function var_0_0.beginCheckAtmosphere(arg_15_0)
	arg_15_0:repeatCheckAtmosphere()
	TaskDispatcher.cancelTask(arg_15_0.repeatCheckAtmosphere, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0.repeatCheckAtmosphere, arg_15_0, 1)
end

function var_0_0.repeatCheckAtmosphere(arg_16_0)
	if arg_16_0._isBlockAtmosphere then
		return
	end

	local var_16_0, var_16_1 = RoomModel.instance:getOpenAndEndAtmosphereList(arg_16_0._buildingId)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		arg_16_0:stopAtmosphere(iter_16_1)
	end

	if not var_16_0 or #var_16_0 <= 0 then
		return
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_0) do
		if not arg_16_0:_getAtmosphere(iter_16_3).isFlowPlaying then
			arg_16_0:beginAtmosphere(iter_16_3)
		end
	end
end

function var_0_0.beginAtmosphere(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:_getAtmosphere(arg_17_1)

	var_17_0.cyclesTimes = 1
	var_17_0.isFlowPlaying = true

	local var_17_1 = arg_17_0:_getAtmosphereResidentEffGO(arg_17_1, true)

	gohelper.setActive(var_17_1, false)
	gohelper.setActive(var_17_1, true)

	var_17_0.isPlaying = true

	local var_17_2 = arg_17_0:_getAtmosphereFlow(arg_17_1, true)

	var_17_2:reset()
	var_17_2:start()
end

function var_0_0.atmosphereSequenceFinish(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2 and arg_18_0:_getAtmosphere(arg_18_2) or nil

	if not var_18_0 then
		return
	end

	if not arg_18_1 then
		arg_18_0:stopAtmosphere(arg_18_2)

		return
	end

	local var_18_1 = RoomConfig.instance:getAtmosphereCyclesTimes(arg_18_2)
	local var_18_2 = RoomConfig.instance:getAtmosphereCfg(arg_18_2)
	local var_18_3 = var_18_2 and var_18_2.cdtimes or 0
	local var_18_4 = var_18_0.cyclesTimes
	local var_18_5 = var_18_1 == 0 or var_18_4 < var_18_1
	local var_18_6 = arg_18_0:_getAtmosphereFlow(arg_18_2)

	if var_18_6 and var_18_5 and var_18_3 == 0 then
		var_18_6:start()

		var_18_0.cyclesTimes = var_18_4 + 1
	else
		if var_18_6 then
			var_18_6:reset()
		end

		arg_18_0:stopAtmosphere(arg_18_2)
		RoomModel.instance:setAtmosphereHasPlay(arg_18_2)
	end
end

function var_0_0.stopAllAtmosphere(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._atmosphereDict) do
		arg_19_0:stopAtmosphere(iter_19_0)
	end
end

function var_0_0.stopAtmosphere(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getAtmosphere(arg_20_1)

	if not var_20_0.isPlaying then
		return
	end

	local var_20_1 = arg_20_0:_getAtmosphereFlow(arg_20_1)

	if var_20_1 then
		var_20_1:stop()
	end

	arg_20_0:_resetAtmosphere(var_20_0)

	local var_20_2 = arg_20_0:_getAtmosphereResidentEffGO(arg_20_1)

	gohelper.setActive(var_20_2, false)
end

function var_0_0.onEffectRebuild(arg_21_0)
	if arg_21_0.__willDestroy then
		return
	end

	arg_21_0:refreshManufactureState()
end

function var_0_0.refreshManufactureState(arg_22_0)
	local var_22_0

	if arg_22_0.entity.getMO then
		var_22_0 = arg_22_0.entity:getMO()
	end

	if not var_22_0 then
		return
	end

	if not ManufactureConfig.instance:isManufactureBuilding(arg_22_0._buildingId) then
		return
	end

	local var_22_1 = var_22_0:getManufactureState() == RoomManufactureEnum.ManufactureState.Running
	local var_22_2 = RoomBuildingEnum.AnimName.Idel

	if var_22_1 then
		var_22_2 = RoomBuildingEnum.AnimName.Produce
	end

	local var_22_3 = arg_22_0.entity:getMainEffectKey()

	arg_22_0.entity.effect:playEffectAnimator(var_22_3, var_22_2)

	local var_22_4 = arg_22_0.entity.effect:getGameObjectsByName(var_22_3, RoomEnum.EntityChildKey.ProduceGOKey)

	if var_22_4 then
		for iter_22_0, iter_22_1 in ipairs(var_22_4) do
			gohelper.setActive(iter_22_1, var_22_1)
		end
	end
end

function var_0_0.beforeDestroy(arg_23_0)
	arg_23_0.__willDestroy = true

	arg_23_0:removeEventListeners()
end

function var_0_0.onDestroy(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.repeatCheckAtmosphere, arg_24_0)

	arg_24_0.entity = nil
	arg_24_0.go = nil
	arg_24_0._buildingId = nil

	for iter_24_0, iter_24_1 in pairs(arg_24_0._atmosphereDict) do
		if not gohelper.isNil(iter_24_1.residentEffGO) then
			local var_24_0 = RoomConfig.instance:getAtmosphereResidentEffect(iter_24_0)
			local var_24_1 = RoomConfig.instance:getRoomEffectPath(var_24_0)

			RoomGOPool.returnInstance(var_24_1, iter_24_1.residentEffGO)
		end

		local var_24_2 = iter_24_1.flow

		if var_24_2 then
			var_24_2:unregisterDoneListener(arg_24_0.atmosphereSequenceFinish, arg_24_0)
			var_24_2:destroy()
		end

		arg_24_0:_resetAtmosphere(iter_24_1)
	end

	arg_24_0._atmosphereDict = nil

	arg_24_0:setIsBlockAtmosphere(false)
end

return var_0_0
