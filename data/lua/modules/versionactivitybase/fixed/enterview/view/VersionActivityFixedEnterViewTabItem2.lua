module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivityFixedEnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "#txt_name")
	arg_1_0.txtNameEn = gohelper.findChildText(arg_1_0.go, "#txt_name/#txt_nameen")
end

function var_0_0.afterSetData(arg_2_0)
	var_0_0.super.afterSetData(arg_2_0)

	local var_2_0 = SLFramework.UGUI.GuiHelper.GetPreferredHeight(arg_2_0.txtName, " ")

	arg_2_0.txtName.text = arg_2_0.activityCo and arg_2_0.activityCo.name or ""
	arg_2_0.txtNameEn.text = arg_2_0.activityCo and arg_2_0.activityCo.nameEn or ""

	ZProj.UGUIHelper.RebuildLayout(arg_2_0.txtName.transform)

	local var_2_1 = arg_2_0.txtName.preferredHeight
	local var_2_2 = arg_2_0.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	var_2_2.minHeight = var_2_2.minHeight + var_2_1 - var_2_0
end

function var_0_0.childRefreshSelect(arg_3_0, arg_3_1)
	var_0_0.super.childRefreshSelect(arg_3_0, arg_3_1)

	local var_3_0 = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if arg_3_0.isSelect then
		var_3_0 = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	arg_3_0.txtName.color = GameUtil.parseColor(var_3_0.cnColor)
	arg_3_0.txtNameEn.color = GameUtil.parseColor(var_3_0.enColor)
	arg_3_0.txtName.fontSize = var_3_0.fontSize
	arg_3_0.txtNameEn.fontSize = var_3_0.enFontSize
end

return var_0_0
