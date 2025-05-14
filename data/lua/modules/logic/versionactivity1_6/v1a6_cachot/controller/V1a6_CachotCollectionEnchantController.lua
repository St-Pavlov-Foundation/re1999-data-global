module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionEnchantController", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionEnchantController", BaseController)
local var_0_1 = 1

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_1_0.onUpdateBagCollectionInfo, arg_1_0)
	arg_1_0:onInit(arg_1_1, V1a6_CachotEnum.CollectionHole.Left, true)
end

function var_0_0.onCloseView(arg_2_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_2_0.onUpdateBagCollectionInfo, arg_2_0)
	V1a6_CachotEnchantBagListModel.instance:reInit()
	V1a6_CachotCollectionEnchantListModel.instance:reInit()
end

function var_0_0.onInit(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	V1a6_CachotEnchantBagListModel.instance:onInitData()
	V1a6_CachotCollectionEnchantListModel.instance:onInitData(arg_3_3)

	local var_3_0 = V1a6_CachotEnchantBagListModel.instance:getById(arg_3_1)
	local var_3_1 = var_3_0 and V1a6_CachotEnchantBagListModel.instance:getIndex(var_3_0)

	arg_3_0:onSelectBagItem(var_3_1, arg_3_2)
end

function var_0_0.onUpdateBagCollectionInfo(arg_4_0)
	local var_4_0 = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
	local var_4_1 = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()

	arg_4_0:onInit(var_4_0, var_4_1, false)
end

function var_0_0.onSelectBagItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1 = V1a6_CachotEnchantBagListModel.instance:getByIndex(arg_5_1)

	if var_5_1 then
		local var_5_2 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_5_1.cfgId)

		if not var_5_2 or var_5_2.type == V1a6_CachotEnum.CollectionType.Enchant or var_5_2.holeNum <= 0 then
			ToastController.instance:showToast(ToastEnum.V1a6Cachot_Unable2Enchant)

			return
		end
	else
		return
	end

	arg_5_2 = arg_5_2 or V1a6_CachotEnum.CollectionHole.Left

	V1a6_CachotEnchantBagListModel.instance:selectCell(var_5_1.id, true)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(arg_5_2)

	local var_5_3 = var_5_1:getEnchantId(arg_5_2)

	arg_5_0:onSelectEnchantItem(var_5_3)
	arg_5_0:notifyViewUpdate()
end

function var_0_0.onSelectEnchantItem(arg_6_0, arg_6_1, arg_6_2)
	V1a6_CachotCollectionEnchantListModel.instance:selectCell(arg_6_1, true)

	if arg_6_2 then
		local var_6_0 = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
		local var_6_1 = V1a6_CachotEnchantBagListModel.instance:getCurSelectHoleIndex()
		local var_6_2 = V1a6_CachotEnchantBagListModel.instance:getById(var_6_0)
		local var_6_3 = (var_6_2 and var_6_2:getEnchantId(var_6_1)) ~= arg_6_1 and arg_6_1 or V1a6_CachotEnum.EmptyEnchantId

		arg_6_0:trySendRogueCollectionEnchantRequest(var_6_0, var_6_3, var_6_1)
	end
end

function var_0_0.trySendRogueCollectionEnchantRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 == nil then
		return
	end

	arg_7_2 = arg_7_2 or V1a6_CachotEnum.EmptyEnchantId

	local var_7_0 = arg_7_0:tryRemoveEnchant(arg_7_2)

	if arg_7_0:tryEnchant2EmptyHole(arg_7_1, arg_7_2, arg_7_3) and var_7_0 and var_7_0 ~= arg_7_1 then
		ToastController.instance:showToast(ToastEnum.V1a6Cachot_HasEnchant)
	end
end

function var_0_0.tryRemoveEnchant(arg_8_0, arg_8_1)
	local var_8_0 = V1a6_CachotCollectionEnchantListModel.instance:getById(arg_8_1)
	local var_8_1 = var_8_0 and var_8_0.enchantUid
	local var_8_2 = V1a6_CachotEnchantBagListModel.instance:getById(var_8_1)

	if var_8_2 then
		local var_8_3 = var_8_2:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local var_8_4 = var_8_2:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)
		local var_8_5 = arg_8_1 == var_8_3 and V1a6_CachotEnum.EmptyEnchantId or var_8_3
		local var_8_6 = arg_8_1 == var_8_4 and V1a6_CachotEnum.EmptyEnchantId or var_8_4

		RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, var_8_1, var_8_5, var_8_6)

		return var_8_1
	end
end

function var_0_0.tryEnchant2EmptyHole(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = V1a6_CachotEnchantBagListModel.instance:getById(arg_9_1)

	if var_9_0 then
		local var_9_1 = var_9_0:getEnchantId(V1a6_CachotEnum.CollectionHole.Left)
		local var_9_2 = var_9_0:getEnchantId(V1a6_CachotEnum.CollectionHole.Right)
		local var_9_3 = arg_9_3 == V1a6_CachotEnum.CollectionHole.Left and arg_9_2 or var_9_1
		local var_9_4 = arg_9_3 == V1a6_CachotEnum.CollectionHole.Right and arg_9_2 or var_9_2

		if var_9_3 == var_9_4 then
			var_9_3 = arg_9_3 == V1a6_CachotEnum.CollectionHole.Left and var_9_3 or V1a6_CachotEnum.EmptyEnchantId
			var_9_4 = arg_9_3 == V1a6_CachotEnum.CollectionHole.Right and var_9_4 or V1a6_CachotEnum.EmptyEnchantId
		end

		RogueRpc.instance:sendRogueCollectionEnchantRequest(V1a6_CachotEnum.ActivityId, arg_9_1, var_9_3, var_9_4)

		return true
	end
end

function var_0_0.onSelectHoleGrid(arg_10_0, arg_10_1, arg_10_2)
	V1a6_CachotEnchantBagListModel.instance:markCurSelectHoleIndex(arg_10_1)

	if not arg_10_2 then
		return
	end

	local var_10_0 = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()
	local var_10_1 = V1a6_CachotEnchantBagListModel.instance:getById(var_10_0)
	local var_10_2 = var_10_1 and var_10_1:getEnchantId(arg_10_1)

	if var_10_2 and var_10_2 ~= V1a6_CachotEnum.EmptyEnchantId then
		arg_10_0:trySendRogueCollectionEnchantRequest(var_10_0, V1a6_CachotEnum.EmptyEnchantId, arg_10_1)
	end
end

function var_0_0.switchCategory(arg_11_0, arg_11_1)
	if arg_11_1 ~= V1a6_CachotEnchantBagListModel.instance:getCurSelectCategory() then
		V1a6_CachotEnchantBagListModel.instance:switchCategory(arg_11_1)
		arg_11_0:onSelectBagItem(var_0_1)
	end
end

function var_0_0.notifyViewUpdate(arg_12_0)
	local var_12_0 = V1a6_CachotEnchantBagListModel.instance:getCurSelectCollectionId()

	var_0_0.instance:dispatchEvent(V1a6_CachotEvent.OnSelectEnchantCollection, var_12_0)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
