module("modules.logic.guide.controller.trigger.GuideTriggerFinishTask", package.seeall)

local var_0_0 = class("GuideTriggerFinishTask", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, arg_1_0._checkStartGuide, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, arg_1_0._checkStartGuide, arg_1_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_1_0._checkStartGuide, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2)
	local var_2_1 = TaskModel.instance:getTaskById(var_2_0)

	return var_2_1 and var_2_1.finishCount >= var_2_1.config.maxFinishCount
end

function var_0_0._onMainScene(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == 1 then
		arg_3_0:checkStartGuide()
	end
end

function var_0_0._checkStartGuide(arg_4_0)
	arg_4_0:checkStartGuide()
end

return var_0_0
