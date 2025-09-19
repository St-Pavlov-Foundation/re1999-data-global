module("modules.logic.scene.shelter.comp.SurvivalShelterScenePathComp", package.seeall)

local var_0_0 = class("SurvivalShelterScenePathComp", BaseSceneComp)

var_0_0.ResPaths = {
	Point = "survival/transport/v2a8_survival_transport_e.prefab"
}

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._pathRoot = gohelper.create3d(arg_1_0._sceneGo, "Effect")

	local var_1_0 = arg_1_0._pathRoot.transform

	transformhelper.setLocalPos(var_1_0, 0, 0.01, 0)

	arg_1_0.effectList = {}
	arg_1_0._pools = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.ResPaths) do
		arg_1_0._pools[iter_1_1] = {}
	end
end

function var_0_0.showPath(arg_2_0, arg_2_1)
	arg_2_0:clearEffects()

	local var_2_0 = arg_2_1[#arg_2_1]

	if not var_2_0 then
		return
	end

	table.insert(arg_2_0.effectList, arg_2_0:getObj(var_0_0.ResPaths.Point, var_2_0, 0))
end

function var_0_0.hidePath(arg_3_0)
	arg_3_0:clearEffects()
end

function var_0_0.getObj(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = table.remove(arg_4_0._pools[arg_4_1])

	if var_4_0 then
		gohelper.setActive(var_4_0, true)
	else
		local var_4_1 = SurvivalMapHelper.instance:getBlockRes(arg_4_1)

		var_4_0 = gohelper.clone(var_4_1, arg_4_0._pathRoot)
	end

	local var_4_2 = var_4_0.transform
	local var_4_3, var_4_4, var_4_5 = SurvivalHelper.instance:hexPointToWorldPoint(arg_4_2.q, arg_4_2.r)

	transformhelper.setLocalPos(var_4_2, var_4_3, var_4_4, var_4_5)
	transformhelper.setLocalRotation(var_4_2, 0, arg_4_3 + 90, 0)

	return {
		path = arg_4_1,
		go = var_4_0
	}
end

function var_0_0.returnObj(arg_5_0, arg_5_1, arg_5_2)
	table.insert(arg_5_0._pools[arg_5_1], arg_5_2)
	gohelper.setActive(arg_5_2, false)
end

function var_0_0.clearEffects(arg_6_0)
	if not next(arg_6_0.effectList) then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.effectList) do
		arg_6_0:returnObj(iter_6_1.path, iter_6_1.go)
	end

	arg_6_0.effectList = {}
end

function var_0_0.onSceneClose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._pools) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			gohelper.destroy(iter_7_3)
		end
	end

	arg_7_0._pools = {}

	for iter_7_4, iter_7_5 in ipairs(arg_7_0.effectList) do
		gohelper.destroy(iter_7_5.go)
	end

	arg_7_0.effectList = {}
end

return var_0_0
