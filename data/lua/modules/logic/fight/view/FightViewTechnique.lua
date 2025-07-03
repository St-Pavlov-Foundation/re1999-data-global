module("modules.logic.fight.view.FightViewTechnique", package.seeall)

local var_0_0 = class("FightViewTechnique", BaseView)
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7

function var_0_0.onInitView(arg_1_0)
	if not var_0_1 then
		var_0_1 = {}
		var_0_2 = {}
		var_0_4 = {}
		var_0_5 = {}
		var_0_6 = {}
		var_0_7 = {}

		for iter_1_0, iter_1_1 in ipairs(lua_fight_technique.configList) do
			local var_1_0 = string.split(iter_1_1.condition, "|")

			for iter_1_2, iter_1_3 in ipairs(var_1_0) do
				local var_1_1 = string.split(iter_1_3, "#")

				if var_1_1[1] == "1" then
					local var_1_2 = tonumber(var_1_1[2])

					var_0_1[var_1_2] = iter_1_1.id
				elseif var_1_1[1] == "2" then
					local var_1_3 = tonumber(var_1_1[2])

					var_0_2[var_1_3] = iter_1_1.id
				elseif var_1_1[1] == "3" then
					var_0_3 = iter_1_1.id
				elseif var_1_1[1] == "4" then
					table.insert(var_0_4, iter_1_1.id)
				elseif var_1_1[1] == "5" then
					table.insert(var_0_5, iter_1_1.id)
				elseif var_1_1[1] == "6" then
					table.insert(var_0_6, iter_1_1.id)
				elseif var_1_1[1] == "7" then
					table.insert(var_0_7, iter_1_1.id)
				end
			end
		end
	end

	arg_1_0._scrollGO = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_effecttips")
	arg_1_0._originY = recthelper.getAnchorY(arg_1_0._scrollGO.transform)
end

function var_0_0.addEvents(arg_2_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightTechnique) then
		return
	end

	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnDistributeCards, arg_2_0._onDistributeCards, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_2_0._beforePlaySkill, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateSimpleProperty, arg_2_0._updateSimpleProperty, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_2_0._onSetStateForDialogBeforeStartFight, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.TriggerCardShowResistanceTag, arg_2_0.onTriggerCardShowResistanceTag, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, arg_2_0.onStartAllocateCardEnergy, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddUseCard, arg_2_0.AddUseCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BloodPool_OnCreate, arg_2_0.onBloodPoolCreate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnDistributeCards, arg_3_0._onDistributeCards, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_3_0._beforePlaySkill, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateSimpleProperty, arg_3_0._updateSimpleProperty, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SetStateForDialogBeforeStartFight, arg_3_0._onSetStateForDialogBeforeStartFight, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.TriggerCardShowResistanceTag, arg_3_0.onTriggerCardShowResistanceTag, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, arg_3_0.onStartAllocateCardEnergy, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.AddUseCard, arg_3_0.AddUseCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.BloodPool_OnCreate, arg_3_0.onBloodPoolCreate, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	FightViewTechniqueModel.instance:initFromSimpleProperty()
	arg_4_0:_udpateAnchorY()
end

function var_0_0.onBloodPoolCreate(arg_5_0, arg_5_1)
	if arg_5_1 ~= FightEnum.TeamType.MySide then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(var_0_7) do
		arg_5_0:_checkAdd(iter_5_1)
	end
end

