module("modules.logic.room.view.critter.detail.RoomCritterDetailAttrItem", package.seeall)

local var_0_0 = class("RoomCritterDetailAttrItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_name/#image_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "#txt_ratio")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "#txt_ratio/arrow")
	arg_1_0._goClick = gohelper.findChild(arg_1_0.viewGO, "#txt_ratio/arrow/clickarea")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnClick then
		arg_3_0._btnClick:RemoveClickListener()
	end
end

function var_0_0.onClick(arg_4_0)
	return
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEvents()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._gobg = gohelper.findChild(arg_8_0.viewGO, "bg")
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

function var_0_0.setRatioColor(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._normalColor = arg_13_1
	arg_13_0._addColor = arg_13_2
end

function var_0_0.onRefreshMo(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7)
	arg_14_0._mo = arg_14_1

	if arg_14_0._txtnum then
		arg_14_0._txtnum.text = arg_14_3 or arg_14_1:getValueNum()
	end

	if arg_14_0._txtratio then
		arg_14_0._txtratio.text = arg_14_4 or arg_14_1:getRateStr()
	end

	if arg_14_0._txtname then
		arg_14_0._txtname.text = arg_14_5 or arg_14_1:getName()
	end

	if arg_14_0._imageicon and not string.nilorempty(arg_14_1:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(arg_14_0._imageicon, arg_14_1:getIcon())
	end

	local var_14_0 = arg_14_1:getIsAddition()

	gohelper.setActive(arg_14_0._goArrow, var_14_0)

	arg_14_0._txtratio.color = GameUtil.parseColor(var_14_0 and arg_14_0._addColor or arg_14_0._normalColor)

	if not arg_14_0._btnClick and arg_14_0._goClick then
		arg_14_0._btnClick = SLFramework.UGUI.UIClickListener.Get(arg_14_0._goClick)

		arg_14_0._btnClick:AddClickListener(arg_14_6, arg_14_7)
	end

	if arg_14_0._gobg then
		gohelper.setActive(arg_14_0._gobg, arg_14_2 % 2 == 0)
	end
end

function var_0_0.setMaturityNum(arg_15_0)
	if arg_15_0._txtratio then
		arg_15_0._txtratio.text = arg_15_0._mo:getValueNum()
	end
end

return var_0_0
