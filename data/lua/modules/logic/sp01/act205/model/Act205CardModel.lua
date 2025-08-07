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

function var_0_0.getGameStageId(arg_13_0)
	return Act205Enum.GameStageId.Card
end

function var_0_0.getGameCount(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = Act205Model.instance:getAct205Id()
	local var_14_2 = arg_14_0:getGameStageId()
	local var_14_3 = Act205Model.instance:getGameInfoMo(var_14_1, var_14_2)

	if var_14_3 then
		var_14_0 = var_14_3:getHaveGameCount()
	end

	return var_14_0
end

function var_0_0.getSelectedCard(arg_15_0, arg_15_1)
	return arg_15_0._selectedCardTypeDict[arg_15_1]
end

function var_0_0.isSelectedCardTypeCard(arg_16_0, arg_16_1)
	return arg_16_0:getSelectedCard(arg_16_1) and true or false
end

function var_0_0.getIsCanBeginPK(arg_17_0)
	local var_17_0 = true

	for iter_17_0, iter_17_1 in pairs(Act205Enum.CardType) do
		if not arg_17_0:isSelectedCardTypeCard(iter_17_1) then
			var_17_0 = false

			break
		end
	end

	return var_17_0
end

function var_0_0.isCardSelected(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = Act205Config.instance:getCardType(arg_18_1)

	return arg_18_0:getSelectedCard(var_18_0) == arg_18_1
end

local function var_0_1(arg_19_0, arg_19_1)
	local var_19_0 = Act205Config.instance:getCardType(arg_19_0)
	local var_19_1 = Act205Config.instance:getCardType(arg_19_1)

	if var_19_0 ~= var_19_1 then
		return var_19_1 < var_19_0
	end

	return arg_19_0 < arg_19_1
end

function var_0_0.getSelectedCardList(arg_20_0)
	local var_20_0 = {}

	if arg_20_0._selectedCardTypeDict then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._selectedCardTypeDict) do
			var_20_0[#var_20_0 + 1] = iter_20_1
		end
	end

	table.sort(var_20_0, var_0_1)

	return var_20_0
end

function var_0_0.getResultPoint(arg_21_0)
	return arg_21_0._resultPoint
end

function var_0_0.getCacheKeyData(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_1 then
		var_22_0 = arg_22_0:_getPlayerCacheData()[arg_22_1]
	end

	return var_22_0
end

function var_0_0.getContinueFailCount(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = Act205Model.instance:getAct205Id()
	local var_23_2 = arg_23_0:getGameStageId()
	local var_23_3 = Act205Model.instance:getGameInfoMo(var_23_1, var_23_2)

	if var_23_3 then
		local var_23_4 = var_23_3:getGameInfo()

		var_23_0 = tonumber(var_23_4) or var_23_0
	end

	return var_23_0
end

function var_0_0.getPKResult(arg_24_0, arg_24_1)
	return arg_24_0._pkResult[arg_24_1] or Act205Enum.CardPKResult.Draw
end

var_0_0.instance = var_0_0.New()

return var_0_0
