module("modules.logic.seasonver.act123.model.Season123PickHeroEntryModel", package.seeall)

local var_0_0 = class("Season123PickHeroEntryModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0:clear()

	arg_1_0._supportPosMO = nil
	arg_1_0.stage = nil
	arg_1_0._equipIdList = nil
	arg_1_0._lastHeroList = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.activityId = arg_2_1
	arg_2_0.stage = arg_2_2

	arg_2_0:initDatas()
	arg_2_0:initFromLocal()
	arg_2_0:clearLastSupportHero()
end

function var_0_0.initDatas(arg_3_0)
	local var_3_0 = {}

	for iter_3_0 = 1, Activity123Enum.PickHeroCount do
		local var_3_1 = Season123PickHeroEntryMO.New(iter_3_0)

		table.insert(var_3_0, var_3_1)

		if iter_3_0 == Activity123Enum.SupportPosIndex then
			arg_3_0._supportPosMO = var_3_1
		end
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.initFromLocal(arg_4_0)
	local var_4_0 = arg_4_0:readSelectionFromLocal()

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = arg_4_0:getByIndex(iter_4_0)
		local var_4_2 = HeroModel.instance:getById(var_4_0[iter_4_0])

		var_4_1:updateByHeroMO(var_4_2, false)
	end
end

function var_0_0.savePickHeroDatas(arg_5_0, arg_5_1)
	if not arg_5_0._supportPosMO then
		return
	end

	for iter_5_0 = 1, Activity123Enum.PickHeroCount do
		local var_5_0 = arg_5_1[iter_5_0]
		local var_5_1 = arg_5_0:getByIndex(iter_5_0)

		if var_5_1 == nil then
			logError("Season123PickHeroEntryModel entryMO is nil : " .. tostring(iter_5_0))

			return
		end

		if var_5_0 then
			if arg_5_0._supportPosMO.isSupport and var_5_0.heroId == arg_5_0._supportPosMO.heroId then
				arg_5_0._supportPosMO:setEmpty()
			end

			var_5_1:updateByPickMO(var_5_0)
		elseif not var_5_1.isSupport then
			var_5_1:setEmpty()
		end
	end
end

function var_0_0.setPickAssistData(arg_6_0, arg_6_1)
	if not arg_6_0._supportPosMO then
		return
	end

	if arg_6_1 == nil then
		if not arg_6_0._supportPosMO:getIsEmpty() and arg_6_0._supportPosMO.isSupport then
			arg_6_0._supportPosMO:setEmpty()
		end
	else
		local var_6_0 = arg_6_0:getList()

		for iter_6_0 = 1, Activity123Enum.PickHeroCount do
			local var_6_1 = var_6_0[iter_6_0]

			if arg_6_1.heroMO and arg_6_1.heroMO.heroId == var_6_1.heroId then
				var_6_1:setEmpty()
			end
		end

		arg_6_0._supportPosMO:updateByPickAssistMO(arg_6_1)
	end
end

function var_0_0.setMainEquips(arg_7_0, arg_7_1)
	arg_7_0._equipIdList = arg_7_1
end

function var_0_0.getSupportPosMO(arg_8_0)
	return arg_8_0._supportPosMO
end

function var_0_0.getSupporterHeroUid(arg_9_0)
	if arg_9_0._supportPosMO and arg_9_0._supportPosMO.isSupport and not arg_9_0._supportPosMO:getIsEmpty() then
		return arg_9_0._supportPosMO.heroUid
	end
end

function var_0_0.getSelectCount(arg_10_0)
	local var_10_0 = 0
	local var_10_1 = arg_10_0:getList()

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if not iter_10_1:getIsEmpty() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0
end

function var_0_0.getLimitCount(arg_11_0)
	return Activity123Enum.PickHeroCount
end

function var_0_0.getHeroUidList(arg_12_0)
	local var_12_0 = arg_12_0:getList()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		table.insert(var_12_1, iter_12_1.heroUid)
	end

	return var_12_1
end

function var_0_0.getMainCardList(arg_13_0)
	return arg_13_0._equipIdList
end

function var_0_0.getMainCardItemMO(arg_14_0, arg_14_1)
	if arg_14_0._equipIdList then
		local var_14_0 = arg_14_0._equipIdList[arg_14_1]

		if var_14_0 and var_14_0 ~= Activity123Enum.EmptyUid then
			local var_14_1 = Season123Model.instance:getActInfo(arg_14_0.activityId)

			if not var_14_1 then
				return
			end

			return (var_14_1:getItemMO(var_14_0))
		end
	end
end

function var_0_0.flushSelectionToLocal(arg_15_0)
	local var_15_0 = arg_15_0:getList()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if not iter_15_1:getIsEmpty() and not iter_15_1.isSupport then
			table.insert(var_15_1, iter_15_1.heroUid)
		end
	end

	PlayerPrefsHelper.setString(arg_15_0:getLocalKey(), cjson.encode(var_15_1))
end

function var_0_0.readSelectionFromLocal(arg_16_0)
	local var_16_0
	local var_16_1 = PlayerPrefsHelper.getString(arg_16_0:getLocalKey(), "")

	if not string.nilorempty(var_16_1) then
		var_16_0 = cjson.decode(var_16_1)
	else
		var_16_0 = {}
	end

	return var_16_0
end

function var_0_0.getLocalKey(arg_17_0)
	return PlayerPrefsKey.Season123PickHeroList .. "#" .. tostring(arg_17_0.activityId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.getCutHeroList(arg_18_0)
	local var_18_0 = arg_18_0._lastHeroList or arg_18_0:readSelectionFromLocal()
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0 = 1, #var_18_0 do
		local var_18_3 = HeroModel.instance:getById(var_18_0[iter_18_0])

		if var_18_3 then
			table.insert(var_18_1, var_18_3.heroId)
		end
	end

	for iter_18_1 = 1, Activity123Enum.PickHeroCount do
		local var_18_4 = arg_18_0:getByIndex(iter_18_1)

		if var_18_4 and not var_18_4:getIsEmpty() then
			if var_18_4.isSupport then
				if arg_18_0._lastSupportHeroId ~= var_18_4.heroId then
					table.insert(var_18_2, iter_18_1)
				end
			elseif var_18_1 then
				if not LuaUtil.tableContains(var_18_1, var_18_4.heroId) then
					table.insert(var_18_2, iter_18_1)
				end
			else
				table.insert(var_18_2, iter_18_1)
			end
		end
	end

	return var_18_2
end

function var_0_0.refeshLastHeroList(arg_19_0)
	local var_19_0 = arg_19_0:getList()

	arg_19_0._lastHeroList = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if not iter_19_1:getIsEmpty() then
			table.insert(arg_19_0._lastHeroList, iter_19_1.heroUid)
		end

		if iter_19_1.isSupport then
			if iter_19_1:getIsEmpty() then
				arg_19_0:clearLastSupportHero()
			else
				arg_19_0._lastSupportHeroId = iter_19_1.heroId
			end
		end
	end
end

function var_0_0.clearLastSupportHero(arg_20_0)
	arg_20_0._lastSupportHeroId = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
