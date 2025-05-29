module("modules.logic.fight.entity.comp.buff.FightBuffRecordByRound", package.seeall)

local var_0_0 = class("FightBuffRecordByRound")

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardData, arg_1_0.onUpdateRecordCard, arg_1_0)
	arg_1_0:onUpdateRecordCard(arg_1_2)
end

function var_0_0.onUpdateRecordCard(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1 and arg_2_1.actCommonParams or ""
	local var_2_1 = FightStrUtil.instance:getSplitToNumberCache(var_2_0, "#")
	local var_2_2 = arg_2_0.entity.heroCustomComp and arg_2_0.entity.heroCustomComp:getCustomComp()

	if var_2_2 then
		var_2_2:setCacheRecordSkillList(var_2_1)
	end

	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardUI)
end

function var_0_0.onBuffEnd(arg_3_0)
	arg_3_0:clear()
end

function var_0_0.clear(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardData, arg_4_0.onUpdateRecordCard, arg_4_0)
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:clear()
end

return var_0_0
