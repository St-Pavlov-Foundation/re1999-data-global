module("modules.logic.versionactivity2_5.autochess.flow.AutoChessSideWork", package.seeall)

local var_0_0 = class("AutoChessSideWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.flowCnt = 1
	arg_1_0.seqFlow = FlowSequence.New()

	arg_1_0.seqFlow:registerDoneListener(arg_1_0.onDone, arg_1_0)

	arg_1_0.effectList = arg_1_1

	arg_1_0:initSideWork()
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0.seqFlow:start(arg_2_1)
end

function var_0_0.onStop(arg_3_0)
	arg_3_0.seqFlow:stop()
end

function var_0_0.onResume(arg_4_0)
	arg_4_0.seqFlow:resume()
end

function var_0_0.onReset(arg_5_0)
	arg_5_0.seqFlow:reset()
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0.seqFlow:unregisterDoneListener(arg_6_0.onDone, arg_6_0)
	arg_6_0.seqFlow:destroy()

	arg_6_0.seqFlow = nil
	arg_6_0.effectList = nil
end

function var_0_0.initSideWork(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.effectList) do
		if iter_7_1.effectType == AutoChessEnum.EffectType.NextFightStep then
			arg_7_0:recursion(iter_7_1.nextFightStep)
		else
			local var_7_0 = AutoChessEffectWork.New(iter_7_1)

			arg_7_0.seqFlow:addWork(var_7_0)
		end
	end
end

function var_0_0.recursion(arg_8_0, arg_8_1)
	if arg_8_1.actionType == AutoChessEnum.ActionType.ChessMove then
		local var_8_0 = FlowParallel.New()

		for iter_8_0, iter_8_1 in ipairs(arg_8_1.effect) do
			if iter_8_1.effectType == AutoChessEnum.EffectType.ChessMove then
				local var_8_1 = AutoChessEffectWork.New(iter_8_1)

				var_8_0:addWork(var_8_1)
			else
				logError("异常:棋子移动Action下面不该有其他类型Effect")
			end
		end

		arg_8_0.seqFlow:addWork(var_8_0)
	else
		local var_8_2

		if arg_8_1.actionType == AutoChessEnum.ActionType.ChessSkill then
			local var_8_3 = AutoChessSkillWork.New(arg_8_1)

			arg_8_0.seqFlow:addWork(var_8_3)

			local var_8_4 = lua_auto_chess_skill.configDict[tonumber(arg_8_1.reasonId)]

			if var_8_4 then
				local var_8_5 = var_8_4.skilleffID

				if not string.nilorempty(var_8_5) then
					var_8_2 = string.splitToNumber(var_8_5, "#")
				end
			end
		end

		for iter_8_2, iter_8_3 in ipairs(arg_8_1.effect) do
			if iter_8_3.effectType == AutoChessEnum.EffectType.NextFightStep then
				arg_8_0:recursion(iter_8_3.nextFightStep)
			else
				local var_8_6 = AutoChessEffectWork.New(iter_8_3)

				arg_8_0.seqFlow:addWork(var_8_6)

				if var_8_2 and iter_8_3.effectType == var_8_2[2] then
					var_8_6:markSkillEffect(var_8_2[1])
				end
			end
		end
	end
end

return var_0_0
