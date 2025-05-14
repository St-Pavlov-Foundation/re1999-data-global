module("framework.gamescene.unitspawn.BaseUnitSpawn", package.seeall)

local var_0_0 = class("BaseUnitSpawn", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.go.tag = arg_1_0:getTag()
	arg_1_0._compList = {}

	arg_1_0:initComponents()
end

function var_0_0.onStart(arg_2_0)
	return
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0._compList = nil
	arg_3_0.go = nil
end

function var_0_0.addComp(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = MonoHelper.addLuaComOnceToGo(arg_4_0.go, arg_4_2, arg_4_0)

	arg_4_0[arg_4_1] = var_4_0

	table.insert(arg_4_0._compList, var_4_0)
end

function var_0_0.getCompList(arg_5_0)
	return arg_5_0._compList
end

function var_0_0.getTag(arg_6_0)
	return SceneTag.Untagged
end

function var_0_0.initComponents(arg_7_0)
	return
end

return var_0_0
