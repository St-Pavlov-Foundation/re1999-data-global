module("modules.logic.rouge.map.controller.RougeMapSkillCheckHelper", package.seeall)

local var_0_0 = class("RougeMapSkillCheckHelper")

var_0_0.CantUseMapSkillReason = {
	UseLimit = 1,
	DoingEvent = 5,
	CoinCost = 3,
	StepCd = 2,
	ForbidenPathSelect = 7,
	ForbidenMiddle = 6,
	PowerCost = 4,
	None = 0
}
var_0_0.CantUseSkillToast = {
	[var_0_0.CantUseMapSkillReason.UseLimit] = ToastEnum.CantUseMapSkill_StepCd,
	[var_0_0.CantUseMapSkillReason.StepCd] = ToastEnum.CantUseMapSkill_StepCd,
	[var_0_0.CantUseMapSkillReason.CoinCost] = ToastEnum.CantUseMapSkill,
	[var_0_0.CantUseMapSkillReason.PowerCost] = ToastEnum.CantUseMapSkill,
	[var_0_0.CantUseMapSkillReason.DoingEvent] = ToastEnum.CantUseMapSkill_DoingEvent,
	[var_0_0.CantUseMapSkillReason.ForbidenMiddle] = ToastEnum.CantUseMapSkill_MiddleLayer,
	[var_0_0.CantUseMapSkillReason.ForbidenPathSelect] = ToastEnum.CantUseMapSkill_MiddleLayer
}

function var_0_0.canUseMapSkill(arg_1_0)
	local var_1_0 = var_0_0._getCantUseReason(arg_1_0)

	return not var_1_0 or var_1_0 == var_0_0.CantUseMapSkillReason.None, var_1_0
end

function var_0_0._getCantUseReason(arg_2_0)
	var_0_0._initSkillUseChcekFuncList()

	local var_2_0 = lua_rouge_map_skill.configDict[arg_2_0.id]

	for iter_2_0, iter_2_1 in ipairs(var_0_0._checkFuncList) do
		local var_2_1 = iter_2_1(arg_2_0, var_2_0)

		if var_2_1 and var_2_1 ~= var_0_0.CantUseMapSkillReason.None then
			return var_2_1
		end
	end
end

function var_0_0.showCantUseMapSkillToast(arg_3_0)
	local var_3_0 = var_0_0.CantUseSkillToast[arg_3_0]

	if var_3_0 then
		GameFacade.showToast(var_3_0)
	end
end

function var_0_0._initSkillUseChcekFuncList()
	if not var_0_0._checkFuncList then
		var_0_0._checkFuncList = {
			var_0_0.checkDoineEvent,
			var_0_0.checkMiddleLayer,
			var_0_0.checkPathSelectLayer,
			var_0_0.checkUseLimiter,
			var_0_0.checkStepCd,
			var_0_0.checkCoinCost,
			var_0_0.checkPowerCost
		}
	end
end

function var_0_0.checkDoineEvent(arg_5_0, arg_5_1)
	if RougeMapModel.instance:isNormalLayer() then
		local var_5_0 = RougeMapModel.instance:getCurNode()

		if var_5_0 and var_5_0:checkIsNormal() and not var_5_0:isFinishEvent() then
			return var_0_0.CantUseMapSkillReason.DoingEvent
		end
	end
end

function var_0_0.checkMiddleLayer(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.middleLayerLimit == 0
	local var_6_1 = RougeMapModel.instance:isMiddle()

	if var_6_0 and var_6_1 then
		return var_0_0.CantUseMapSkillReason.ForbidenMiddle
	end
end

function var_0_0.checkPathSelectLayer(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.middleLayerLimit == 0
	local var_7_1 = RougeMapModel.instance:isPathSelect()

	if var_7_0 and var_7_1 then
		return var_0_0.CantUseMapSkillReason.ForbidenPathSelect
	end
end

function var_0_0.checkUseLimiter(arg_8_0, arg_8_1)
	if arg_8_0:getUseCount() >= arg_8_1.useLimit then
		return var_0_0.CantUseMapSkillReason.UseLimit
	end
end

function var_0_0.checkStepCd(arg_9_0, arg_9_1)
	if arg_9_0:getStepRecord() >= arg_9_1.stepCd then
		return var_0_0.CantUseMapSkillReason.StepCd
	end
end

function var_0_0.checkCoinCost(arg_10_0, arg_10_1)
	local var_10_0 = RougeModel.instance:getRougeInfo()

	if (var_10_0 and var_10_0.coin or 0) < arg_10_1.coinCost then
		return var_0_0.CantUseMapSkillReason.CoinCost
	end
end

function var_0_0.checkPowerCost(arg_11_0, arg_11_1)
	local var_11_0 = RougeModel.instance:getRougeInfo()

	if (var_11_0 and var_11_0.power or 0) < arg_11_1.powerCost then
		return var_0_0.CantUseMapSkillReason.PowerCost
	end
end

function var_0_0._initUseMapSkillCallBackMap()
	if not var_0_0._mapSkillUseCallBackMap then
		var_0_0._mapSkillUseCallBackMap = {
			[13002] = var_0_0.useMapSkill_13002
		}
	end
end

function var_0_0.executeUseMapSkillCallBack(arg_13_0)
	if not arg_13_0 then
		return
	end

	var_0_0._initUseMapSkillCallBackMap()

	local var_13_0 = var_0_0._mapSkillUseCallBackMap[arg_13_0.id]

	if var_13_0 then
		var_13_0(arg_13_0)
	end
end

local function var_0_1(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = RougeMapModel.instance:getNode(arg_14_0)

	if var_14_0 and not var_14_0:checkIsEnd() then
		local var_14_1 = var_14_0.nextNodeList

		if var_14_1 then
			for iter_14_0, iter_14_1 in ipairs(var_14_1) do
				local var_14_2 = RougeMapModel.instance:getNode(iter_14_1)
				local var_14_3 = var_14_2 and var_14_2:getEventCo()
				local var_14_4 = var_14_3 and var_14_3.type == RougeMapEnum.EventType.TreasurePlace

				if var_14_2 and not var_14_2:checkIsEnd() and not var_14_4 and not arg_14_1[iter_14_1] then
					arg_14_1[iter_14_1] = true

					table.insert(arg_14_2, iter_14_1)
				end

				var_0_1(iter_14_1, arg_14_1, arg_14_2)
			end
		end
	end
end

function var_0_0.useMapSkill_13002(arg_15_0, arg_15_1)
	if RougeMapModel.instance:isNormalLayer() then
		local var_15_0 = RougeMapModel.instance:getCurNode()
		local var_15_1 = {}
		local var_15_2 = {}
		local var_15_3 = var_15_0 and var_15_0.nodeId

		var_0_1(var_15_3, var_15_1, var_15_2)

		if #var_15_2 < 2 then
			GameFacade.showToast(ToastEnum.UseMapSkillLimit_13002)
		end
	end
end

return var_0_0
