module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErGameMo", package.seeall)

local var_0_0 = pureTable("MoLiDeErGameMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.actId = arg_1_1
	arg_1_0.episodeId = arg_1_2.episodeId
	arg_1_0.gameId = MoLiDeErConfig.instance:getEpisodeConfig(arg_1_1, arg_1_2.episodeId).gameId
	arg_1_0.previousRound = arg_1_0.currentRound
	arg_1_0.previousRoundEnergy = arg_1_0.leftRoundEnergy
	arg_1_0.currentRound = arg_1_2.currentRound
	arg_1_0.totalRoundEnergy = arg_1_2.totalRoundEnergy
	arg_1_0.leftRoundEnergy = arg_1_2.leftRoundEnergy
	arg_1_0.eventInfos = arg_1_2.eventInfos
	arg_1_0.teamInfos = arg_1_2.teamInfos
	arg_1_0.itemInfos = arg_1_2.itemInfos
	arg_1_0.buffIds = arg_1_2.buffIds
	arg_1_0.itemBuffIds = arg_1_2.itemBuffIds
	arg_1_0.finishedEventInfos = arg_1_2.finishedEventInfos
	arg_1_0.isExtraStar = arg_1_2.isExtraStar
	arg_1_0.isEpisodeFinish = arg_1_3
	arg_1_0.passStar = arg_1_4

	arg_1_0:initEquipInfo()
	arg_1_0:initEventInfo()
	arg_1_0:initFinishEventInfo()
	arg_1_0:initTeamInfo()
	arg_1_0:initEventProgressInfo()
end

function var_0_0.initEquipInfo(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.itemInfos) do
		local var_2_3 = iter_2_1.itemId

		var_2_0[var_2_3] = iter_2_1

		if arg_2_0._equipInfoDic and arg_2_0._equipInfoDic[var_2_3] == nil then
			logNormal("莫莉德尔 角色活动 获得新装备 id:" .. tostring(var_2_3))
			table.insert(var_2_1, var_2_3)

			var_2_2[var_2_3] = true
		end
	end

	arg_2_0._equipInfoDic = var_2_0
	arg_2_0.newGetItem = var_2_1
	arg_2_0.newGetItemDic = var_2_2
end

function var_0_0.initEventInfo(arg_3_0)
	arg_3_0._eventInfoDic = {}
	arg_3_0._dispatchDic = {}
	arg_3_0._allDispatch = true

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.eventInfos) do
		arg_3_0._eventInfoDic[iter_3_1.eventId] = iter_3_1

		if iter_3_1.teamId ~= nil or iter_3_1.teamId ~= 0 then
			arg_3_0._dispatchDic[iter_3_1.teamId] = true
			arg_3_0._allDispatch = false
		end
	end
end

function var_0_0.getEventInfo(arg_4_0, arg_4_1)
	return arg_4_0._eventInfoDic[arg_4_1]
end

function var_0_0.getEquipInfo(arg_5_0, arg_5_1)
	return arg_5_0._equipInfoDic[arg_5_1]
end

function var_0_0.canEquipUse(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getEquipInfo(arg_6_1)

	if var_6_0 == nil then
		return false
	end

	local var_6_1 = MoLiDeErConfig.instance:getItemConfig(arg_6_1)

	if var_6_1 == nil then
		logError("不存在的道具id:" .. arg_6_1)
	end

	return var_6_1.isUse == MoLiDeErEnum.ItemType.Initiative and var_6_0.quantity > 0
end

function var_0_0.initTeamInfo(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}

	arg_7_0._allActTimeNotMatch = true

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.teamInfos) do
		local var_7_3 = iter_7_1.teamId

		var_7_0[var_7_3] = iter_7_1

		if arg_7_0._allActTimeNotMatch == true and iter_7_1.roundActionTime > 0 and iter_7_1.roundActedTime < iter_7_1.roundActionTime then
			arg_7_0._allActTimeNotMatch = false
		end

		if arg_7_0._teamInfoDic and arg_7_0._teamInfoDic[var_7_3] == nil then
			logNormal("莫莉德尔 角色活动 获得新小队 id:" .. tostring(var_7_3))
			table.insert(var_7_1, var_7_3)

			var_7_2[var_7_3] = true
		end
	end

	arg_7_0._teamInfoDic = var_7_0
	arg_7_0.newGetTeam = var_7_1
	arg_7_0.newGetTeamDic = var_7_2
	arg_7_0._teamDispatchDic = {}
	arg_7_0._teamDispatchEventDic = {}

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.eventInfos) do
		if iter_7_3.teamId ~= nil and iter_7_3.teamId ~= 0 then
			arg_7_0._teamDispatchDic[iter_7_3.teamId] = iter_7_3.eventId
			arg_7_0._teamDispatchEventDic[iter_7_3.eventId] = iter_7_3.teamId
		end
	end
end

function var_0_0.initFinishEventInfo(arg_8_0)
	arg_8_0._finishEventDic = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.finishedEventInfos) do
		arg_8_0._finishEventDic[iter_8_1.finishedEventId] = iter_8_1
	end
end

function var_0_0.isNewFinishEvent(arg_9_0, arg_9_1)
	return arg_9_0._finishEventDic[arg_9_1] == nil
end

function var_0_0.isNewEvent(arg_10_0, arg_10_1)
	return arg_10_0._eventInfoDic[arg_10_1] == nil
end

function var_0_0.isDispatchTeam(arg_11_0, arg_11_1)
	return arg_11_0._teamDispatchDic[arg_11_1] ~= nil
end

function var_0_0.getEventDispatchTeam(arg_12_0, arg_12_1)
	return arg_12_0._teamDispatchEventDic[arg_12_1]
end

