module("modules.logic.rouge.controller.RougeCollectionEnchantController", package.seeall)

local var_0_0 = class("RougeCollectionEnchantController", BaseController)
local var_0_1 = 1

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:onInit(arg_1_1, arg_1_2, arg_1_3, true)
end

function var_0_0.onCloseView(arg_2_0)
	RougeCollectionUnEnchantListModel.instance:reInit()
	RougeCollectionEnchantListModel.instance:reInit()
end

function var_0_0.onInit(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	RougeCollectionUnEnchantListModel.instance:onInitData(arg_3_2)
	RougeCollectionEnchantListModel.instance:onInitData(arg_3_4)

	local var_3_0 = RougeCollectionUnEnchantListModel.instance:getById(arg_3_1)
	local var_3_1 = var_3_0 and RougeCollectionUnEnchantListModel.instance:getIndex(var_3_0)

	arg_3_0:onSelectBagItem(var_3_1, arg_3_3)
end

function var_0_0.onSelectBagItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1 = RougeCollectionUnEnchantListModel.instance:getByIndex(arg_4_1)

	if not var_4_1 then
		return
	end

	arg_4_2 = arg_4_2 or var_0_1

	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(arg_4_2)
	RougeCollectionUnEnchantListModel.instance:switchSelectCollection(var_4_1.id)

	local var_4_2 = var_4_1:getEnchantIdAndCfgId(arg_4_2)

	arg_4_0:onSelectEnchantItem(var_4_1.id, var_4_2, arg_4_2)
end

function var_0_0.onSelectEnchantItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_2 = arg_5_2 or 0
	arg_5_3 = arg_5_3 or 0

	if not arg_5_1 or not (arg_5_2 > 0) or not (arg_5_3 > 0) then
		RougeCollectionEnchantListModel.instance:selectCell(nil, false)
		var_0_0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, arg_5_1)

		return
	end

	local var_5_0 = RougeCollectionModel.instance:getCollectionByUid(arg_5_1)

	if (var_5_0 and var_5_0:getEnchantIdAndCfgId(arg_5_3)) ~= arg_5_2 then
		arg_5_0:trySendRogueCollectionEnchantRequest(arg_5_1, arg_5_2, arg_5_3)
	elseif RougeCollectionEnchantListModel.instance:getCurSelectEnchantId() ~= arg_5_2 then
		RougeCollectionEnchantListModel.instance:selectCell(arg_5_2, true)
		var_0_0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, arg_5_1)
	end
end

function var_0_0.trySendRogueCollectionEnchantRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 or not arg_6_2 or not arg_6_3 then
		return
	end

	local var_6_0 = RougeCollectionModel.instance:getCollectionByUid(arg_6_1)

	if not var_6_0 then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(var_6_0.id))

		return
	end

	if arg_6_2 ~= RougeEnum.EmptyEnchantId and not (RougeCollectionModel.instance:getCollectionByUid(arg_6_2) or RougeCollectionEnchantListModel.instance:getById(arg_6_2)) then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该附魔软盘,软盘uid = " .. tostring(arg_6_2))

		return
	end

	local var_6_1 = RougeCollectionConfig.instance:getCollectionCfg(var_6_0.cfgId).holeNum or 0

	if var_6_1 <= 0 then
		return
	end

	if var_6_1 < arg_6_3 then
		logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", arg_6_3, var_6_0.id, var_6_0.cfgId, var_6_1))

		return
	end

	RougeRpc.instance:sendRougeInlayRequest(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.trySendRemoveCollectionEnchantRequest(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	local var_7_0 = RougeCollectionModel.instance:getCollectionByUid(arg_7_1)

	if not var_7_0 then
		logError("尝试将新的造物附魔数据发送给后端失败,失败原因:背包中找不到该造物,造物uid = " .. tostring(arg_7_1))

		return
	end

	local var_7_1 = var_7_0:getEnchantIdAndCfgId(arg_7_2)

	if not var_7_1 or var_7_1 <= 0 then
		return
	end

	local var_7_2 = RougeCollectionConfig.instance:getCollectionCfg(var_7_0.cfgId).holeNum or 0

	if var_7_2 < arg_7_2 then
		logError(string.format("尝试将新的造物附魔数据发送给后端失败,失败原因:准备对序号为%s的孔位进行附魔操作,但是配置表中配置的孔位数量小于该序号,软盘uid = %s, 配置id = %s,孔位数量 = %s", arg_7_2, var_7_0.id, var_7_0.cfgId, var_7_2))

		return
	end

	RougeRpc.instance:sendRougeDemountRequest(arg_7_1, arg_7_2)
end

function var_0_0.onSelectHoleGrid(arg_8_0, arg_8_1)
	RougeCollectionUnEnchantListModel.instance:markCurSelectHoleIndex(arg_8_1)

	local var_8_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()

	if var_8_0 then
		local var_8_1 = RougeCollectionUnEnchantListModel.instance:getById(var_8_0)
		local var_8_2 = var_8_1 and var_8_1:getEnchantIdAndCfgId(arg_8_1)

		arg_8_0:onSelectEnchantItem(var_8_0, var_8_2, arg_8_1)
	end
end

function var_0_0.switchCollection(arg_9_0, arg_9_1)
	local var_9_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex()
	local var_9_1 = RougeCollectionUnEnchantListModel.instance:getCount()
	local var_9_2

	if arg_9_1 then
		var_9_2 = Mathf.Clamp(var_9_0 + 1, 1, var_9_1)
	else
		var_9_2 = Mathf.Clamp(var_9_0 - 1, 1, var_9_1)
	end

	if var_9_2 ~= var_9_0 and RougeCollectionUnEnchantListModel.instance:getByIndex(var_9_2) then
		RougeCollectionEnchantListModel.instance:executeSortFunc()
		arg_9_0:onSelectBagItem(var_9_2, var_0_1)
	end
end

function var_0_0.removeEnchant(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RougeCollectionModel.instance:getCollectionByUid(arg_10_1)
	local var_10_1 = var_10_0 and var_10_0:getEnchantIdAndCfgId(arg_10_2)

	if var_10_1 and var_10_1 > 0 then
		RougeCollectionEnchantListModel.instance:selectCell(var_10_1, false)
	end

	arg_10_0:trySendRemoveCollectionEnchantRequest(arg_10_1, arg_10_2)
end

function var_0_0.onRougeInlayInfoUpdate(arg_11_0, arg_11_1, arg_11_2)
	if RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId() == arg_11_1 then
		local var_11_0 = RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex()
		local var_11_1 = RougeCollectionModel.instance:getCollectionByUid(arg_11_1):getEnchantIdAndCfgId(var_11_0)

		RougeCollectionEnchantListModel.instance:selectCell(var_11_1, true)
	end

	if arg_11_2 and arg_11_2 > 0 then
		var_0_0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, arg_11_2)
	end

	var_0_0.instance:dispatchEvent(RougeEvent.UpdateCollectionEnchant, arg_11_1)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
