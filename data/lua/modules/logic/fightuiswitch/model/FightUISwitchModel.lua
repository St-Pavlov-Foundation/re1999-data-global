module("modules.logic.fightuiswitch.model.FightUISwitchModel", package.seeall)

local var_0_0 = class("FightUISwitchModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curShowStyleClassify = FightUISwitchEnum.StyleClassify.FightCard
	arg_1_0._curUseStyleId = nil
	arg_1_0._curSelectStyleId = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curShowStyleClassify = FightUISwitchEnum.StyleClassify.FightCard
	arg_2_0._curUseStyleId = nil
	arg_2_0._curSelectStyleId = nil
end

function var_0_0.isOpenFightUISwitchSystem(arg_3_0)
	return true
end

function var_0_0._getUseStyleDefaultId(arg_4_0, arg_4_1)
	local var_4_0 = FightUISwitchConfig.instance:getFightUIStyleCoList()

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if iter_4_1.type == arg_4_1 and iter_4_1.defaultUnlock == 1 then
				return iter_4_1.id
			end
		end
	end
end

function var_0_0.initMo(arg_5_0)
	arg_5_0._styleMosClassifyList = {}
	arg_5_0._styleMosList = {}

	local var_5_0 = FightUISwitchConfig.instance:getFightUIStyleCoList()

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_1 = iter_5_1.type

			if not arg_5_0._styleMosClassifyList[var_5_1] then
				arg_5_0._styleMosClassifyList[var_5_1] = {}
			end

			local var_5_2 = FightUIStyleMo.New()

			var_5_2:initMo(iter_5_1, var_5_1)
			table.insert(arg_5_0._styleMosClassifyList[var_5_1], var_5_2)

			arg_5_0._styleMosList[iter_5_1.id] = var_5_2

			if var_5_2:isUse() then
				arg_5_0:setSelectStyleId(var_5_1, var_5_2.id)
			end
		end
	end

	FightUISwitchListModel.instance:setMoList()
end

function var_0_0.getStyleMoListByClassify(arg_6_0, arg_6_1)
	if not arg_6_0._styleMosClassifyList then
		arg_6_0:initMo()
	end

	return arg_6_0._styleMosClassifyList[arg_6_1] or {}
end

function var_0_0.getStyleMoById(arg_7_0, arg_7_1)
	if not arg_7_0._styleMosList then
		arg_7_0:initMo()
	end

	return arg_7_0._styleMosList[arg_7_1]
end

function var_0_0.getCurStyleMo(arg_8_0)
	local var_8_0 = arg_8_0:getCurShowStyleClassify()
	local var_8_1 = arg_8_0:getSelectStyleId(var_8_0)

	return (arg_8_0:getStyleMoById(var_8_1))
end

function var_0_0.setCurShowStyleClassify(arg_9_0, arg_9_1)
	arg_9_0._curShowStyleClassify = arg_9_1
end

function var_0_0.getCurShowStyleClassify(arg_10_0)
	return arg_10_0._curShowStyleClassify
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	arg_11_0:setSelectStyleId(arg_11_1.classify, arg_11_1.id)
	FightUISwitchListModel.instance:onSelect(arg_11_1.id, true)
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.SelectFightUIStyle, arg_11_1.classify, arg_11_1.id)
end

function var_0_0.getSelectStyleId(arg_12_0, arg_12_1)
	if not arg_12_0._curSelectStyleId then
		arg_12_0._curSelectStyleId = {}
	end

	if not arg_12_0._curSelectStyleId[arg_12_1] then
		arg_12_0._curSelectStyleId[arg_12_1] = arg_12_0:_getUseStyleDefaultId(arg_12_1)
	end

	return arg_12_0._curSelectStyleId[arg_12_1]
end

