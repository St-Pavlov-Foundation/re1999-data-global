module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipItem", package.seeall)

local var_0_0 = class("WuErLiXiUnitTipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "txt_desc/image_bg/txt_namecn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_1, "txt_desc")
	arg_1_0._gonormalicon = gohelper.findChild(arg_1_1, "Icon")
	arg_1_0._imageiconbg = gohelper.findChildImage(arg_1_1, "Icon/image_IconBG")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "Icon/image_icon")
	arg_1_0._golongicon = gohelper.findChild(arg_1_1, "Icon_long")
end

function var_0_0.setItem(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, true)

	arg_2_0._config = arg_2_1
	arg_2_0._txtname.text = arg_2_0._config.name
	arg_2_0._txtdesc.text = arg_2_0._config.desc

	gohelper.setActive(arg_2_0._golongicon, arg_2_0._config.id == WuErLiXiEnum.UnitType.SignalMulti)
	gohelper.setActive(arg_2_0._gonormalicon, arg_2_0._config.id ~= WuErLiXiEnum.UnitType.SignalMulti)

	if arg_2_0._config.id ~= WuErLiXiEnum.UnitType.SignalMulti then
		local var_2_0 = WuErLiXiHelper.getUnitSpriteName(arg_2_0._config.id, false)

		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_2_0._imageicon, var_2_0)

		local var_2_1 = "v2a4_wuerlixi_node_icon2"

		if arg_2_0._config.id == WuErLiXiEnum.UnitType.SignalStart or arg_2_0._config.id == WuErLiXiEnum.UnitType.SignalEnd then
			var_2_1 = "v2a4_wuerlixi_node_icon4"
		end

		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_2_0._imageiconbg, var_2_1)
	end
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0.go, false)
end

return var_0_0
