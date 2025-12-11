module("modules.logic.scene.room.comp.RoomSceneCameraFOVBlockComp", package.seeall)

local var_0_0 = class("RoomSceneCameraFOVBlockComp", BaseSceneComp)
local var_0_1 = {
	Building = 2,
	Hero = 1,
	Vehicle = 3
}
local var_0_2 = {
	_SCREENCOORD = "_SCREENCOORD"
}
local var_0_3 = UnityEngine.Shader
local var_0_4 = {
	alphaThreshold = var_0_3.PropertyToID("_AlphaThreshold")
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._v3PoolList = {}
	arg_1_0._meshReaderBoundsCacheDict = {}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._scene = arg_3_0:getCurScene()

	TaskDispatcher.runRepeat(arg_3_0._onUpdate, arg_3_0, 0.1)

	arg_3_0._buildingPosListMap = nil
end

function var_0_0._onUpdate(arg_4_0)
	if RoomController.instance:isEditMode() then
		return
	end

	arg_4_0:_updateEntityFovBlock()
end

function var_0_0._checkIsNeedUpdateBlock(arg_5_0)
	if arg_5_0:_getPlayingInteractionParam() then
		if arg_5_0._isCameraChange then
			return true
		end
	elseif not arg_5_0._lastOpenNum or arg_5_0._lastOpenNum == 0 then
		return true
	end

	return false
end

function var_0_0._updateEntityFovBlock(arg_6_0)
	if not arg_6_0:_getPlayingInteractionParam() and (not arg_6_0._lastOpenNum or arg_6_0._lastOpenNum == 0) then
		return
	end

	arg_6_0._lastOpenNum = 0

	local var_6_0 = GameSceneMgr.instance:getCurScene()
	local var_6_1 = RoomCharacterHelper.getAllBlockMeshRendererList()
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		table.insert(var_6_2, iter_6_1:GetInstanceID())
	end

	local var_6_3 = arg_6_0:_getBlockMeshRendererDict(var_6_1, var_6_2)
	local var_6_4
	local var_6_5 = arg_6_0._lastMeshReaderDic or {}
	local var_6_6 = {}

	arg_6_0._lastMeshReaderDic = var_6_6

	local var_6_7 = var_0_2._SCREENCOORD
	local var_6_8 = var_0_4.alphaThreshold

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		local var_6_9 = var_6_2[iter_6_2]
		local var_6_10 = var_6_3[var_6_9]

		if var_6_10 and var_6_10 > 0 then
			arg_6_0._lastOpenNum = arg_6_0._lastOpenNum + 1

			if var_6_5[var_6_9] ~= var_6_10 then
				if not var_6_4 then
					var_6_4 = var_6_0.mapmgr:getPropertyBlock()

					var_6_4:Clear()
					var_6_4:SetFloat(var_6_8, var_6_10)
				end

				MaterialReplaceHelper.SetRendererKeyworld(iter_6_3, var_6_7, true)
				iter_6_3:SetPropertyBlock(var_6_4)
			end

			var_6_6[var_6_9] = var_6_10
		elseif var_6_5[var_6_9] then
			MaterialReplaceHelper.SetRendererKeyworld(iter_6_3, var_6_7, false)
			iter_6_3:SetPropertyBlock(nil)
		end
	end
end

local var_0_5 = {}

function var_0_0._getBlockMeshRendererDict(arg_7_0, arg_7_1, arg_7_2)
	if not RoomController.instance:isObMode() then
		return var_0_5
	end

	local var_7_0, var_7_1 = arg_7_0:_getPlayingInteractionParam()

	if not var_7_0 then
		return var_0_5
	end

	local var_7_2 = {}

	arg_7_0:_addBlockPositionById(var_7_1, var_7_0, var_7_2)

	if #arg_7_1 <= 0 or #var_7_2 <= 0 then
		return var_0_5
	end

	local var_7_3 = arg_7_0._scene.camera:getCameraPosition()
	local var_7_4 = {}
	local var_7_5 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_2) do
		local var_7_6 = RoomBendingHelper.worldToBendingSimple(iter_7_1)
		local var_7_7 = Vector3.Distance(var_7_3, var_7_6)
		local var_7_8 = Vector3.Normalize(var_7_6 - var_7_3)
		local var_7_9 = Ray(var_7_8, var_7_3)

		table.insert(var_7_4, var_7_9)
		table.insert(var_7_5, var_7_7)
	end

	arg_7_0:_pushVector3List(var_7_2)

	local var_7_10

	if var_0_1.Hero == var_7_1 then
		var_7_10 = var_7_0.buildingUid
	elseif var_0_1.Building == var_7_1 then
		var_7_10 = var_7_0
	end

	arg_7_0._blockMeshRendererInstanceIdDict = arg_7_0._blockMeshRendererInstanceIdDict or {}

	local var_7_11 = arg_7_0._blockMeshRendererInstanceIdDict
	local var_7_12 = arg_7_0._meshReaderBoundsCacheDict

	if #var_7_4 > 0 then
		local var_7_13 = {}
		local var_7_14 = Time.time

		arg_7_0:_addBuildingMeshRendererIdDict(var_7_10, var_7_13)

		for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
			local var_7_15 = arg_7_2[iter_7_2]
			local var_7_16 = var_7_12[var_7_15]

			if not var_7_16 then
				local var_7_17 = iter_7_3.bounds

				var_7_16 = {
					bounds = var_7_17,
					extents = var_7_17.extents,
					center = var_7_17.center
				}
				var_7_12[var_7_15] = var_7_16
			end

			if not var_7_13[var_7_15] and RoomCharacterHelper.isBlockCharacter(var_7_4, var_7_5, var_7_16) then
				var_7_11[var_7_15] = 0.6
			else
				var_7_11[var_7_15] = 0
			end
		end

		for iter_7_4, iter_7_5 in ipairs(var_7_4) do
			rawset(var_7_4, iter_7_4, nil)
		end
	end

	return var_7_11
