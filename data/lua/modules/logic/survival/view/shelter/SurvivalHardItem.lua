module("modules.logic.survival.view.shelter.SurvivalHardItem", package.seeall)

local var_0_0 = class("SurvivalHardItem", ListScrollCellExtend)

var_0_0.ColorSetting = {
	"#82B18C",
	"#709cc6",
	"#9A75A8",
	"#BF865C",
	"#B35555"
}
var_0_0.IconColorSetting = {
	"#4B814A",
	"#165E88",
	"#8C539A",
	"#C86F2D",
	"#B02525"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLine = gohelper.findChild(arg_1_0.viewGO, "image_Line")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "txt_Desc")
	arg_1_0.goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_Empty")
	arg_1_0.goIcon = gohelper.findChild(arg_1_0.viewGO, "#go_Icon")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_Icon")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Icon/image_Icon")

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
	arg_5_0.mo = arg_5_1

	local var_5_0 = arg_5_1.hardId == nil

	if LangSettings.instance:isCn() then
		gohelper.setActive(arg_5_0.goEmpty, var_5_0)
	else
		gohelper.setActive(arg_5_0.goEmpty, false)
	end

	gohelper.setActive(arg_5_0.goIcon, not var_5_0)

	if var_5_0 then
		arg_5_0.txtDesc.text = ""
	else
		local var_5_1 = lua_survival_hardness.configDict[arg_5_1.hardId]
		local var_5_2 = var_0_0.ColorSetting[var_5_1.level] or var_0_0.ColorSetting[1]

		arg_5_0.txtDesc.text = string.format("<color=%s>%s</color>", var_5_2, var_5_1.desc)

		local var_5_3 = var_0_0.IconColorSetting[var_5_1.level] or var_0_0.IconColorSetting[1]

		SLFramework.UGUI.GuiHelper.SetColor(arg_5_0.imageIcon, var_5_3)

		local var_5_4 = string.format("singlebg/survival_singlebg/difficulty/difficulticon/%s.png", var_5_1.icon)

		arg_5_0.simageIcon:LoadImage(var_5_4)
	end
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0.simageIcon:UnLoadImage()
end

return var_0_0
