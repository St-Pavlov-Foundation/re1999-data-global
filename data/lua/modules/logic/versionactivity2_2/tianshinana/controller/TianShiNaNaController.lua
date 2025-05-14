module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaController", package.seeall)

local var_0_0 = class("TianShiNaNaController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._stepFlow = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearFlow()
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:registerCallback(TianShiNaNaEvent.ExitLevel, arg_3_0.clearFlow, arg_3_0)
end

function var_0_0.openMainView(arg_4_0)
	Activity167Rpc.instance:sendGetAct167InfoRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, arg_4_0._onRecvMsg, arg_4_0)
end

function var_0_0._onRecvMsg(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 then
		ViewMgr.instance:openView(ViewName.TianShiNaNaMainView)
	end
end

function var_0_0.buildFlow(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._stepFlow

	arg_6_0._stepFlow = arg_6_0._stepFlow or FlowSequence.New()

	local var_6_1 = TianShiNaNaPlayEffectWork.New()

	arg_6_0._stepFlow:addWork(var_6_1)

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_3 = cjson.decode(iter_6_1.param)

		if var_6_3.stepType == TianShiNaNaEnum.StepType.Move and var_6_3.id == TianShiNaNaModel.instance:getHeroMo().co.id then
			table.insert(var_6_2, var_6_3)
		end

		local var_6_4 = _G[string.format("TianShiNaNa%sStep", TianShiNaNaEnum.StepTypeToName[var_6_3.stepType] or "")]

		if var_6_4 then
			local var_6_5 = var_6_4.New()

			var_6_5:initData(var_6_3)
			arg_6_0._stepFlow:addWork(var_6_5)
		else
			logError("未处理步骤类型" .. var_6_3.stepType)
		end
	end

	var_6_1:setWalkPath(var_6_2)

	if not var_6_0 then
		arg_6_0._stepFlow:addWork(TianShiNaNaMapCollapseStep.New())
		arg_6_0._stepFlow:registerDoneListener(arg_6_0.flowDone, arg_6_0)

		if TianShiNaNaModel.instance.sceneLevelLoadFinish then
			if TianShiNaNaModel.instance:getState() ~= TianShiNaNaEnum.CurState.DoStep then
				TianShiNaNaModel.instance:setState(TianShiNaNaEnum.CurState.DoStep)
			end

			arg_6_0._stepFlow:start()
		else
			TianShiNaNaModel.instance.waitStartFlow = true
		end
	end
end

function var_0_0.checkBeginFlow(arg_7_0)
	local var_7_0 = TianShiNaNaModel.instance.waitStartFlow

	TianShiNaNaModel.instance.waitStartFlow = false

	if var_7_0 and arg_7_0._stepFlow then
		arg_7_0._stepFlow:start()
	end
end

function var_0_0.flowDone(arg_8_0, arg_8_1)
	arg_8_0:dispatchEvent(TianShiNaNaEvent.OnFlowEnd, arg_8_1)

	arg_8_0._stepFlow = nil
end

function var_0_0.clearFlow(arg_9_0)
	TianShiNaNaModel.instance.waitStartFlow = false

	if arg_9_0._stepFlow then
		arg_9_0._stepFlow:onDestroyInternal()

		arg_9_0._stepFlow = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
