module("modules.logic.seasonver.act123.model.Season123CardPackageModel", package.seeall)

local var_0_0 = class("Season123CardPackageModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()

	arg_1_0.packageMap = {}
end

function var_0_0.release(arg_2_0)
	arg_2_0:clear()

	arg_2_0.cardItemList = {}
	arg_2_0.cardItemMap = {}
	arg_2_0.curActId = nil
end

function var_0_0.reInit(arg_3_0)
	arg_3_0.curActId = nil
	arg_3_0.packageConfigMap = {}
	arg_3_0.cardItemList = {}
	arg_3_0.cardItemMap = {}
	arg_3_0.packageCount = 0
	arg_3_0.packageMap = {}
end

function var_0_0.initData(arg_4_0, arg_4_1)
	arg_4_0.curActId = arg_4_1

	arg_4_0:initOpenPackageMO(arg_4_1)
	arg_4_0:initPackageCount()
end

function var_0_0.getOpenPackageMO(arg_5_0)
	if arg_5_0.packageCount > 0 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.packageMap) do
			if ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, iter_5_1.id) > 0 then
				return iter_5_1
			end
		end
	end
end

function var_0_0.initOpenPackageMO(arg_6_0, arg_6_1)
	local var_6_0 = ItemModel.instance:getDict()

	if GameUtil.getTabLen(arg_6_0.packageConfigMap) == 0 then
		arg_6_0:initCurActCardPackageConfigMap(arg_6_1)
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_0.packageConfigMap) do
		local var_6_1 = var_6_0[iter_6_1.id]
		local var_6_2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, iter_6_1.id)

		if var_6_1 and var_6_2 > 0 then
			arg_6_0.packageMap[var_6_1.id] = var_6_1
		end
	end
end

function var_0_0.initCurActCardPackageConfigMap(arg_7_0, arg_7_1)
	local var_7_0 = ItemConfig.instance:getItemListBySubType(Activity123Enum.CardPackageSubType) or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.activityId == arg_7_1 then
			arg_7_0.packageConfigMap[iter_7_1.id] = iter_7_1
		end
	end
end

function var_0_0.initPackageCount(arg_8_0)
	arg_8_0.packageCount = 0

	if GameUtil.getTabLen(arg_8_0.packageMap) == 0 then
		arg_8_0:initOpenPackageMO(arg_8_0.curActId)
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.packageMap) do
		local var_8_0 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, iter_8_1.id)

		arg_8_0.packageCount = arg_8_0.packageCount + var_8_0
	end

	return arg_8_0.packageCount
end

function var_0_0.setCardItemList(arg_9_0, arg_9_1)
	arg_9_0.cardItemList = {}
	arg_9_0.cardItemMap = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = arg_9_0.cardItemMap[iter_9_1]

		if not var_9_0 then
			var_9_0 = Season123CardPackageItemMO.New()

			var_9_0:init(iter_9_1)

			arg_9_0.cardItemMap[iter_9_1] = var_9_0

			table.insert(arg_9_0.cardItemList, var_9_0)
		else
			var_9_0.count = var_9_0.count + 1
		end
	end

	table.sort(arg_9_0.cardItemList, arg_9_0.sortCardItemList)
	arg_9_0:setList(arg_9_0.cardItemList)
end

function var_0_0.sortCardItemList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.config
	local var_10_1 = arg_10_1.config

	if var_10_0 ~= nil and var_10_1 ~= nil then
		if var_10_0.rare ~= var_10_1.rare then
			return var_10_0.rare > var_10_1.rare
		else
			return var_10_0.equipId > var_10_1.equipId
		end
	else
		return arg_10_0.itemId < arg_10_1.itemId
	end
end

function var_0_0.getCardMaxRare(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0.cardItemList) do
		if iter_11_1.config and var_11_0 < iter_11_1.config.rare then
			var_11_0 = iter_11_1.config.rare
		elseif not iter_11_1.config then
			logError("activity123_equip config id is not exit: " .. tostring(iter_11_1.itemId))
		end
	end

	return var_11_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
