module("modules.logic.survival.view.shelter.SurvivalEventPanelView", package.seeall)

local var_0_0 = class("SurvivalEventPanelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClose:AddClickListener(arg_2_0.onClickBtnClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnClose:RemoveClickListener()
end

function var_0_0.onClickBtnClose(arg_4_0)
	arg_4_0:closeThis()

	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_4_1 = SurvivalConfig.instance:getTaskCo(arg_4_0.moduleId, arg_4_0.taskId)

	if not var_4_1 then
		return
	end

	local var_4_2 = var_4_1.eventID

	ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
		moduleId = arg_4_0.moduleId,
		taskConfig = var_4_1,
		eventID = var_4_2
	})
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_gudu_win)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.moduleId = arg_7_0.viewParam.moduleId
	arg_7_0.taskId = arg_7_0.viewParam.taskId
end

function var_0_0.refreshView(arg_8_0)
	return
end

return var_0_0
