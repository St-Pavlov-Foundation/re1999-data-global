module("modules.logic.room.entity.comp.RoomBuildingReflectionComp", package.seeall)

local var_0_0 = class("RoomBuildingReflectionComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	local var_2_0 = arg_2_0:getMO()

	arg_2_0._isReflection = arg_2_0:_checkReflection()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, arg_3_0._onDropBuildingDown, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, arg_4_0._onDropBuildingDown, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0._onDropBuildingDown(arg_6_0)
	arg_6_0:refreshReflection()
end

function var_0_0.refreshReflection(arg_7_0)
	local var_7_0 = arg_7_0:_checkReflection()

	if arg_7_0._isReflection ~= var_7_0 then
		arg_7_0._isReflection = var_7_0

		arg_7_0:_updateReflection()
	end
end

function var_0_0._updateReflection(arg_8_0)
	local var_8_0 = arg_8_0.entity.effect:getGameObjectsByName(arg_8_0._effectKey, RoomEnum.EntityChildKey.ReflerctionGOKey)

	if var_8_0 and #var_8_0 > 0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			gohelper.setActive(iter_8_1, arg_8_0._isReflection)
		end
	end
end

function var_0_0._checkReflection(arg_9_0)
	if arg_9_0.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	local var_9_0, var_9_1 = arg_9_0:_getOccupyDict()

	if not var_9_0 then
		return false
	end

	local var_9_2 = RoomMapBlockModel.instance

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_3 = var_9_2:getBlockMO(iter_9_1.x, iter_9_1.y)

		if var_9_3 and var_9_3:isInMapBlock() and var_9_3:hasRiver() then
			return true
		end
	end

	return false
end

function var_0_0._getOccupyDict(arg_10_0)
	return arg_10_0.entity:getOccupyDict()
end

function var_0_0.getMO(arg_11_0)
	return arg_11_0.entity:getMO()
end

function var_0_0.onEffectRebuild(arg_12_0)
	local var_12_0 = arg_12_0.entity.effect

	if var_12_0:isHasEffectGOByKey(arg_12_0._effectKey) and not var_12_0:isSameResByKey(arg_12_0._effectKey, arg_12_0._effectRes) then
		arg_12_0._effectRes = var_12_0:getEffectRes(arg_12_0._effectKey)

		arg_12_0:_updateReflection()
	end
end

return var_0_0
