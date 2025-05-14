module("modules.logic.explore.map.unit.comp.ExploreUnitUIComp", package.seeall)

local var_0_0 = class("ExploreUnitUIComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0.uiDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.setup(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.uiDict) do
		iter_3_1:setTarget(arg_3_1)
	end
end

function var_0_0.addUI(arg_4_0, arg_4_1)
	if not arg_4_0.uiDict[arg_4_1.__cname] then
		arg_4_0.uiDict[arg_4_1.__cname] = arg_4_1.New(arg_4_0.unit)
	end

	return arg_4_0.uiDict[arg_4_1.__cname]
end

function var_0_0.removeUI(arg_5_0, arg_5_1)
	if arg_5_0.uiDict[arg_5_1.__cname] then
		arg_5_0.uiDict[arg_5_1.__cname]:tryDispose()

		arg_5_0.uiDict[arg_5_1.__cname] = nil
	end
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.uiDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.uiDict) do
			iter_6_1:setTarget(arg_6_0.go)
		end
	end
end

function var_0_0.onDestroy(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.uiDict) do
		iter_7_1:tryDispose()
	end

	arg_7_0.uiDict = nil
	arg_7_0.unit = nil
	arg_7_0.go = nil
end

return var_0_0
