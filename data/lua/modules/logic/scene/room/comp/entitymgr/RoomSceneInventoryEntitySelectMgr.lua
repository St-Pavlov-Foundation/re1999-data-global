module("modules.logic.scene.room.comp.entitymgr.RoomSceneInventoryEntitySelectMgr", package.seeall)

local var_0_0 = class("RoomSceneInventoryEntitySelectMgr", BaseSceneUnitMgr)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._inventoryRootGO = arg_2_0._scene.go.inventoryRootGO
	arg_2_0._inventoryBlockIdList = {}
	arg_2_0._entityPosInfoList = {}
	arg_2_0._locationParamDic = {}

	for iter_2_0 = 1, 24 do
		table.insert(arg_2_0._entityPosInfoList, {
			blockId = 0,
			remove = false,
			index = iter_2_0
		})
	end

	arg_2_0:refreshInventoryBlock()
end

function var_0_0.refreshInventoryBlock(arg_3_0)
	if not RoomController.instance:isEditMode() then
		return
	end

	if arg_3_0:_isHasEntity() then
		arg_3_0._scene.camera:refreshOrthCamera()
	end
end

function var_0_0._isHasEntity(arg_4_0)
	if arg_4_0._entityPosInfoList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._entityPosInfoList) do
			if iter_4_1.blockId ~= 0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.addBlockEntity(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 then
		local var_5_0 = arg_5_0:_getOrcreateUnit(arg_5_1, arg_5_2)

		arg_5_0:_setTransform(var_5_0, arg_5_0:_findIndexById(arg_5_1))
		arg_5_0:refreshInventoryBlock()
	end
end

function var_0_0.removeBlockEntity(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0:_deleteById(arg_6_1)
		arg_6_0:refreshInventoryBlock()
	end
end

function var_0_0.getIndexById(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._entityPosInfoList) do
		if iter_7_1.blockId == arg_7_1 then
			return iter_7_1.index
		end
	end
end

function var_0_0._removeIndexById(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._entityPosInfoList) do
		if iter_8_1.blockId == arg_8_1 then
			iter_8_1.blockId = 0

			return iter_8_1.index
		end
	end
end

function var_0_0._findIndexById(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getIndexById(arg_9_1)

	if var_9_0 then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._entityPosInfoList) do
		if iter_9_1.blockId == 0 then
			iter_9_1.blockId = arg_9_1

			return iter_9_1.index
		end
	end
end

function var_0_0._getOrcreateUnit(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getUnit(SceneTag.RoomInventoryBlock, arg_10_1)

	if not var_10_0 then
		local var_10_1 = gohelper.create3d(arg_10_0._inventoryRootGO, string.format("block_%d", arg_10_1))

		var_10_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, RoomInventoryBlockEntity, {
			entityId = arg_10_1,
			isWaterReform = arg_10_2
		})
		var_10_0.retainCount = 1

		arg_10_0:addUnit(var_10_0)
		table.insert(arg_10_0._inventoryBlockIdList, arg_10_1)
		gohelper.addChild(arg_10_0._inventoryRootGO, var_10_1)
	else
		var_10_0.retainCount = var_10_0.retainCount + 1
	end

	arg_10_0:refreshInventoryBlock()

	return var_10_0
end

function var_0_0._deleteById(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUnit(SceneTag.RoomInventoryBlock, arg_11_1)

	if var_11_0 then
		var_11_0.retainCount = var_11_0.retainCount - 1

		if var_11_0.retainCount < 1 then
			var_11_0.retainCount = 0

			arg_11_0:_removeIndexById(arg_11_1)
		end
	else
		arg_11_0:_removeIndexById(arg_11_1)
	end

	if not arg_11_0._isHasDelayCheckRetainTask then
		arg_11_0._isHasDelayCheckRetainTask = true

		TaskDispatcher.runDelay(arg_11_0._onDelayCheckRetain, arg_11_0, 0.06666666666666667)
	end

	arg_11_0:refreshInventoryBlock()
end

function var_0_0._onDelayCheckRetain(arg_12_0)
	arg_12_0._isHasDelayCheckRetainTask = false

	local var_12_0 = arg_12_0._inventoryBlockIdList

	for iter_12_0 = #var_12_0, 1, -1 do
		local var_12_1 = var_12_0[iter_12_0]

		if not arg_12_0:getIndexById(var_12_1) then
			table.remove(var_12_0, iter_12_0)
			arg_12_0:removeUnit(SceneTag.RoomInventoryBlock, var_12_1)
		end
	end

	arg_12_0:refreshInventoryBlock()
end

function var_0_0._setTransform(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.goTrs
	local var_13_1 = arg_13_0:_getLocationParam(arg_13_2)

	transformhelper.setLocalScale(var_13_0, var_13_1.scale, var_13_1.scale, var_13_1.scale)
	transformhelper.setLocalRotation(var_13_0, var_13_1.rotationX, var_13_1.rotationY, var_13_1.rotationZ)
	arg_13_1:setLocalPos(var_13_1.positionX, var_13_1.positionY, var_13_1.positionZ)
	arg_13_1:refreshBlock()
	arg_13_1:refreshRotation()
	arg_13_0:refreshInventoryBlock()
end

function var_0_0.moveForward(arg_14_0)
	arg_14_0:refreshInventoryBlock()
end

function var_0_0.playForwardAnim(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:_removeAnim()

	if arg_15_1 then
		arg_15_0._forwardAnimCallback = arg_15_1
		arg_15_0._forwardAnimCallbackObj = arg_15_2
		arg_15_0._isDelayForwardAminRun = true

		TaskDispatcher.runDelay(arg_15_0._delayForwardAnimCallback, arg_15_0, 0.11)
	end

	arg_15_0:refreshInventoryBlock()
end

function var_0_0._removeAnim(arg_16_0)
	arg_16_0._forwardAnimCallback = nil
	arg_16_0._forwardAnimCallbackObj = nil

	if arg_16_0._isDelayForwardAminRun then
		arg_16_0._isDelayForwardAminRun = false

		TaskDispatcher.cancelTask(arg_16_0._delayForwardAnimCallback, arg_16_0)
	end
end

function var_0_0._delayForwardAnimCallback(arg_17_0)
	arg_17_0._isDelayForwardAminRun = false

	if arg_17_0._forwardAnimCallback then
		if arg_17_0._forwardAnimCallbackObj then
			arg_17_0._forwardAnimCallback(arg_17_0._forwardAnimCallbackObj)
		else
			arg_17_0._forwardAnimCallback()
		end
	end

	arg_17_0:refreshInventoryBlock()
end

function var_0_0._getLocationParam(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._locationParamDic[arg_18_1]

	if not var_18_0 then
		var_18_0 = {}
		arg_18_0._locationParamDic[arg_18_1] = var_18_0

		local var_18_1 = arg_18_1 - 1
		local var_18_2 = 1
		local var_18_3 = 1.3125
		local var_18_4 = math.floor(var_18_1 % 6)
		local var_18_5 = math.floor(var_18_1 / 6)

		var_18_0.positionX = -2.51 + var_18_4 * var_18_2
		var_18_0.positionY = 0.15
		var_18_0.positionZ = -1.55 + var_18_5 * var_18_3
		var_18_0.rotationX = 26
		var_18_0.rotationY = 0
		var_18_0.rotationZ = 0
		var_18_0.scale = 0.9
	end

	return var_18_0
end

function var_0_0.refreshRemainBlock(arg_19_0)
	return
end

function var_0_0.getBlockEntity(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getTagUnitDict(SceneTag.RoomInventoryBlock)

	return var_20_0 and var_20_0[arg_20_1]
end

function var_0_0.onSceneClose(arg_21_0)
	var_0_0.super.onSceneClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onDelayCheckRetain, arg_21_0)

	arg_21_0._inventoryBlockIdList = {}

	arg_21_0:_removeAnim()
	arg_21_0:removeAllUnits()
end

function var_0_0.addUnit(arg_22_0, arg_22_1)
	var_0_0.super.addUnit(arg_22_0, arg_22_1)
end

return var_0_0