function var_0_0.getTeamInfo(arg_13_0, arg_13_1)
	return arg_13_0._teamInfoDic[arg_13_1]
end

function var_0_0.canDispatchTeam(arg_14_0, arg_14_1)
	if arg_14_0:getTeamInfo(arg_14_1) == nil then
		return false
	end

	return not arg_14_0:isInDispatching(arg_14_1)
end

function var_0_0.isInDispatching(arg_15_0, arg_15_1)
	return arg_15_0._dispatchDic[arg_15_1] ~= nil
end

function var_0_0.isAllInDispatching(arg_16_0)
	return arg_16_0._allDispatch
end

function var_0_0.isAllActTimesNotMatch(arg_17_0)
	return arg_17_0._allActTimeNotMatch
end

function var_0_0.initEventProgressInfo(arg_18_0)
	arg_18_0._targetProgressDic = {}
	arg_18_0._targetNewCompleteDic = {}
	arg_18_0._targetNewFailDic = {}

	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = MoLiDeErConfig.instance:getGameConfig(arg_18_0.gameId)

	if arg_18_0.isEpisodeFinish and arg_18_0.passStar == -1 then
		arg_18_0._targetProgressDic[MoLiDeErEnum.TargetId.Main] = MoLiDeErEnum.ProgressRange.Failed
		var_18_1[MoLiDeErEnum.TargetId.Main] = true

		logNormal("莫莉德尔 角色活动 主目标失败")
	end

	if arg_18_0.isExtraStar then
		arg_18_0._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Success
		var_18_0[MoLiDeErEnum.TargetId.Extra] = true
	else
		local var_18_3 = var_18_2.extraCondition

		if not string.nilorempty(var_18_3) then
			local var_18_4 = string.splitToNumber(var_18_3, "#")
			local var_18_5 = var_18_4[1]

			if (var_18_5 == MoLiDeErEnum.TargetConditionType.RoundLimitedFinishAll or var_18_5 == MoLiDeErEnum.TargetConditionType.RoundLimitedFinishAny) and var_18_4[2] < arg_18_0.currentRound then
				arg_18_0._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Failed
				var_18_1[MoLiDeErEnum.TargetId.Extra] = true
			end
		end
	end

	if arg_18_0.finishedEventInfos and arg_18_0.finishedEventInfos[1] then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0.finishedEventInfos) do
			local var_18_6 = MoLiDeErConfig.instance:getProgressConfig(iter_18_1.optionId)

			if var_18_6 ~= nil then
				local var_18_7 = string.split(var_18_6.condition, "|")

				for iter_18_2, iter_18_3 in ipairs(var_18_7) do
					local var_18_8 = string.splitToNumber(iter_18_3, "#")
					local var_18_9 = var_18_8[1]
					local var_18_10 = var_18_8[2]

					if var_18_9 == arg_18_0.gameId then
						local var_18_11 = arg_18_0._targetProgressDic[var_18_10] or 0

						if var_18_11 > MoLiDeErEnum.ProgressRange.Failed and var_18_11 < MoLiDeErEnum.ProgressRange.Success then
							local var_18_12 = var_18_6.progressChange
							local var_18_13 = var_18_6.progressNum

							if var_18_12 == MoLiDeErEnum.ProgressChangeType.Percentage then
								var_18_11 = Mathf.Clamp(var_18_11 + var_18_13, MoLiDeErEnum.ProgressRange.Failed, MoLiDeErEnum.ProgressRange.Success)
							elseif var_18_12 == MoLiDeErEnum.ProgressChangeType.Success then
								var_18_11 = MoLiDeErEnum.ProgressRange.Success
								var_18_0[var_18_10] = true
							elseif var_18_12 == MoLiDeErEnum.ProgressChangeType.Failed then
								var_18_11 = MoLiDeErEnum.ProgressRange.Failed
							end
						end

						arg_18_0._targetProgressDic[var_18_10] = var_18_11
					end
				end
			end
		end
	end

	if arg_18_0.isEpisodeFinish and (arg_18_0.passStar == -1 or arg_18_0.passStar == 1) and arg_18_0._targetProgressDic[MoLiDeErEnum.TargetId.Extra] ~= MoLiDeErEnum.ProgressRange.Success then
		arg_18_0._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Failed
		var_18_1[MoLiDeErEnum.TargetId.Extra] = true

		logNormal("莫莉德尔 角色活动 额外目标失败")
	end

	if arg_18_0._targetCompleteDic then
		for iter_18_4, iter_18_5 in pairs(var_18_0) do
			if arg_18_0._targetCompleteDic[iter_18_4] == nil then
				arg_18_0._targetNewCompleteDic[iter_18_4] = true

				logNormal("莫莉德尔 角色活动 存在新的完成目标 id: " .. tostring(iter_18_4))
			end
		end
	end

	if arg_18_0._targetFailDic then
		for iter_18_6, iter_18_7 in pairs(var_18_1) do
			if arg_18_0._targetFailDic[iter_18_6] == nil then
				arg_18_0._targetNewFailDic[iter_18_6] = true

				logNormal("莫莉德尔 角色活动 存在新的失败目标 id: " .. tostring(iter_18_6))
			end
		end
	end

	arg_18_0._targetCompleteDic = var_18_0
	arg_18_0._targetFailDic = var_18_1
end

function var_0_0.getTargetProgress(arg_19_0, arg_19_1)
	return arg_19_0._targetProgressDic[arg_19_1] or 0
end

function var_0_0.isNewCompleteTarget(arg_20_0, arg_20_1)
	return arg_20_0._targetNewCompleteDic[arg_20_1]
end

function var_0_0.isNewFailTarget(arg_21_0, arg_21_1)
	return arg_21_0._targetNewFailDic[arg_21_1]
end

return var_0_0
