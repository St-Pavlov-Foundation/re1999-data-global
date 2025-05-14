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

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	TaskDispatcher.runRepeat(arg_2_0._onUpdate, arg_2_0, 0.1)

	arg_2_0._buildingPosListMap = nil
end

function var_0_0._onUpdate(arg_3_0)
	if RoomController.instance:isEditMode() then
		return
	end

	arg_3_0:_updateEntityFovBlock()
end

function var_0_0._checkIsNeedUpdateBlock(arg_4_0)
	if arg_4_0:_getPlayingInteractionParam() then
		if arg_4_0._isCameraChange then
			return true
		end
	elseif not arg_4_0._lastOpenNum or arg_4_0._lastOpenNum == 0 then
		return true
	end

	return false
end

function var_0_0._updateEntityFovBlock(arg_5_0)
	if not arg_5_0:_getPlayingInteractionParam() and (not arg_5_0._lastOpenNum or arg_5_0._lastOpenNum == 0) then
		return
	end

	arg_5_0._lastOpenNum = 0

	local var_5_0 = GameSceneMgr.instance:getCurScene()
	local var_5_1 = RoomCharacterHelper.getAllBlockMeshRendererList()
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		table.insert(var_5_2, iter_5_1:GetInstanceID())
	end

	local var_5_3 = arg_5_0:_getBlockMeshRendererDict(var_5_1, var_5_2)
	local var_5_4
	local var_5_5 = arg_5_0._lastMeshReaderDic or {}
	local var_5_6 = {}

	arg_5_0._lastMeshReaderDic = var_5_6

	local var_5_7 = var_0_2._SCREENCOORD
	local var_5_8 = var_0_4.alphaThreshold

	for iter_5_2, iter_5_3 in ipairs(var_5_1) do
		local var_5_9 = var_5_2[iter_5_2]
		local var_5_10 = var_5_3[var_5_9]

		if var_5_10 and var_5_10 > 0 then
			arg_5_0._lastOpenNum = arg_5_0._lastOpenNum + 1

			if var_5_5[var_5_9] ~= var_5_10 then
				if not var_5_4 then
					var_5_4 = var_5_0.mapmgr:getPropertyBlock()

					var_5_4:Clear()
					var_5_4:SetFloat(var_5_8, var_5_10)
				end

				MaterialReplaceHelper.SetRendererKeyworld(iter_5_3, var_5_7, true)
				iter_5_3:SetPropertyBlock(var_5_4)
			end

			var_5_6[var_5_9] = var_5_10
		elseif var_5_5[var_5_9] then
			MaterialReplaceHelper.SetRendererKeyworld(iter_5_3, var_5_7, false)
			iter_5_3:SetPropertyBlock(nil)
		end
	end
end

function var_0_0._getBlockMeshRendererDict(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	if not RoomController.instance:isObMode() then
		return var_6_0
	end

	local var_6_1, var_6_2 = arg_6_0:_getPlayingInteractionParam()

	if not var_6_1 then
		return var_6_0
	end

	local var_6_3 = {}

	arg_6_0:_addBlockPositionById(var_6_2, var_6_1, var_6_3)

	if #arg_6_1 <= 0 or #var_6_3 <= 0 then
		return var_6_0
	end

	local var_6_4 = arg_6_0._scene.camera:getCameraPosition()
	local var_6_5 = {}
	local var_6_6 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_3) do
		local var_6_7 = RoomBendingHelper.worldToBendingSimple(iter_6_1)
		local var_6_8 = Vector3.Distance(var_6_4, var_6_7)
		local var_6_9 = Vector3.Normalize(var_6_7 - var_6_4)
		local var_6_10 = Ray(var_6_9, var_6_4)

		table.insert(var_6_5, var_6_10)
		table.insert(var_6_6, var_6_8)
	end

	local var_6_11

	if var_0_1.Hero == var_6_2 then
		var_6_11 = var_6_1.buildingUid
	elseif var_0_1.Building == var_6_2 then
		var_6_11 = var_6_1
	end

	if #var_6_5 > 0 then
		local var_6_12 = {}

		arg_6_0:_addBuildingMeshRendererIdDict(var_6_11, var_6_12)

		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			local var_6_13 = arg_6_2[iter_6_2]

			if not var_6_12[var_6_13] and RoomCharacterHelper.isBlockCharacter(var_6_5, var_6_6, iter_6_3) then
				var_6_0[var_6_13] = 0.6
			end
		end
	end

	return var_6_0
end

