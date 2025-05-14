module("modules.logic.scene.common.BaseSceneUnitMgr", package.seeall)

local var_0_0 = class("BaseSceneUnitMgr", BaseSceneComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._tagUnitDict = {}
	arg_1_0._containerGO = arg_1_0:getCurScene():getSceneContainerGO()
end

function var_0_0.onSceneClose(arg_2_0)
	arg_2_0:removeAllUnits()
end

function var_0_0.addUnit(arg_3_0, arg_3_1)
	gohelper.addChild(arg_3_0._containerGO, arg_3_1.go)

	local var_3_0 = arg_3_1.go.tag
	local var_3_1 = arg_3_0._tagUnitDict[var_3_0]

	if not var_3_1 then
		var_3_1 = {}
		arg_3_0._tagUnitDict[var_3_0] = var_3_1
	end

	var_3_1[arg_3_1.id] = arg_3_1
end

function var_0_0.removeUnit(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._tagUnitDict[arg_4_1]

	if var_4_0 then
		local var_4_1 = var_4_0[arg_4_2]

		if var_4_1 then
			var_4_0[arg_4_2] = nil

			arg_4_0:destroyUnit(var_4_1)
		end
	end
end

function var_0_0.removeUnitData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._tagUnitDict[arg_5_1] and arg_5_0._tagUnitDict[arg_5_1][arg_5_2] then
		local var_5_0 = arg_5_0._tagUnitDict[arg_5_1][arg_5_2]

		arg_5_0._tagUnitDict[arg_5_1][arg_5_2] = nil

		return var_5_0
	end
end

function var_0_0.removeUnits(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._tagUnitDict[arg_6_1]

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			var_6_0[iter_6_0] = nil

			arg_6_0:destroyUnit(iter_6_1)
		end
	end
end

function var_0_0.removeAllUnits(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._tagUnitDict) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			iter_7_1[iter_7_2] = nil

			arg_7_0:destroyUnit(iter_7_3)
		end
	end
end

function var_0_0.getUnit(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._tagUnitDict[arg_8_1]

	if var_8_0 then
		return var_8_0[arg_8_2]
	end
end

function var_0_0.getTagUnitDict(arg_9_0, arg_9_1)
	return arg_9_0._tagUnitDict[arg_9_1]
end

function var_0_0.destroyUnit(arg_10_0, arg_10_1)
	if arg_10_1.beforeDestroy then
		arg_10_1:beforeDestroy()
	end

	gohelper.destroy(arg_10_1.go)
end

return var_0_0
