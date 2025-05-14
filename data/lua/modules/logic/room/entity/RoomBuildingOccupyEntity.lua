module("modules.logic.room.entity.RoomBuildingOccupyEntity", package.seeall)

local var_0_0 = class("RoomBuildingOccupyEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.Untagged
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.goTrs = arg_3_1.transform
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.StaticContainerGOKey)

	var_0_0.super.init(arg_3_0, arg_3_1)

	arg_3_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
end

function var_0_0.onEffectRebuild(arg_6_0)
	return
end

function var_0_0._isShowNeighbor(arg_7_0, arg_7_1, arg_7_2)
	if RoomMapBuildingModel.instance:getTempBuildingParam(arg_7_1, arg_7_2) then
		return false
	end

	return true
end

function var_0_0._getContainerGO(arg_8_0, arg_8_1)
	if arg_8_1 then
		return arg_8_0.containerGO
	end

	return arg_8_0.staticContainerGO
end

function var_0_0._refreshNeighbor(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1 and RoomEnum.EffectKey.BuildingOccupyCanSideKeys or RoomEnum.EffectKey.BuildingOccupyNotSideKeys

	for iter_9_0 = 1, 6 do
		local var_9_1 = HexPoint.directions[iter_9_0]
		local var_9_2 = arg_9_0:_isShowNeighbor(var_9_1.x + arg_9_3.x, var_9_1.y + arg_9_3.y)
		local var_9_3 = var_9_0[iter_9_0]

		if var_9_2 and not arg_9_0.effect:isHasEffectGOByKey(var_9_3) then
			arg_9_0.effect:addParams({
				[var_9_3] = {
					res = arg_9_1 and RoomScenePreloader.ResEffectF or RoomScenePreloader.ResEffectE,
					containerGO = arg_9_0:_getContainerGO(arg_9_1),
					localRotation = Vector3(0, (iter_9_0 - 1 + 3) * 60, 0)
				}
			})
		end

		arg_9_0.effect:setActiveByKey(var_9_3, var_9_2)
	end
end

function var_0_0._refreshOccupy(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 and RoomEnum.EffectKey.BuildingOccupyCanJudgeKey or RoomEnum.EffectKey.BuildingOccupyNotJudgeKey

	if not arg_10_0.effect:isHasKey(var_10_0) then
		arg_10_0.effect:addParams({
			[var_10_0] = {
				res = arg_10_1 and RoomScenePreloader.ResEffectD01 or RoomScenePreloader.ResEffectD02,
				containerGO = arg_10_0:_getContainerGO(arg_10_1)
			}
		})
	end
end

function var_0_0._isJudge(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 == false then
		return false
	end

	local var_11_0 = RoomMapBlockModel.instance:getBlockMO(arg_11_1, arg_11_2)

	if var_11_0 then
		return RoomBuildingHelper.isJudge(var_11_0.hexPoint, var_11_0.id)
	end

	return false
end

function var_0_0.refreshTempOccupy(arg_12_0)
	local var_12_0 = arg_12_0:getBuildingParam()
	local var_12_1 = false

	if var_12_0 then
		var_12_1 = RoomMapBuildingModel.instance:isTempOccupy(var_12_0.hexPoint)
	end

	if var_12_1 then
		local var_12_2 = arg_12_0:_isJudge(var_12_0.hexPoint.x, var_12_0.hexPoint.y, var_12_0.checkBuildingAreaSuccess)

		if arg_12_0._lastIsJudge ~= var_12_2 then
			arg_12_0._lastIsJudge = var_12_2

			gohelper.setActive(arg_12_0.containerGO, var_12_2)
			gohelper.setActive(arg_12_0.staticContainerGO, not var_12_2)
		end

		arg_12_0:_refreshNeighbor(var_12_2, var_12_0.blockRotate, var_12_0.hexPoint)
		arg_12_0:_refreshOccupy(var_12_2)

		local var_12_3 = HexMath.hexToPosition(var_12_0.hexPoint, RoomBlockEnum.BlockSize)

		transformhelper.setLocalPos(arg_12_0.goTrs, var_12_3.x, 0, var_12_3.y)
	elseif arg_12_0._lastIsJudge ~= nil then
		arg_12_0._lastIsJudge = nil

		gohelper.setActive(arg_12_0.containerGO, false)
		gohelper.setActive(arg_12_0.staticContainerGO, false)
	end

	arg_12_0.effect:refreshEffect()
end

function var_0_0.getBuildingParam(arg_13_0)
	return RoomMapBuildingModel.instance:getTempBuildingParamByPointIndex(arg_13_0.id)
end

function var_0_0.getMO(arg_14_0)
	return RoomMapBuildingModel.instance:getTempBuildingMO()
end

return var_0_0
