module("modules.logic.room.entity.comp.RoomBlockChangeColorComp", package.seeall)

local var_0_0 = class("RoomBlockChangeColorComp", LuaCompBase)
local var_0_1 = UnityEngine.Shader
local var_0_2 = {
	enableChangeColor = var_0_1.PropertyToID("_EnableChangeColor"),
	hue = var_0_1.PropertyToID("_Hue"),
	saturation = var_0_1.PropertyToID("_Saturation"),
	brightness = var_0_1.PropertyToID("_Brightness")
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._blockColor = nil
	arg_1_0._blockColorKeyMap = {}
end

function var_0_0.onEffectReturn(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_refreshColor(arg_2_1, RoomWaterReformModel.InitBlockColor)
end

function var_0_0.onEffectRebuild(arg_3_0)
	arg_3_0:refreshLand()
end

function var_0_0.beforeDestroy(arg_4_0)
	arg_4_0.__willDestroy = true

	TaskDispatcher.cancelTask(arg_4_0._onRunRefreshLandTask, arg_4_0)
end

function var_0_0.refreshLand(arg_5_0)
	if arg_5_0.__willDestroy then
		return
	end

	if not arg_5_0._isHasRefreshLandTask then
		arg_5_0._isHasRefreshLandTask = true

		TaskDispatcher.runDelay(arg_5_0._onRunRefreshLandTask, arg_5_0, 0.05)
	end
end

function var_0_0._onRunRefreshLandTask(arg_6_0)
	arg_6_0._isHasRefreshLandTask = false

	if arg_6_0.__willDestroy then
		return
	end

	local var_6_0 = arg_6_0.entity:getMO()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_6_0:getDefineBlockType()

	arg_6_0:_refreshColor(RoomEnum.EffectKey.BlockRiverKey, arg_6_0:_getColorIdByBlockType(var_6_1))
	arg_6_0:_refreshFullRiver(var_6_0)
end

function var_0_0._refreshFullRiver(arg_7_0, arg_7_1)
	if not arg_7_1 or not arg_7_1:isFullWater() then
		return
	end

	for iter_7_0 = 1, 6 do
		local var_7_0
		local var_7_1
		local var_7_2

		if arg_7_1:getResourceId(iter_7_0, true) == RoomResourceEnum.ResourceId.River then
			var_7_0, var_7_1, var_7_2 = arg_7_1:getResourceTypeRiver(iter_7_0, true)
		end

		if var_7_0 then
			if var_7_1 then
				arg_7_0:_refreshColor(RoomEnum.EffectKey.BlockFloorKeys[iter_7_0], arg_7_0:_getColorIdByBlockType(var_7_1))
			end

			if var_7_2 then
				arg_7_0:_refreshColor(RoomEnum.EffectKey.BlockFloorBKeys[iter_7_0], arg_7_0:_getColorIdByBlockType(var_7_2))
			end
		end
	end
end

function var_0_0._getColorIdByBlockType(arg_8_0, arg_8_1)
	if arg_8_1 >= 10000 then
		local var_8_0 = math.floor(arg_8_1 / 10000)

		if lua_room_block_color_param.configDict[var_8_0] then
			return var_8_0
		end
	end

	return RoomWaterReformModel.InitBlockColor
end

function var_0_0._refreshColor(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == RoomWaterReformModel.InitBlockColor and not arg_9_0._blockColorKeyMap[arg_9_1] or arg_9_0._blockColorKeyMap[arg_9_1] == arg_9_2 then
		return
	end

	local var_9_0 = arg_9_0.entity.effect:getComponentsByPath(arg_9_1, RoomEnum.ComponentName.MeshRenderer, "mesh")

	if var_9_0 and #var_9_0 > 0 then
		local var_9_1 = arg_9_0:_getMPBById(arg_9_2)

		arg_9_0:_setMeshReaderColor(var_9_0, var_9_1)

		arg_9_0._blockColorKeyMap[arg_9_1] = arg_9_2
	end
end

function var_0_0._setMeshReaderColor(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			iter_10_1:SetPropertyBlock(arg_10_2)
		end
	end
end

local var_0_3

function var_0_0._getMPBById(arg_11_0, arg_11_1)
	if not var_0_3 then
		var_0_3 = {}

		local var_11_0 = lua_room_block_color_param.configList
		local var_11_1 = UnityEngine.MaterialPropertyBlock

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			local var_11_2 = var_11_1.New()

			var_11_2:SetFloat(var_0_2.hue, iter_11_1.hue)
			var_11_2:SetFloat(var_0_2.saturation, iter_11_1.saturation)
			var_11_2:SetFloat(var_0_2.brightness, iter_11_1.brightness)
			var_11_2:SetFloat(var_0_2.enableChangeColor, 1)

			var_0_3[iter_11_1.id] = var_11_2
		end

		if #var_11_0 > 50 then
			logError("颜色数量超过了 50 ......数量过大")
		end
	end

	return var_0_3[arg_11_1]
end

return var_0_0
