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
	if arg_2_2:isVorpalith() or arg_2_3:isVorpalith() then
		return
	end

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
	actInfo = function(arg_5_0, arg_5_1)
		local function var_5_0(arg_6_0, arg_6_1)
			return arg_6_0.actId < arg_6_1.actId
		end

		table.sort(arg_5_0, var_5_0)
		table.sort(arg_5_1, var_5_0)
		FightDataUtil.doFindDiff(arg_5_0, arg_5_1)
	end
}

local function var_0_2(arg_7_0, arg_7_1)
	local var_7_0 = {
		_last_clone_mo = true
	}

	FightDataUtil.doFindDiff(arg_7_0, arg_7_1, var_7_0, var_0_1)
end

function var_0_0.compareBuffDic(arg_8_0, arg_8_1)
	FightDataUtil.doFindDiff(arg_8_0, arg_8_1, nil, nil, var_0_2)
end

local var_0_3 = {
	[FightDataUtil.diffType.missingSource] = "服务器数据不存在",
	[FightDataUtil.diffType.missingTarget] = "本地数据不存在",
	[FightDataUtil.diffType.difference] = "数据不一致"
}
local var_0_4 = {
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

var_0_0.filterCompareKey = var_0_4

local var_0_5 = {
	attrMO = var_0_0.compareAttrMO,
	summonedInfo = var_0_0.compareSummonedInfo,
	buffDic = var_0_0.compareBuffDic
}

var_0_0.costomCompareFunc = var_0_5

function var_0_0._onCountEntityInfoReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = arg_9_2.entityInfo and FightLocalDataMgr.instance.entityMgr:getById(arg_9_2.entityInfo.uid)

		if var_9_0 then
			local var_9_1 = var_9_0.id
			local var_9_2 = FightEntityMO.New()
			local var_9_3 = FightEntityInfoData.New(arg_9_2.entityInfo)

			var_9_2:init(var_9_3, var_9_0.side)

			local var_9_4, var_9_5 = FightDataUtil.findDiff(var_9_2, var_9_0, var_0_4, var_0_5)

			if var_9_4 then
				local var_9_6 = var_9_0:getCO()
				local var_9_7 = "前后端entity数据不一致,entityId:%s, 角色名称:%s \n"
				local var_9_8 = string.format(var_9_7, var_9_1, var_9_6 and var_9_6.name or "")

				for iter_9_0, iter_9_1 in pairs(var_9_5) do
					for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
						local var_9_9 = " "

						if iter_9_3.diffType == FightDataUtil.diffType.difference then
							local var_9_10, var_9_11 = FightDataUtil.getDiffValue(var_9_2, var_9_0, iter_9_3)

							var_9_9 = string.format("    服务器数据:%s, 本地数据:%s", var_9_10, var_9_11)
						end

						var_9_8 = var_9_8 .. "路径: entityMO." .. iter_9_3.pathStr .. ", 原因:" .. var_0_3[iter_9_3.diffType] .. var_9_9 .. "\n"
					end

					var_9_8 = var_9_8 .. "\n"
					var_9_8 = var_9_8 .. "服务器数据: entityMO." .. iter_9_0 .. " = " .. FightHelper.logStr(var_9_2[iter_9_0], var_0_4) .. "\n"
					var_9_8 = var_9_8 .. "\n"
					var_9_8 = var_9_8 .. "本地数据: entityMO." .. iter_9_0 .. " = " .. FightHelper.logStr(var_9_0[iter_9_0], var_0_4) .. "\n"
					var_9_8 = var_9_8 .. "------------------------------------------------------------------------------------------------------------------------\n"
				end

				logError(var_9_8)
				FightLocalDataMgr.instance.entityMgr:replaceEntityMO(var_9_2)
			end
		else
			logError("数据错误")
		end
	end

	arg_9_0._count = arg_9_0._count - 1

	if arg_9_0._count <= 0 then
		FightController.instance:dispatchEvent(FightEvent.AfterForceUpdatePerformanceData)
		arg_9_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_10_0)
	logError("对比前后端数据超时")
	arg_10_0:onDone(true)
end

function var_0_0.clearWork(arg_11_0)
	return
end

return var_0_0
