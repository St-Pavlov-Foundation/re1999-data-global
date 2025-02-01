module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievement", package.seeall)

slot0 = class("V1a4_BossRush_ScoreTaskAchievement", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "Left/#go_AssessIcon")
	slot0._txtScoreNum = gohelper.findChildText(slot0.viewGO, "Left/Score/#txt_ScoreNum")
	slot0._scrollScoreList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_ScoreList")
	slot0._goBlock = gohelper.findChild(slot0.viewGO, "#go_Block")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtScoreNum.text = ""

	slot0._simageFullBG:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_score_fullbg"))
	slot0:_initAssessIcon()
end

function slot0._initAssessIcon(slot0)
	slot1 = V1a4_BossRush_Task_AssessIcon
	slot0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_achievement_assessicon, slot0._goAssessIcon, slot1.__cname), slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:setActiveBlock(false)

	slot0._isStartBlockOnce = nil
	slot0._isEndBlockOnce = nil

	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setStaticData(false)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._refreshRight, slot0)
	BossRushController.instance:sendGetTaskInfoRequest()
	slot0:_refreshLeft()
end

function slot0.onClose(slot0)
	TaskController.instance:unregisterCallback(TaskEvent.SetTaskList, slot0._refreshRight, slot0)
end

function slot0._refresh(slot0)
	slot0:_refreshLeft()
	slot0:_refreshRight()
end

function slot0._refreshLeft(slot0)
	slot2 = slot0.viewParam.stage
	slot3 = BossRushModel.instance:getHighestPoint(slot2)

	slot0._assessIcon:setData(slot2, slot3)

	slot0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(slot3)
end

function slot0._refreshRight(slot0)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setList(BossRushModel.instance:getTaskMoListByStage(slot0.viewParam.stage))
end

function slot0.setActiveBlock(slot0, slot1, slot2)
	if slot2 then
		if slot1 then
			if slot0._isStartBlockOnce then
				return
			end

			slot0._isStartBlockOnce = true
		else
			if slot0._isEndBlockOnce then
				return
			end

			slot0._isEndBlockOnce = true
		end
	end

	gohelper.setActive(slot0._goBlock, slot1)
end

return slot0
