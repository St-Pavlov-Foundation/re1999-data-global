module("modules.logic.scene.survival.comp.SurvivalPointEffectComp", package.seeall)

local var_0_0 = class("SurvivalPointEffectComp", BaseSceneComp)

var_0_0.ResPaths = {
	warming2 = "survival/effects/prefab/v2a8_survival_jingjie_2.prefab",
	useitem = "survival/effects/prefab/v2a8_survival_daoju.prefab",
	warming1 = "survival/effects/prefab/v2a8_survival_jingjie_1.prefab"
}

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._effectRoot = gohelper.create3d(arg_1_0._sceneGo, "PointEffectRoot")
	arg_1_0._warmingPool = {}
	arg_1_0._useitemPool = {}
	arg_1_0._allInsts = {}
	arg_1_0._allKeys = {}
end

function var_0_0.setPointEffectType(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if not arg_2_0._effectRoot then
		return
	end

	if not arg_2_0._allInsts[arg_2_2] then
		arg_2_0._allInsts[arg_2_2] = {}
	end

	if not arg_2_0._allInsts[arg_2_2][arg_2_3] then
		arg_2_0._allInsts[arg_2_2][arg_2_3] = {
			allKey = {}
		}
	end

	local var_2_0 = arg_2_0._allInsts[arg_2_2][arg_2_3]
	local var_2_1 = var_2_0.allKey

	if var_2_1[arg_2_1] == arg_2_4 then
		return
	end

	var_2_1[arg_2_1] = arg_2_4
	arg_2_0._allKeys[arg_2_1] = true

	arg_2_0:pointChangeCheck(var_2_0, arg_2_2, arg_2_3)
end

function var_0_0.clearPointsByKey(arg_3_0, arg_3_1)
	if not arg_3_0._allKeys[arg_3_1] then
		return
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0._allInsts) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_3.allKey[arg_3_1] then
				iter_3_3.allKey[arg_3_1] = nil

				arg_3_0:pointChangeCheck(iter_3_3, iter_3_0, iter_3_2)
			end
		end
	end

	arg_3_0._allKeys[arg_3_1] = nil
end

function var_0_0.pointChangeCheck(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_1.allKey
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if var_4_1 < iter_4_1 then
			var_4_1 = iter_4_1
		end
	end

	if var_4_1 == 0 then
		var_4_1 = nil
	end

	if var_4_1 ~= arg_4_1.curType then
		arg_4_0:inPoolRes(arg_4_1.curType, arg_4_1.obj)

		arg_4_1.curType = var_4_1
		arg_4_1.obj = arg_4_0:setResByType(var_4_1, arg_4_2, arg_4_3)
	end
end

function var_0_0.setResByType(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 then
		return
	end

	local var_5_0

	if arg_5_1 == 1 then
		var_5_0 = table.remove(arg_5_0._warmingPool)

		if not var_5_0 then
			local var_5_1 = var_0_0.ResPaths.warming1
			local var_5_2 = SurvivalMapModel.instance:getCurMapId()
			local var_5_3 = lua_survival_map_group_mapping.configDict[var_5_2].id
			local var_5_4 = SurvivalConfig.instance:getCopyCo(var_5_3)

			if not var_5_4 then
				logError("没有找到配置" .. tostring(var_5_2) .. " >> " .. tostring(var_5_3))
			end

			if var_5_4.id == 5 then
				var_5_1 = var_0_0.ResPaths.warming2
			end

			local var_5_5 = SurvivalMapHelper.instance:getBlockRes(var_5_1)

			var_5_0 = gohelper.clone(var_5_5, arg_5_0._effectRoot)

			transformhelper.setLocalRotation(var_5_0.transform, 0, 30, 0)
		end
	elseif arg_5_1 == 2 then
		var_5_0 = table.remove(arg_5_0._useitemPool)

		if not var_5_0 then
			local var_5_6 = SurvivalMapHelper.instance:getBlockRes(var_0_0.ResPaths.useitem)

			var_5_0 = gohelper.clone(var_5_6, arg_5_0._effectRoot)

			transformhelper.setLocalRotation(var_5_0.transform, 0, 30, 0)
		end
	end

	gohelper.setActive(var_5_0, true)

	local var_5_7, var_5_8, var_5_9 = SurvivalHelper.instance:hexPointToWorldPoint(arg_5_2, arg_5_3)

	transformhelper.setLocalPos(var_5_0.transform, var_5_7, var_5_8, var_5_9)

	var_5_0.name = string.format("[%s,%s,%s]", arg_5_2, arg_5_3, -arg_5_2 - arg_5_3)

	return var_5_0
end

function var_0_0.inPoolRes(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	gohelper.setActive(arg_6_2, false)

	if arg_6_1 == 1 then
		table.insert(arg_6_0._warmingPool, arg_6_2)
	elseif arg_6_1 == 2 then
		table.insert(arg_6_0._useitemPool, arg_6_2)
	end
end

function var_0_0.onSceneClose(arg_7_0)
	if arg_7_0._effectRoot then
		gohelper.destroy(arg_7_0._effectRoot)

		arg_7_0._effectRoot = nil
	end

	arg_7_0._warmingPool = {}
	arg_7_0._useitemPool = {}
	arg_7_0._allInsts = {}
end

return var_0_0
