module("modules.logic.voyage.view.ActivityGiftForTheVoyageItemRewardItem", package.seeall)

local var_0_0 = class("ActivityGiftForTheVoyageItemRewardItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._gohasGet = gohelper.findChild(arg_1_0.viewGO, "#go_hasGet")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1

	arg_2_0:onInitView()
end

function var_0_0._editableInitView(arg_3_0)
	gohelper.setActive(arg_3_0._gohasGet, false)

	arg_3_0._item = IconMgr.instance:getCommonItemIcon(arg_3_0._goitem)
end

function var_0_0.refreshRewardItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._item

	var_4_0:setMOValue(arg_4_1[1], arg_4_1[2], arg_4_1[3], nil, true)
	var_4_0:setConsume(true)
	var_4_0:isShowEffect(true)
	var_4_0:setAutoPlay(true)
	var_4_0:setCountFontSize(48)
	var_4_0:showStackableNum2()
	var_4_0:setGetMask(arg_4_2)
	gohelper.setActive(arg_4_0._gohasGet, arg_4_2)
end

function var_0_0.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMemberList(arg_5_0, "_item")
end

function var_0_0.onDestroy(arg_6_0)
	arg_6_0:onDestroyView()
end

return var_0_0