function var_0_0._addBlockPositionById(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._blockTypeFuncMap then
		arg_7_0._blockTypeFuncMap = {
			[var_0_1.Hero] = arg_7_0._addHeroPosFunc,
			[var_0_1.Building] = arg_7_0._addBuildingPosFunc,
			[var_0_1.Vehicle] = arg_7_0._addVehiclePosFunc
		}
	end

	local var_7_0 = arg_7_0._blockTypeFuncMap[arg_7_1]

	if var_7_0 then
		var_7_0(arg_7_0, arg_7_2, arg_7_3)
	end
end

function var_0_0._addVehiclePosFunc(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._scene.vehiclemgr:getVehicleEntity(arg_8_1)

	if var_8_0 then
		local var_8_1, var_8_2, var_8_3 = transformhelper.getPos(var_8_0.goTrs)

		table.insert(arg_8_2, Vector3(var_8_1, var_8_2, var_8_3))

		local var_8_4, var_8_5, var_8_6 = var_8_0.cameraFollowTargetComp:getPositionXYZ()

		table.insert(arg_8_2, Vector3(var_8_4, var_8_5, var_8_6))
	end
end

function var_0_0._addBuildingPosFunc(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._buildingPosListMap = arg_9_0._buildingPosListMap or {}

	local var_9_0 = arg_9_0._buildingPosListMap[arg_9_1]

	if not var_9_0 then
		var_9_0 = {}
		arg_9_0._buildingPosListMap[arg_9_1] = var_9_0

		local var_9_1 = arg_9_0._scene.buildingmgr:getBuildingEntity(arg_9_1, SceneTag.RoomBuilding)

		if var_9_1 then
			local var_9_2 = var_9_1:getBodyGO()

			if var_9_2 then
				local var_9_3, var_9_4, var_9_5 = transformhelper.getPos(var_9_2.transform)

				table.insert(var_9_0, Vector3(var_9_3, var_9_4, var_9_5))
			end
		end

		local var_9_6 = RoomMapBuildingModel.instance:getBuildingMOById(arg_9_1)
		local var_9_7 = var_9_6 and RoomMapModel.instance:getBuildingPointList(var_9_6.buildingId, var_9_6.rotate)

		if var_9_7 and var_9_6 then
			for iter_9_0, iter_9_1 in ipairs(var_9_7) do
				local var_9_8, var_9_9 = HexMath.hexXYToPosXY(iter_9_1.x + var_9_6.hexPoint.x, iter_9_1.y + var_9_6.hexPoint.y, RoomBlockEnum.BlockSize)

				table.insert(var_9_0, Vector3(var_9_8, 0.11, var_9_9))
			end
		end
	end

	tabletool.addValues(arg_9_2, var_9_0)
end

function var_0_0._addHeroPosFunc(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_addCharacterPosById(arg_10_1.heroId, arg_10_2)
	arg_10_0:_addCharacterPosById(arg_10_1.relateHeroId, arg_10_2)
end

function var_0_0._addCharacterPosById(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._scene.charactermgr:getCharacterEntity(arg_11_1, SceneTag.RoomCharacter)

	if var_11_0 then
		local var_11_1, var_11_2, var_11_3 = transformhelper.getPos(var_11_0.goTrs)

		table.insert(arg_11_2, Vector3(var_11_1, var_11_2, var_11_3))
	end
end

function var_0_0._addBuildingMeshRendererIdDict(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._scene.buildingmgr:getBuildingEntity(arg_12_1, SceneTag.RoomBuilding)
	local var_12_1 = var_12_0 and var_12_0:getCharacterMeshRendererList()

	if var_12_1 then
		for iter_12_0, iter_12_1 in ipairs(var_12_1) do
			arg_12_2[iter_12_1:GetInstanceID()] = true
		end
	end
end

function var_0_0._getPlayingInteractionParam(arg_13_0)
	local var_13_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if var_13_0 == nil then
		var_13_0 = RoomCritterController.instance:getPlayingInteractionParam()
	end

	if var_13_0 == nil then
		local var_13_1 = arg_13_0._scene.camera:getCameraState()

		if arg_13_0._lookCaneraState == var_13_1 then
			return arg_13_0._lookEntityUid, arg_13_0._lookLockType
		end
	end

	return var_13_0, var_0_1.Hero
end

function var_0_0.setLookBuildingUid(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._buildingPosListMap and arg_14_2 then
		arg_14_0._buildingPosListMap[arg_14_2] = nil
	end

	arg_14_0:_setLookEntityUid(arg_14_1, arg_14_2, var_0_1.Building)
end

function var_0_0.setLookVehicleUid(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:_setLookEntityUid(arg_15_1, arg_15_2, var_0_1.Vehicle)
end

function var_0_0.clearLookParam(arg_16_0)
	arg_16_0:_setLookEntityUid(nil, nil, nil)
end

function var_0_0._setLookEntityUid(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._lookCaneraState = arg_17_1
	arg_17_0._lookEntityUid = arg_17_2
	arg_17_0._lookLockType = arg_17_3
end

function var_0_0.onSceneClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._onUpdate, arg_18_0)
	arg_18_0:_setLookEntityUid(nil, nil, nil)
end

return var_0_0
