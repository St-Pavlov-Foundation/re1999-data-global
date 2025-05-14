module("modules.logic.versionactivity2_1.enter.view.VersionActivity2_1EnterViewTabItem2", package.seeall)

local var_0_0 = class("VersionActivity2_1EnterViewTabItem2", VersionActivity2_1EnterViewTabItemBase)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.goselect = gohelper.findChild(arg_1_0.go, "#go_unselect")
	arg_1_0.gounselect = gohelper.findChild(arg_1_0.go, "#go_unselect")
	arg_1_0.txtselectName = gohelper.findChildText(arg_1_0.go, "#go_select/#txt_name")
	arg_1_0.txtselectNameEn = gohelper.findChildText(arg_1_0.go, "#go_select/#txt_nameen")
	arg_1_0.txtunselectName = gohelper.findChildText(arg_1_0.go, "#go_unselect/#txt_name")
	arg_1_0.txtunselectNameEn = gohelper.findChildText(arg_1_0.go, "#go_unselect/#txt_nameen")
end

function var_0_0.afterSetData(arg_2_0)
	var_0_0.super.afterSetData(arg_2_0)

	arg_2_0.txtselectName.text = arg_2_0.activityCo and arg_2_0.activityCo.name or ""
	arg_2_0.txtselectNameEn.text = arg_2_0.activityCo and arg_2_0.activityCo.nameEn or ""
	arg_2_0.txtunselectName.text = arg_2_0.activityCo and arg_2_0.activityCo.name or ""
	arg_2_0.txtunselectNameEn.text = arg_2_0.activityCo and arg_2_0.activityCo.nameEn or ""
end

function var_0_0.childRefreshSelect(arg_3_0, arg_3_1)
	var_0_0.super.childRefreshSelect(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.goselect, arg_3_0.isSelect)
	gohelper.setActive(arg_3_0.gounselect, not arg_3_0.isSelect)
end

return var_0_0
