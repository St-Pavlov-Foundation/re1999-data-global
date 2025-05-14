module("modules.logic.sdk.model.SDKChannelEventModel", package.seeall)

local var_0_0 = class("SDKChannelEventModel", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._enum = nil

	if GameChannelConfig.isEfun() then
		arg_1_0._enum = SDKEfunChannelEventEnum
	elseif GameChannelConfig.isLongCheng() and BootNativeUtil.isMobilePlayer() then
		arg_1_0._enum = SDKLongchengChannelEventEnum
	end

	arg_1_0._totalChargeAmount = nil
	arg_1_0._dailyTaskActiveNum = 0
	arg_1_0._consumeItemDic = {}
	arg_1_0._totalSummonCount = nil
	arg_1_0._needAppReview = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._dailyTaskActiveNum = 0
	arg_2_0._totalChargeAmount = nil
	arg_2_0._consumeItemDic = {}
	arg_2_0._totalSummonCount = nil
	arg_2_0._needAppReview = false
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.episodePass(arg_4_0, arg_4_1)
	if arg_4_0._enum and arg_4_0._enum.EpisodePass[arg_4_1] then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_4_0._enum.EpisodePass[arg_4_1])
	end

	if arg_4_0._enum and arg_4_1 and arg_4_0._enum.AppReviewePisodeId == arg_4_1 then
		SDKMgr.instance:appReview()
	end
end

function var_0_0.playerLevelUp(arg_5_0, arg_5_1)
	if arg_5_0._enum and arg_5_0._enum.PlayerLevelUp[arg_5_1] then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_5_0._enum.PlayerLevelUp[arg_5_1])
	end

	if GameChannelConfig.isEfun() and arg_5_1 == 5 then
		SDKMgr.instance:showATTDialog("level_five")
	end
end

function var_0_0.firstSummon(arg_6_0)
	if arg_6_0._enum and arg_6_0._enum.FirstSummon then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_6_0._enum.FirstSummon)
	end
end

function var_0_0.addTotalSummonCount(arg_7_0, arg_7_1)
	if not arg_7_0._totalSummonCount then
		arg_7_0._totalSummonCount = 0
	end

	arg_7_0:updateTotalSummonCount(arg_7_0._totalSummonCount + arg_7_1)
end

function var_0_0.updateTotalSummonCount(arg_8_0, arg_8_1)
	if arg_8_0._totalSummonCount and arg_8_0._enum and arg_8_0._enum.Summon then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._enum.Summon) do
			if iter_8_0 > arg_8_0._totalSummonCount and iter_8_0 <= arg_8_1 then
				SDKDataTrackMgr.instance:trackChannelEvent(iter_8_1)
			end
		end
	end

	arg_8_0._totalSummonCount = arg_8_1
end

function var_0_0.consumeItem(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._enum and arg_9_0._enum.ConsumeItem[arg_9_1] and arg_9_0._consumeItemDic[arg_9_1] then
		local var_9_0 = arg_9_0._consumeItemDic[arg_9_1]
		local var_9_1 = arg_9_0._enum.ConsumeItem[arg_9_1]

		if var_9_0 < var_9_1[1] and arg_9_2 >= var_9_1[1] then
			SDKDataTrackMgr.instance:trackChannelEvent(var_9_1[2])
		end
	end

	arg_9_0._consumeItemDic[arg_9_1] = arg_9_2
end

function var_0_0.firstPurchase(arg_10_0)
	if arg_10_0._enum and arg_10_0._enum.FirstPurchase then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_10_0._enum.FirstPurchase)
	end
end

function var_0_0.purchase(arg_11_0, arg_11_1)
	if arg_11_0._enum and arg_11_0._enum.Purchase[arg_11_1] then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_11_0._enum.Purchase[arg_11_1])
	end
end

function var_0_0.totalChargeAmount(arg_12_0, arg_12_1)
	arg_12_1 = tonumber(arg_12_1)

	if arg_12_0._totalChargeAmount then
		if arg_12_0._enum and arg_12_0._enum.TotalChargeAmount then
			for iter_12_0, iter_12_1 in pairs(arg_12_0._enum.TotalChargeAmount) do
				if iter_12_0 > arg_12_0._totalChargeAmount and iter_12_0 <= arg_12_1 then
					SDKDataTrackMgr.instance:trackChannelEvent(iter_12_1)
				end
			end
		end

		local var_12_0 = GameChannelConfig.isGpJapan() and SDKMediaEventEnum.JP_TotalChargeAmount or SDKMediaEventEnum.TotalChargeAmount

		for iter_12_2, iter_12_3 in pairs(var_12_0) do
			if iter_12_2 > arg_12_0._totalChargeAmount and iter_12_2 <= arg_12_1 then
				SDKDataTrackMgr.instance:trackMediaEvent(iter_12_3)
			end
		end
	end

	arg_12_0._totalChargeAmount = arg_12_1
end

function var_0_0.getMaxRareHero(arg_13_0)
	if arg_13_0._enum and arg_13_0._enum.GetMaxRareHero then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_13_0._enum.GetMaxRareHero)
	end
end

function var_0_0.onSummonResult(arg_14_0, arg_14_1)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.AppReview) == 1 then
		return
	end

	if arg_14_1 and #arg_14_1 > 0 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			if iter_14_1.heroId and iter_14_1.heroId ~= 0 and HeroConfig.instance:getHeroCO(iter_14_1.heroId).rare == CharacterEnum.MaxRare then
				arg_14_0:setNeedAppReview(true)

				break
			end
		end
	end
end

function var_0_0.setNeedAppReview(arg_15_0, arg_15_1)
	arg_15_0._needAppReview = arg_15_1
end

function var_0_0.needAppReview(arg_16_0)
	return false
end

function var_0_0.firstBuyPower(arg_17_0)
	if arg_17_0._enum and arg_17_0._enum.FirstBuyPower then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_17_0._enum.FirstBuyPower)
	end
end

function var_0_0.nickName(arg_18_0)
	if arg_18_0._enum and arg_18_0._enum.NickName then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_18_0._enum.NickName)
	end
end

function var_0_0.firstExchangeDiamond(arg_19_0)
	if arg_19_0._enum and arg_19_0._enum.FirstExchangeDiamond then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_19_0._enum.FirstExchangeDiamond)
	end
end

function var_0_0.heroRankUp(arg_20_0, arg_20_1)
	if arg_20_0._enum and arg_20_0._enum.HeroRankUp[arg_20_1] then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_20_0._enum.HeroRankUp[arg_20_1])
	end
end

function var_0_0.updateDailyTaskActive(arg_21_0)
	local var_21_0 = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Daily).value

	if arg_21_0._dailyTaskActiveNum ~= var_21_0 and arg_21_0._enum and arg_21_0._enum.DailyTaskActive[var_21_0] then
		SDKDataTrackMgr.instance:trackChannelEvent(arg_21_0._enum.DailyTaskActive[var_21_0])
	end

	arg_21_0._dailyTaskActiveNum = var_21_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
