module("modules.logic.fight.view.FightViewCardItemResistance", package.seeall)

local var_0_0 = class("FightViewCardItemResistance", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.resistanceGo = gohelper.findChild(arg_2_1, "#go_resistance")
	arg_2_0.resistanceGoPart = gohelper.findChild(arg_2_1, "#go_resistancecrash")
	arg_2_0.rectTr = arg_2_0.resistanceGo:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.partRectTr = arg_2_0.resistanceGoPart:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_2_0.resistanceGo, false)
	gohelper.setActive(arg_2_0.resistanceGoPart, false)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_3_0.onSelectSkillTarget, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.SelectSkillTarget, arg_4_0.onSelectSkillTarget, arg_4_0)
end

function var_0_0.onSelectSkillTarget(arg_5_0)
	if not arg_5_0.cardInfoMO then
		return
	end

	arg_5_0:updateByCardInfo(arg_5_0.cardInfoMO)
end

function var_0_0.updateByBeginRoundOp(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return arg_6_0:hideResistanceGo()
	end

	if not arg_6_1:isPlayCard() then
		return arg_6_0:hideResistanceGo()
	end

	local var_6_0 = arg_6_1.toId

	if not var_6_0 then
		return arg_6_0:hideResistanceGo()
	end

	local var_6_1 = FightDataHelper.entityMgr:getById(var_6_0)

	if not var_6_1 then
		return arg_6_0:hideResistanceGo()
	end

	if var_6_1.side ~= FightEnum.EntitySide.EnemySide then
		return arg_6_0:hideResistanceGo()
	end

	return arg_6_0:refreshResistance(var_6_1, arg_6_1.skillId)
end

function var_0_0.updateByCardInfo(arg_7_0, arg_7_1)
	arg_7_0.cardInfoMO = arg_7_1

	if not arg_7_1 then
		return arg_7_0:hideResistanceGo()
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return arg_7_0:hideResistanceGo()
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		return arg_7_0:hideResistanceGo()
	end

	local var_7_0 = FightDataHelper.operationDataMgr.curSelectEntityId

	if var_7_0 == 0 then
		return arg_7_0:hideResistanceGo()
	end

	local var_7_1 = FightDataHelper.entityMgr:getById(var_7_0)

	if not var_7_1 then
		return arg_7_0:hideResistanceGo()
	end

	return arg_7_0:refreshResistance(var_7_1, arg_7_1.skillId)
end

function var_0_0.updateBySkillDisplayMo(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return arg_8_0:hideResistanceGo()
	end

	local var_8_0 = arg_8_1.targetId

	if var_8_0 == 0 then
		return arg_8_0:hideResistanceGo()
	end

	local var_8_1 = FightDataHelper.entityMgr:getById(var_8_0)

	if not var_8_1 then
		return arg_8_0:hideResistanceGo()
	end

	return arg_8_0:refreshResistance(var_8_1, arg_8_1.skillId)
end

var_0_0.AnchorY = {
	BigSkill = -68,
	Normal = -54
}

function var_0_0.refreshResistance(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_skill.configDict[arg_9_2]
	local var_9_1 = var_9_0 and var_9_0.resistancesTag

	if not string.nilorempty(var_9_1) then
		local var_9_2 = FightStrUtil.instance:getSplitCache(var_9_1, "#")

		if arg_9_0:checkIsFullResistance(arg_9_1, var_9_2) then
			arg_9_0:showFullResistanceTag(var_9_0.isBigSkill == 1)
		elseif arg_9_0:checkIsPartResistance(arg_9_1, var_9_2) then
			arg_9_0:showPartResistanceTag(var_9_0.isBigSkill == 1)
		else
			arg_9_0:hideResistanceGo()
		end
	else
		arg_9_0:hideResistanceGo()
	end
end

function var_0_0.showFullResistanceTag(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.resistanceGo, true)

	local var_10_0 = arg_10_1 and var_0_0.AnchorY.BigSkill or var_0_0.AnchorY.Normal

	recthelper.setAnchorY(arg_10_0.rectTr, var_10_0)
	FightController.instance:dispatchEvent(FightEvent.TriggerCardShowResistanceTag)
end

function var_0_0.showPartResistanceTag(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.resistanceGoPart, true)

	local var_11_0 = arg_11_1 and var_0_0.AnchorY.BigSkill or var_0_0.AnchorY.Normal

	recthelper.setAnchorY(arg_11_0.partRectTr, var_11_0)
	FightController.instance:dispatchEvent(FightEvent.TriggerCardShowResistanceTag)
end

function var_0_0.checkIsFullResistance(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		if arg_12_1:isFullResistance(iter_12_1) then
			return true
		end
	end

	return false
end

function var_0_0.checkIsPartResistance(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
		if arg_13_1:isPartResistance(iter_13_1) then
			return true
		end
	end

	return false
end

function var_0_0.hideResistanceGo(arg_14_0)
	gohelper.setActive(arg_14_0.resistanceGo, false)
	gohelper.setActive(arg_14_0.resistanceGoPart, false)
end

return var_0_0
