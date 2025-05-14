module("modules.logic.fight.view.FightDreamlandTaskView", package.seeall)

local var_0_0 = class("FightDreamlandTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTask = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/#go_tasktips")
	arg_1_0._txtTask = gohelper.findChildText(arg_1_0.viewGO, "root/topLeftContent/#go_tasktips/taskitembg/#txt_task")
	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(arg_1_0._goTask)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, arg_2_0._refreshDes, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_2_0._onCameraFocusChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = FightModel.instance:getFightParam()

	arg_6_0._taskConfig = Activity126Config.instance:getDramlandTask(var_6_0 and var_6_0.battleId)

	arg_6_0:_refreshDes()
end

function var_0_0._refreshDes(arg_7_0)
	gohelper.setActive(arg_7_0._goTask, arg_7_0._taskConfig)

	if arg_7_0._taskConfig then
		local var_7_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_7_0._taskConfig.indicator)
		local var_7_1 = arg_7_0._taskConfig.num
		local var_7_2 = string.format(" <color=#cc7f56>(%d/%d)</color>", var_7_0, var_7_1)

		arg_7_0._txtTask.text = arg_7_0._taskConfig.desc .. var_7_2

		if var_7_1 <= var_7_0 then
			if arg_7_0._finish then
				gohelper.setActive(arg_7_0._goTask, false)

				return
			end

			arg_7_0._ani:Play("finish", arg_7_0._finishDone, arg_7_0)

			arg_7_0._finish = true
		else
			arg_7_0._ani:Play("idle", nil, nil)

			arg_7_0._finish = false
		end
	end
end

function var_0_0._finishDone(arg_8_0)
	gohelper.setActive(arg_8_0._goTask, false)
end

function var_0_0._onCameraFocusChanged(arg_9_0, arg_9_1)
	if arg_9_1 then
		gohelper.setActive(arg_9_0._goTask, arg_9_0._taskConfig)
	else
		arg_9_0:_refreshDes()
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
