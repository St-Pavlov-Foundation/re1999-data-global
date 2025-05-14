module("modules.logic.versionactivity1_5.aizila.helper.AiZiLaHelper", package.seeall)

local var_0_0 = {
	getLimitTimeStr = function()
		local var_1_0 = ActivityModel.instance:getActMO(VersionActivity1_5Enum.ActivityId.AiZiLa)

		if var_1_0 then
			return string.format(luaLang("versionactivity_remain_day"), var_1_0:getRemainTimeStr3())
		end

		return ""
	end,
	isOpenDay = function(arg_2_0)
		local var_2_0 = VersionActivity1_5Enum.ActivityId.AiZiLa
		local var_2_1 = ActivityModel.instance:getActMO(var_2_0)
		local var_2_2 = AiZiLaConfig.instance:getEpisodeCo(var_2_0, arg_2_0)

		if var_2_1 and var_2_2 then
			local var_2_3 = var_2_2.openDay or 0
			local var_2_4 = var_2_1:getRealStartTimeStamp() + (var_2_3 - 1) * 24 * 60 * 60
			local var_2_5 = ServerTime.now()
			local var_2_6 = var_2_2.preEpisode == 0 or AiZiLaModel.instance:isEpisodeClear(var_2_2.preEpisode)
			local var_2_7 = math.max(var_2_4 - var_2_5, 0)

			if not var_2_6 or var_2_7 > 0 then
				return false, var_2_7
			end
		else
			if not var_2_2 then
				logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", var_2_0, arg_2_0))
			end

			return false, -1
		end

		return true
	end
}

function var_0_0.showToastByEpsodeId(arg_3_0)
	local var_3_0 = VersionActivity1_5Enum.ActivityId.AiZiLa
	local var_3_1 = AiZiLaConfig.instance:getEpisodeCo(var_3_0, arg_3_0)

	if not var_3_1 then
		logNormal(string.format("can not find v1a5 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_5Enum.ActivityId.AiZiLa, arg_3_0))

		return
	end

	local var_3_2, var_3_3 = var_0_0.isOpenDay(var_3_1.id)

	if not var_3_2 then
		if var_3_1.preEpisode ~= 0 or not AiZiLaModel.instance:isEpisodeClear(var_3_1.preEpisode) then
			GameFacade.showToast(ToastEnum.V1a5AiZiLaEpisodeNotOpen, var_3_1.unlockDesc)
		else
			GameFacade.showToast(ToastEnum.Va3Act120EpisodeNotOpenTime)
		end
	end
end

function var_0_0.clearOrCreateModel(arg_4_0)
	if arg_4_0 then
		arg_4_0:clear()
	else
		arg_4_0 = BaseModel.New()
	end

	return arg_4_0
end

function var_0_0.updateMOModel(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1:getById(arg_5_2)

	if var_5_0 == nil then
		var_5_0 = arg_5_0.New()

		var_5_0:init(arg_5_2)
		arg_5_1:addAtLast(var_5_0)
	end

	var_5_0:updateInfo(arg_5_3)

	return var_5_0
end

function var_0_0.getCostParams(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0 and GameUtil.splitString2(arg_6_0.cost, true)

	if var_6_1 then
		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			table.insert(var_6_0, {
				itemId = iter_6_1[1],
				itemNum = iter_6_1[2]
			})
		end
	end

	return var_6_0
end

function var_0_0.checkCostParams(arg_7_0)
	if arg_7_0 then
		local var_7_0 = AiZiLaModel.instance

		for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
			if var_7_0:getItemQuantity(iter_7_1.itemId) < iter_7_1.itemNum then
				return false
			end
		end
	end

	return true
end

function var_0_0.getEpisodeReward(arg_8_0)
	local var_8_0 = {}

	if not string.nilorempty(arg_8_0) then
		local var_8_1 = string.splitToNumber(arg_8_0, "|")

		if var_8_1 then
			for iter_8_0, iter_8_1 in ipairs(var_8_1) do
				table.insert(var_8_0, {
					itemId = iter_8_1
				})
			end
		end
	end

	return var_8_0
end

function var_0_0.playViewAnimator(arg_9_0, arg_9_1)
	local var_9_0 = ViewMgr.instance:getContainer(arg_9_0)

	if var_9_0 and var_9_0.playViewAnimator then
		var_9_0:playViewAnimator(arg_9_1)
	end
end

function var_0_0.getItemMOListByBonusStr(arg_10_0, arg_10_1)
	if string.nilorempty(arg_10_0) then
		return arg_10_1
	end

	local var_10_0 = GameUtil.splitString2(arg_10_0, true)

	if var_10_0 then
		arg_10_1 = arg_10_1 or {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_1 = AiZiLaItemMO.New()

			var_10_1:init(iter_10_1[1], iter_10_1[1], iter_10_1[2] or 1)
			table.insert(arg_10_1, var_10_1)
		end
	end

	return arg_10_1
end

function var_0_0.startBlock(arg_11_0)
	if not UIBlockMgr.instance:isKeyBlock(arg_11_0) then
		UIBlockMgr.instance:startBlock(arg_11_0)
	end
end

function var_0_0.endBlock(arg_12_0)
	if UIBlockMgr.instance:isKeyBlock(arg_12_0) then
		UIBlockMgr.instance:endBlock(arg_12_0)
	end
end

function var_0_0.isFinishRed(arg_13_0)
	return PlayerPrefsHelper.getNumber(arg_13_0, 0) == 1
end

function var_0_0.finishRed(arg_14_0)
	PlayerPrefsHelper.setNumber(arg_14_0, 1)
end

function var_0_0.getRedKey(arg_15_0, arg_15_1)
	local var_15_0 = PlayerModel.instance:getMyUserId() or 0

	return string.format("AiZiLaModel_red_skey_%s_%s_%s", var_15_0, arg_15_0, arg_15_1 or 0)
end

return var_0_0
