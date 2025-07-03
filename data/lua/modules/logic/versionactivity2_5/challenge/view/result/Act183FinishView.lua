module("modules.logic.versionactivity2_5.challenge.view.result.Act183FinishView", package.seeall)

local var_0_0 = class("Act183FinishView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(arg_3_0.viewName)
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
	arg_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_7_0.viewGO)

	arg_7_0.animatorPlayer:Play(UIAnimationName.Open, arg_7_0.closeThis, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenFinishView)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
