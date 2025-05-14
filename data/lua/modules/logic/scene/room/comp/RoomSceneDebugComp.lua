module("modules.logic.scene.room.comp.RoomSceneDebugComp", package.seeall)

local var_0_0 = class("RoomSceneDebugComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	if RoomController.instance:isDebugMode() then
		RoomDebugController.instance:registerCallback(RoomEvent.DebugConfirmPlaceBlock, arg_2_0._debugConfirmPlaceBlock, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBlock, arg_2_0._debugRotateBlock, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, arg_2_0._debugRootOutBlock, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, arg_2_0._debugReplaceBlock, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, arg_2_0._debugSetPackage, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceBuilding, arg_2_0._debugPlaceBuilding, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRotateBuilding, arg_2_0._debugRotateBuilding, arg_2_0)
		RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBuilding, arg_2_0._debugRootOutBuilding, arg_2_0)
	end

	if isDebugBuild then
		TaskDispatcher.runRepeat(arg_2_0._onFrame, arg_2_0, 0.01)
	end
end

function var_0_0._onFrame(arg_3_0)
	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.S) then
		local var_3_0 = RoomMapBlockModel.instance:getConfirmBlockCount()

		logNormal(string.format("一共放置了%d个地块", var_3_0))
	end
end

function var_0_0._debugConfirmPlaceBlock(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0._scene.mapmgr:getBlockEntity(arg_4_3 and arg_4_3.id, SceneTag.RoomEmptyBlock)

	if var_4_0 then
		arg_4_0._scene.mapmgr:destroyBlock(var_4_0)
	end

	local var_4_1 = arg_4_0._scene.mapmgr:spawnMapBlock(arg_4_2)
	local var_4_2 = RoomBlockHelper.getNearBlockEntity(false, arg_4_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_4_2, "refreshBlock")

	local var_4_3 = RoomBlockHelper.getNearBlockEntity(true, arg_4_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_4_3, "refreshWaveEffect")

	local var_4_4 = arg_4_2.hexPoint:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for iter_4_0, iter_4_1 in ipairs(var_4_4) do
		local var_4_5 = RoomMapBlockModel.instance:getBlockMO(iter_4_1.x, iter_4_1.y)

		if var_4_5 and var_4_5.blockState == RoomBlockEnum.BlockState.Water and not arg_4_0._scene.mapmgr:getBlockEntity(var_4_5.id, SceneTag.RoomEmptyBlock) then
			local var_4_6 = arg_4_0._scene.mapmgr:spawnMapBlock(var_4_5)
		end
	end
end

function var_0_0._debugRotateBlock(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._scene.mapmgr:getBlockEntity(arg_5_2.id, SceneTag.RoomMapBlock)

	if var_5_0 then
		var_5_0:refreshRotation()
		var_5_0:refreshBlock()
	end

	local var_5_1 = RoomBlockHelper.getNearBlockEntity(false, arg_5_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_5_1, "refreshBlock")
end

function var_0_0._debugRootOutBlock(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0._scene.mapmgr:getBlockEntity(arg_6_2.id, SceneTag.RoomMapBlock)

	if var_6_0 then
		arg_6_0._scene.mapmgr:destroyBlock(var_6_0)
	end

	local var_6_1 = RoomMapBlockModel.instance:getBlockMO(arg_6_1.x, arg_6_1.y)

	if var_6_1 and var_6_1.blockState == RoomBlockEnum.BlockState.Water and not arg_6_0._scene.mapmgr:getBlockEntity(var_6_1.id, SceneTag.RoomEmptyBlock) then
		local var_6_2 = arg_6_0._scene.mapmgr:spawnMapBlock(var_6_1)
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
		local var_6_3 = arg_6_0._scene.mapmgr:getBlockEntity(iter_6_1.id, SceneTag.RoomEmptyBlock)

		if var_6_3 then
			arg_6_0._scene.mapmgr:destroyBlock(var_6_3)
		end
	end

	local var_6_4 = RoomBlockHelper.getNearBlockEntity(false, arg_6_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_6_4, "refreshBlock")

	local var_6_5 = RoomBlockHelper.getNearBlockEntity(true, arg_6_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_6_5, "refreshWaveEffect")
end

function var_0_0._debugReplaceBlock(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._scene.mapmgr:getBlockEntity(arg_7_2.id, SceneTag.RoomMapBlock)

	if var_7_0 then
		var_7_0:refreshBlock()
	end

	local var_7_1 = RoomBlockHelper.getNearBlockEntity(false, arg_7_1, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_7_1, "refreshBlock")
end

function var_0_0._debugSetPackage(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_0._scene.mapmgr:getBlockEntity(arg_8_2.id, SceneTag.RoomMapBlock)

	if var_8_0 then
		var_8_0:refreshPackage()
	end

	RoomDebugPackageListModel.instance:setDebugPackageList()
end

function var_0_0._debugPlaceBuilding(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._scene.buildingmgr:spawnMapBuilding(arg_9_2)
	local var_9_1 = RoomBlockHelper.getNearBlockEntityByBuilding(false, arg_9_2.buildingId, arg_9_2.hexPoint, arg_9_2.rotate)

	RoomBlockHelper.refreshBlockResourceType(var_9_1)
	RoomBlockHelper.refreshBlockEntity(var_9_1, "refreshBlock")

	local var_9_2 = RoomBlockHelper.getNearBlockEntityByBuilding(true, arg_9_2.buildingId, arg_9_2.hexPoint, arg_9_2.rotate)

	RoomBlockHelper.refreshBlockEntity(var_9_2, "refreshWaveEffect")
end

function var_0_0._debugRotateBuilding(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._scene.buildingmgr:getBuildingEntity(arg_10_2.id, SceneTag.RoomBuilding)

	if var_10_0 then
		var_10_0:refreshRotation()
	end

	local var_10_1 = RoomBlockHelper.getNearBlockEntityByBuilding(false, arg_10_2.buildingId, arg_10_2.hexPoint, arg_10_3)

	RoomBlockHelper.refreshBlockResourceType(var_10_1)
	RoomBlockHelper.refreshBlockEntity(var_10_1, "refreshBlock")

	local var_10_2 = RoomBlockHelper.getNearBlockEntityByBuilding(true, arg_10_2.buildingId, arg_10_2.hexPoint, arg_10_3)

	RoomBlockHelper.refreshBlockEntity(var_10_2, "refreshWaveEffect")

	local var_10_3 = RoomBlockHelper.getNearBlockEntityByBuilding(false, arg_10_2.buildingId, arg_10_2.hexPoint, arg_10_2.rotate)

	RoomBlockHelper.refreshBlockResourceType(var_10_3)
	RoomBlockHelper.refreshBlockEntity(var_10_3, "refreshBlock")

	local var_10_4 = RoomBlockHelper.getNearBlockEntityByBuilding(true, arg_10_2.buildingId, arg_10_2.hexPoint, arg_10_2.rotate)

	RoomBlockHelper.refreshBlockEntity(var_10_4, "refreshWaveEffect")
end

function var_0_0._debugRootOutBuilding(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._scene.buildingmgr:getBuildingEntity(arg_11_2.id, SceneTag.RoomBuilding)

	if var_11_0 then
		arg_11_0._scene.buildingmgr:destroyBuilding(var_11_0)
	end

	local var_11_1 = RoomBlockHelper.getNearBlockEntityByBuilding(false, arg_11_2.buildingId, arg_11_2.hexPoint, arg_11_2.rotate)

	RoomBlockHelper.refreshBlockResourceType(var_11_1)
	RoomBlockHelper.refreshBlockEntity(var_11_1, "refreshBlock")

	local var_11_2 = RoomBlockHelper.getNearBlockEntityByBuilding(true, arg_11_2.buildingId, arg_11_2.hexPoint, arg_11_2.rotate)

	RoomBlockHelper.refreshBlockEntity(var_11_2, "refreshWaveEffect")
end

function var_0_0.onSceneClose(arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugConfirmPlaceBlock, arg_12_0._debugConfirmPlaceBlock, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBlock, arg_12_0._debugRotateBlock, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, arg_12_0._debugRootOutBlock, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, arg_12_0._debugReplaceBlock, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, arg_12_0._debugSetPackage, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceBuilding, arg_12_0._debugPlaceBuilding, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRotateBuilding, arg_12_0._debugRotateBuilding, arg_12_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBuilding, arg_12_0._debugRootOutBuilding, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onFrame, arg_12_0)
end

return var_0_0
