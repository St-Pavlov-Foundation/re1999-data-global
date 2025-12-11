module("modules.logic.scene.room.comp.entitymgr.RoomSceneMapEntityMgr", package.seeall)

local var_0_0 = class("RoomSceneMapEntityMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	local var_2_0 = RoomMapBlockModel.instance:getBlockMOList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1

		if iter_2_1.blockState == RoomBlockEnum.BlockState.Water then
			var_2_1 = arg_2_0:getUnit(SceneTag.RoomEmptyBlock, iter_2_1.id)
		else
			var_2_1 = arg_2_0:getUnit(SceneTag.RoomMapBlock, iter_2_1.id)
		end

		if not var_2_1 then
			arg_2_0:spawnMapBlock(iter_2_1)
		else
			arg_2_0:_refreshBlockEntiy(var_2_1, iter_2_1)
		end
	end

	if not arg_2_0:getUnit(SceneTag.Untagged, 1) then
		arg_2_0:_spawnBlockEffect(RoomEnum.EffectKey.BlockCanPlaceKey, RoomBlockCanPlaceEntity, 1)
	end
end

function var_0_0.onSwitchMode(arg_3_0)
	local var_3_0 = RoomMapBlockModel.instance
	local var_3_1 = {
		SceneTag.RoomEmptyBlock,
		SceneTag.RoomMapBlock
	}

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = arg_3_0:getTagUnitDict(iter_3_1)

		if var_3_2 then
			local var_3_3 = {}

			for iter_3_2, iter_3_3 in pairs(var_3_2) do
				local var_3_4

				if iter_3_1 == SceneTag.RoomEmptyBlock then
					var_3_4 = var_3_0:getEmptyBlockMOById(iter_3_2)
				else
					var_3_4 = var_3_0:getFullBlockMOById(iter_3_2)
				end

				if not var_3_4 then
					table.insert(var_3_3, iter_3_2)
				end
			end

			for iter_3_4 = 1, #var_3_3 do
				arg_3_0:removeUnit(iter_3_1, var_3_3[iter_3_4])
			end
		end
	end
end

function var_0_0._spawnBlockEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0._scene.go.blockRoot
	local var_4_1 = gohelper.create3d(var_4_0, arg_4_1)
	local var_4_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_1, arg_4_2, arg_4_3)

	gohelper.addChild(var_4_0, var_4_1)
	arg_4_0:addUnit(var_4_2)

	return var_4_2
end

function var_0_0.spawnMapBlock(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._scene.go.blockRoot
	local var_5_1 = arg_5_1.hexPoint

	if not var_5_1 then
		logError("RoomSceneMapEntityMgr: 没有位置信息")

		return
	end

	local var_5_2 = gohelper.create3d(var_5_0, RoomResHelper.getBlockName(var_5_1))
	local var_5_3

	if arg_5_1.blockState == RoomBlockEnum.BlockState.Water then
		var_5_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_2, RoomEmptyBlockEntity, arg_5_1.id)
	else
		var_5_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_2, RoomMapBlockEntity, arg_5_1.id)
	end

	arg_5_0:addUnit(var_5_3)
	gohelper.addChild(var_5_0, var_5_2)
	arg_5_0:_refreshBlockEntiy(var_5_3, arg_5_1)

	return var_5_3
end

function var_0_0._refreshBlockEntiy(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = HexMath.hexToPosition(arg_6_2.hexPoint, RoomBlockEnum.BlockSize)

	arg_6_1:setLocalPos(var_6_0.x, 0, var_6_0.y)
	arg_6_1:refreshBlock()
	arg_6_1:refreshRotation()
end

function var_0_0.moveTo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = HexMath.hexToPosition(arg_7_2, RoomBlockEnum.BlockSize)

	arg_7_1:setLocalPos(var_7_0.x, 0, var_7_0.y)
end

function var_0_0.destroyBlock(arg_8_0, arg_8_1)
	arg_8_0:removeUnit(arg_8_1:getTag(), arg_8_1.id)
end

function var_0_0.getBlockEntity(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = (not arg_9_2 or arg_9_2 == SceneTag.RoomMapBlock) and arg_9_0:getTagUnitDict(SceneTag.RoomMapBlock)
	local var_9_1 = var_9_0 and var_9_0[arg_9_1]

	if var_9_1 then
		return var_9_1
	end

	local var_9_2 = (not arg_9_2 or arg_9_2 == SceneTag.RoomEmptyBlock) and arg_9_0:getTagUnitDict(SceneTag.RoomEmptyBlock)

	return var_9_2 and var_9_2[arg_9_1]
end

function var_0_0.getMapBlockEntityDict(arg_10_0)
	return arg_10_0._tagUnitDict[SceneTag.RoomMapBlock]
end

function var_0_0.refreshAllBlockEntity(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getTagUnitDict(arg_11_1)

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			local var_11_1 = iter_11_1:getMO()

			arg_11_0:_refreshBlockEntiy(iter_11_1, var_11_1)
		end
	end
end

function var_0_0.getPropertyBlock(arg_12_0)
	if not arg_12_0._propertyBlock then
		arg_12_0._propertyBlock = UnityEngine.MaterialPropertyBlock.New()
	end

	return arg_12_0._propertyBlock
end

function var_0_0.onSceneClose(arg_13_0)
	var_0_0.super.onSceneClose(arg_13_0)

	if arg_13_0._propertyBlock then
		arg_13_0._propertyBlock:Clear()

		arg_13_0._propertyBlock = nil
	end
end

return var_0_0
