module("modules.logic.survival.controller.work.SurvivalContinueMoveWork", package.seeall)

local var_0_0 = class("SurvivalContinueMoveWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	if var_1_0 and (not arg_1_1 or not arg_1_1.isEnterFight) and SurvivalMapModel.instance.result == SurvivalEnum.MapResult.None and not arg_1_0.context.fastExecute then
		local var_1_1 = var_1_0.player.pos

		if type(arg_1_1.tryTrigger) == "table" then
			local var_1_2 = var_1_0:getUnitByPos(var_1_1, true)
			local var_1_3 = false

			for iter_1_0, iter_1_1 in ipairs(var_1_2) do
				if arg_1_1.tryTrigger[iter_1_1.id] then
					var_1_3 = true

					break
				end
			end

			if not var_1_3 then
				arg_1_1.tryTrigger = nil
			end
		end

		local var_1_4, var_1_5 = SurvivalMapModel.instance:getTargetPos()

		if var_1_4 or arg_1_1.tryTrigger and not var_1_0.panel then
			if arg_1_1.tryTrigger or var_1_4 == var_1_1 then
				SurvivalMapHelper.instance:tryShowEventView(var_1_1)
			else
				local var_1_6

				if var_1_5 then
					for iter_1_2, iter_1_3 in ipairs(var_1_5) do
						if iter_1_3 == var_1_1 then
							var_1_6 = var_1_5[iter_1_2 + 1]

							break
						end
					end
				end

				if not var_1_6 then
					local var_1_7 = SurvivalMapModel.instance:getCurMapCo().walkables
					local var_1_8 = SurvivalAStarFindPath.instance:findPath(var_1_1, var_1_4, var_1_7)

					if var_1_8 then
						var_1_6 = var_1_8[1]
					end
				end

				if var_1_6 then
					arg_1_0._nextPos = var_1_6

					TaskDispatcher.runDelay(arg_1_0._delaySendMoveReq, arg_1_0, 0)
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._delaySendMoveReq(arg_2_0)
	if SurvivalMapHelper.instance:isInFlow() or not arg_2_0._nextPos then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SurvivalGuideLock) then
		return
	end

	local var_2_0 = SurvivalMapModel.instance:getSceneMo().player.pos
	local var_2_1 = SurvivalHelper.instance:getDir(var_2_0, arg_2_0._nextPos)

	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.PlayerMove, tostring(var_2_1))
end

return var_0_0
