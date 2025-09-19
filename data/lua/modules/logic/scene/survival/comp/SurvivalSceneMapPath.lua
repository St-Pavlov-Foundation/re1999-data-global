module("modules.logic.scene.survival.comp.SurvivalSceneMapPath", package.seeall)

local var_0_0 = class("SurvivalSceneMapPath", BaseSceneComp)

var_0_0.ResPaths = {
	line180 = "survival/transport/v2a8_survival_transport_b.prefab",
	tail = "survival/transport/v2a8_survival_transport_a.prefab",
	linePoint = "survival/transport/v2a8_survival_transport_e.prefab",
	line60 = "survival/transport/v2a8_survival_transport_c.prefab",
	line120 = "survival/transport/v2a8_survival_transport_d.prefab"
}

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._pathRoot = gohelper.create3d(arg_1_0._sceneGo, "PathRoot")

	local var_1_0 = arg_1_0._pathRoot.transform

	transformhelper.setLocalPos(var_1_0, 0, 0.01, 0)

	arg_1_0._curShowLines = {}
	arg_1_0._pools = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.ResPaths) do
		arg_1_0._pools[iter_1_1] = {}
	end
end

function var_0_0.setPathListShow(arg_2_0, arg_2_1)
	TaskDispatcher.cancelTask(arg_2_0.setPathListShow, arg_2_0)
	arg_2_0:clearCurLines()

	if arg_2_1 and #arg_2_1 >= 2 then
		for iter_2_0 = 1, #arg_2_1 do
			local var_2_0, var_2_1 = arg_2_0:getPathAndRotate(arg_2_1[iter_2_0 - 1], arg_2_1[iter_2_0], arg_2_1[iter_2_0 + 1])
			local var_2_2 = arg_2_0:getObj(var_2_0, arg_2_1[iter_2_0], var_2_1)

			table.insert(arg_2_0._curShowLines, var_2_2)
		end

		table.insert(arg_2_0._curShowLines, arg_2_0:getObj(var_0_0.ResPaths.linePoint, arg_2_1[#arg_2_1], 0))

		local var_2_3 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.MoveCost)

		SurvivalMapModel.instance.showCostTime = (#arg_2_1 - 1) * var_2_3
	else
		SurvivalMapModel.instance.showCostTime = 0
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCostTimeUpdate)
end

function var_0_0.getPathAndRotate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		local var_3_0 = SurvivalHelper.instance:getDir(arg_3_2, arg_3_3)

		return var_0_0.ResPaths.tail, var_3_0 * 60
	elseif not arg_3_3 then
		local var_3_1 = SurvivalHelper.instance:getDir(arg_3_2, arg_3_1)

		return var_0_0.ResPaths.tail, var_3_1 * 60
	else
		local var_3_2 = SurvivalHelper.instance:getDir(arg_3_2, arg_3_1)
		local var_3_3 = SurvivalHelper.instance:getDir(arg_3_2, arg_3_3)
		local var_3_4 = (var_3_3 - var_3_2 + 6) % 6

		if var_3_4 == 3 then
			return var_0_0.ResPaths.line180, var_3_2 * 60
		elseif var_3_4 == 2 then
			return var_0_0.ResPaths.line120, var_3_2 * 60
		elseif var_3_4 == 1 then
			return var_0_0.ResPaths.line60, var_3_2 * 60
		elseif var_3_4 == 4 then
			return var_0_0.ResPaths.line120, var_3_3 * 60
		elseif var_3_4 == 5 then
			return var_0_0.ResPaths.line60, var_3_3 * 60
		end
	end
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

function var_0_0.clearCurLines(arg_6_0)
	if not next(arg_6_0._curShowLines) then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._curShowLines) do
		arg_6_0:returnObj(iter_6_1.path, iter_6_1.go)
	end

	arg_6_0._curShowLines = {}
end

function var_0_0.setDelayHide(arg_7_0)
	SurvivalMapModel.instance.showCostTime = 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCostTimeUpdate)
	TaskDispatcher.runDelay(arg_7_0.setPathListShow, arg_7_0, 0.3)
end

function var_0_0.onSceneClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.setPathListShow, arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._pools) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			gohelper.destroy(iter_8_3)
		end
	end

	arg_8_0._pools = {}

	for iter_8_4, iter_8_5 in ipairs(arg_8_0._curShowLines) do
		gohelper.destroy(iter_8_5.go)
	end

	arg_8_0._curShowLines = {}
end

return var_0_0
