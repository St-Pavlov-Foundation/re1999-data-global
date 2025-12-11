module("modules.logic.scene.room.comp.entitymgr.RoomSceneBuildingEntityMgr", package.seeall)

local var_0_0 = class("RoomSceneBuildingEntityMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	arg_2_0:_spawnInitBuilding()
	arg_2_0:_spawnPartBuilding()

	local var_2_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.buildingType ~= RoomBuildingEnum.BuildingType.Transport then
			arg_2_0:spawnMapBuilding(iter_2_1)
		end
	end

	for iter_2_2 = 1, RoomBuildingEnum.MaxBuildingOccupyNum do
		arg_2_0:spawnMapBuildingOccupy(iter_2_2)
	end
end

function var_0_0._spawnInitBuilding(arg_3_0)
	if FishingModel.instance:isInFishing() then
		return
	end

	local var_3_0 = arg_3_0:getUnit(SceneTag.RoomInitBuilding, 0)

	if not var_3_0 then
		local var_3_1 = arg_3_0._scene.go.initbuildingRoot
		local var_3_2 = gohelper.findChild(var_3_1, "main")
		local var_3_3 = gohelper.create3d(var_3_2, "initbuilding")

		var_3_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_3, RoomInitBuildingEntity, 0)

		arg_3_0:addUnit(var_3_0)
		gohelper.addChild(var_3_2, var_3_3)
		transformhelper.setLocalPos(var_3_3.transform, 0, 0, 0)

		arg_3_0._initBuildingGO = var_3_3
	end

	var_3_0:refreshBuilding()
end

function var_0_0._spawnPartBuilding(arg_4_0)
	if FishingModel.instance:isInFishing() then
		return
	end

	arg_4_0._partBuildingGODict = arg_4_0._partBuildingGODict or {}

	for iter_4_0, iter_4_1 in ipairs(lua_production_part.configList) do
		local var_4_0 = iter_4_1.id
		local var_4_1 = arg_4_0:getUnit(SceneTag.RoomPartBuilding, var_4_0)

		if not var_4_1 then
			local var_4_2 = arg_4_0:getPartContainerGO(var_4_0)
			local var_4_3 = gohelper.create3d(var_4_2, "partbuilding")

			var_4_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, RoomPartBuildingEntity, var_4_0)

			arg_4_0:addUnit(var_4_1)
			gohelper.addChild(var_4_2, var_4_3)
			transformhelper.setLocalPos(var_4_3.transform, 0, 0, 0)

			arg_4_0._partBuildingGODict[var_4_0] = var_4_3
		end

		var_4_1:refreshBuilding()
	end
end

function var_0_0.spawnMapBuilding(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._scene.go.buildingRoot
	local var_5_1 = arg_5_1.hexPoint

	if not var_5_1 then
		logError("RoomSceneBuildingEntityMgr: 没有位置信息")

		return
	end

	local var_5_2 = HexMath.hexToPosition(var_5_1, RoomBlockEnum.BlockSize)
	local var_5_3 = arg_5_0:getBuildingEntity(arg_5_1.id, SceneTag.RoomBuilding)

	if not var_5_3 then
		local var_5_4 = gohelper.create3d(var_5_0, RoomResHelper.getBlockName(var_5_1))

		var_5_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_4, RoomBuildingEntity, arg_5_1.id)

		arg_5_0:addUnit(var_5_3)
		gohelper.addChild(var_5_0, var_5_4)
	end

	var_5_3:setLocalPos(var_5_2.x, 0, var_5_2.y)
	var_5_3:refreshBuilding()
	var_5_3:refreshRotation()

	return var_5_3
end

