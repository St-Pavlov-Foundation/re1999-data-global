module("modules.logic.room.entity.comp.RoomNightLightComp", package.seeall)

local var_0_0 = class("RoomNightLightComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	arg_1_0._isNight = RoomWeatherModel.instance:getIsNight()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.setEffectKey(arg_3_0, arg_3_1)
	arg_3_0._effectKey = arg_3_1
end

function var_0_0.addEventListeners(arg_4_0)
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, arg_4_0._onNightLight, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, arg_5_0._onNightLight, arg_5_0)
end

function var_0_0._onNightLight(arg_6_0, arg_6_1)
	if arg_6_1 ~= nil and arg_6_0._isNight ~= arg_6_1 then
		arg_6_0._isNight = arg_6_1

		arg_6_0:_updateNight()
	end
end

function var_0_0._updateNight(arg_7_0)
	local var_7_0 = arg_7_0.entity.effect:getGameObjectsByName(arg_7_0._effectKey, RoomEnum.EntityChildKey.NightLightGOKey)

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			gohelper.setActive(iter_7_1, arg_7_0._isNight)
		end
	end
end

function var_0_0.beforeDestroy(arg_8_0)
	return
end

function var_0_0.onEffectRebuild(arg_9_0)
	local var_9_0 = arg_9_0.entity.effect

	if var_9_0:isHasEffectGOByKey(arg_9_0._effectKey) and not var_9_0:isSameResByKey(arg_9_0._effectKey, arg_9_0._effectRes) then
		arg_9_0._effectRes = var_9_0:getEffectRes(arg_9_0._effectKey)

		arg_9_0:_updateNight()
	end
end

return var_0_0
