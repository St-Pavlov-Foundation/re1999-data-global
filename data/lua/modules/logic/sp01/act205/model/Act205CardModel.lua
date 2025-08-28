module("modules.logic.sp01.act205.model.Act205CardModel", package.seeall)

local var_0_0 = class("Act205CardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:setResultPoint()
	arg_3_0:setGetRewardTime()
	arg_3_0:clearSelectedCard()

	arg_3_0._playerCacheData = nil
end

function var_0_0._getPlayerCacheData(arg_4_0)
	if not arg_4_0._playerCacheData then
		local var_4_0 = GameUtil.playerPrefsGetStringByUserId(Act205Enum.CardGameCacheDataPrefsKey, "")

		if not string.nilorempty(var_4_0) then
			arg_4_0._playerCacheData = cjson.decode(var_4_0)
		end

		arg_4_0._playerCacheData = arg_4_0._playerCacheData or {}
	end

	return arg_4_0._playerCacheData
end

function var_0_0._savePlayerCacheData(arg_5_0)
	if not arg_5_0._playerCacheData then
		return
	end

	GameUtil.playerPrefsSetStringByUserId(Act205Enum.CardGameCacheDataPrefsKey, cjson.encode(arg_5_0._playerCacheData))
end

function var_0_0.setSelectedCard(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = Act205Config.instance:getCardType(arg_6_1)

	if arg_6_2 then
		arg_6_0._selectedCardTypeDict[var_6_0] = arg_6_1
	else
		arg_6_0._selectedCardTypeDict[var_6_0] = nil
	end
end

function var_0_0.clearSelectedCard(arg_7_0)
	arg_7_0._pkResult = {}
	arg_7_0._selectedCardTypeDict = {}
end

function var_0_0.setResultPoint(arg_8_0, arg_8_1)
	arg_8_0._resultPoint = arg_8_1
end

function var_0_0.setCacheKeyData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_getPlayerCacheData()[arg_9_1] = arg_9_2

	arg_9_0:_savePlayerCacheData()
end

function var_0_0.setCacheKeyDataByDict(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0:_getPlayerCacheData()

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		var_10_0[iter_10_0] = iter_10_1
	end

	arg_10_0:_savePlayerCacheData()
end

function var_0_0.clearCacheKeyDataByList(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	local var_11_0 = arg_11_0:_getPlayerCacheData()

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_11_0[iter_11_1] = nil
	end

	arg_11_0:_savePlayerCacheData()
end

function var_0_0.setPkResult(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._pkResult[arg_12_1] = arg_12_2
end

function var_0_0.setGetRewardTime(arg_13_0, arg_13_1)
	arg_13_0._getRewardTime = arg_13_1
end

function var_0_0.getGameStageId(arg_14_0)
	return Act205Enum.GameStageId.Card
end

function var_0_0.getGameCount(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = Act205Model.instance:getAct205Id()
	local var_15_2 = arg_15_0:getGameStageId()
	local var_15_3 = Act205Model.instance:getGameInfoMo(var_15_1, var_15_2)

	if var_15_3 then
		var_15_0 = var_15_3:getHaveGameCount()
	end

	return var_15_0
end

function var_0_0.getSelectedCard(arg_16_0, arg_16_1)
	return arg_16_0._selectedCardTypeDict[arg_16_1]
end

function var_0_0.isSelectedCardTypeCard(arg_17_0, arg_17_1)
	return arg_17_0:getSelectedCard(arg_17_1) and true or false
end

function var_0_0.getIsCanBeginPK(arg_18_0)
	local var_18_0 = true

	for iter_18_0, iter_18_1 in pairs(Act205Enum.CardType) do
		if not arg_18_0:isSelectedCardTypeCard(iter_18_1) then
			var_18_0 = false

			break
		end
	end

	return var_18_0
end

function var_0_0.isCardSelected(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return
	end

	local var_19_0 = Act205Config.instance:getCardType(arg_19_1)

	return arg_19_0:getSelectedCard(var_19_0) == arg_19_1
end

local function var_0_1(arg_20_0, arg_20_1)
	local var_20_0 = Act205Config.instance:getCardType(arg_20_0)
	local var_20_1 = Act205Config.instance:getCardType(arg_20_1)

	if var_20_0 ~= var_20_1 then
		return var_20_1 < var_20_0
	end

	return arg_20_0 < arg_20_1
end

function var_0_0.getSelectedCardList(arg_21_0)
	local var_21_0 = {}

	if arg_21_0._selectedCardTypeDict then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._selectedCardTypeDict) do
			var_21_0[#var_21_0 + 1] = iter_21_1
		end
	end

	table.sort(var_21_0, var_0_1)

	return var_21_0
end

function var_0_0.getResultPoint(arg_22_0)
	return arg_22_0._resultPoint
end

function var_0_0.getCacheKeyData(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1 then
		var_23_0 = arg_23_0:_getPlayerCacheData()[arg_23_1]
	end

	return var_23_0
end

function var_0_0.getContinueFailCount(arg_24_0)
	local var_24_0 = 0
	local var_24_1 = Act205Model.instance:getAct205Id()
	local var_24_2 = arg_24_0:getGameStageId()
	local var_24_3 = Act205Model.instance:getGameInfoMo(var_24_1, var_24_2)

	if var_24_3 then
		local var_24_4 = var_24_3:getGameInfo()

		var_24_0 = tonumber(var_24_4) or var_24_0
	end

	return var_24_0
end

function var_0_0.getPKResult(arg_25_0, arg_25_1)
	return arg_25_0._pkResult[arg_25_1] or Act205Enum.CardPKResult.Draw
end

function var_0_0.getRecordRewardTime(arg_26_0)
	return arg_26_0._getRewardTime
end

var_0_0.instance = var_0_0.New()

return var_0_0
