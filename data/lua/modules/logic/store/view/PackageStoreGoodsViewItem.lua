module("modules.logic.store.view.PackageStoreGoodsViewItem", package.seeall)

local var_0_0 = class("PackageStoreGoodsViewItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0._gogoods = gohelper.findChild(arg_1_0.viewGO, "go_goods")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "go_goods/#go_icon")

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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	local var_5_0 = tonumber(arg_5_1[1])
	local var_5_1 = arg_5_1[2]
	local var_5_2 = arg_5_1[3]
	local var_5_3, var_5_4 = ItemModel.instance:getItemConfigAndIcon(var_5_0, var_5_1, true)

	if not arg_5_0._itemIcon then
		arg_5_0._itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_5_0._goicon)
	end

	arg_5_0._itemIcon:setMOValue(var_5_0, var_5_1, var_5_2, nil, true)
	arg_5_0._itemIcon:hideExpEquipState()
	arg_5_0._itemIcon:isShowName(false)

	if arg_5_0._itemIcon:isEquipIcon() then
		arg_5_0._itemIcon:isShowEquipAndItemCount(true)
	end

	arg_5_0._itemIcon:setCountFontSize(36)
	arg_5_0._itemIcon:hideEquipLvAndBreak(true)
	arg_5_0._itemIcon:showEquipRefineContainer(false)
	arg_5_0._itemIcon:setScale(0.7)
	arg_5_0._itemIcon:SetCountLocalY(43.6)
	arg_5_0._itemIcon:SetCountBgHeight(25)
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, arg_6_1)
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0:__onDispose()
end

return var_0_0
