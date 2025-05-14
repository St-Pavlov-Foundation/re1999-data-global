module("modules.logic.investigate.view.InvestigateOpinionTabView", package.seeall)

local var_0_0 = class("InvestigateOpinionTabView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "root/#go_container")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, arg_4_0._onChangeArrow, arg_4_0)
end

function var_0_0._onChangeArrow(arg_5_0)
	local var_5_0, var_5_1 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(var_5_0.id) then
		arg_5_0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	else
		arg_5_0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_theft_open)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
