module("modules.logic.versionactivity1_6.act148.model.Activity148Model", package.seeall)

local var_0_0 = 4
local var_0_1 = class("Activity148Model", BaseModel)

function var_0_1.onInit(arg_1_0)
	arg_1_0:initActivity148Mo()
end

function var_0_1.reInit(arg_2_0)
	arg_2_0:initActivity148Mo()
end

function var_0_1.initActivity148Mo(arg_3_0)
	arg_3_0._act148MoDict = {}

	for iter_3_0 = 1, var_0_0 do
		local var_3_0 = iter_3_0
		local var_3_1 = 0
		local var_3_2 = Activity148Mo.New()

		var_3_2:init(var_3_0, var_3_1)

		arg_3_0._act148MoDict[var_3_0] = var_3_2
	end
end

function var_0_1.getAct148SkillMo(arg_4_0, arg_4_1)
	if not arg_4_0._act148MoDict then
		arg_4_0:initActivity148Mo()
	end

	return arg_4_0._act148MoDict[arg_4_1]
end

function var_0_1.getTotalGotSkillPointNum(arg_5_0)
	return arg_5_0._totalSkillPoint and arg_5_0._totalSkillPoint or 0
end

function var_0_1.onReceiveInfos(arg_6_0, arg_6_1)
	if not arg_6_0._act148MoDict then
		arg_6_0:initActivity148Mo()
	end

	arg_6_0._actId = arg_6_1.activityId
	arg_6_0._totalSkillPoint = arg_6_1.totalSkillPoint

	local var_6_0 = arg_6_1.skillTrees

	if #var_6_0 > 0 then
		for iter_6_0 = 1, #var_6_0 do
			local var_6_1 = var_6_0[iter_6_0]

			arg_6_0:updateAct148Mo(var_6_1)
		end
	else
		arg_6_0:initActivity148Mo()
	end
end

function var_0_1.onReceiveLevelUpReply(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.skillTree

	arg_7_0:updateAct148Mo(var_7_0)
end

function var_0_1.onReceiveLevelDownReply(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.skillTree

	arg_8_0:updateAct148Mo(var_8_0)
end

function var_0_1.onResetSkillInfos(arg_9_0, arg_9_1)
	arg_9_0._act148MoDict = {}

	for iter_9_0 = 1, var_0_0 do
		local var_9_0 = iter_9_0
		local var_9_1 = 0
		local var_9_2 = Activity148Mo.New()

		var_9_2:init(var_9_0, var_9_1)

		arg_9_0._act148MoDict[var_9_0] = var_9_2
	end
end

function var_0_1.updateAct148Mo(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.type
	local var_10_1 = arg_10_1.level
	local var_10_2 = arg_10_0._act148MoDict[var_10_0]

	if not var_10_2 then
		var_10_2 = Activity148Mo.New()

		var_10_2:init(var_10_0, var_10_1)

		arg_10_0._act148MoDict[var_10_0] = var_10_2
	end

	var_10_2:updateByServerData(arg_10_1)
end

function var_0_1.getAllSkillPoint(arg_11_0)
	local var_11_0 = 0

	if not arg_11_0._act148MoDict then
		return var_11_0
	end

	for iter_11_0 = 1, var_0_0 do
		local var_11_1 = iter_11_0
		local var_11_2 = arg_11_0._act148MoDict[var_11_1]
		local var_11_3 = var_11_2 and var_11_2:getLevel() or 0

		var_11_0 = var_11_0 + (var_11_3 > 0 and Activity148Config.instance:getAct148SkillPointCost(var_11_1, var_11_3) or 0)
	end

	local var_11_4 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	return var_11_0 + (var_11_4 and var_11_4.quantity or 0)
end

var_0_1.instance = var_0_1.New()

return var_0_1
