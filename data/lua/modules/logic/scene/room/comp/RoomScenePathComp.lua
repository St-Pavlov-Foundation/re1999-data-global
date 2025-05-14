module("modules.logic.scene.room.comp.RoomScenePathComp", package.seeall)

local var_0_0 = class("RoomScenePathComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	if RoomEnum.UseAStarPath then
		if RoomEnum.MeshUseOptimize then
			local var_2_0, var_2_1, var_2_2, var_2_3 = RoomMapBlockModel.instance:getFullMapSizeAndCenter()

			ZProj.AStarPathBridge.ScanAStarMesh(var_2_0, var_2_1, var_2_2, var_2_3)
		else
			ZProj.AStarPathBridge.ScanAStarMesh()
		end
	end

	arg_2_0._isInited = true
end

function var_0_0.tryGetPath(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	local var_3_0 = arg_3_0._scene.charactermgr:getCharacterEntity(arg_3_1.id)

	if not var_3_0 then
		return
	end

	local var_3_1 = var_3_0.charactermove:getSeeker()

	if not var_3_1 then
		return
	end

	var_3_1:RemoveOnPathCall()
	var_3_1:AddOnPathCall(arg_3_4, arg_3_5, arg_3_6)
	var_3_1:StartPath(arg_3_2, arg_3_3)
end

function var_0_0.stopGetPath(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._scene.charactermgr:getCharacterEntity(arg_4_1.id)

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.charactermove:getSeeker()

	if not var_4_1 then
		return
	end

	var_4_1:RemoveOnPathCall()
end

function var_0_0.updatePathGraphic(arg_5_0, arg_5_1)
	if not arg_5_0._isInited then
		return
	end

	ZProj.AStarPathBridge.UpdateColliderGrid(arg_5_1, GameSceneMgr.instance:isLoading() and 0 or 0.1)
	RoomCharacterModel.instance:clearNodePositionList()
end

function var_0_0.addPathCollider(arg_6_0, arg_6_1)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		arg_6_0._needPathGOs = arg_6_0._needPathGOs or {}

		table.insert(arg_6_0._needPathGOs, arg_6_1)

		return
	end

	if not gohelper.isNil(arg_6_1) then
		local var_6_0 = {}

		ZProj.AStarPathBridge.FindChildrenByName(arg_6_1, "#collider", var_6_0)

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			gohelper.setLayer(iter_6_1, UnityLayer.Scene, true)
			arg_6_0:updatePathGraphic(iter_6_1)
		end
	end
end

function var_0_0.doNeedPathGOs(arg_7_0)
	if arg_7_0._needPathGOs then
		local var_7_0 = tabletool.copy(arg_7_0._needPathGOs)

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if not gohelper.isNil(iter_7_1) then
				arg_7_0:addPathCollider(iter_7_1)
			end
		end
	end

	arg_7_0._needPathGOs = nil
end

function var_0_0.onSceneClose(arg_8_0)
	arg_8_0._isInited = false
	arg_8_0._needPathGOs = nil

	if RoomEnum.UseAStarPath then
		ZProj.AStarPathBridge.StopScan()
	end

	RoomVectorPool.instance:clean()
	ZProj.AStarPathBridge.CleanCache()
end

function var_0_0.addEntityCollider(arg_9_0)
	if not RoomEnum.UseAStarPath then
		return
	end

	local var_9_0 = GameSceneMgr.instance:getCurScene()

	if var_9_0.path and not gohelper.isNil(arg_9_0) then
		var_9_0.path:addPathCollider(arg_9_0)
	end
end

function var_0_0.getNearestNodeHeight(arg_10_0, arg_10_1)
	if not RoomEnum.UseAStarPath or not arg_10_0._isInited then
		return 0
	end

	local var_10_0, var_10_1 = ZProj.AStarPathBridge.GetNearestNodeHeight(arg_10_1, 0)

	if not var_10_0 then
		return 0
	end

	return var_10_1
end

return var_0_0
