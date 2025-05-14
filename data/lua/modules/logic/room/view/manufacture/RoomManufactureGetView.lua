module("modules.logic.room.view.manufacture.RoomManufactureGetView", package.seeall)

local var_0_0 = class("RoomManufactureGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._scrollproduct = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_product")
	arg_1_0._goproductitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_product/Viewport/Content/#go_productitem")
	arg_1_0._gonormalLayout = gohelper.findChild(arg_1_0.viewGO, "#scroll_product/Viewport/Content/#go_normalLayout")
	arg_1_0._gousedTitle = gohelper.findChild(arg_1_0.viewGO, "#scroll_product/Viewport/Content/txt_tips")
	arg_1_0._gousedLayout = gohelper.findChild(arg_1_0.viewGO, "#scroll_product/Viewport/Content/#go_usedLayout")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goproductitem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	if arg_6_0.viewParam then
		arg_6_0.normalList = arg_6_0.viewParam.normalList
		arg_6_0.usedList = arg_6_0.viewParam.usedList
	end

	arg_6_0.normalList = arg_6_0.normalList or {}
	arg_6_0.usedList = arg_6_0.usedList or {}
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:onUpdateParam()
	arg_7_0:setNormalList()
	arg_7_0:setUsedList()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouhuo_2_2)
end

function var_0_0.setNormalList(arg_8_0)
	gohelper.CreateObjList(arg_8_0, arg_8_0._onSeItem, arg_8_0.normalList, arg_8_0._gonormalLayout, arg_8_0._goproductitem)
end

function var_0_0.setUsedList(arg_9_0)
	local var_9_0 = arg_9_0.usedList and #arg_9_0.usedList > 0

	gohelper.setActive(arg_9_0._gousedTitle, var_9_0)
	gohelper.setActive(arg_9_0._gousedLayout, var_9_0)
	gohelper.CreateObjList(arg_9_0, arg_9_0._onSeItem, arg_9_0.usedList, arg_9_0._gousedLayout, arg_9_0._goproductitem)
end

function var_0_0._onSeItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_2.isShowExtra
	local var_10_1 = gohelper.findChild(arg_10_1, "tag_extra")
	local var_10_2 = gohelper.findChild(arg_10_1, "#baoji")

	gohelper.setActive(var_10_1, var_10_0)
	gohelper.setActive(var_10_2, var_10_0)

	local var_10_3 = gohelper.findChild(arg_10_1, "go_icon")
	local var_10_4 = IconMgr.instance:getCommonItemIcon(var_10_3)

	var_10_4:isShowQuality(false)

	local var_10_5 = var_10_4:getCountBg()
	local var_10_6 = var_10_4:getCount()
	local var_10_7 = var_10_5.transform
	local var_10_8 = var_10_6.transform

	recthelper.setAnchorY(var_10_7, RoomManufactureEnum.ItemCountBgY)
	recthelper.setAnchorY(var_10_8, RoomManufactureEnum.ItemCountY)
	var_10_4:onUpdateMO(arg_10_2)

	local var_10_9 = gohelper.findChildImage(arg_10_1, "#image_quality")
	local var_10_10 = var_10_4:getRare()
	local var_10_11 = RoomManufactureEnum.RareImageMap[var_10_10]

	UISpriteSetMgr.instance:setCritterSprite(var_10_9, var_10_11)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
