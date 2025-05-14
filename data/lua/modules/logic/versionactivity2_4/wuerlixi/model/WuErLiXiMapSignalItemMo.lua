module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapSignalItemMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapSignalItemMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.rayId = 0
	arg_1_0.rayDir = 0
	arg_1_0.rayType = WuErLiXiEnum.RayType.NormalSignal
	arg_1_0.startNodeMo = {}
	arg_1_0.endNodeMo = {}
	arg_1_0.startPos = {}
	arg_1_0.endPos = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.rayId = arg_2_1
	arg_2_0.rayType = arg_2_2
	arg_2_0.rayDir = arg_2_3
	arg_2_0.startNodeMo = arg_2_4
	arg_2_0.endNodeMo = arg_2_5
	arg_2_0.startPos = {
		arg_2_4.x,
		arg_2_4.y
	}
	arg_2_0.endPos = {
		arg_2_5.x,
		arg_2_5.y
	}
end

function var_0_0.reset(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.rayId = arg_3_1
	arg_3_0.rayType = arg_3_2
	arg_3_0.rayDir = arg_3_3
	arg_3_0.endNodeMo = arg_3_4
	arg_3_0.endPos = {
		arg_3_4.x,
		arg_3_4.y
	}
end

function var_0_0.setId(arg_4_0, arg_4_1)
	arg_4_0.rayId = arg_4_1
end

function var_0_0.setType(arg_5_0, arg_5_1)
	arg_5_0.rayType = arg_5_1
end

function var_0_0.setRayDir(arg_6_0, arg_6_1)
	arg_6_0.rayDir = arg_6_1
end

function var_0_0.resetEndNodeMo(arg_7_0, arg_7_1)
	arg_7_0.endNodeMo = arg_7_1
end

function var_0_0.getSignalLength(arg_8_0)
	return math.abs(arg_8_0.startPos[1] + arg_8_0.startPos[2] - arg_8_0.endPos[1] - arg_8_0.endPos[2]) + 1
end

return var_0_0
