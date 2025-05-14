module("modules.logic.voyage.view.ActivityGiftForTheVoyageItem", package.seeall)

local var_0_0 = class("ActivityGiftForTheVoyageItem", ActivityGiftForTheVoyageItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskdesc")
	arg_1_0._gotxttaskdesc1 = gohelper.findChild(arg_1_0.viewGO, "#go_txt_taskdesc1")
	arg_1_0._gotxttaskdesc2 = gohelper.findChild(arg_1_0.viewGO, "#go_txt_taskdesc2")
	arg_1_0._gotxttaskdesc3 = gohelper.findChild(arg_1_0.viewGO, "#go_txt_taskdesc3")
	arg_1_0._txttaskdesc_client = gohelper.findChildText(arg_1_0.viewGO, "#txt_taskdesc_client")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_line")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Rewards")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_Rewards/Viewport/#go_Rewards/#go_Item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onRefresh(arg_4_0)
	local var_4_0 = arg_4_0._mo
	local var_4_1 = var_4_0.id
	local var_4_2 = VoyageModel.instance:getStateById(var_4_1)

	gohelper.setActive(arg_4_0._gotxttaskdesc1, var_4_1 > 0 and var_4_2 == VoyageEnum.State.Got)
	gohelper.setActive(arg_4_0._gotxttaskdesc2, var_4_1 > 0 and var_4_2 == VoyageEnum.State.Available)
	gohelper.setActive(arg_4_0._gotxttaskdesc3, var_4_1 > 0 and var_4_2 == VoyageEnum.State.None)

	arg_4_0._txttaskdesc.text = var_4_1 > 0 and var_4_0.desc or ""
	arg_4_0._txttaskdesc_client.text = var_4_1 > 0 and "" or var_4_0.desc

	arg_4_0:_refreshRewards()

	arg_4_0._scrollRewards.horizontalNormalizedPosition = 0
end

function var_0_0._onRewardItemShow(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_0.super._onRewardItemShow(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1:setGetMask(true)
end

function var_0_0.setActiveLine(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goline, arg_6_1)
end

function var_0_0._isGot(arg_7_0)
	local var_7_0 = arg_7_0._mo.id

	return VoyageModel.instance:getStateById(var_7_0) == VoyageEnum.State.Got
end

function var_0_0._createItemList(arg_8_0)
	if arg_8_0._itemList then
		return
	end

	local var_8_0 = arg_8_0._mo.id

	gohelper.setActive(arg_8_0._goitem, true)

	arg_8_0._itemList = {}

	local var_8_1 = VoyageConfig.instance:getRewardStrList(var_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = string.splitToNumber(iter_8_1, "#")
		local var_8_3 = arg_8_0:_createRewardItem(ActivityGiftForTheVoyageItemRewardItem)

		table.insert(arg_8_0._itemList, var_8_3)
		var_8_3:refreshRewardItem(var_8_2, arg_8_0:_isGot())
	end

	gohelper.setActive(arg_8_0._goitem, false)
end

function var_0_0._createRewardItem(arg_9_0, arg_9_1)
	local var_9_0 = gohelper.cloneInPlace(arg_9_0._goitem, arg_9_1.__name)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_9_0, arg_9_1)
end

function var_0_0._refreshRewards(arg_10_0)
	arg_10_0:_createItemList()
end

function var_0_0.onDestroyView(arg_11_0)
	GameUtil.onDestroyViewMemberList(arg_11_0, "_itemList")
end

return var_0_0
