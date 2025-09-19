module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaInfoItem", package.seeall)

local var_0_0 = class("NuoDiKaInfoItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "txt_namecn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_1, "txt_desc")
	arg_1_0._goicon = gohelper.findChild(arg_1_1, "go_icon")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_1, "go_icon/image_icon")
	arg_1_0._gonew = gohelper.findChild(arg_1_1, "go_icon/go_new")
	arg_1_0._type = arg_1_2

	gohelper.setActive(arg_1_0._gonew, false)
end

function var_0_0.setItem(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0.go, true)

	arg_2_0._config = arg_2_1
	arg_2_0._txtname.text = arg_2_0._config.name
	arg_2_0._txtdesc.text = arg_2_0._config.desc

	if arg_2_0._type == NuoDiKaEnum.EventType.Enemy then
		arg_2_0._simageicon:LoadImage(ResUrl.getNuoDiKaMonsterIcon(arg_2_0._config.picture))
	elseif arg_2_0._type == NuoDiKaEnum.EventType.Item then
		arg_2_0._simageicon:LoadImage(ResUrl.getNuoDiKaItemIcon(arg_2_0._config.picture))
	end
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0.go, false)
end

function var_0_0.destory(arg_4_0)
	arg_4_0._simageicon:UnLoadImage()
end

return var_0_0