function var_0_0.spawnMapBuildingOccupy(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getBuildingOccupy(arg_6_1)

	if not var_6_0 then
		local var_6_1 = arg_6_0._scene.go.buildingRoot
		local var_6_2 = gohelper.create3d(var_6_1, "BuildingOccupy_" .. arg_6_1)

		gohelper.addChild(var_6_1, var_6_2)

		var_6_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, RoomBuildingOccupyEntity, arg_6_1)

		arg_6_0:addUnit(var_6_0)
	end

	return var_6_0
end

function var_0_0.onSwitchMode(arg_7_0)
	local var_7_0 = arg_7_0:getMapBuildingEntityDict()

	if var_7_0 then
		local var_7_1 = RoomMapBuildingModel.instance
		local var_7_2 = SceneTag.RoomBuilding
		local var_7_3 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if not var_7_1:getBuildingMOById(iter_7_0) then
				table.insert(var_7_3, iter_7_0)
			end
		end

		for iter_7_2 = 1, #var_7_3 do
			arg_7_0:removeUnit(var_7_2, var_7_3[iter_7_2])
		end
	end

	if FishingModel.instance:isInFishing() then
		arg_7_0:removeUnits(SceneTag.RoomInitBuilding)
		arg_7_0:removeUnits(SceneTag.RoomPartBuilding)
	end
end

function var_0_0.getBuildingOccupy(arg_8_0, arg_8_1)
	return arg_8_0:getUnit(RoomBuildingOccupyEntity:getTag(), arg_8_1)
end

function var_0_0.refreshAllBlockEntity(arg_9_0)
	local var_9_0 = arg_9_0:getTagUnitDict(SceneTag.RoomBuilding)

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			local var_9_1 = iter_9_1:getMO()
			local var_9_2 = HexMath.hexToPosition(var_9_1.hexPoint, RoomBlockEnum.BlockSize)

			iter_9_1:setLocalPos(var_9_2.x, 0, var_9_2.y)
			iter_9_1:refreshBuilding()
			iter_9_1:refreshRotation()
		end
	end
end

function var_0_0.moveTo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = HexMath.hexToPosition(arg_10_2, RoomBlockEnum.BlockSize)

	arg_10_1:setLocalPos(var_10_0.x, 0, var_10_0.y)
end

function var_0_0.destroyBuilding(arg_11_0, arg_11_1)
	arg_11_0:removeUnit(arg_11_1:getTag(), arg_11_1.id)
end

function var_0_0.getBuildingEntity(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = (not arg_12_2 or arg_12_2 == SceneTag.RoomBuilding) and arg_12_0:getTagUnitDict(SceneTag.RoomBuilding)

	return var_12_0 and var_12_0[arg_12_1]
end

function var_0_0.changeBuildingEntityId(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 and arg_13_1 ~= arg_13_2 then
		local var_13_0 = arg_13_0:getMapBuildingEntityDict()

		if var_13_0 and var_13_0[arg_13_1] and not var_13_0[arg_13_2] then
			local var_13_1 = var_13_0[arg_13_1]

			var_13_0[arg_13_2] = var_13_1
			var_13_0[arg_13_1] = nil

			var_13_1:setEntityId(arg_13_2)
		end
	end
end

function var_0_0.getMapBuildingEntityDict(arg_14_0)
	return arg_14_0._tagUnitDict[SceneTag.RoomBuilding]
end

function var_0_0.getInitBuildingGO(arg_15_0)
	return arg_15_0._initBuildingGO
end

function var_0_0.getPartBuildingGO(arg_16_0, arg_16_1)
	return arg_16_0._partBuildingGODict and arg_16_0._partBuildingGODict[arg_16_1]
end

function var_0_0.getPartContainerGO(arg_17_0, arg_17_1)
	if arg_17_0._scene then
		return arg_17_0._scene.go:getPartGOById(arg_17_1)
	end
end

function var_0_0.onSceneClose(arg_18_0)
	var_0_0.super.onSceneClose(arg_18_0)

	arg_18_0._initBuildingGO = nil
	arg_18_0._partBuildingGODict = nil
end

return var_0_0
