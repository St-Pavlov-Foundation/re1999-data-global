module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTaskView", package.seeall)

local var_0_0 = class("DiceHeroTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onOpen(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._oneClaimReward, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	DiceHeroTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.DiceHero
	}, arg_2_0._oneClaimReward, arg_2_0)
end

function var_0_0._oneClaimReward(arg_3_0)
	DiceHeroTaskListModel.instance:init()
end

function var_0_0._onFinishTask(arg_4_0, arg_4_1)
	if DiceHeroTaskListModel.instance:getById(arg_4_1) then
		DiceHeroTaskListModel.instance:init()
	end
end

return var_0_0
