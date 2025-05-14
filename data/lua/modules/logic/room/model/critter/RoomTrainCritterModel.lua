module("modules.logic.room.model.critter.RoomTrainCritterModel", package.seeall)

local var_0_0 = class("RoomTrainCritterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectOptionInfos = {}
	arg_2_0._totalSelectCount = 0
	arg_2_0._storyPlayedList = {}

	local var_2_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, "")

	if not LuaUtil.isEmptyStr(var_2_0) then
		local var_2_1 = ServerTime.now()
		local var_2_2 = string.split(var_2_0, "#")

		if #var_2_2 > 1 and TimeUtil.isSameDay(tonumber(var_2_2[1]), var_2_1) then
			for iter_2_0 = 2, #var_2_2 do
				table.insert(arg_2_0._storyPlayedList, tonumber(var_2_2[iter_2_0]))
			end
		end
	end
end

function var_0_0.isEventTrainStoryPlayed(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._storyPlayedList) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function var_0_0.setEventTrainStoryPlayed(arg_4_0, arg_4_1)
	if arg_4_0:isEventTrainStoryPlayed(arg_4_1) then
		return
	end

	table.insert(arg_4_0._storyPlayedList, arg_4_1)

	local var_4_0 = tostring(ServerTime.now())

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._storyPlayedList) do
		var_4_0 = string.format("%s#%s", var_4_0, iter_4_1)
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.RoomCritterTrainStoryPlayed, var_4_0)
end

function var_0_0.isCritterTrainStory(arg_5_0, arg_5_1)
	if #tostring(arg_5_1) ~= 9 then
		return false
	end

	local var_5_0 = arg_5_1 % 100000

	for iter_5_0, iter_5_1 in pairs(lua_critter_train_event.configDict) do
		if iter_5_1.type == CritterEnum.EventType.ActiveTime and (var_5_0 == iter_5_1.initStoryId or var_5_0 == iter_5_1.normalStoryId or var_5_0 == iter_5_1.skilledStoryId) then
			return true
		end
	end

	return false
end

function var_0_0.getCritterTrainStory(arg_6_0, arg_6_1, arg_6_2)
	return 100000 * arg_6_1 + arg_6_2
end

function var_0_0.clearSelectOptionInfos(arg_7_0)
	arg_7_0._totalSelectCount = 0
	arg_7_0._selectOptionInfos = {}
end

function var_0_0.getSelectOptionInfos(arg_8_0)
	if not arg_8_0._selectOptionInfos or not next(arg_8_0._selectOptionInfos) then
		arg_8_0._selectOptionInfos = {
			{
				optionId = 1,
				count = 0
			},
			{
				optionId = 2,
				count = 0
			},
			{
				optionId = 3,
				count = 0
			}
		}
	end

	return arg_8_0._selectOptionInfos
end

function var_0_0.addSelectOptionCount(arg_9_0, arg_9_1)
	if not arg_9_0._selectOptionInfos[arg_9_1] then
		arg_9_0:getSelectOptionInfos()
	end

	arg_9_0._selectOptionInfos[arg_9_1].count = arg_9_0._selectOptionInfos[arg_9_1].count + 1
end

function var_0_0.cancelSelectOptionCount(arg_10_0, arg_10_1)
	if not arg_10_0._selectOptionInfos[arg_10_1] then
		arg_10_0:getSelectOptionInfos()
	end

	if arg_10_0._selectOptionInfos[arg_10_1].count < 1 then
		return
	end

	arg_10_0._selectOptionInfos[arg_10_1].count = arg_10_0._selectOptionInfos[arg_10_1].count - 1
end

function var_0_0.getSelectOptionCount(arg_11_0, arg_11_1)
	if not arg_11_0._selectOptionInfos[arg_11_1] then
		arg_11_0:getSelectOptionInfos()
	end

	return arg_11_0._selectOptionInfos[arg_11_1].count
end

function var_0_0.getSelectOptionTotalCount(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._selectOptionInfos) do
		var_12_0 = var_12_0 + iter_12_1.count
	end

	return var_12_0
end

function var_0_0.setOptionsSelectTotalCount(arg_13_0, arg_13_1)
	arg_13_0._totalSelectCount = arg_13_1
end

function var_0_0.getOptionsSelectTotalCount(arg_14_0)
	return arg_14_0._totalSelectCount
end

function var_0_0.getSelectOptionLimitCount(arg_15_0)
	local var_15_0 = arg_15_0:getSelectOptionTotalCount()

	if arg_15_0._totalSelectCount - var_15_0 <= 0 then
		return 0
	end

	return arg_15_0._totalSelectCount - var_15_0
end

function var_0_0.getProductGood(arg_16_0, arg_16_1)
	local var_16_0 = StoreConfig.instance:getRoomCritterProductGoods(arg_16_1)

	if #var_16_0 < 1 then
		return nil
	end

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_1 = StoreModel.instance:getGoodsMO(iter_16_1.id)

		if var_16_1.buyCount < var_16_1.config.maxBuyCount then
			return var_16_1
		end
	end

	for iter_16_2, iter_16_3 in pairs(var_16_0) do
		local var_16_2 = StoreModel.instance:getGoodsMO(iter_16_3.id)

		if var_16_2.config.maxBuyCount == 0 then
			return var_16_2
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
