module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingCritterMgr", package.seeall)

local var_0_0 = class("RoomSceneBuildingCritterMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	if RoomController.instance:isEditMode() then
		return
	end

	arg_2_0:addEventListeners()
	arg_2_0:refreshAllCritterEntities()
end

function var_0_0.addEventListeners(arg_3_0)
	if arg_3_0._isInitAddEvent then
		return
	end

	arg_3_0._isInitAddEvent = true

	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureInfoUpdate, arg_3_0._startRefreshAllTask, arg_3_0)
	ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._startRefreshAllTask, arg_3_0)
	ManufactureController.instance:registerCallback(ManufactureEvent.CritterWorkInfoChange, arg_3_0._startRefreshAllTask, arg_3_0)
	CritterController.instance:registerCallback(CritterEvent.CritterBuildingChangeRestingCritter, arg_3_0._startRefreshAllTask, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	if not arg_4_0._isInitAddEvent then
		return
	end

	arg_4_0._isInitAddEvent = false

	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureInfoUpdate, arg_4_0._startRefreshAllTask, arg_4_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, arg_4_0._startRefreshAllTask, arg_4_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.CritterWorkInfoChange, arg_4_0._startRefreshAllTask, arg_4_0)
	CritterController.instance:unregisterCallback(CritterEvent.CritterBuildingChangeRestingCritter, arg_4_0._startRefreshAllTask, arg_4_0)
end

function var_0_0._startRefreshAllTask(arg_5_0)
	if not arg_5_0._isHasWaitRefreshAllTask then
		arg_5_0._isHasWaitRefreshAllTask = true

		TaskDispatcher.runDelay(arg_5_0._onRunRefreshAllTask, arg_5_0, 0.1)
	end
end

function var_0_0._stopRefreshAllTask(arg_6_0)
	if arg_6_0._isHasWaitRefreshAllTask then
		arg_6_0._isHasWaitRefreshAllTask = false

		TaskDispatcher.cancelTask(arg_6_0._onRunRefreshAllTask, arg_6_0)
	end
end

function var_0_0._onRunRefreshAllTask(arg_7_0)
	arg_7_0._isHasWaitRefreshAllTask = false

	arg_7_0:refreshAllCritterEntities()
end

function var_0_0.refreshAllCritterEntities(arg_8_0)
	local var_8_0 = RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob
	local var_8_1 = {}
	local var_8_2 = arg_8_0:getRoomCritterEntityDict()
	local var_8_3 = RoomCritterModel.instance

	for iter_8_0, iter_8_1 in pairs(var_8_2) do
		local var_8_4
		local var_8_5

		if var_8_0 then
			local var_8_6 = var_8_3:getCritterMOById(iter_8_1.id)

			if var_8_6 then
				var_8_4, var_8_5 = var_8_6:getStayBuilding()
			end
		end

		if var_8_4 and var_8_5 then
			local var_8_7 = arg_8_0._scene.buildingmgr:getBuildingEntity(var_8_4, SceneTag.RoomBuilding)

			if var_8_7 then
				local var_8_8 = var_8_7:getCritterPoint(var_8_5)

				if not gohelper.isNil(var_8_8) then
					local var_8_9, var_8_10, var_8_11 = transformhelper.getPos(var_8_8.transform)

					iter_8_1:setLocalPos(var_8_9, var_8_10, var_8_11)
					iter_8_1.critterspine:refreshAnimState()
				end
			end
		else
			var_8_1[#var_8_1 + 1] = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		arg_8_0:destroyCritter(iter_8_3)
	end

	if var_8_0 then
		local var_8_12 = var_8_3:getRoomBuildingCritterList() or {}

		for iter_8_4, iter_8_5 in ipairs(var_8_12) do
			local var_8_13 = iter_8_5:getId()

			if not arg_8_0:getCritterEntity(var_8_13) then
				arg_8_0:spawnRoomCritter(iter_8_5)
			end
		end
	end
end

function var_0_0.spawnRoomCritter(arg_9_0, arg_9_1)
	local var_9_0 = RoomController.instance:isObMode()
	local var_9_1 = RoomController.instance:isVisitMode()

	if not var_9_0 and not var_9_1 or not arg_9_1 then
		return
	end

	local var_9_2, var_9_3 = arg_9_1:getStayBuilding()

	if not var_9_2 or not var_9_3 then
		return
	end

	local var_9_4 = arg_9_0._scene.go.critterRoot
	local var_9_5 = gohelper.create3d(var_9_4, string.format("%s", arg_9_1.id))
	local var_9_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_5, RoomCritterEntity, arg_9_1.id)
	local var_9_7 = {
		z = 0,
		x = 0,
		y = 0
	}
	local var_9_8 = arg_9_0._scene.buildingmgr:getBuildingEntity(var_9_2, SceneTag.RoomBuilding)

	if var_9_8 then
		local var_9_9 = var_9_8:getCritterPoint(var_9_3)

		if not gohelper.isNil(var_9_9) then
			local var_9_10, var_9_11, var_9_12 = transformhelper.getPos(var_9_9.transform)

			var_9_7.x = var_9_10
			var_9_7.y = var_9_11
			var_9_7.z = var_9_12
		else
			logError(string.format("RoomSceneBuildingCritterMgr:spawnRoomCritter error, no critter point, buildingUid:%s,index:%s", var_9_2, var_9_3 + 1))
		end
	end

	var_9_6:setLocalPos(var_9_7.x, var_9_7.y, var_9_7.z)

	if arg_9_1:isRestingCritter() then
		var_9_6.critterspine:setScale(CritterEnum.CritterScaleInSeatSlot)
	end

	arg_9_0:addUnit(var_9_6)
	gohelper.addChild(var_9_4, var_9_5)

	return var_9_6
