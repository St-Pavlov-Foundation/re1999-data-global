module("modules.logic.fight.entity.comp.buff.FightBuffCoverPerson", package.seeall)

local var_0_0 = class("FightBuffCoverPerson")
local var_0_1 = {
	2,
	3,
	5,
	10
}

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entity = arg_1_1
	arg_1_0.buffMO = arg_1_2
	arg_1_0._celebrityCharm = arg_1_0:_calcCelebrityCharm()
	arg_1_0._useCelebrityCharm = 0

	FightController.instance:registerCallback(FightEvent.AddPlayOperationData, arg_1_0._onAddPlayOperationData, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnResetCard, arg_1_0._onResetCard, arg_1_0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, arg_1_0._respBeginRound, arg_1_0)
	FightController.instance:registerCallback(FightEvent.StageChanged, arg_1_0.onStageChange, arg_1_0)
end

function var_0_0._removeEvents(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.AddPlayOperationData, arg_2_0._onAddPlayOperationData, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnResetCard, arg_2_0._onResetCard, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, arg_2_0._respBeginRound, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, arg_2_0.onStageChange, arg_2_0)
end

function var_0_0._onAddPlayOperationData(arg_3_0, arg_3_1)
	if arg_3_1.operType ~= FightEnum.CardOpType.PlayCard then
		return
	end

	if arg_3_1.belongToEntityId ~= arg_3_0.entity.id then
		return
	end

	local var_3_0 = arg_3_1.skillId
	local var_3_1 = lua_skill.configDict[var_3_0].name
	local var_3_2 = arg_3_0.entity:getMO():getSkillLv(var_3_0) or 1
	local var_3_3 = var_0_1[var_3_2]

	if var_3_3 + arg_3_0._useCelebrityCharm <= arg_3_0._celebrityCharm then
		arg_3_0._useCelebrityCharm = arg_3_0._useCelebrityCharm + var_3_3

		arg_3_1:copyCard()
	end
end

function var_0_0._onResetCard(arg_4_0)
	arg_4_0._useCelebrityCharm = 0
end

function var_0_0._respBeginRound(arg_5_0)
	arg_5_0._useCelebrityCharm = 0
end

function var_0_0.onStageChange(arg_6_0, arg_6_1)
	if arg_6_1 == FightStageMgr.StageType.Operate then
		arg_6_0._useCelebrityCharm = 0
		arg_6_0._celebrityCharm = arg_6_0:_calcCelebrityCharm()
	end
end

function var_0_0.onBuffEnd(arg_7_0)
	arg_7_0:_removeEvents()
end

function var_0_0.reset(arg_8_0)
	arg_8_0:_removeEvents()
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:_removeEvents()
end

function var_0_0._calcCelebrityCharm(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.entity:getMO():getBuffDic()) do
		local var_10_1 = lua_skill_buff.configDict[iter_10_1.buffId]

		if (var_10_1 and lua_skill_bufftype.configDict[var_10_1.typeId]).id == FightEnum.BuffTypeId_CelebrityCharm then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

return var_0_0
