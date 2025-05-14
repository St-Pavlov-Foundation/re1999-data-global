module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEntityMgr", package.seeall)

local var_0_0 = class("TianShiNaNaEntityMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._entitys = {}
	arg_1_0._nodes = {}
end

function var_0_0.addEntity(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0._entitys[arg_2_1.co.id]

	if var_2_0 then
		var_2_0:reAdd()

		return var_2_0
	end

	local var_2_1 = TianShiNaNaModel.instance.mapCo:getNodeCo(arg_2_1.x, arg_2_1.y)

	if not var_2_1 or var_2_1:isCollapse() then
		return nil
	end

	local var_2_2 = arg_2_1.co.unitType
	local var_2_3 = TianShiNaNaEnum.UnitTypeToName[var_2_2] or ""
	local var_2_4 = _G[string.format("TianShiNaNa%sEntity", var_2_3)] or TianShiNaNaUnitEntityBase
	local var_2_5 = gohelper.create3d(arg_2_2, var_2_3 .. arg_2_1.co.id)
	local var_2_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_5, var_2_4)

	var_2_6:updateMo(arg_2_1)

	arg_2_0._entitys[arg_2_1.co.id] = var_2_6

	return var_2_6
end

function var_0_0.getEntity(arg_3_0, arg_3_1)
	return arg_3_0._entitys[arg_3_1]
end

function var_0_0.removeEntity(arg_4_0, arg_4_1)
	if arg_4_0._entitys[arg_4_1] then
		arg_4_0._entitys[arg_4_1]:dispose()

		arg_4_0._entitys[arg_4_1] = nil
	end
end

function var_0_0.addNode(arg_5_0, arg_5_1, arg_5_2)
	if string.nilorempty(arg_5_1.nodePath) then
		return
	end

	if arg_5_0._nodes[arg_5_1] then
		return arg_5_0._nodes[arg_5_1]
	end

	local var_5_0 = gohelper.create3d(arg_5_2, string.format("%d_%d", arg_5_1.x, arg_5_1.y))
	local var_5_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, TianShiNaNaNodeEntity)

	var_5_1:updateCo(arg_5_1)

	arg_5_0._nodes[arg_5_1] = var_5_1

	return var_5_1
end

function var_0_0.removeNode(arg_6_0, arg_6_1)
	if arg_6_0._nodes[arg_6_1] then
		arg_6_0._nodes[arg_6_1]:dispose()

		arg_6_0._nodes[arg_6_1] = nil
	end
end

function var_0_0.clear(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._entitys) do
		iter_7_1:dispose()
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._nodes) do
		iter_7_3:dispose()
	end

	arg_7_0._entitys = {}
	arg_7_0._nodes = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
