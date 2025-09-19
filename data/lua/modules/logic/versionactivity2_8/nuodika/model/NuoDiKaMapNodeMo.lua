module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaMapNodeMo", package.seeall)

local var_0_0 = pureTable("NuoDiKaMapNodeMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.x = arg_1_1[1]
	arg_1_0.y = arg_1_1[2]
	arg_1_0.id = 100 * arg_1_0.x + arg_1_0.y
	arg_1_0.nodeType = arg_1_1[3]
	arg_1_0.eventList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[4]) do
		table.insert(arg_1_0.eventList, iter_1_1)
	end

	arg_1_0.initEventCo = nil

	arg_1_0:resetNode()
end

function var_0_0.getInitEvent(arg_2_0)
	return arg_2_0.initEventCo
end

function var_0_0.getEvent(arg_3_0)
	return arg_3_0.eventCo
end

function var_0_0.clearEvent(arg_4_0)
	arg_4_0.hp = 0
	arg_4_0.atk = 0
	arg_4_0.limitInteract = 0
	arg_4_0.eventCo = nil
	arg_4_0.isWarn = false
end

function var_0_0.setNodeEvent(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1 > 0 then
		arg_5_0.eventCo = NuoDiKaConfig.instance:getEventCo(arg_5_1)
	end

	if arg_5_0.eventCo then
		if arg_5_0.eventCo.initVisible > 0 then
			if not arg_5_0.isUnlock and arg_5_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				local var_5_0 = NuoDiKaConfig.instance:getEnemyCo(arg_5_0.eventCo.eventParam)
				local var_5_1 = NuoDiKaConfig.instance:getSkillCo(var_5_0.skillID)
				local var_5_2 = string.splitToNumber(var_5_1.trigger, "#")

				if var_5_2[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
					arg_5_0.interactTimes = var_5_2[2]
				end
			end

			arg_5_0.isUnlock = true
		end

		if arg_5_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
			local var_5_3 = NuoDiKaConfig.instance:getEnemyCo(arg_5_0.eventCo.eventParam)

			arg_5_0.hp = var_5_3.hp
			arg_5_0.atk = var_5_3.atk
		end
	end
end

function var_0_0.setNodeUnlock(arg_6_0, arg_6_1)
	if not arg_6_0.isUnlock and arg_6_1 and arg_6_0.eventCo and arg_6_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
		local var_6_0 = NuoDiKaConfig.instance:getEnemyCo(arg_6_0.eventCo.eventParam)
		local var_6_1 = NuoDiKaConfig.instance:getSkillCo(var_6_0.skillID)
		local var_6_2 = string.splitToNumber(var_6_1.trigger, "#")

		if var_6_2[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
			arg_6_0.interactTimes = var_6_2[2]
		end
	end

	arg_6_0.isUnlock = arg_6_1
end

function var_0_0.isNodeUnlock(arg_7_0)
	return arg_7_0.isUnlock
end

function var_0_0.isNodeHasEnemy(arg_8_0)
	if arg_8_0.eventCo and arg_8_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
		return true
	end

	return false
end

function var_0_0.setNodeItemUse(arg_9_0)
	arg_9_0.eventCo = nil
end

function var_0_0.isNodeHasItem(arg_10_0)
	if arg_10_0.eventCo and arg_10_0.eventCo.eventType == NuoDiKaEnum.EventType.Item then
		return true
	end

	return false
end

function var_0_0.reduceHp(arg_11_0, arg_11_1)
	arg_11_0.hp = arg_11_0.hp - arg_11_1

	if arg_11_0.hp <= 0 then
		arg_11_0:clearEvent()
	end
end

function var_0_0.reduceAtk(arg_12_0, arg_12_1)
	arg_12_0.atk = arg_12_0.atk - arg_12_1
end

function var_0_0.reduceInteract(arg_13_0, arg_13_1)
	if not arg_13_0.eventCo or arg_13_0.eventCo.eventType ~= NuoDiKaEnum.EventType.Enemy then
		return
	end

	local var_13_0 = NuoDiKaConfig.instance:getEnemyCo(arg_13_0.eventCo.eventParam)
	local var_13_1 = NuoDiKaConfig.instance:getSkillCo(var_13_0.skillID)
	local var_13_2 = string.splitToNumber(var_13_1.trigger, "#")

	if var_13_2[1] ~= NuoDiKaEnum.TriggerTimingType.InteractTimes then
		return
	end

	arg_13_0.interactTimes = arg_13_0.interactTimes - arg_13_1

	if arg_13_0.interactTimes <= 0 then
		arg_13_0.interactTimes = var_13_2[2]
	end
end

function var_0_0.isTriggerTypeEnemy(arg_14_0)
	if not arg_14_0.eventCo or arg_14_0.eventCo.eventType ~= NuoDiKaEnum.EventType.Enemy then
		return false
	end

	local var_14_0 = NuoDiKaConfig.instance:getEnemyCo(arg_14_0.eventCo.eventParam)
	local var_14_1 = NuoDiKaConfig.instance:getSkillCo(var_14_0.skillID)

	if string.splitToNumber(var_14_1.trigger, "#")[1] ~= NuoDiKaEnum.TriggerTimingType.InteractTimes then
		return false
	end

	return true
end

function var_0_0.gainHp(arg_15_0, arg_15_1)
	arg_15_0.hp = arg_15_0.hp + arg_15_1
end

function var_0_0.gainAtk(arg_16_0, arg_16_1)
	arg_16_0.atk = arg_16_0.atk + arg_16_1
end

function var_0_0.setWarn(arg_17_0, arg_17_1)
	arg_17_0.isWarn = arg_17_1
end

function var_0_0.resetNode(arg_18_0)
	arg_18_0.isUnlock = false
	arg_18_0.isWarn = false
	arg_18_0.eventCo = nil

	local var_18_0 = 0

	arg_18_0.hp = 0
	arg_18_0.atk = 0

	if arg_18_0.nodeType == NuoDiKaEnum.NodeType.Normal then
		var_18_0 = arg_18_0.eventList[1]
	elseif arg_18_0.nodeType == NuoDiKaEnum.NodeType.Random then
		var_18_0 = arg_18_0.eventList[math.random(1, #arg_18_0.eventList)]
	end

	if var_18_0 and var_18_0 > 0 then
		arg_18_0.eventCo = NuoDiKaConfig.instance:getEventCo(var_18_0)
		arg_18_0.initEventCo = NuoDiKaConfig.instance:getEventCo(var_18_0)
	end

	if arg_18_0.eventCo then
		if arg_18_0.eventCo.initVisible > 0 then
			if not arg_18_0.isUnlock and arg_18_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
				local var_18_1 = NuoDiKaConfig.instance:getEnemyCo(arg_18_0.eventCo.eventParam)
				local var_18_2 = NuoDiKaConfig.instance:getSkillCo(var_18_1.skillID)
				local var_18_3 = string.splitToNumber(var_18_2.trigger, "#")

				if var_18_3[1] == NuoDiKaEnum.TriggerTimingType.InteractTimes then
					arg_18_0.interactTimes = var_18_3[2]
				end
			end

			arg_18_0.isUnlock = true
		end

		if arg_18_0.eventCo.eventType == NuoDiKaEnum.EventType.Enemy then
			local var_18_4 = NuoDiKaConfig.instance:getEnemyCo(arg_18_0.eventCo.eventParam)

			arg_18_0.hp = var_18_4.hp
			arg_18_0.atk = var_18_4.atk
		end
	end
end

function var_0_0.getEventList(arg_19_0)
	return arg_19_0.eventList
end

return var_0_0
