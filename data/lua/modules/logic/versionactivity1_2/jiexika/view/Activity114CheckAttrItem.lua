module("modules.logic.versionactivity1_2.jiexika.view.Activity114CheckAttrItem", package.seeall)

local var_0_0 = class("Activity114CheckAttrItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtLevel = gohelper.findChildTextMesh(arg_1_1, "txt_info")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._txtLevel.text = string.format("%d[%s]", arg_2_1.value, arg_2_1.name)

	if arg_2_1.isAttr then
		SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._txtLevel, "#e55151")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._txtLevel, "#9ee091")
	end
end

function var_0_0.onDestroyView(arg_3_0)
	arg_3_0._txtLevel = nil
end

return var_0_0
