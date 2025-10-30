module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity3_0EnterViewTabItem2", VersionActivity3_0EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0.txtNameEn = gohelper.findChildText(arg_1_0.go, "#txt_name/#txt_nameen")
end

function var_0_0.afterSetData(arg_2_0)
	var_0_0.super.afterSetData(arg_2_0)

	arg_2_0.txtName.text = arg_2_0.activityCo and arg_2_0.activityCo.name or ""
	arg_2_0.txtNameEn.text = arg_2_0.activityCo and arg_2_0.activityCo.nameEn or ""

	local var_2_0 = arg_2_0.txtName.preferredWidth
	local var_2_1 = 132
	local var_2_2 = 300

	if var_2_1 < var_2_0 then
		local var_2_3 = arg_2_0.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

		if var_2_3 then
			var_2_3.preferredWidth = var_2_2 + (var_2_0 - var_2_1)
		end
	end
end

function var_0_0.childRefreshSelect(arg_3_0, arg_3_1)
	var_0_0.super.childRefreshSelect(arg_3_0, arg_3_1)

	local var_3_0 = VersionActivity3_0Enum.TabSetting.unselect

	if arg_3_0.isSelect then
		var_3_0 = VersionActivity3_0Enum.TabSetting.select
	end

	arg_3_0.txtName.color = GameUtil.parseColor(var_3_0.cnColor)
	arg_3_0.txtNameEn.color = GameUtil.parseColor(var_3_0.enColor)
	arg_3_0.txtName.fontSize = var_3_0.fontSize
	arg_3_0.txtNameEn.fontSize = var_3_0.enFontSize
end

return var_0_0
