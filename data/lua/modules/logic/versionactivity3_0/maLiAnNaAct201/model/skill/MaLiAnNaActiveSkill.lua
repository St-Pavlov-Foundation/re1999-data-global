module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaActiveSkill", package.seeall)

local var_0_0 = class("MaLiAnNaActiveSkill", MaLiAnNaSkillBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._config = Activity201MaLiAnNaConfig.instance:getActiveSkillConfig(arg_1_2)

	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._cdTime = 0
	arg_1_0._skillParams = {}
	arg_1_0._skillParamCount = 0

	local var_1_0 = arg_1_0:getSkillActionType()

	if var_1_0 == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider or var_1_0 == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider or var_1_0 == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		arg_1_0._skillParamCount = 1
	end

	if var_1_0 == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		arg_1_0._skillParamCount = 2
	end

	arg_1_0._skillType = Activity201MaLiAnNaEnum.SkillType.active
end

function var_0_0.addParams(arg_2_0, arg_2_1)
	if arg_2_0:paramIsFull() then
		return true
	end

	if arg_2_1 == nil then
		return false
	end

	local var_2_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_2_1)

	if var_2_0 == nil then
		return false
	end

	if arg_2_0:getSkillNeedSlotCamp() == var_2_0:getSlotCamp() then
		arg_2_0._skillParams[#arg_2_0._skillParams + 1] = arg_2_1

		return true
	end

	return false
end

function var_0_0.getSkillNeedSlotCamp(arg_3_0)
	local var_3_0 = arg_3_0:getSkillActionType()

	if var_3_0 == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Player
	end

	if var_3_0 == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider then
		return Activity201MaLiAnNaEnum.CampType.Enemy
	end

	if var_3_0 == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Enemy
	end

	if var_3_0 == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		return Activity201MaLiAnNaEnum.CampType.Player
	end

	return Activity201MaLiAnNaEnum.CampType.Player
end

function var_0_0.clearParams(arg_4_0)
	tabletool.clear(arg_4_0._skillParams)
end

function var_0_0.paramIsFull(arg_5_0)
	return #arg_5_0._skillParams == arg_5_0._skillParamCount
end

function var_0_0.execute(arg_6_0)
	if arg_6_0:isInCD() then
		return
	end

	Activity201MaLiAnNaGameController.instance:addAction(arg_6_0:getEffect(), arg_6_0._skillParams)

	arg_6_0._cdTime = arg_6_0._config.coolDown

	local var_6_0 = arg_6_0._skillParams[1]
	local var_6_1 = arg_6_0._skillParams[2]

	if var_6_0 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowShowVX, var_6_0, arg_6_0:getSkillActionType())
	end

	if var_6_1 then
		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.ShowShowVX, var_6_1, arg_6_0:getSkillActionType(), 1)
	end

	arg_6_0:clearParams()
end

function var_0_0.isInCD(arg_7_0)
	return arg_7_0._cdTime > 0
end

function var_0_0.getCDPercent(arg_8_0)
	return arg_8_0._cdTime / arg_8_0._config.coolDown
end

function MaLiAnNaPassiveSkill.destroy(arg_9_0)
	arg_9_0._config = nil
end

return var_0_0
