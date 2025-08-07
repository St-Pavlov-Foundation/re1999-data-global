module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_AchievementView", package.seeall)

local var_0_0 = class("V1a6_BossRush_AchievementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Left/#go_AssessIcon")
	arg_1_0._txtScoreNum = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_ScoreNum")
	arg_1_0._scrollScoreList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_ScoreList")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "Right")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._isFirstOpen = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_2_0._refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_3_0._refresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.stage = arg_6_0.viewParam.stage

	arg_6_0:_initAssessIcon()
	gohelper.setActive(arg_6_0._goRight, true)

	local var_6_0 = arg_6_0._isFirstOpen and BossRushEnum.V1a6_BonusViewAnimName.Open or BossRushEnum.V1a6_BonusViewAnimName.In

	arg_6_0:playAnim(var_6_0)

	arg_6_0._isFirstOpen = nil
	arg_6_0._scrollScoreList.verticalNormalizedPosition = 1

	arg_6_0:_refresh()
end

function var_0_0.onClose(arg_7_0)
	gohelper.setActive(arg_7_0._goRight, false)

	if arg_7_0._assessIcon then
		arg_7_0._assessIcon:onClose()
	end

	arg_7_0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._assessIcon then
		arg_8_0._assessIcon:onDestroyView()
	end
end

function var_0_0._initAssessIcon(arg_9_0)
	if not arg_9_0._assessIcon then
		local var_9_0 = V1a4_BossRush_Task_AssessIcon
		local var_9_1 = arg_9_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, arg_9_0._goAssessIcon, var_9_0.__cname)

		arg_9_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, var_9_0)
	end

	local var_9_2 = BossRushModel.instance:getActivityBonus()
	local var_9_3 = var_9_2 and var_9_2[V1a6_BossRush_BonusModel.instance:getTab()]
	local var_9_4 = BossRushModel.instance:getHighestPoint(arg_9_0.stage)

	if var_9_3.SpModel and var_9_3.SpModel.instance.getHighestPoint then
		var_9_4 = var_9_3.SpModel.instance:getHighestPoint(arg_9_0.stage)
	end

	arg_9_0._assessIcon:setData(arg_9_0.stage, var_9_4, false)

	arg_9_0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(var_9_4)
end

function var_0_0._refresh(arg_10_0)
	arg_10_0:_refreshRight()
end

function var_0_0._refreshRight(arg_11_0)
	V1a6_BossRush_BonusModel.instance:selecAchievementTab(arg_11_0.stage)
end

function var_0_0.playAnim(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0._animatorPlayer then
		arg_12_0._animatorPlayer:Play(arg_12_1, arg_12_2, arg_12_3)
	end
end

return var_0_0
