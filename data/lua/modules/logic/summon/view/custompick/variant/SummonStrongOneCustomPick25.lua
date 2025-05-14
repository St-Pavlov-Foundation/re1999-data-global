module("modules.logic.summon.view.custompick.variant.SummonStrongOneCustomPick25", package.seeall)

local var_0_0 = class("SummonStrongOneCustomPick25", SummonStrongOneCustomPickView)

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_selfselectsix2/v2a5_selfselectsix_role.png"
}

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._btncheck1 = gohelper.findChildButton(arg_1_0.viewGO, "#go_ui/current/#go_unselected/#btn_check_1")
	arg_1_0._btncheck2 = gohelper.findChildButton(arg_1_0.viewGO, "#go_ui/current/#go_selected/#btn_check_2")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btncheck1:AddClickListener(arg_2_0._btnOpenOnClick1, arg_2_0)
	arg_2_0._btncheck2:AddClickListener(arg_2_0._btnOpenOnClick2, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btncheck1:RemoveClickListener()
	arg_3_0._btncheck2:RemoveClickListener()
end

function var_0_0._btnOpenOnClick1(arg_4_0)
	local var_4_0 = SummonMainModel.instance:getCurPool()
	local var_4_1 = SummonConfig.instance:getStrongCustomChoiceIds(var_4_0.id)
	local var_4_2 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = var_4_1
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_4_2)
end

function var_0_0._btnOpenOnClick2(arg_5_0)
	local var_5_0 = SummonMainModel.instance:getCurPool()
	local var_5_1 = {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = arg_5_0:getPickHeroIds(var_5_0)
	}

	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, var_5_1)
end

return var_0_0
