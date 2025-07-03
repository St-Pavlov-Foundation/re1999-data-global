module("modules.logic.fight.system.work.FightWorkShowBuffDialog", package.seeall)

local var_0_0 = class("FightWorkShowBuffDialog", BaseWork)

var_0_0.needStopWork = nil
var_0_0.addBuffRoundId = nil
var_0_0.delBuffRoundId = nil

function var_0_0.onStart(arg_1_0)
	if FightModel.instance:getCurRoundId() == 1 then
		var_0_0.addBuffRoundId = nil
		var_0_0.delBuffRoundId = nil
	end

	var_0_0.needStopWork = nil

	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundBefore)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.BuffRoundAfter)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.RoundEndAndCheckBuff)
	FightController.instance:dispatchEvent(FightEvent.FightDialog, FightViewDialog.Type.checkHaveMagicCircle)

	if var_0_0.needStopWork then
		arg_1_0._flow = FlowSequence.New()

		arg_1_0._flow:addWork(FunctionWork.New(arg_1_0._detectPlayTimeline, arg_1_0))
		arg_1_0._flow:addWork(FightWorkWaitDialog.New())
		arg_1_0._flow:registerDoneListener(arg_1_0._onFightDialogEnd, arg_1_0)
		arg_1_0._flow:start()
	else
		arg_1_0:onDone(true)
	end
end

local var_0_1 = {
	[13304021] = "630404_innate1",
	[13304022] = "630404_innate1",
	[13304020] = "630404_innate1",
	[13304024] = "630404_innate1",
	[13304011] = "630404_innate1",
	[13304019] = "630404_innate1",
	[13304013] = "630404_innate1",
	[13304023] = "630404_innate1",
	[13304012] = "630404_innate1",
	[13304025] = "630404_innate1",
	[13304026] = "630404_innate1",
	[13304027] = "630404_innate1",
	[13304010] = "630404_innate1"
}

function var_0_0._detectPlayTimeline(arg_2_0)
	local var_2_0 = var_0_0.needStopWork

	if var_2_0 and var_0_1[var_2_0.id] then
		local var_2_1 = "-1"
		local var_2_2 = FightHelper.getEntity(var_2_1)

		if var_2_2 and var_2_2.skill then
			local var_2_3 = {
				actId = 0,
				stepUid = 0,
				actEffect = {
					{
						targetId = var_2_1
					}
				},
				fromId = var_2_1,
				toId = var_2_1,
				actType = FightEnum.ActType.SKILL
			}

			var_2_2.skill:playTimeline(var_0_1[var_0_0.needStopWork.id], var_2_3)
		end
	end
end

function var_0_0._onFightDialogEnd(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._flow then
		arg_4_0._flow:unregisterDoneListener(arg_4_0._onFightDialogEnd, arg_4_0)
		arg_4_0._flow:stop()

		arg_4_0._flow = nil
	end
end

return var_0_0
