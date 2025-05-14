module("modules.logic.room.entity.comp.RoomBuildingLevelComp", package.seeall)

local var_0_0 = class("RoomBuildingLevelComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	arg_1_0._levelPathDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._level = arg_2_0:_getLevel()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.BuildingLevelUpPush, arg_3_0._onBuildingLevelUpPush, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingLevelUpPush, arg_4_0._onBuildingLevelUpPush, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0._onBuildingLevelUpPush(arg_6_0)
	arg_6_0:refreshLevel()
end

function var_0_0.refreshLevel(arg_7_0)
	local var_7_0 = arg_7_0:_getLevel()

	if arg_7_0._level ~= var_7_0 then
		arg_7_0._level = var_7_0

		arg_7_0.entity:refreshBuilding()
		arg_7_0:_updateLevel()
	end
end

function var_0_0._updateLevel(arg_8_0)
	local var_8_0 = arg_8_0:getMO()

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_0.entity.effect

	if not var_8_1:isHasEffectGOByKey(arg_8_0._effectKey) then
		return
	end

	local var_8_2 = RoomConfig.instance:getLevelGroupLevelDict(var_8_0.buildingId)

	for iter_8_0, iter_8_1 in pairs(var_8_2) do
		if not arg_8_0._levelPathDict[iter_8_0] then
			arg_8_0._levelPathDict[iter_8_0] = string.format(RoomEnum.EffectPath.BuildingLevelPath, iter_8_0)
		end

		local var_8_3 = var_8_1:getGameObjectByPath(arg_8_0._effectKey, arg_8_0._levelPathDict[iter_8_0])

		if var_8_3 then
			gohelper.setActive(var_8_3, iter_8_0 <= arg_8_0._level)
		end
	end
end

function var_0_0._getLevel(arg_9_0)
	return arg_9_0:getMO().level or 0
end

function var_0_0.getMO(arg_10_0)
	return arg_10_0.entity:getMO()
end

function var_0_0.onEffectRebuild(arg_11_0)
	local var_11_0 = arg_11_0.entity.effect

	if var_11_0:isHasEffectGOByKey(arg_11_0._effectKey) and not var_11_0:isSameResByKey(arg_11_0._effectKey, arg_11_0._effectRes) then
		arg_11_0._effectRes = var_11_0:getEffectRes(arg_11_0._effectKey)
		arg_11_0._level = arg_11_0:_getLevel()

		arg_11_0:_updateLevel()
	end
end

return var_0_0