function var_0_0.setSelectStyleId(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0._curSelectStyleId then
		arg_13_0._curSelectStyleId = {}
	end

	arg_13_0._curSelectStyleId[arg_13_1] = arg_13_2
end

function var_0_0._getCurUseStyleId(arg_14_0, arg_14_1)
	if not arg_14_0._curUseStyleId then
		arg_14_0._curUseStyleId = {}
	end

	if not arg_14_0._curUseStyleId[arg_14_1] then
		local var_14_0 = arg_14_0:_getUseStyleDefaultId(arg_14_1)
		local var_14_1 = FightUISwitchEnum.StyleClassifyInfo[arg_14_1].SimpleProperty
		local var_14_2 = PlayerModel.instance:getSimpleProperty(var_14_1, var_14_0) or var_14_0

		arg_14_0._curUseStyleId[arg_14_1] = tonumber(var_14_2)
	end

	return arg_14_0._curUseStyleId[arg_14_1]
end

function var_0_0._setCurUseStyleId(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._curUseStyleId[arg_15_1] == arg_15_2 then
		return
	end

	arg_15_0._curUseStyleId[arg_15_1] = arg_15_2

	local var_15_0 = FightUISwitchEnum.StyleClassifyInfo[arg_15_1].SimpleProperty

	PlayerModel.instance:forceSetSimpleProperty(var_15_0, tostring(arg_15_2))
	PlayerRpc.instance:sendSetSimplePropertyRequest(var_15_0, tostring(arg_15_2))
	FightUISwitchController.instance:dispatchEvent(FightUISwitchEvent.UseFightUIStyle, arg_15_1, arg_15_2)
end

function var_0_0.getStyleMoByItemId(arg_16_0, arg_16_1)
	local var_16_0 = FightUISwitchConfig.instance:getStyleCosByItemId(arg_16_1)
	local var_16_1 = var_16_0 and var_16_0[1]

	if var_16_1 then
		return (arg_16_0:getStyleMoById(var_16_1.id))
	end
end

function var_0_0.getSceneRes(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.showres

	if arg_17_2 == ViewName.FightUISwitchSceneView then
		var_17_0 = var_17_0 .. "_big"
	end

	return var_17_0
end

function var_0_0.getCurUseFightUICardStyleId(arg_18_0)
	return arg_18_0:_getCurUseStyleId(FightUISwitchEnum.StyleClassify.FightCard)
end

function var_0_0.getCurUseFightUIFloatStyleId(arg_19_0)
	return arg_19_0:_getCurUseStyleId(FightUISwitchEnum.StyleClassify.FightFloat)
end

function var_0_0.getCurUseStyleIdByClassify(arg_20_0, arg_20_1)
	return arg_20_0:_getCurUseStyleId(arg_20_1)
end

function var_0_0.useStyleId(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0:_setCurUseStyleId(arg_21_1, arg_21_2)
end

function var_0_0.useCurStyleId(arg_22_0)
	local var_22_0 = arg_22_0:getCurShowStyleClassify()
	local var_22_1 = arg_22_0:getSelectStyleId(var_22_0)

	return arg_22_0:_setCurUseStyleId(var_22_0, var_22_1)
end

function var_0_0.isNewUnlockStyle(arg_23_0)
	local var_23_0 = arg_23_0:getNewUnlockIds()

	return LuaUtil.tableNotEmpty(var_23_0)
end

function var_0_0.getNewUnlockIds(arg_24_0)
	local var_24_0 = {}

	if not arg_24_0._styleMosList then
		arg_24_0:initMo()
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_0._styleMosList) do
		if not iter_24_1:isDefault() and iter_24_1:isUnlock() then
			local var_24_1 = arg_24_0:getUnlockPrefsKey(iter_24_1.id)

			if GameUtil.playerPrefsGetNumberByUserId(var_24_1, 0) == 0 then
				if not var_24_0[iter_24_1.classify] then
					var_24_0[iter_24_1.classify] = {}
				end

				table.insert(var_24_0[iter_24_1.classify], iter_24_1.id)
			end
		end
	end

	return var_24_0
end

function var_0_0.cancelNewUnlockClassifyReddot(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getNewUnlockIds()[arg_25_1]

	if var_25_0 then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			local var_25_1 = arg_25_0:getUnlockPrefsKey(iter_25_1)

			GameUtil.playerPrefsSetNumberByUserId(var_25_1, 1)
		end
	end
end

function var_0_0.getUnlockPrefsKey(arg_26_0, arg_26_1)
	return "FightUISwitchModel_unlockPrefsKey_" .. arg_26_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
