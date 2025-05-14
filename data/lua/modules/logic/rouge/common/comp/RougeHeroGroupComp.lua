module("modules.logic.rouge.common.comp.RougeHeroGroupComp", package.seeall)

local var_0_0 = class("RougeHeroGroupComp", UserDataDispose)

function var_0_0.Get(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1

	arg_2_0:_editableInitView()
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._btnMember = gohelper.findChildButtonWithAudio(arg_3_0.go, "Root/#btn_Member")
	arg_3_0._goRecovery = gohelper.findChild(arg_3_0.go, "Root/recovery")
	arg_3_0._goLossLife = gohelper.findChild(arg_3_0.go, "Root/bleeding")

	gohelper.setActive(arg_3_0._goRecovery, false)
	gohelper.setActive(arg_3_0._goLossLife, false)
	arg_3_0:addEventCb(RougeMapController.instance, RougeMapEvent.onTeamLifeChange, arg_3_0.onLifeChange, arg_3_0)
end

function var_0_0.onLifeChange(arg_4_0, arg_4_1)
	if arg_4_1 == RougeMapEnum.LifeChangeStatus.Idle then
		return
	end

	if arg_4_1 == RougeMapEnum.LifeChangeStatus.Add then
		gohelper.setActive(arg_4_0._goRecovery, false)
		gohelper.setActive(arg_4_0._goRecovery, true)

		return
	end

	gohelper.setActive(arg_4_0._goLossLife, false)
	gohelper.setActive(arg_4_0._goLossLife, true)
end

function var_0_0._btnMemberOnClick(arg_5_0)
	RougeController.instance:openRougeTeamView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._btnMember:AddClickListener(arg_6_0._btnMemberOnClick, arg_6_0)
end

function var_0_0.onClose(arg_7_0)
	arg_7_0._btnMember:RemoveClickListener()
end

function var_0_0.destroy(arg_8_0)
	arg_8_0:__onDispose()
end

return var_0_0
