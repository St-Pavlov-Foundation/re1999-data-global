﻿module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity2_0EnterViewTabItem2", VersionActivity2_0EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0.txtNameEn = gohelper.findChildText(arg_1_0.go, "#txt_nameen")
end

function var_0_0.afterSetData(arg_2_0)
	var_0_0.super.afterSetData(arg_2_0)

	arg_2_0.txtName.text = arg_2_0.activityCo and arg_2_0.activityCo.name or ""
	arg_2_0.txtNameEn.text = arg_2_0.activityCo and arg_2_0.activityCo.nameEn or ""
end

function var_0_0.childRefreshSelect(arg_3_0, arg_3_1)
	var_0_0.super.childRefreshSelect(arg_3_0, arg_3_1)

	local var_3_0 = VersionActivity2_0Enum.TabSetting.unselect

	if arg_3_0.isSelect then
		var_3_0 = VersionActivity2_0Enum.TabSetting.select
	end

	arg_3_0.txtName.color = var_3_0.color
	arg_3_0.txtName.fontSize = var_3_0.fontSize
	arg_3_0.txtNameEn.fontSize = var_3_0.enFontSize
end

return var_0_0
