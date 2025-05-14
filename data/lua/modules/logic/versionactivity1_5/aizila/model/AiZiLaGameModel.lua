module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGameModel", package.seeall)

local var_0_0 = class("AiZiLaGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._curEpisodeId = 0
	arg_4_0._roundCount = 0
	arg_4_0._elevation = 0
	arg_4_0._isSafe = false
	arg_4_0._isFirstPass = false
	arg_4_0._curActivityId = VersionActivity1_5Enum.ActivityId.AiZiLa
	arg_4_0._itemModel = arg_4_0:_clearOrCreateModel(arg_4_0._itemModel)
	arg_4_0._resultItemModel = arg_4_0:_clearOrCreateModel(arg_4_0._resultItemModel)
	arg_4_0._equipModel = arg_4_0:_clearOrCreateModel(arg_4_0._equipModel)
	arg_4_0._curEpisodeMO = arg_4_0._curEpisodeMO or AiZiLaEpsiodeMO.New()
end

function var_0_0._clearOrCreateModel(arg_5_0, arg_5_1)
	return AiZiLaHelper.clearOrCreateModel(arg_5_1)
end

function var_0_0._updateMOModel(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	return AiZiLaHelper.updateMOModel(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
end

function var_0_0._updateItemModel(arg_7_0, arg_7_1)
	return arg_7_0:_updateMOModel(AiZiLaItemMO, arg_7_0._itemModel, arg_7_1.itemId, arg_7_1)
end

function var_0_0.setEpisodeId(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._curEpisodeId = arg_8_1
	arg_8_0._curEpisodeMO = AiZiLaEpsiodeMO.New()

	arg_8_0._curEpisodeMO:init(arg_8_1)

	local var_8_0 = VersionActivity1_5Enum.ActivityId.AiZiLa

	arg_8_0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(var_8_0, arg_8_1)
end

function var_0_0.getEpisodeId(arg_9_0)
	return arg_9_0._curEpisodeId
end

function var_0_0.getActivityID(arg_10_0)
	return arg_10_0._curActivityId
end

function var_0_0.getItemList(arg_11_0)
	return arg_11_0._itemModel:getList()
end

function var_0_0.getItemQuantity(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._itemModel:getById(arg_12_1)

	return var_12_0 and var_12_0:getQuantity() or 0
end

function var_0_0.getResultItemList(arg_13_0, arg_13_1)
	return arg_13_0._resultItemModel:getList()
end

function var_0_0.setIsSafe(arg_14_0, arg_14_1)
	arg_14_0._isSafe = arg_14_1
end

function var_0_0.getIsSafe(arg_15_0)
	return arg_15_0._isSafe
end

function var_0_0.isPass(arg_16_0)
	return arg_16_0._curEpisodeMO and arg_16_0._curEpisodeMO:isPass() or false
end

function var_0_0.getIsFirstPass(arg_17_0)
	return arg_17_0._isFirstPass
end

function var_0_0.getEventId(arg_18_0)
	return arg_18_0._curEpisodeMO and arg_18_0._curEpisodeMO.eventId or 0
end

function var_0_0.getBuffIdList(arg_19_0)
	return arg_19_0._curEpisodeMO and arg_19_0._curEpisodeMO.buffIds
end

function var_0_0.getElevation(arg_20_0)
	return arg_20_0._curEpisodeMO and arg_20_0._curEpisodeMO.altitude or 0
end

function var_0_0.getRoundCount(arg_21_0)
	return arg_21_0._curEpisodeMO and arg_21_0._curEpisodeMO.day
end

function var_0_0.getEpisodeMO(arg_22_0)
	return arg_22_0._curEpisodeMO
end

function var_0_0.updateEpisode(arg_23_0, arg_23_1)
	arg_23_0._curEpisodeMO:updateInfo(arg_23_1)
end

function var_0_0.addAct144Items(arg_24_0, arg_24_1)
	arg_24_0:_addModelAct144Items(arg_24_0._itemModel, arg_24_1)
end

function var_0_0.setAct144Items(arg_25_0, arg_25_1)
	arg_25_0._itemModel = arg_25_0:_clearOrCreateModel(arg_25_0._itemModel)

	arg_25_0:_addModelAct144Items(arg_25_0._itemModel, arg_25_1)
end

function var_0_0._addModelAct144Items(arg_26_0, arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(arg_26_2) do
		local var_26_0 = arg_26_1:getById(iter_26_1.itemId)

		if var_26_0 then
			var_26_0:addInfo(iter_26_1)
		else
			local var_26_1 = AiZiLaItemMO.New()

			var_26_1:init(iter_26_1.itemId, iter_26_1.itemId, iter_26_1.quantity)
			arg_26_1:addAtLast(var_26_1)
		end
	end
end

function var_0_0.setAct144ResultItems(arg_27_0, arg_27_1)
	arg_27_0._resultItemModel = arg_27_0:_clearOrCreateModel(arg_27_0._resultItemModel)

	arg_27_0:_addModelAct144Items(arg_27_0._resultItemModel, arg_27_1)
end

function var_0_0.settlePush(arg_28_0, arg_28_1)
	arg_28_0._isSafe = arg_28_1.isSafe
	arg_28_0._isFirstPass = arg_28_1.isFirstPass

	local var_28_0 = arg_28_1.tempAct144Items or {}

	arg_28_0:setAct144ResultItems(var_28_0)
	arg_28_0:updateEpisode(arg_28_1)
end

function var_0_0.settleEpisodeReply(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.act144Episode
	local var_29_1 = var_29_0 and var_29_0.tempAct144Items or {}

	arg_29_0:setAct144ResultItems(var_29_1)
	arg_29_0:updateEpisode(var_29_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
