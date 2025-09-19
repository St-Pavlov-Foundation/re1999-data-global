module("modules.logic.survival.view.shelter.SurvivalBossInvadeView", package.seeall)

local var_0_0 = class("SurvivalBossInvadeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageFrame = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Frame")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_7_0._destroyViewFinish, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_warn)
end

function var_0_0._destroyViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.SurvivalLoadingView then
		gohelper.setActive(arg_8_0.viewGO, false)
		gohelper.setActive(arg_8_0.viewGO, true)
	end
end

function var_0_0.onClose(arg_9_0)
	ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
		showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Watch
	})
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
