module("modules.logic.fightuiswitch.model.FightUIStyleMo", package.seeall)

local var_0_0 = class("FightUIStyleMo")

function var_0_0.initMo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.co = arg_1_1
	arg_1_0.classify = arg_1_2
	arg_1_0.itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, arg_1_1.itemId)
	arg_1_0._effectMosList = {}

	local var_1_0 = string.splitToNumber(arg_1_1.banner, "#")

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = FightUIEffectMo.New()

		var_1_1:initMo(iter_1_1, arg_1_2)
		table.insert(arg_1_0._effectMosList, var_1_1)
	end
end

function var_0_0.isUse(arg_2_0)
	return arg_2_0.id == FightUISwitchModel.instance:getCurUseStyleIdByClassify(arg_2_0.classify)
end

function var_0_0.isUnlock(arg_3_0)
	if arg_3_0:isDefault() then
		return true
	end

	return ItemModel.instance:getItemCount(arg_3_0.co.itemId) > 0
end

function var_0_0.getRare(arg_4_0)
	return arg_4_0.itemCo and arg_4_0.itemCo.rare or 3
end

function var_0_0.getAllEffectMos(arg_5_0)
	return arg_5_0._effectMosList
end

function var_0_0.isDefault(arg_6_0)
	return arg_6_0.co.defaultUnlock == 1
end

function var_0_0.getConfig(arg_7_0)
	return arg_7_0.co
end

function var_0_0.getItemConfig(arg_8_0)
	return arg_8_0.itemCo
end

function var_0_0.getObtainTime(arg_9_0)
	if not arg_9_0:isUnlock() then
		return
	end

	local var_9_0

	if arg_9_0:isDefault() then
		local var_9_1 = PlayerModel.instance:getPlayinfo()

		var_9_0 = var_9_1 and var_9_1.registerTime
	else
		local var_9_2 = ItemModel.instance:getById(arg_9_0.co.itemId)

		var_9_0 = var_9_2 and var_9_2.lastUpdateTime
	end

	if string.nilorempty(var_9_0) then
		return
	end

	local var_9_3 = var_9_0 and TimeUtil.timestampToString3(ServerTime.timeInLocal(var_9_0 / 1000))

	return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("fightuiswitch_obtaintime"), var_9_3)
end

function var_0_0.canJump(arg_10_0)
	local var_10_0 = MainSceneSwitchConfig.instance:getItemSource(arg_10_0.itemCo.id)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1, var_10_2 = MainSceneSwitchModel._getCantJump(iter_10_1)

		if not var_10_1 then
			return true
		end
	end

	return false
end

return var_0_0
