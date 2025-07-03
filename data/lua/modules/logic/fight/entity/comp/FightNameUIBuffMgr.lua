module("modules.logic.fight.entity.comp.FightNameUIBuffMgr", package.seeall)

local var_0_0 = class("FightNameUIBuffMgr")
local var_0_1 = 4
local var_0_2 = {
	[20004] = true,
	[20003] = true,
	[30003] = true,
	[30004] = true
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.entity = arg_1_1
	arg_1_0.goBuffItem = arg_1_2
	arg_1_0.opContainerTr = arg_1_3
	arg_1_0.buffItemList = {}
	arg_1_0.buffLineCount = 0

	gohelper.setActive(arg_1_0.goBuffItem, false)
	arg_1_0:refreshBuffList()
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, arg_1_0.updateBuff, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_1_0.updateBuff, arg_1_0)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, arg_1_0._onMultiHpChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_1_0.updateBuff, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_1_0.updateBuff, arg_1_0)
	FightController.instance:registerCallback(FightEvent.GMForceRefreshNameUIBuff, arg_1_0._onGMForceRefreshNameUIBuff, arg_1_0)
	FightController.instance:registerCallback(FightEvent.AfterForceUpdatePerformanceData, arg_1_0._onAfterForceUpdatePerformanceData, arg_1_0)
	FightController.instance:registerCallback(FightEvent.CoverPerformanceEntityData, arg_1_0._onCoverPerformanceEntityData, arg_1_0)
end

function var_0_0.beforeDestroy(arg_2_0)
	arg_2_0.goBuffItem = nil
	arg_2_0.opContainerTr = nil
	arg_2_0.buffItemList = nil
	arg_2_0.deleteBuffItemList = nil

	TaskDispatcher.cancelTask(arg_2_0.playDeleteAniDone, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, arg_2_0.updateBuff, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_2_0.updateBuff, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, arg_2_0._onMultiHpChange, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_2_0.updateBuff, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0.updateBuff, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.GMForceRefreshNameUIBuff, arg_2_0._onGMForceRefreshNameUIBuff, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.AfterForceUpdatePerformanceData, arg_2_0._onAfterForceUpdatePerformanceData, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.CoverPerformanceEntityData, arg_2_0._onCoverPerformanceEntityData, arg_2_0)
end

function var_0_0.updateBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_1 and arg_3_1 ~= arg_3_0.entity.id then
		return
	end

	if arg_3_2 == FightEnum.EffectType.BUFFDEL then
		if not arg_3_0.deleteBuffItemList then
			arg_3_0.deleteBuffItemList = {}
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.buffItemList) do
			if iter_3_1.buffMO.uid == arg_3_4 then
				local var_3_0 = table.remove(arg_3_0.buffItemList, iter_3_0)
				local var_3_1 = 1

				if var_0_2[arg_3_5] then
					var_3_1 = var_3_0:playAni("close")
				else
					var_3_1 = var_3_0:playAni("disappear")
				end

				table.insert(arg_3_0.deleteBuffItemList, var_3_0)
				TaskDispatcher.runDelay(arg_3_0.playDeleteAniDone, arg_3_0, var_3_1)

				break
			end
		end
	end

	arg_3_0:refreshBuffList()

	if arg_3_2 == FightEnum.EffectType.BUFFADD then
		local var_3_2 = lua_skill_buff.configDict[arg_3_3]

		if var_3_2 and var_3_2.isNoShow == 0 and arg_3_0.curBuffItemCount ~= 0 then
			arg_3_0.buffItemList[arg_3_0.curBuffItemCount]:playAni("appear")
		end
	end

	if arg_3_2 == FightEnum.EffectType.BUFFUPDATE then
		for iter_3_2, iter_3_3 in ipairs(arg_3_0.buffItemList) do
			if arg_3_4 == iter_3_3.buffMO.uid and iter_3_3.buffMO._last_clone_mo and iter_3_3.buffMO.duration > iter_3_3.buffMO._last_clone_mo.duration then
				iter_3_3:playAni("text")
			end
		end
	end
end

