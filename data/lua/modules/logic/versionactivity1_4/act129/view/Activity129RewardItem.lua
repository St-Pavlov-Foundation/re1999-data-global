module("modules.logic.versionactivity1_4.act129.view.Activity129RewardItem", package.seeall)

local var_0_0 = class("Activity129RewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goItem = gohelper.findChild(arg_1_1, "#go_Item")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_1, "Num/#txt_ItemNum")
	arg_1_0.goGet = gohelper.findChild(arg_1_1, "#go_Get")
	arg_1_0.goLimit = gohelper.findChild(arg_1_1, "#go_limit")
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.hideMark = false

	gohelper.setActive(arg_2_0.go, true)
	gohelper.setAsLastSibling(arg_2_0.go)

	if not arg_2_0.itemIcon then
		arg_2_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_2_0.goItem)
	end

	arg_2_0.itemIcon:setMOValue(arg_2_1[1], arg_2_1[2], arg_2_1[3], nil, true)
	arg_2_0.itemIcon:isShowEffect(true)
	arg_2_0.itemIcon:setCountTxtSize(34)

	local var_2_0 = ItemModel.instance:getItemConfig(arg_2_1[1], arg_2_1[2])
	local var_2_1 = string.splitToNumber(var_2_0.tag or "")

	gohelper.setActive(arg_2_0.goLimit, tabletool.indexOf(var_2_1, 1) ~= nil)

	local var_2_2 = arg_2_1[4] or 0

	if var_2_2 > 0 then
		local var_2_3 = Activity129Model.instance:getActivityMo(arg_2_2):getPoolMo(arg_2_3)
		local var_2_4 = var_2_2 - (var_2_3 and var_2_3:getGoodsGetNum(arg_2_4, arg_2_1[1], arg_2_1[2]) or 0)

		arg_2_0.txtNum.text = string.format("%s/%s", var_2_4, var_2_2)

		gohelper.setActive(arg_2_0.goGet, var_2_4 <= 0)
	else
		arg_2_0.txtNum.text = "<size=40>∞</size>"

		gohelper.setActive(arg_2_0.goGet, false)
	end
end

function var_0_0.setHideMark(arg_3_0)
	arg_3_0.hideMark = true
end

function var_0_0.checkHide(arg_4_0)
	if arg_4_0.hideMark then
		gohelper.setActive(arg_4_0.go, false)
	end
end

function var_0_0.onDestroy(arg_5_0)
	return
end

return var_0_0