function var_0_0.onTriggerCardShowResistanceTag(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(var_0_4) do
		arg_6_0:_checkAdd(iter_6_1)
	end
end

function var_0_0.onStartAllocateCardEnergy(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(var_0_5) do
		arg_7_0:_checkAdd(iter_7_1)
	end
end

function var_0_0.AddUseCard(arg_8_0, arg_8_1)
	local var_8_0 = FightPlayCardModel.instance:getUsedCards()

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = var_8_0[iter_8_1]

		if var_8_1 and FightHelper.isASFDSkill(var_8_1.skillId) then
			for iter_8_2, iter_8_3 in ipairs(var_0_6) do
				arg_8_0:_checkAdd(iter_8_3)
			end
		end
	end
end

function var_0_0._onBuffUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local var_9_0 = lua_skill_buff.configDict[arg_9_3]

	if not var_9_0 then
		return
	end

	local var_9_1 = var_0_1[var_9_0.typeId]

	if not var_9_1 then
		return
	end

	arg_9_0:_checkAdd(var_9_1)
end

function var_0_0._onDistributeCards(arg_10_0)
	arg_10_0:removeEventCb(FightController.instance, FightEvent.OnDistributeCards, arg_10_0._onDistributeCards, arg_10_0)

	local var_10_0 = FightModel.instance:getFightParam().battleId
	local var_10_1 = var_10_0 and var_0_2[var_10_0]

	if not var_10_1 then
		return
	end

	arg_10_0:_checkAdd(var_10_1)
end

function var_0_0._beforePlaySkill(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1:getMO() then
		return
	end

	arg_11_0._rejectTypes = nil
	arg_11_0._rejectIds = nil

	local var_11_0 = arg_11_1:getMO():getBuffDic()

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = lua_skill_buff.configDict[iter_11_1.buffId]
		local var_11_2 = lua_skill_bufftype.configDict[var_11_1.typeId]

		if not string.nilorempty(var_11_2.rejectTypes) then
			local var_11_3 = string.split(var_11_2.rejectTypes, "#")
			local var_11_4 = string.split(var_11_3[2], ",")
			local var_11_5

			if var_11_3[1] == "1" then
				arg_11_0._rejectTypes = arg_11_0._rejectTypes or {}
				var_11_5 = arg_11_0._rejectTypes
			elseif var_11_3[1] == "2" then
				arg_11_0._rejectIds = arg_11_0._rejectIds or {}
				var_11_5 = arg_11_0._rejectIds
			end

			if var_11_5 then
				for iter_11_2, iter_11_3 in ipairs(var_11_5) do
					var_11_5[iter_11_3] = true
				end
			end
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not var_0_3 then
		return
	end

	if not arg_12_1:isMySide() then
		return
	end

	if arg_12_1.id == FightEntityScene.MySideId or arg_12_1.id == FightEntityScene.EnemySideId then
		return
	end

	local var_12_0 = lua_skill.configDict[arg_12_2]

	if not var_12_0 then
		return
	end

	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_3.actEffect) do
		if (iter_12_1.effectType == FightEnum.EffectType.BUFFADD or iter_12_1.effectType == FightEnum.EffectType.BUFFUPDATE) and iter_12_1.buff then
			var_12_1[iter_12_1.buff.buffId] = true
		end
	end

	for iter_12_2 = 1, FightEnum.MaxBehavior do
		local var_12_2 = var_12_0["behavior" .. iter_12_2]

		if not string.nilorempty(var_12_2) then
			local var_12_3 = FightStrUtil.instance:getSplitToNumberCache(var_12_2, "#")
			local var_12_4 = var_12_3[1]
			local var_12_5 = var_12_3[2]
			local var_12_6 = lua_skill_buff.configDict[var_12_5]
			local var_12_7 = var_12_4 == 1
			local var_12_8 = not var_12_1[var_12_5]
			local var_12_9 = arg_12_0._rejectTypes and arg_12_0._rejectTypes[var_12_6.typeId] or arg_12_0._rejectIds and arg_12_0._rejectIds[var_12_5]

			if var_12_7 and var_12_8 and not var_12_9 then
				arg_12_0:_checkAdd(var_0_3)

				break
			end
		end
	end
end

function var_0_0._checkAdd(arg_13_0, arg_13_1)
	if not FightViewTechniqueModel.instance:addUnread(arg_13_1) then
		return
	end

	local var_13_0 = FightViewTechniqueModel.instance:getPropertyStr()

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.FightTechnique, var_13_0)
	arg_13_0:_udpateAnchorY()
end

function var_0_0._updateSimpleProperty(arg_14_0, arg_14_1)
	if arg_14_1 == PlayerEnum.SimpleProperty.FightTechnique then
		arg_14_0:_udpateAnchorY()
	end
end

function var_0_0._udpateAnchorY(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(FightViewTechniqueModel.instance:getList()) do
		local var_15_1 = lua_fight_technique.configDict[iter_15_1.id]

		if var_15_1 and var_15_1.iconShow == "1" then
			table.insert(var_15_0, iter_15_1)

			if #var_15_0 >= 3 then
				break
			end
		end
	end

	FightViewTechniqueListModel.instance:showUnreadFightViewTechniqueList(var_15_0)

	local var_15_2 = #var_15_0

	if var_15_2 >= 3 then
		recthelper.setAnchorY(arg_15_0._scrollGO.transform, arg_15_0._originY)
	elseif var_15_2 > 0 then
		recthelper.setAnchorY(arg_15_0._scrollGO.transform, arg_15_0._originY - (3 - var_15_2) * 140 / 2)
	end

	local var_15_3 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightTechnique)

	gohelper.setActive(arg_15_0._scrollGO, var_15_3 and var_15_2 > 0)
end

function var_0_0._onSetStateForDialogBeforeStartFight(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._scrollGO, not arg_16_1)

	if not arg_16_1 then
		arg_16_0:_udpateAnchorY()
	end
end

return var_0_0
