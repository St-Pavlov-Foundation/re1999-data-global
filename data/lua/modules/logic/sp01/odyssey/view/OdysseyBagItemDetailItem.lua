module("modules.logic.sp01.odyssey.view.OdysseyBagItemDetailItem", package.seeall)

local var_0_0 = class("OdysseyBagItemDetailItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtitemName = gohelper.findChildText(arg_1_0.viewGO, "#txt_itemName")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/Viewport/Content/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.setInfo(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1

	arg_2_0:refreshUI()
end

function var_0_0.refreshUI(arg_3_0)
	local var_3_0 = arg_3_0.mo.config

	arg_3_0._simageicon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(var_3_0.icon))

	arg_3_0._txtdesc.text = var_3_0.desc
	arg_3_0._txtitemName.text = var_3_0.name
end

function var_0_0.onDestroy(arg_4_0)
	return
end

return var_0_0
