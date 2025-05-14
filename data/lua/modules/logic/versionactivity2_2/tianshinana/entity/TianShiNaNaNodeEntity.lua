module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaNodeEntity", package.seeall)

local var_0_0 = class("TianShiNaNaNodeEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
end

function var_0_0.updateCo(arg_2_0, arg_2_1)
	PrefabInstantiate.Create(arg_2_0.go):startLoad(arg_2_1.nodePath)

	local var_2_0 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(arg_2_1.x, arg_2_1.y))

	transformhelper.setLocalPos(arg_2_0.go.transform, var_2_0.x, var_2_0.y, var_2_0.z)
end

function var_0_0.dispose(arg_3_0)
	gohelper.destroy(arg_3_0.go)
end

return var_0_0
