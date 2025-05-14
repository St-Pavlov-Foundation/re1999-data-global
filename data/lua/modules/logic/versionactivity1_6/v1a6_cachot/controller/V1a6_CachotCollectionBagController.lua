module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionBagController", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionBagController", BaseController)
local var_0_1 = 1

function var_0_0.onOpenView(arg_1_0)
	V1a6_CachotCollectionEnchantController.instance:registerCallback(V1a6_CachotEvent.OnSelectEnchantCollection, arg_1_0.onEnchantViewSelectCollection, arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_1_0.onCollectionDataUpdate, arg_1_0)
	V1a6_CachotCollectionBagListModel.instance:onInitData()
	arg_1_0:onSelectBagItemByIndex(var_0_1)
end

function var_0_0.onCloseView(arg_2_0)
	V1a6_CachotCollectionEnchantController.instance:unregisterCallback(V1a6_CachotEvent.OnSelectEnchantCollection, arg_2_0.onEnchantViewSelectCollection, arg_2_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_2_0.onCollectionDataUpdate, arg_2_0)
end

function var_0_0.onCollectionDataUpdate(arg_3_0)
	V1a6_CachotCollectionBagListModel.instance:onCollectionDataUpdate()
	arg_3_0:notifyViewUpdate()
end

function var_0_0.onSelectBagItemByIndex(arg_4_0, arg_4_1)
	V1a6_CachotCollectionBagListModel.instance:selectCell(arg_4_1, true)

	local var_4_0 = V1a6_CachotCollectionBagListModel.instance:getByIndex(arg_4_1)
	local var_4_1 = var_4_0 and var_4_0.id

	arg_4_0:notifyViewUpdate(var_4_1)
end

function var_0_0.onSelectBagItemById(arg_5_0, arg_5_1)
	local var_5_0 = V1a6_CachotCollectionBagListModel.instance:getById(arg_5_1)
	local var_5_1 = V1a6_CachotCollectionBagListModel.instance:getIndex(var_5_0)

	V1a6_CachotCollectionBagListModel.instance:selectCell(var_5_1, true)
	arg_5_0:notifyViewUpdate(arg_5_1)
end

function var_0_0.onEnchantViewSelectCollection(arg_6_0, arg_6_1)
	arg_6_0:onSelectBagItemById(arg_6_1)
end

function var_0_0.notifyViewUpdate(arg_7_0, arg_7_1)
	arg_7_0:dispatchEvent(V1a6_CachotEvent.OnSelectBagCollection, arg_7_1)
end

function var_0_0.moveCollectionWithHole2TopAndSelect(arg_8_0)
	local var_8_0 = V1a6_CachotCollectionBagListModel.instance:moveCollectionWithHole2Top()

	if var_8_0 then
		arg_8_0:onSelectBagItemByIndex(var_0_1)
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
