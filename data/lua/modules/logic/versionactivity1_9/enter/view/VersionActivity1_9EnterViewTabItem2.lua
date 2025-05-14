module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity1_9EnterViewTabItem2", VersionActivity1_9EnterViewBaseTabItem)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.rootGo, "#txt_name")
	arg_1_0.txtNameEn = gohelper.findChildText(arg_1_0.rootGo, "#txt_nameen")

	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.refreshData(arg_2_0)
	var_0_0.super.refreshData(arg_2_0)

	arg_2_0.txtName.text = arg_2_0.activityCo.name
	arg_2_0.txtNameEn.text = arg_2_0.activityCo.nameEn
end

function var_0_0.refreshSelect(arg_3_0, arg_3_1)
	var_0_0.super.refreshSelect(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_1 == arg_3_0.actId

	arg_3_0.txtName.color = var_3_0 and VersionActivity1_9Enum.ActivityNameColor.Select or VersionActivity1_9Enum.ActivityNameColor.UnSelect
	arg_3_0.txtName.fontSize = var_3_0 and VersionActivity1_9Enum.ActivityNameFontSize.Select or VersionActivity1_9Enum.ActivityNameFontSize.UnSelect
	arg_3_0.txtNameEn.fontSize = var_3_0 and VersionActivity1_9Enum.ActivityNameEnFontSize.Select or VersionActivity1_9Enum.ActivityNameEnFontSize.UnSelect
end

return var_0_0
