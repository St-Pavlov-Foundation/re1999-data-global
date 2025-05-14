module("modules.logic.act189.view.ShortenActStyleItem_impl", package.seeall)

local var_0_0 = table.insert
local var_0_1 = class("ShortenActStyleItem_impl", RougeSimpleItemBase)

function var_0_1.ctor(arg_1_0, ...)
	arg_1_0:__onInit()
	var_0_1.super.ctor(arg_1_0, ...)
end

function var_0_1._getStyleCO(arg_2_0)
	return arg_2_0:_assetGetParent():getStyleCO()
end

function var_0_1._getBonusList(arg_3_0)
	return arg_3_0:_assetGetParent():getBonusList()
end

function var_0_1._isClaimable(arg_4_0)
	return arg_4_0:_assetGetParent():isClaimable()
end

function var_0_1._editableInitView(arg_5_0)
	var_0_1.super._editableInitView(arg_5_0)

	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "1")

	arg_5_0._simagerewardicon1Go = gohelper.findChild(var_5_0, "#simage_rewardicon1")
	arg_5_0._simagerewardicon2Go = gohelper.findChild(var_5_0, "#simage_rewardicon2")
	arg_5_0._goisget1 = gohelper.findChild(var_5_0, "#go_isget1")
	arg_5_0._goisget2 = gohelper.findChild(var_5_0, "#go_isget2")
	arg_5_0._gocanget1 = gohelper.findChild(var_5_0, "#go_canget1")
	arg_5_0._gocanget2 = gohelper.findChild(var_5_0, "#go_canget2")
	arg_5_0._txtnumbg1 = gohelper.findChildImage(var_5_0, "numbg1")
	arg_5_0._txtnumbg2 = gohelper.findChildImage(var_5_0, "numbg2")
	arg_5_0._txtnum1 = gohelper.findChildText(var_5_0, "numbg1/#txt_num1")
	arg_5_0._txtnum2 = gohelper.findChildText(var_5_0, "numbg2/#txt_num2")
	arg_5_0._gotimebg1 = gohelper.findChild(var_5_0, "#go_timebg1")
	arg_5_0._gotimebg2 = gohelper.findChild(var_5_0, "#go_timebg2")
	arg_5_0._gotimebgImg1 = arg_5_0._gotimebg1:GetComponent(gohelper.Type_Image)
	arg_5_0._gotimebgImg2 = arg_5_0._gotimebg2:GetComponent(gohelper.Type_Image)
	arg_5_0._commonPropItemIconList = {}

	local var_5_1 = IconMgr.instance:getCommonPropItemIcon(arg_5_0._simagerewardicon1Go)
	local var_5_2 = IconMgr.instance:getCommonPropItemIcon(arg_5_0._simagerewardicon2Go)

	var_0_0(arg_5_0._commonPropItemIconList, var_5_1)
	var_0_0(arg_5_0._commonPropItemIconList, var_5_2)

	arg_5_0._txtList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._txtList, arg_5_0._txtnum1)
	var_0_0(arg_5_0._txtList, arg_5_0._txtnum2)

	arg_5_0._txtBgList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._txtBgList, arg_5_0._txtnumbg1)
	var_0_0(arg_5_0._txtBgList, arg_5_0._txtnumbg2)

	arg_5_0._goisgetList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._goisgetList, arg_5_0._goisget1)
	var_0_0(arg_5_0._goisgetList, arg_5_0._goisget2)

	arg_5_0._gocangetList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._gocangetList, arg_5_0._gocanget1)
	var_0_0(arg_5_0._gocangetList, arg_5_0._gocanget2)

	arg_5_0._gotimebgList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._gotimebgList, arg_5_0._gotimebg1)
	var_0_0(arg_5_0._gotimebgList, arg_5_0._gotimebg2)

	arg_5_0._gotimebgImgList = arg_5_0:getUserDataTb_()

	var_0_0(arg_5_0._gotimebgImgList, arg_5_0._gotimebgImg1)
	var_0_0(arg_5_0._gotimebgImgList, arg_5_0._gotimebgImg2)
end

local var_0_2 = "#A5A5A5A0"

function var_0_1.setData(arg_6_0, arg_6_1)
	var_0_1.super.setData(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_0:_getBonusList()
	local var_6_1 = arg_6_0:_isClaimable()
	local var_6_2 = not var_6_1
	local var_6_3 = var_6_2 and var_0_2 or "#FFFFFF"

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_4 = arg_6_0._commonPropItemIconList[iter_6_0]
		local var_6_5 = arg_6_0._txtList[iter_6_0]
		local var_6_6 = arg_6_0._txtBgList[iter_6_0]
		local var_6_7 = arg_6_0._goisgetList[iter_6_0]
		local var_6_8 = arg_6_0._gocangetList[iter_6_0]
		local var_6_9 = arg_6_0._gotimebgList[iter_6_0]
		local var_6_10 = arg_6_0._gotimebgImgList[iter_6_0]
		local var_6_11 = iter_6_1[1]
		local var_6_12 = iter_6_1[2]
		local var_6_13 = iter_6_1[3]

		var_6_4:setMOValue(var_6_11, var_6_12, var_6_13)
		var_6_4:isShowQuality(false)
		var_6_4:isShowEquipAndItemCount(false)
		var_6_4:setItemColor(var_6_2 and var_0_2 or nil)
		var_6_4:customOnClickCallback(arg_6_0["_onClickItem" .. iter_6_0], arg_6_0)
		var_6_4:setCanShowDeadLine(false)

		var_6_5.text = var_6_13 and luaLang("multiple") .. var_6_13 or ""

		gohelper.setActive(var_6_7, var_6_2)
		gohelper.setActive(var_6_8, var_6_1)
		gohelper.setActive(var_6_9, var_6_4:isExpiredItem())
		SLFramework.UGUI.GuiHelper.SetColor(var_6_5, var_6_3)
		SLFramework.UGUI.GuiHelper.SetColor(var_6_6, var_6_3)
		SLFramework.UGUI.GuiHelper.SetColor(var_6_10, var_6_3)
	end
end

function var_0_1._onClickItem(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0:parent():onItemClick() then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_7_1, arg_7_2)
end

function var_0_1._onClickItem2(arg_8_0)
	local var_8_0 = arg_8_0:_getBonusList()[2]
	local var_8_1 = var_8_0[1]
	local var_8_2 = var_8_0[2]

	arg_8_0:_onClickItem(var_8_1, var_8_2)
end

function var_0_1._onClickItem1(arg_9_0)
	local var_9_0 = arg_9_0:_getBonusList()[1]
	local var_9_1 = var_9_0[1]
	local var_9_2 = var_9_0[2]

	arg_9_0:_onClickItem(var_9_1, var_9_2)
end

function var_0_1.onDestroyView(arg_10_0)
	GameUtil.onDestroyViewMemberList(arg_10_0, "_commonPropItemIconList")
	var_0_1.super.onDestroyView(arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_1
