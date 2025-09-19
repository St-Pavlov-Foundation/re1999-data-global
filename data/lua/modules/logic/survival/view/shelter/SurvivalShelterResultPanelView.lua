module("modules.logic.survival.view.shelter.SurvivalShelterResultPanelView", package.seeall)

local var_0_0 = class("SurvivalShelterResultPanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_failed")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_3_0._onViewOpen, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.isWin

	gohelper.setActive(arg_4_0._gosuccess, var_4_0)
	gohelper.setActive(arg_4_0._gofail, not var_4_0)

	if var_4_0 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_1)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_fail)
	end
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:_onClickClose()
end

function var_0_0._onClickClose(arg_6_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_6_0._onViewOpen, arg_6_0)
	SurvivalController.instance:enterSurvivalSettle()
	arg_6_0:closeThis()
end

function var_0_0._onViewOpen(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.SurvivalCeremonyClosingView then
		arg_7_0:closeThis()
	end
end

return var_0_0
