module("modules.logic.explore.controller.ExploreStepController", package.seeall)

local var_0_0 = class("ExploreStepController", BaseController)

function var_0_0.initMap(arg_1_0)
	if arg_1_0._map then
		return
	end

	arg_1_0._map = ExploreController.instance:getMap()
	arg_1_0._hero = arg_1_0._map:getHero()
	arg_1_0._mapId = ExploreModel.instance:getMapId()

	local var_1_0, var_1_1 = ExploreMapModel.instance:getHeroPos()

	arg_1_0._cachePos = {
		x = var_1_0,
		y = var_1_1
	}
	arg_1_0._stepList = {}
end

function var_0_0.onExploreStepPush(arg_2_0, arg_2_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Explore then
		return
	end

	arg_2_0:initMap()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.steps) do
		local var_2_0 = cjson.decode(iter_2_1.param)
		local var_2_1 = #arg_2_0._stepList

		while arg_2_0._stepList[var_2_1] do
			if arg_2_0._stepList[var_2_1].alwaysLast then
				var_2_1 = var_2_1 - 1
			else
				break
			end
		end

		if var_2_0.stepType == ExploreEnum.StepType.UpdateUnit or var_2_0.stepType == ExploreEnum.StepType.DelUnit then
			var_2_0.interact = cjson.decode(var_2_0.interact)
		end

		if var_2_0.stepType == ExploreEnum.StepType.UpdateUnit then
			for iter_2_2 = #arg_2_0._stepList, 1, -1 do
				local var_2_2 = arg_2_0._stepList[iter_2_2]

				if var_2_2.stepType == ExploreEnum.StepType.UpdateUnit then
					if var_2_2.interact.id == var_2_0.interact.id then
						table.remove(arg_2_0._stepList, iter_2_2)

						var_2_1 = var_2_1 - 1

						break
					end
				else
					break
				end
			end
		end

		table.insert(arg_2_0._stepList, var_2_1 + 1, var_2_0)

		if var_2_0.stepType == ExploreEnum.StepType.RoleMove then
			ExploreMapModel.instance:updatHeroPos(var_2_0.x, var_2_0.y, var_2_0.direction)

			arg_2_0._cachePos = var_2_0
		end
	end

	arg_2_0:startStep()
end

function var_0_0.insertClientStep(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:initMap()

	if arg_3_2 then
		table.insert(arg_3_0._stepList, arg_3_2, arg_3_1)
	else
		table.insert(arg_3_0._stepList, arg_3_1)
	end
end

function var_0_0.forceAsyncPos(arg_4_0)
	arg_4_0:initMap()
	arg_4_0._hero:stopMoving(true)
	arg_4_0._hero:setPosByNode(arg_4_0._cachePos, true)
	arg_4_0._hero:setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	arg_4_0._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true)
end

function var_0_0.startStep(arg_5_0)
	if arg_5_0._curRunStep then
		return
	end

	if ExploreModel.instance:getStepPause() then
		return
	end

	if not arg_5_0._stepList then
		return
	end

	if #arg_5_0._stepList <= 0 then
		arg_5_0:onStepAllDone()

		return
	end

	local var_5_0 = table.remove(arg_5_0._stepList, 1)
	local var_5_1 = var_5_0.stepType
	local var_5_2 = string.format("Explore%sStep", ExploreEnum.StepTypeToName[var_5_1] or "")
	local var_5_3 = _G[var_5_2]

	if var_5_3 then
		arg_5_0._curRunStep = var_5_3.New(var_5_0)
	else
		logError("未处理步骤类型" .. tostring(var_5_1))

		arg_5_0._curRunStep = ExploreStepBase.New(var_5_0)
	end

	return arg_5_0._curRunStep:onStart()
end

function var_0_0.onStepEnd(arg_6_0)
	arg_6_0._curRunStep = nil

	arg_6_0:startStep()
end

function var_0_0.onStepAllDone(arg_7_0)
	return
end

function var_0_0.getCurStepType(arg_8_0)
	if not arg_8_0._curRunStep then
		return
	end

	return arg_8_0._curRunStep._data.stepType
end

function var_0_0.getStepIndex(arg_9_0, arg_9_1)
	if arg_9_0._curRunStep and arg_9_0._curRunStep._data.stepType == arg_9_1 then
		return 0
	end

	if not arg_9_0._stepList then
		return -1
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._stepList) do
		if iter_9_1.stepType == arg_9_1 then
			return iter_9_0
		end
	end

	return -1
end

function var_0_0.clear(arg_10_0)
	arg_10_0._map = nil
	arg_10_0._hero = nil

	if arg_10_0._curRunStep then
		arg_10_0._curRunStep:onDestory()

		arg_10_0._curRunStep = nil
	end

	local var_10_0 = arg_10_0._stepList

	arg_10_0._stepList = {}

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if ExploreEnum.MustDoStep[iter_10_1.stepType] then
				local var_10_1 = string.format("Explore%sStep", ExploreEnum.StepTypeToName[iter_10_1.stepType] or "")

				_G[var_10_1].New(iter_10_1):onStart()
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