function var_0_0.playDeleteAniDone(arg_4_0)
	if arg_4_0.deleteBuffItemList then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.deleteBuffItemList) do
			iter_4_1:closeAni()
			gohelper.setActive(iter_4_1.go, false)
			table.insert(arg_4_0.buffItemList, iter_4_1)
		end

		arg_4_0.deleteBuffItemList = {}
	end

	table.sort(arg_4_0.buffItemList, var_0_0.sortBuffItem)
	arg_4_0:refreshBuffList()
end

function var_0_0.sortBuffItem(arg_5_0, arg_5_1)
	return arg_5_0.originIndex < arg_5_1.originIndex
end

function var_0_0.sortBuffMo(arg_6_0, arg_6_1)
	if arg_6_0.time ~= arg_6_1.time then
		return arg_6_0.time < arg_6_1.time
	end

	return arg_6_0.id < arg_6_1.id
end

function var_0_0.refreshBuffList(arg_7_0)
	local var_7_0 = arg_7_0.entity:getMO()

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getBuffList()
	local var_7_2 = FightBuffHelper.filterBuffType(var_7_1, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_7_2)
	table.sort(var_7_2, var_0_0.sortBuffMo)

	local var_7_3 = var_7_2 and #var_7_2 or 0
	local var_7_4 = 0

	arg_7_0.buffItemOriginIndex = arg_7_0.buffItemOriginIndex or 0

	local var_7_5 = arg_7_0.deleteBuffItemList and #arg_7_0.deleteBuffItemList or 0

	for iter_7_0 = 1, var_7_3 do
		local var_7_6 = var_7_2[iter_7_0]
		local var_7_7 = lua_skill_buff.configDict[var_7_6.buffId]

		if var_7_7 and var_7_7.isNoShow == 0 and var_7_4 + var_7_5 < FightEnum.MaxBuffIconCount then
			var_7_4 = var_7_4 + 1

			local var_7_8 = arg_7_0.buffItemList[var_7_4]

			if not var_7_8 then
				local var_7_9 = gohelper.cloneInPlace(arg_7_0.goBuffItem, "buff" .. var_7_4)

				var_7_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_9, FightBuffItem)

				var_7_8:setTipsOffset(435, 0)
				table.insert(arg_7_0.buffItemList, var_7_8)

				arg_7_0.buffItemOriginIndex = arg_7_0.buffItemOriginIndex + 1
				var_7_8.originIndex = arg_7_0.buffItemOriginIndex
			end

			gohelper.setActive(var_7_8.go, true)
			var_7_8:updateBuffMO(var_7_6)
		end
	end

	arg_7_0.curBuffItemCount = var_7_4

	for iter_7_1 = var_7_4 + 1, #arg_7_0.buffItemList do
		arg_7_0.buffItemList[iter_7_1]:closeAni()
		gohelper.setActive(arg_7_0.buffItemList[iter_7_1].go, false)
	end

	arg_7_0.buffLineCount = Mathf.Ceil((var_7_4 + var_7_5) / var_0_1)

	local var_7_10 = arg_7_0.buffLineCount * 34.5 - 24

	recthelper.setAnchorY(arg_7_0.opContainerTr, var_7_10)
end

function var_0_0.getBuffLineCount(arg_8_0)
	return arg_8_0.buffLineCount
end

function var_0_0.showPoisoningEffect(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.buffItemList) do
		if iter_9_1.buffMO.buffId == arg_9_1.id then
			iter_9_1:showPoisoningEffect()
		end
	end
end

function var_0_0._onMultiHpChange(arg_10_0, arg_10_1)
	if arg_10_0.entity and arg_10_0.entity.id == arg_10_1 then
		arg_10_0:refreshBuffList()
	end
end

function var_0_0._onGMForceRefreshNameUIBuff(arg_11_0, arg_11_1)
	if arg_11_0.entity and arg_11_0.entity.id == arg_11_1 then
		arg_11_0:refreshBuffList()
	end
end

function var_0_0._onAfterForceUpdatePerformanceData(arg_12_0)
	arg_12_0:refreshBuffList()
end

function var_0_0._onCoverPerformanceEntityData(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0.entity.id then
		return
	end

	arg_13_0:refreshBuffList()
end

return var_0_0
