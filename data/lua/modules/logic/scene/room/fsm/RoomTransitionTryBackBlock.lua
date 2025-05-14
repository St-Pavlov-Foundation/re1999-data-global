module("modules.logic.scene.room.fsm.RoomTransitionTryBackBlock", package.seeall)

local var_0_0 = class("RoomTransitionTryBackBlock", JompFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
	arg_1_0._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.hexPoint
	local var_3_1 = RoomMapBlockModel.instance:getBlockMO(var_3_0.x, var_3_0.y)
	local var_3_2 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_3_2:getCount() >= RoomEnum.ConstNum.InventoryBlockOneBackMax and var_3_2:getById(var_3_1.id) == nil then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockOneBackMax)
		arg_3_0:onDone()

		return
	end

	if not RoomMapBlockModel.instance:isBackMore() then
		arg_3_0:_backOne(var_3_1.id)
	end

	local var_3_3 = arg_3_0._scene.mapmgr:getBlockEntity(var_3_1.id, SceneTag.RoomMapBlock)
	local var_3_4 = arg_3_0._opToDis[var_3_1:getOpState()] or RoomBlockEnum.OpState.Normal

	var_3_1:setOpState(var_3_4)

	if var_3_4 == RoomBlockEnum.OpState.Back then
		var_3_2:addAtLast(var_3_1)
	else
		var_3_2:remove(var_3_1)
		var_3_3:refreshBlock()

		var_3_0 = nil
	end

	arg_3_0:onDone()
	arg_3_0:_refreshBackBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientTryBackBlock)

	if var_3_0 then
		local var_3_5 = HexMath.hexToPosition(var_3_0, RoomBlockEnum.BlockSize)
		local var_3_6 = {}

		if arg_3_0:_isOutScreen(var_3_5) then
			var_3_6.focusX = var_3_5.x
			var_3_6.focusY = var_3_5.y
		end

		arg_3_0._scene.camera:tweenCamera(var_3_6)
	end
end

function var_0_0._refreshBackBlock(arg_4_0)
	local var_4_0 = RoomMapBlockModel.instance:isCanBackBlock()
	local var_4_1 = RoomMapBlockModel.instance:getBackBlockModel():getList()

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = var_4_1[iter_4_0]

		if var_4_2:getOpStateParam() ~= var_4_0 then
			var_4_2:setOpState(RoomBlockEnum.OpState.Back, var_4_0)

			local var_4_3 = arg_4_0._scene.mapmgr:getBlockEntity(var_4_2.id, SceneTag.RoomMapBlock)

			if var_4_3 then
				var_4_3:refreshBlock()
			end
		end
	end
end

function var_0_0._backOne(arg_5_0, arg_5_1)
	local var_5_0 = RoomMapBlockModel.instance:getBackBlockModel()
	local var_5_1 = var_5_0:getList()

	for iter_5_0 = 1, #var_5_1 do
		local var_5_2 = var_5_1[iter_5_0]

		if var_5_2 and var_5_2.id ~= arg_5_1 then
			var_5_2:setOpState(RoomBlockEnum.OpState.Normal)

			local var_5_3 = arg_5_0._scene.mapmgr:getBlockEntity(var_5_2.id, SceneTag.RoomMapBlock)

			if var_5_3 then
				var_5_3:refreshBlock()
			end
		end
	end

	var_5_0:clear()
end

function var_0_0._isOutScreen(arg_6_0, arg_6_1)
	return RoomHelper.isOutCameraFocus(arg_6_1)
end

function var_0_0.stop(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

function var_0_0.onDone(arg_9_0)
	var_0_0.super.onDone(arg_9_0)
end

return var_0_0