end

function var_0_0.refreshAllCritterEntityPos(arg_10_0)
	if not arg_10_0._scene then
		return
	end

	local var_10_0 = arg_10_0:getRoomCritterEntityDict()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_1 = iter_10_1:getMO()
		local var_10_2
		local var_10_3

		if var_10_1 then
			var_10_2, var_10_3 = var_10_1:getStayBuilding()
		end

		if not var_10_2 or not var_10_3 then
			return
		end

		local var_10_4 = arg_10_0._scene.buildingmgr:getBuildingEntity(var_10_2, SceneTag.RoomBuilding)
		local var_10_5 = var_10_4 and var_10_4:getCritterPoint(var_10_3)

		if gohelper.isNil(var_10_5) then
			return
		end

		local var_10_6, var_10_7, var_10_8 = transformhelper.getPos(var_10_5.transform)

		iter_10_1:setLocalPos(var_10_6, var_10_7, var_10_8)
	end
end

function var_0_0.refreshCritterPosByBuilding(arg_11_0, arg_11_1)
	if not arg_11_0._scene then
		return
	end

	local var_11_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_11_1)
	local var_11_1 = arg_11_0._scene.buildingmgr:getBuildingEntity(arg_11_1, SceneTag.RoomBuilding)

	if not var_11_1 or not var_11_0 then
		return
	end

	local var_11_2

	if ManufactureConfig.instance:isManufactureBuilding(var_11_0.buildingId) then
		local var_11_3 = ManufactureModel.instance:getManufactureMOById(arg_11_1)

		var_11_2 = var_11_3 and var_11_3:getSlot2CritterDict()
	else
		local var_11_4 = ManufactureModel.instance:getCritterBuildingMOById(arg_11_1)

		var_11_2 = var_11_4 and var_11_4:getSeatSlot2CritterDict()
	end

	if not var_11_2 then
		return
	end

	for iter_11_0, iter_11_1 in pairs(var_11_2) do
		local var_11_5 = arg_11_0:getCritterEntity(iter_11_1)
		local var_11_6 = var_11_1:getCritterPoint(iter_11_0)

		if not var_11_5 or gohelper.isNil(var_11_6) then
			return
		end

		local var_11_7, var_11_8, var_11_9 = transformhelper.getPos(var_11_6.transform)

		var_11_5:setLocalPos(var_11_7, var_11_8, var_11_9)
	end
end

function var_0_0.destroyCritter(arg_12_0, arg_12_1)
	arg_12_0:removeUnit(arg_12_1:getTag(), arg_12_1.id)
end

function var_0_0._onUpdate(arg_13_0)
	return
end

function var_0_0.getCritterEntity(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = (not arg_14_2 or arg_14_2 == SceneTag.RoomCharacter) and arg_14_0:getTagUnitDict(SceneTag.RoomCharacter)

	return var_14_0 and var_14_0[arg_14_1]
end

function var_0_0.getRoomCritterEntityDict(arg_15_0)
	return arg_15_0._tagUnitDict[SceneTag.RoomCharacter] or {}
end

function var_0_0.onSceneClose(arg_16_0)
	var_0_0.super.onSceneClose(arg_16_0)
	arg_16_0:removeEventListeners()
	arg_16_0:_stopRefreshAllTask()
end

return var_0_0
