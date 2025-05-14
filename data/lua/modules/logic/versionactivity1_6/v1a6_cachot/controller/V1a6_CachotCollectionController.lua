module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionController", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2)
	V1a6_CachotCollectionListModel.instance:onInitData(arg_1_1, arg_1_2)
	arg_1_0:selectFirstCollection()
	var_0_0.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
end

function var_0_0.onCloseView(arg_2_0)
	local var_2_0 = V1a6_CachotCollectionListModel.instance:getNewCollectionAndClickList()

	if var_2_0 and #var_2_0 > 0 then
		RogueRpc.instance:sendRogueCollectionNewRequest(V1a6_CachotEnum.ActivityId, var_2_0)
	end

	V1a6_CachotCollectionListModel.instance:release()
end

function var_0_0.selectFirstCollection(arg_3_0)
	local var_3_0 = V1a6_CachotCollectionListModel.instance:getCurCategoryFirstCollection()

	arg_3_0:onSelectCollection(var_3_0)
end

function var_0_0.onSelectCollection(arg_4_0, arg_4_1)
	V1a6_CachotCollectionListModel.instance:markSelectCollecionId(arg_4_1)
	var_0_0.instance:dispatchEvent(V1a6_CachotEvent.OnSelectCollectionItem)
end

function var_0_0.onSwitchCategory(arg_5_0, arg_5_1)
	if arg_5_1 ~= V1a6_CachotCollectionListModel.instance:getCurCategory() then
		V1a6_CachotCollectionListModel.instance:resetCurPlayAnimCellIndex()
		V1a6_CachotCollectionListModel.instance:switchCategory(arg_5_1)
		arg_5_0:selectFirstCollection()
		var_0_0.instance:dispatchEvent(V1a6_CachotEvent.OnSwitchCategory)
	end
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
