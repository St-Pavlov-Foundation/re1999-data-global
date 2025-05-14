module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemBase", package.seeall)

local var_0_0 = class("ActivityGiftForTheVoyageItemBase", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	arg_1_0:onInitView()
	arg_1_0:addEvents()
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0:onDestroyView()
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._mo = arg_3_1

	arg_3_0:onRefresh()
end

function var_0_0._refreshRewardList(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._mo.id
	local var_4_1 = VoyageConfig.instance:getRewardStr(var_4_0)
	local var_4_2 = ItemModel.instance:getItemDataListByConfigStr(var_4_1)

	IconMgr.instance:getCommonPropItemIconList(arg_4_0, arg_4_0._onRewardItemShow, var_4_2, arg_4_1)
end

function var_0_0._onRewardItemShow(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1:onUpdateMO(arg_5_2)
	arg_5_1:setConsume(true)
	arg_5_1:isShowEffect(true)
	arg_5_1:setAutoPlay(true)
	arg_5_1:setCountFontSize(48)
	arg_5_1:showStackableNum2()
end

function var_0_0.addEvents(arg_6_0)
	return
end

function var_0_0.removeEvents(arg_7_0)
	return
end

function var_0_0.onRefresh(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:removeEvents()
end

return var_0_0
