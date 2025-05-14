module("modules.logic.rouge.dlc.101.view.RougeHeroGroupFightView_1_101", package.seeall)

local var_0_0 = class("RougeHeroGroupFightView_1_101", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorouge = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero/heroitem/#go_rouge")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getCurNode()
	local var_2_1 = var_2_0 and var_2_0.eventMo
	local var_2_2 = var_2_1 and var_2_1:getSurpriseAttackList()

	if not var_2_2 or #var_2_2 <= 0 then
		return
	end

	RougeDLCController101.instance:openRougeDangerousView()
end

function var_0_0._editableInitView(arg_3_0)
	return
end

return var_0_0
