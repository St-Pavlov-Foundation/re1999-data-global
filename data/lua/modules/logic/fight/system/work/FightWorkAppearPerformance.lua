module("modules.logic.fight.system.work.FightWorkAppearPerformance", package.seeall)

local var_0_0 = class("FightWorkAppearPerformance", BaseWork)

function var_0_0.onStart(arg_1_0)
	arg_1_0._flow = FlowSequence.New()

	arg_1_0._flow:addWork(FightWorkAppearTimeline.New())

	local var_1_0, var_1_1 = FightWorkAppearTimeline.hasAppearTimeline()
	local var_1_2 = FightHelper.getEntity(var_1_1)
	local var_1_3 = var_1_2 and var_1_2:getMO()

	if var_1_0 and var_1_3 then
		arg_1_0._flow:addWork(FunctionWork.New(function()
			local var_2_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

			for iter_2_0, iter_2_1 in ipairs(var_2_0) do
				if iter_2_1.nameUI then
					iter_2_1.nameUI:setActive(false)
				end

				if iter_2_1.setAlpha then
					iter_2_1:setAlpha(0, 0)
				end
			end
		end))
		arg_1_0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterAppearTimeline, var_1_3.modelId))
	end

	arg_1_0._flow:registerDoneListener(arg_1_0._onFlowDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._flow then
		arg_4_0._flow:unregisterDoneListener(arg_4_0._onFlowDone, arg_4_0)
		arg_4_0._flow:stop()

		arg_4_0._flow = nil
	end
end

return var_0_0
