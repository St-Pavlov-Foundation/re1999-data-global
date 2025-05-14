module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapRayMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapRayMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.rayId = 0
	arg_1_0.rayParent = 0
	arg_1_0.rayDir = 0
	arg_1_0.rayType = WuErLiXiEnum.RayType.NormalSignal
	arg_1_0.rayTime = ServerTime.now()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.rayId = arg_2_1
	arg_2_0.rayType = arg_2_2
	arg_2_0.rayDir = arg_2_3
	arg_2_0.rayParent = arg_2_4
	arg_2_0.rayTime = ServerTime.now()
end

function var_0_0.reset(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_0.rayId ~= arg_3_1 or arg_3_0.rayType ~= arg_3_2 then
		arg_3_0.rayTime = ServerTime.now()
	end

	arg_3_0.rayId = arg_3_1
	arg_3_0.rayType = arg_3_2
	arg_3_0.rayDir = arg_3_3
	arg_3_0.rayParent = arg_3_4
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

function var_0_0.setRayParent(arg_7_0, arg_7_1)
	arg_7_0.rayParent = arg_7_1
end

return var_0_0
