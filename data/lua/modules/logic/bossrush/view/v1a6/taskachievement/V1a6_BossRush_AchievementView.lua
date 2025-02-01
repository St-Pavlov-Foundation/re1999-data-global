module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_AchievementView", package.seeall)

slot0 = class("V1a6_BossRush_AchievementView", BaseView)

function slot0.onInitView(slot0)
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "Left/#go_AssessIcon")
	slot0._txtScoreNum = gohelper.findChildText(slot0.viewGO, "Left/#txt_ScoreNum")
	slot0._scrollScoreList = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_ScoreList")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._isFirstOpen = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._refresh, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refresh, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._refresh, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._refresh, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refresh, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._refresh, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.stage = slot0.viewParam.stage

	slot0:_initAssessIcon()
	gohelper.setActive(slot0._goRight, true)
	slot0:playAnim(slot0._isFirstOpen and BossRushEnum.V1a6_BonusViewAnimName.Open or BossRushEnum.V1a6_BonusViewAnimName.In)

	slot0._isFirstOpen = nil
	slot0._scrollScoreList.verticalNormalizedPosition = 1

	slot0:_refresh()
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._goRight, false)
	slot0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
end

function slot0.onDestroyView(slot0)
	if slot0._assessIcon then
		slot0._assessIcon:onDestroyView()
	end
end

function slot0._initAssessIcon(slot0)
	if not slot0._assessIcon then
		slot1 = V1a4_BossRush_Task_AssessIcon
		slot0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, slot0._goAssessIcon, slot1.__cname), slot1)
	end

	slot1 = BossRushModel.instance:getHighestPoint(slot0.stage)

	slot0._assessIcon:setData(slot0.stage, slot1, false)

	slot0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(slot1)
end

function slot0._refresh(slot0)
	slot0:_refreshRight()
end

function slot0._refreshRight(slot0)
	V1a6_BossRush_BonusModel.instance:selecAchievementTab(slot0.stage)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if slot0._animatorPlayer then
		slot0._animatorPlayer:Play(slot1, slot2, slot3)
	end
end

return slot0
