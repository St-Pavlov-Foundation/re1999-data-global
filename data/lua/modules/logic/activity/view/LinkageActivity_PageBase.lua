module("modules.logic.activity.view.LinkageActivity_PageBase", package.seeall)

local var_0_0 = class("LinkageActivity_PageBase", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.onDestroyView(arg_2_0)
	var_0_0.super.onDestroyView(arg_2_0)
	arg_2_0:__onDispose()
end

function var_0_0.actId(arg_3_0)
	return arg_3_0:_assetGetParent():actId()
end

function var_0_0.actCO(arg_4_0)
	return arg_4_0:_assetGetParent():actCO()
end

function var_0_0.getLinkageActivityCO(arg_5_0)
	return arg_5_0:_assetGetParent():getLinkageActivityCO()
end

function var_0_0.getDataList(arg_6_0)
	return arg_6_0:_assetGetParent():getDataList()
end

function var_0_0.getTempDataList(arg_7_0)
	return arg_7_0:_assetGetParent():getTempDataList()
end

function var_0_0.selectedPage(arg_8_0, arg_8_1)
	return arg_8_0:_assetGetParent():selectedPage(arg_8_1)
end

function var_0_0.getDurationTimeStr(arg_9_0)
	local var_9_0 = arg_9_0:getLinkageActivityCO()

	return StoreController.instance:getRecommendStoreTime(var_9_0)
end

function var_0_0.jump(arg_10_0)
	local var_10_0 = arg_10_0:getLinkageActivityCO()

	GameFacade.jumpByAdditionParam(var_10_0.systemJumpCode or "10173")
end

function var_0_0.getLinkageActivityCO_item(arg_11_0, arg_11_1)
	return arg_11_0:getLinkageActivityCO()["item" .. arg_11_1]
end

function var_0_0.getLinkageActivityCO_res_video(arg_12_0, arg_12_1)
	return arg_12_0:getLinkageActivityCO()["res_video" .. arg_12_1]
end

function var_0_0.getLinkageActivityCO_desc(arg_13_0, arg_13_1)
	return arg_13_0:getLinkageActivityCO()["desc" .. arg_13_1]
end

function var_0_0.getItemIconResUrl(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getLinkageActivityCO_item(arg_14_1)
	local var_14_1 = arg_14_0:_assetGetViewContainer()

	return var_14_1:getItemIconResUrl(var_14_1:itemCo2TIQ(var_14_0))
end

function var_0_0.getItemConfig(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getLinkageActivityCO_item(arg_15_1)
	local var_15_1 = arg_15_0:_assetGetViewContainer()

	return var_15_1:getItemConfig(var_15_1:itemCo2TIQ(var_15_0))
end

function var_0_0.itemCo2TIQ(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getLinkageActivityCO_item(arg_16_1)

	return arg_16_0:_assetGetViewContainer():itemCo2TIQ(var_16_0)
end

function var_0_0.onPostSelectedPage(arg_17_0, arg_17_1, arg_17_2)
	return
end

return var_0_0
