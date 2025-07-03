module("modules.logic.fight.system.work.FightWorkCompareServerEntityData", package.seeall)

local var_0_0 = class("FightWorkCompareServerEntityData", FightWorkItem)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		arg_1_0:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		arg_1_0:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		arg_1_0:onDone(true)

		return
	end

	if FightReplayModel.instance:isReplay() then
		arg_1_0:onDone(true)

		return
	end

	if SLFramework.FrameworkSettings.IsEditor then
		arg_1_0:com_registTimer(arg_1_0._delayDone, 5)

		arg_1_0._count = 0

		arg_1_0:com_registFightEvent(FightEvent.CountEntityInfoReply, arg_1_0._onCountEntityInfoReply)

		local var_1_0 = FightLocalDataMgr.instance.entityMgr:getAllEntityMO()

		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if not iter_1_1:isStatusDead() then
				arg_1_0._count = arg_1_0._count + 1

				local var_1_1 = iter_1_1.uid

				FightRpc.instance:sendEntityInfoRequest(var_1_1)
			end
		end

		if arg_1_0._count == 0 then
			arg_1_0:onDone(true)
		end

		return
	end

	arg_1_0:onDone(true)
end

function var_0_0.compareAttrMO(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.hp ~= arg_2_1.hp then
		FightDataUtil.addDiff("hp", FightDataUtil.diffType.difference)
	end

	if arg_2_0.multiHpNum ~= arg_2_1.multiHpNum then
		FightDataUtil.addDiff("multiHpNum", FightDataUtil.diffType.difference)
	end
end

function var_0_0.comparSummonedOneData(arg_3_0, arg_3_1)
	FightDataUtil.doFindDiff(arg_3_0, arg_3_1, {
		stanceIndex = true
	})
end

function var_0_0.compareSummonedInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	FightDataUtil.addPathkey("dataDic")
	FightDataUtil.doFindDiff(arg_4_0.dataDic, arg_4_1.dataDic, nil, nil, var_0_0.comparSummonedOneData)
	FightDataUtil.removePathKey()
end

local var_0_1 = {
	[FightDataUtil.diffType.missingSource] = "服务器数据不存在",
	[FightDataUtil.diffType.missingTarget] = "本地数据不存在",
	[FightDataUtil.diffType.difference] = "数据不一致"
}
local var_0_2 = {
	buffFeaturesSplit = true,
	playCardExPoint = true,
	resistanceDict = true,
	_playCardAddExpoint = true,
	configMaxExPoint = true,
	moveCardExPoint = true,
	passiveSkillDic = true,
	_combineCardAddExpoint = true,
	custom_refreshNameUIOp = true,
	class = true,
	skillList = true,
	_moveCardAddExpoint = true
}
local var_0_3 = {
	attrMO = var_0_0.compareAttrMO,
	summonedInfo = var_0_0.compareSummonedInfo
}

function var_0_0._onCountEntityInfoReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		local var_5_0 = arg_5_2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(arg_5_2.entityInfo.uid)

		if var_5_0 then
			local var_5_1 = var_5_0.id
			local var_5_2 = FightEntityMO.New()

			var_5_2:init(arg_5_2.entityInfo, var_5_0.side)

			local var_5_3, var_5_4 = FightDataUtil.findDiff(var_5_2, var_5_0, var_0_2, var_0_3)

			if var_5_3 then
				local var_5_5 = var_5_0:getCO()
				local var_5_6 = "前后端entity数据不一致,entityId:%s, 角色名称:%s \n"
				local var_5_7 = string.format(var_5_6, var_5_1, var_5_5 and var_5_5.name or "")

				for iter_5_0, iter_5_1 in pairs(var_5_4) do
					for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
						local var_5_8 = " "

						if iter_5_3.diffType == FightDataUtil.diffType.difference then
							local var_5_9, var_5_10 = FightDataUtil.getDiffValue(var_5_2, var_5_0, iter_5_3)

							var_5_8 = string.format("    服务器数据:%s, 本地数据:%s", var_5_9, var_5_10)
						end

						var_5_7 = var_5_7 .. "路径: entityMO." .. iter_5_3.pathStr .. ", 原因:" .. var_0_1[iter_5_3.diffType] .. var_5_8 .. "\n"
					end

					var_5_7 = var_5_7 .. "\n"
					var_5_7 = var_5_7 .. "服务器数据: entityMO." .. iter_5_0 .. " = " .. FightHelper.logStr(var_5_2[iter_5_0], var_0_2) .. "\n"
					var_5_7 = var_5_7 .. "\n"
					var_5_7 = var_5_7 .. "本地数据: entityMO." .. iter_5_0 .. " = " .. FightHelper.logStr(var_5_0[iter_5_0], var_0_2) .. "\n"
					var_5_7 = var_5_7 .. "------------------------------------------------------------------------------------------------------------------------\n"
				end

				logError(var_5_7)
				FightLocalDataMgr.instance.entityMgr:replaceEntityMO(var_5_2)
			end
		else
			logError("数据错误")
		end
	end

	arg_5_0._count = arg_5_0._count - 1

	if arg_5_0._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		arg_5_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_6_0)
	logError("对比前后端数据超时")
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	return
end

return var_0_0
