module("modules.logic.scene.survival.comp.SurvivalPointEffectComp", package.seeall)

local var_0_0 = class("SurvivalPointEffectComp", BaseSceneComp)

var_0_0.ResPaths = {
	changeModel = "survival/effects/prefab/v3a1_scene_zaiju.prefab",
	teleportGate = "survival/effects/prefab/v3a1_scene_biaoji.prefab",
	explode = "survival/effects/prefab/v3a1_scene_baozha.prefab",
	warming1 = "survival/effects/prefab/v2a8_survival_jingjie_1.prefab",
	warming2 = "survival/effects/prefab/v2a8_survival_jingjie_2.prefab",
	useitem = "survival/effects/prefab/v2a8_survival_daoju.prefab",
	fastfight = "survival/effects/prefab/v2a8_scene_tiaoguo.prefab"
}

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._effectRoot = gohelper.create3d(arg_1_0._sceneGo, "PointEffectRoot")
	arg_1_0._warmingPool = {}
	arg_1_0._useitemPool = {}
	arg_1_0._allInsts = {}
	arg_1_0._allKeys = {}
	arg_1_0._autoDisposeEffect = {}

	arg_1_0:setTeleportGateEffect()
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

function var_0_0.setTeleportGateEffect(arg_3_0)
	if not arg_3_0._effectRoot then
		return
	end

	local var_3_0 = SurvivalMapModel.instance:getSceneMo()

	if var_3_0.sceneProp.teleportGate == 1 then
		if not arg_3_0._teleportEffect then
			local var_3_1 = SurvivalMapHelper.instance:getBlockRes(var_0_0.ResPaths.teleportGate)

			arg_3_0._teleportEffect = gohelper.clone(var_3_1, arg_3_0._effectRoot)
		else
			gohelper.setActive(arg_3_0._teleportEffect, true)
		end

		local var_3_2 = var_3_0.sceneProp.teleportGateHex
		local var_3_3, var_3_4, var_3_5 = SurvivalHelper.instance:hexPointToWorldPoint(var_3_2.q, var_3_2.r)

		transformhelper.setLocalPos(arg_3_0._teleportEffect.transform, var_3_3, var_3_4, var_3_5)
	else
		gohelper.setActive(arg_3_0._teleportEffect, false)
	end
end

function var_0_0.addAutoDisposeEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0._effectRoot then
		return
	end

	arg_4_3 = arg_4_3 or 2

	local var_4_0 = SurvivalMapHelper.instance:getBlockRes(arg_4_1)
	local var_4_1 = gohelper.clone(var_4_0, arg_4_0._effectRoot)

	transformhelper.setLocalPos(var_4_1.transform, arg_4_2.x, arg_4_2.y, arg_4_2.z)

	arg_4_0._autoDisposeEffect[var_4_1] = arg_4_3 + UnityEngine.Time.realtimeSinceStartup

	TaskDispatcher.runRepeat(arg_4_0._checkEffectDispose, arg_4_0, 2, -1)
end

function var_0_0._checkEffectDispose(arg_5_0)
	local var_5_0 = UnityEngine.Time.realtimeSinceStartup

	for iter_5_0, iter_5_1 in pairs(arg_5_0._autoDisposeEffect) do
		if iter_5_1 < var_5_0 then
			gohelper.destroy(iter_5_0)

			arg_5_0._autoDisposeEffect[iter_5_0] = nil
		end
	end

	if not next(arg_5_0._autoDisposeEffect) then
		TaskDispatcher.cancelTask(arg_5_0._checkEffectDispose, arg_5_0)
	end
end

function var_0_0.clearPointsByKey(arg_6_0, arg_6_1)
	if not arg_6_0._allKeys[arg_6_1] then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0._allInsts) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_3.allKey[arg_6_1] then
				iter_6_3.allKey[arg_6_1] = nil

				arg_6_0:pointChangeCheck(iter_6_3, iter_6_0, iter_6_2)
			end
		end
	end

	arg_6_0._allKeys[arg_6_1] = nil
end

function var_0_0.pointChangeCheck(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1.allKey
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if var_7_1 < iter_7_1 then
			var_7_1 = iter_7_1
		end
	end

	if var_7_1 == 0 then
		var_7_1 = nil
	end

	if var_7_1 ~= arg_7_1.curType then
		arg_7_0:inPoolRes(arg_7_1.curType, arg_7_1.obj)

		arg_7_1.curType = var_7_1
		arg_7_1.obj = arg_7_0:setResByType(var_7_1, arg_7_2, arg_7_3)
	end
end

function var_0_0.setResByType(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_1 then
		return
	end

	local var_8_0

	if arg_8_1 == 1 then
		var_8_0 = table.remove(arg_8_0._warmingPool)

		if not var_8_0 then
			local var_8_1 = var_0_0.ResPaths.warming1
			local var_8_2 = SurvivalMapModel.instance:getCurMapId()
			local var_8_3 = lua_survival_map_group_mapping.configDict[var_8_2].id
			local var_8_4 = lua_survival_map_group.configDict[var_8_3]

			if not var_8_4 then
				logError("没有找到配置" .. tostring(var_8_2) .. " >> " .. tostring(var_8_3))
			end

			if var_8_4.id == 5 then
				var_8_1 = var_0_0.ResPaths.warming2
			end

			local var_8_5 = SurvivalMapHelper.instance:getBlockRes(var_8_1)

			var_8_0 = gohelper.clone(var_8_5, arg_8_0._effectRoot)

			transformhelper.setLocalRotation(var_8_0.transform, 0, 30, 0)
		end
	elseif arg_8_1 == 2 then
		var_8_0 = table.remove(arg_8_0._useitemPool)

		if not var_8_0 then
			local var_8_6 = SurvivalMapHelper.instance:getBlockRes(var_0_0.ResPaths.useitem)

			var_8_0 = gohelper.clone(var_8_6, arg_8_0._effectRoot)

			transformhelper.setLocalRotation(var_8_0.transform, 0, 30, 0)
		end
	end

	gohelper.setActive(var_8_0, true)

	local var_8_7, var_8_8, var_8_9 = SurvivalHelper.instance:hexPointToWorldPoint(arg_8_2, arg_8_3)

	transformhelper.setLocalPos(var_8_0.transform, var_8_7, var_8_8, var_8_9)

	var_8_0.name = string.format("[%s,%s,%s]", arg_8_2, arg_8_3, -arg_8_2 - arg_8_3)

	return var_8_0
end

function var_0_0.inPoolRes(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 then
		return
	end

	gohelper.setActive(arg_9_2, false)

	if arg_9_1 == 1 then
		table.insert(arg_9_0._warmingPool, arg_9_2)
	elseif arg_9_1 == 2 then
		table.insert(arg_9_0._useitemPool, arg_9_2)
	end
end

function var_0_0.onSceneClose(arg_10_0)
	if arg_10_0._teleportEffect then
		gohelper.destroy(arg_10_0._teleportEffect)

		arg_10_0._teleportEffect = nil
	end

	if arg_10_0._effectRoot then
		gohelper.destroy(arg_10_0._effectRoot)

		arg_10_0._effectRoot = nil
	end

	TaskDispatcher.cancelTask(arg_10_0._checkEffectDispose, arg_10_0)

	arg_10_0._autoDisposeEffect = {}
	arg_10_0._warmingPool = {}
	arg_10_0._useitemPool = {}
	arg_10_0._allInsts = {}
end

return var_0_0