end

function var_0_0._addBlockPositionById(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0._blockTypeFuncMap then
		arg_8_0._blockTypeFuncMap = {
			[var_0_1.Hero] = arg_8_0._addHeroPosFunc,
			[var_0_1.Building] = arg_8_0._addBuildingPosFunc,
			[var_0_1.Vehicle] = arg_8_0._addVehiclePosFunc
		}
	end

	local var_8_0 = arg_8_0._blockTypeFuncMap[arg_8_1]

	if var_8_0 then
		var_8_0(arg_8_0, arg_8_2, arg_8_3)
	end
end

function var_0_0._addVehiclePosFunc(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._scene.vehiclemgr:getVehicleEntity(arg_9_1)

	if var_9_0 then
		local var_9_1, var_9_2, var_9_3 = transformhelper.getPos(var_9_0.goTrs)

		table.insert(arg_9_2, arg_9_0:_popVector3(var_9_1, var_9_2, var_9_3))

		local var_9_4, var_9_5, var_9_6 = var_9_0.cameraFollowTargetComp:getPositionXYZ()

		table.insert(arg_9_2, arg_9_0:_popVector3(var_9_4, var_9_5, var_9_6))
	end
end

function var_0_0._popVector3(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0
	local var_10_1 = #arg_10_0._v3PoolList

	if var_10_1 > 0 then
		local var_10_2 = arg_10_0._v3PoolList[var_10_1]

		table.remove(arg_10_0._v3PoolList, var_10_1)
		var_10_2:Set(arg_10_1, arg_10_2, arg_10_3)

		return var_10_2
	end

	return Vector3(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0._pushVector3List(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		table.insert(arg_11_0._v3PoolList, iter_11_1)
	end
end

function var_0_0._addBuildingPosFunc(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._buildingPosListMap = arg_12_0._buildingPosListMap or {}

	local var_12_0 = arg_12_0._buildingPosListMap[arg_12_1]

	if not var_12_0 then
		var_12_0 = {}
		arg_12_0._buildingPosListMap[arg_12_1] = var_12_0

		local var_12_1 = arg_12_0._scene.buildingmgr:getBuildingEntity(arg_12_1, SceneTag.RoomBuilding)

		if var_12_1 then
			local var_12_2 = var_12_1:getBodyGO()

			if var_12_2 then
				local var_12_3, var_12_4, var_12_5 = transformhelper.getPos(var_12_2.transform)

				table.insert(var_12_0, arg_12_0:_popVector3(var_12_3, var_12_4, var_12_5))
			end
		end

		local var_12_6 = RoomMapBuildingModel.instance:getBuildingMOById(arg_12_1)
		local var_12_7 = var_12_6 and RoomMapModel.instance:getBuildingPointList(var_12_6.buildingId, var_12_6.rotate)

		if var_12_7 and var_12_6 then
			for iter_12_0, iter_12_1 in ipairs(var_12_7) do
				local var_12_8, var_12_9 = HexMath.hexXYToPosXY(iter_12_1.x + var_12_6.hexPoint.x, iter_12_1.y + var_12_6.hexPoint.y, RoomBlockEnum.BlockSize)

				table.insert(var_12_0, arg_12_0:_popVector3(var_12_8, 0.11, var_12_9))
			end
		end
	end

	tabletool.addValues(arg_12_2, var_12_0)
end

function var_0_0._addHeroPosFunc(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_addCharacterPosById(arg_13_1.heroId, arg_13_2)
	arg_13_0:_addCharacterPosById(arg_13_1.relateHeroId, arg_13_2)
end

function var_0_0._addCharacterPosById(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._scene.charactermgr:getCharacterEntity(arg_14_1, SceneTag.RoomCharacter)

	if var_14_0 then
		local var_14_1, var_14_2, var_14_3 = transformhelper.getPos(var_14_0.goTrs)

		table.insert(arg_14_2, arg_14_0:_popVector3(var_14_1, var_14_2, var_14_3))
	end
end

function var_0_0._addBuildingMeshRendererIdDict(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._scene.buildingmgr:getBuildingEntity(arg_15_1, SceneTag.RoomBuilding)
	local var_15_1 = var_15_0 and var_15_0:getCharacterMeshRendererList()

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			arg_15_2[iter_15_1:GetInstanceID()] = true
		end
	end
end

function var_0_0._getPlayingInteractionParam(arg_16_0)
	local var_16_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if var_16_0 == nil then
		var_16_0 = RoomCritterController.instance:getPlayingInteractionParam()
	end

	if var_16_0 == nil then
		local var_16_1 = arg_16_0._scene.camera:getCameraState()

		if arg_16_0._lookCaneraState == var_16_1 then
			return arg_16_0._lookEntityUid, arg_16_0._lookLockType
		end
	end

	return var_16_0, var_0_1.Hero
end

function var_0_0.setLookBuildingUid(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._buildingPosListMap and arg_17_2 then
		arg_17_0._buildingPosListMap[arg_17_2] = nil
	end

	arg_17_0:_setLookEntityUid(arg_17_1, arg_17_2, var_0_1.Building)
end

function var_0_0.setLookVehicleUid(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:_setLookEntityUid(arg_18_1, arg_18_2, var_0_1.Vehicle)
end

function var_0_0.clearLookParam(arg_19_0)
	arg_19_0:_setLookEntityUid(nil, nil, nil)
end

function var_0_0._setLookEntityUid(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._lookCaneraState = arg_20_1
	arg_20_0._lookEntityUid = arg_20_2
	arg_20_0._lookLockType = arg_20_3
end

function var_0_0.onSceneClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onUpdate, arg_21_0)
	arg_21_0:_setLookEntityUid(nil, nil, nil)

	local var_21_0 = arg_21_0._meshReaderBoundsCacheDict

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1) do
			rawset(iter_21_1, iter_21_2, nil)
		end

		rawset(var_21_0, iter_21_0, nil)
	end
end

return var_0_0
