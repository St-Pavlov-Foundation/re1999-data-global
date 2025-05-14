module("modules.logic.herogroup.view.CommonTrialHeroDetailView", package.seeall)

local var_0_0 = class("CommonTrialHeroDetailView", SummonHeroDetailView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._btnClose, false)
	gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "characterinfo/#go_characterinfo/attribute"), false)
	gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "characterinfo/#go_characterinfo/exskill"), false)
end

return var_0_0
