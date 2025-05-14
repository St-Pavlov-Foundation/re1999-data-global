module("modules.logic.scene.room.work.RoomSceneCharacterInteractionWork", package.seeall)

local var_0_0 = class("RoomSceneCharacterInteractionWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scene = arg_1_1
	arg_1_0._isChangeMode = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:_randomPlaceCharacter()

	if RoomController.instance:isObMode() and not arg_2_0._isChangeMode then
		arg_2_0:_getCharacterInteractionInfo()
	else
		arg_2_0:onDone(true)
		arg_2_0:startBuilingInteraction()
	end
end

function var_0_0.startBuilingInteraction(arg_3_0)
	if RoomController.instance:isObMode() then
		RoomInteractionController.instance:refreshCharacterBuilding()
		RoomInteractionController.instance:tryPlaceCharacterInteraction()
	end
end

function var_0_0._getCharacterInteractionInfo(arg_4_0)
	RoomRpc.instance:sendGetCharacterInteractionInfoRequest(arg_4_0._onGetInfo, arg_4_0)
end

function var_0_0._onGetInfo(arg_5_0)
	local var_5_0 = RoomModel.instance:getInteractionCount()
	local var_5_1 = arg_5_0:_getConfigList()

	arg_5_0:_trySetInteracts(var_5_1, var_5_0)
	arg_5_0:onDone(true)
	arg_5_0:startBuilingInteraction()
end

function var_0_0._randomPlaceCharacter(arg_6_0)
	if RoomController.instance:isObMode() or RoomController.instance:isVisitMode() then
		RoomCharacterController.instance:checkCharacterMax()

		if arg_6_0._isChangeMode then
			RoomCharacterController.instance:tryCorrectAllCharacter(false)
		else
			RoomCharacterController.instance:tryCorrectAllCharacter(true)
		end
	end
end

function var_0_0.cfgSortFunc(arg_7_0, arg_7_1)
	if arg_7_0.behaviour == arg_7_1.behaviour and arg_7_0.heroId == arg_7_1.heroId and arg_7_0.behaviour == RoomCharacterEnum.InteractionType.Dialog and arg_7_0.faithDialog ~= arg_7_1.faithDialog then
		if arg_7_0.faithDialog == 0 then
			return false
		elseif arg_7_1.faithDialog == 0 then
			return true
		else
			return arg_7_0.faithDialog < arg_7_1.faithDialog
		end
	end

	if arg_7_0.id ~= arg_7_1.id then
		return arg_7_0.id < arg_7_1.id
	end
end

function var_0_0._getConfigList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = RoomCharacterModel.instance:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		tabletool.addValues(var_8_0, RoomConfig.instance:getCharacterInteractionConfigListByHeroId(iter_8_1.heroId))
	end

	table.sort(var_8_0, var_0_0.cfgSortFunc)

	return var_8_0
end

function var_0_0._trySetInteracts(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomCharacterInteractionLimitCount)

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.behaviour ~= RoomCharacterEnum.InteractionType.Animal and RoomCharacterHelper.checkInteractionValid(iter_9_1) and (arg_9_2 < var_9_0 or iter_9_1.excludeDaily or RoomModel.instance:getInteractionState(iter_9_1.id) == RoomCharacterEnum.InteractionState.Start) and arg_9_0:_trySetInteract(iter_9_1) and not iter_9_1.excludeDaily and RoomModel.instance:getInteractionState(iter_9_1.id) ~= RoomCharacterEnum.InteractionState.Start then
			arg_9_2 = arg_9_2 + 1
		end
	end

	RoomCharacterController.instance:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function var_0_0._trySetInteract(arg_10_0, arg_10_1)
	if RoomModel.instance:getInteractionState(arg_10_1.id) == RoomCharacterEnum.InteractionState.Complete then
		return false
	end

	if not RoomCharacterHelper.interactionIsDialogWithSelect(arg_10_1.id) and RoomModel.instance:getInteractionState(arg_10_1.id) == RoomCharacterEnum.InteractionState.Start then
		return false
	end

	if not RoomConditionHelper.isConditionStr(arg_10_1.conditionStr) then
		return false
	end

	if arg_10_1.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		return arg_10_0:_trySetDialogInteract(arg_10_1)
	elseif arg_10_1.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- block empty
	end
end

function var_0_0._trySetDialogInteract(arg_11_0, arg_11_1)
	local var_11_0 = RoomCharacterModel.instance:getCharacterMOById(arg_11_1.heroId)

	if var_11_0:getCurrentInteractionId() or var_11_0:isTrainSourceState() then
		return false
	end

	if arg_11_1.relateHeroId ~= 0 then
		local var_11_1 = RoomCharacterModel.instance:getCharacterMOById(arg_11_1.relateHeroId)

		if var_11_1:getCurrentInteractionId() then
			return false
		end

		local var_11_2 = {}
		local var_11_3 = RoomCharacterModel.instance:getList()

		for iter_11_0, iter_11_1 in ipairs(var_11_3) do
			if iter_11_1.heroId ~= arg_11_1.heroId and iter_11_1.heroId ~= arg_11_1.relateHeroId then
				local var_11_4 = iter_11_1:getMoveTargetPoint().hexPoint

				var_11_2[var_11_4.x] = var_11_2[var_11_4.x] or {}
				var_11_2[var_11_4.x][var_11_4.y] = true
			end
		end

		local var_11_5 = false
		local var_11_6 = RoomMapBlockModel.instance:getFullBlockMOList()
		local var_11_7 = GameUtil.randomTable(tabletool.copy(var_11_6))

		for iter_11_2, iter_11_3 in ipairs(var_11_7) do
			local var_11_8 = iter_11_3.hexPoint

			if not var_11_2[var_11_8.x] or not var_11_2[var_11_8.x][var_11_8.y] then
				var_11_5 = arg_11_0:_trySetTwoCharacterInOneBlock(var_11_0, var_11_1, var_11_8)

				if var_11_5 then
					break
				end
			end
		end

		if not var_11_5 then
			return false
		end

		var_11_1:setCurrentInteractionId(arg_11_1.id)
	end

	var_11_0:setCurrentInteractionId(arg_11_1.id)

	return true
end

function var_0_0._trySetTwoCharacterInOneBlock(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not RoomMapBlockModel.instance:getBlockMO(arg_12_3.x, arg_12_3.y) then
		return false
	end

	local var_12_0 = arg_12_1.heroId
	local var_12_1 = arg_12_1.skinId
	local var_12_2 = arg_12_2.heroId
	local var_12_3 = arg_12_2.skinId

	for iter_12_0 = 0, 6 do
		local var_12_4 = ResourcePoint(arg_12_3, iter_12_0)
		local var_12_5 = RoomCharacterHelper.getCharacterPosition3D(var_12_4, false)

		if RoomCharacterHelper.canConfirmPlace(var_12_0, var_12_5, var_12_1, false) then
			for iter_12_1 = 0, 6 do
				if iter_12_1 ~= iter_12_0 then
					local var_12_6 = ResourcePoint(arg_12_3, iter_12_1)
					local var_12_7 = RoomCharacterHelper.getCharacterPosition3D(var_12_6, false)

					if RoomCharacterHelper.canConfirmPlace(var_12_2, var_12_7, var_12_3, false) then
						RoomCharacterController.instance:moveCharacterTo(arg_12_1, var_12_5, false)
						RoomCharacterController.instance:moveCharacterTo(arg_12_2, var_12_7, false)

						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0.clearWork(arg_13_0)
	arg_13_0._scene = nil
end

return var_0_0
