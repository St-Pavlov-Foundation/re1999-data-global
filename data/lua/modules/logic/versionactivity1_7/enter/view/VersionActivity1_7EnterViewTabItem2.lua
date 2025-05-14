module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity1_7EnterViewTabItem2", VersionActivity1_7EnterViewBaseTabItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.txtName = gohelper.findChildText(arg_1_0.rootGo, "#txt_namebg/#txt_name")
	arg_1_0.txtNameEn = gohelper.findChildText(arg_1_0.rootGo, "#txt_nameen")
	arg_1_0.txtName.text = arg_1_0.activityCo.name
	arg_1_0.txtNameEn.text = arg_1_0.activityCo.nameEn
end

function var_0_0.refreshSelect(arg_2_0, arg_2_1)
	var_0_0.super.refreshSelect(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1 == arg_2_0.actId

	arg_2_0.txtName.color = var_2_0 and VersionActivity1_7Enum.ActivityNameColor.Select or VersionActivity1_7Enum.ActivityNameColor.UnSelect
	arg_2_0.txtName.fontSize = var_2_0 and VersionActivity1_7Enum.ActivityNameFontSize.Select or VersionActivity1_7Enum.ActivityNameFontSize.UnSelect
	arg_2_0.txtNameEn.fontSize = var_2_0 and VersionActivity1_7Enum.ActivityNameEnFontSize.Select or VersionActivity1_7Enum.ActivityNameEnFontSize.UnSelect
end

return var_0_0
