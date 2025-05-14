module("modules.logic.room.entity.RoomBaseEntity", package.seeall)

local var_0_0 = class("RoomBaseEntity", BaseUnitSpawn)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.luaMono = arg_2_1:GetComponent(RoomEnum.ComponentType.LuaMonobehavier)
	arg_2_0.__hasTaskOnEnabled = true

	TaskDispatcher.runDelay(arg_2_0._onEnabledLuaMono, arg_2_0, 0.01)
end

function var_0_0._onEnabledLuaMono(arg_3_0)
	arg_3_0.__hasTaskOnEnabled = false
	arg_3_0.luaMono.enabled = false
end

function var_0_0.getCharacterMeshRendererList(arg_4_0)
	return
end

function var_0_0.getGameObjectListByName(arg_5_0, arg_5_1)
	return
end

function var_0_0.playAudio(arg_6_0, arg_6_1)
	logNormal("当前接口未实现,需子类实现")
end

function var_0_0.getMainEffectKey(arg_7_0)
	return RoomEnum.EffectKey.BuildingGOKey
end

function var_0_0.addComp(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.go, arg_8_2, arg_8_0)

	arg_8_0[arg_8_1] = var_8_0

	table.insert(arg_8_0._compList, var_8_0)
end

function var_0_0.beforeDestroy(arg_9_0)
	if arg_9_0.__hasTaskOnEnabled then
		arg_9_0.__hasTaskOnEnabled = false

		TaskDispatcher.cancelTask(arg_9_0._onEnabledLuaMono, arg_9_0)
	end

	local var_9_0 = arg_9_0:getCompList()

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if iter_9_1.beforeDestroy then
				iter_9_1:beforeDestroy()
			end
		end
	end
end

return var_0_0
