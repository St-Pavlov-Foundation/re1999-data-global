module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_SpecialScheduleView", package.seeall)

slot0 = class("V2a1_BossRush_SpecialScheduleView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTotalScore = gohelper.findChildText(slot0.viewGO, "Left/Total/#txt_TotalScore")
	slot0._goSlider = gohelper.findChild(slot0.viewGO, "Left/Slider/#go_Slider")
	slot0._scrollprogress = gohelper.findChildScrollRect(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	slot0._imageSliderBG = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	slot0._imageSliderFG1 = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	slot0._imageSliderFG2 = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	slot0._goprefabInst = gohelper.findChild(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	slot0._scrollScoreList = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_ScoreList")
	slot0._goAssessIcon = gohelper.findChild(slot0.viewGO, "Left/#go_AssessIcon")
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
	slot0.scoreList = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.stage = slot0.viewParam.stage

	gohelper.setActive(slot0._goRight, true)
	slot0:_initAssessIcon()
	slot0:_refresh()
	gohelper.setActive(slot0._gostatus, false)
	slot0:playAnim(slot0._isFirstOpen and BossRushEnum.V1a6_BonusViewAnimName.Open or BossRushEnum.V1a6_BonusViewAnimName.In)

	slot0._isFirstOpen = nil
	slot0._scrollScoreList.verticalNormalizedPosition = 1
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._goRight, false)
	slot0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	slot0:_clearKillTween()
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

	slot0._assessIcon:setData(slot0.stage, BossRushModel.instance:getLayer4HightScore(slot0.stage), true)
end

function slot0.refreshScore(slot0)
	slot2 = BossRushModel.instance:getLayer4MaxRewardScore(slot0.stage)
	slot1 = Mathf.Min(BossRushModel.instance:getLayer4CurScore(slot0.stage), slot2)
	slot0._tweenTime = 1.5
	slot4, slot5 = slot0:_getPrefsSchedule(slot0.stage)

	if slot4 < slot1 then
		slot0:_refreshNumTxt(slot4, slot2)

		slot0._tweenNumId = ZProj.TweenHelper.DOTweenFloat(0, slot1, slot0._tweenTime, slot0._onTweenNumUpdate, nil, slot0, {
			curNum = slot1,
			maxNum = slot2
		}, EaseType.OutQuad)
	else
		slot0:_refreshNumTxt(slot1, slot2)
	end

	slot0._goContent = slot0._scrollprogress.content
	slot8 = slot0._goprefabInst.transform.rect.width
	slot11, slot12 = V1a6_BossRush_BonusModel.instance:getLayer4ProgressWidth(slot0.stage, slot0._goContent.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup)).spacing + slot8, 30 + slot8 * 0.5)

	recthelper.setWidth(slot0._imageSliderBG.transform, slot11)

	if slot5 < slot12 then
		slot0:_refrehSlider(slot5, slot11, slot12)

		slot0._tweenSliderId = ZProj.TweenHelper.DOTweenFloat(slot5, slot12, slot0._tweenTime, slot0._onTweenSliderUpdate, nil, slot0, {
			grayWidth = slot11,
			gotWidth = slot12
		}, EaseType.Linear)
	else
		slot0:_refrehSlider(slot12, slot11, slot12)
	end

	slot0:_setPrefsSchedule(slot0.stage, slot1, slot12)
end

function slot0._onTweenNumUpdate(slot0, slot1, slot2)
	slot0:_refreshNumTxt(slot1, slot2.maxNum)
end

function slot0._onTweenSliderUpdate(slot0, slot1, slot2)
	slot0:_refrehSlider(slot1, slot2.grayWidth, slot2.gotWidth)
end

function slot0._clearKillTween(slot0)
	if slot0._tweenSliderId then
		ZProj.TweenHelper.KillById(slot0._tweenSliderId)

		slot0._tweenSliderId = nil
	end

	if slot0._tweenNumId then
		ZProj.TweenHelper.KillById(slot0._tweenNumId)

		slot0._tweenNumId = nil
	end
end

function slot0._refreshNumTxt(slot0, slot1, slot2)
	if slot0._txtTotalScore then
		slot0._txtTotalScore.text = string.format("<color=#41D9C5><size=50>%s</size></color>/%s", Mathf.Ceil(slot1), slot2)
	end
end

function slot0._refrehSlider(slot0, slot1, slot2, slot3)
	if slot0._imageSliderFG1 then
		recthelper.setWidth(slot0._imageSliderFG1.transform, slot1)
		recthelper.setWidth(slot0._imageSliderFG2.transform, slot3 - slot1)
	end

	if slot0._scrollprogress then
		slot0._scrollprogress.horizontalNormalizedPosition = slot2 and slot2 > 0 and slot1 / slot2 or 0
	end
end

function slot0.refreshScoreItem(slot0)
	slot2 = BossRushModel.instance:getLayer4CurScore(slot0.stage)

	for slot6, slot7 in pairs(BossRushModel.instance:getSpecialScheduleViewRewardList(slot0.stage)) do
		if slot7.config then
			slot10 = slot8.maxProgress

			if not slot0.scoreList[slot6] then
				slot9 = {
					go = gohelper.cloneInPlace(slot0._goprefabInst, "scoreitem_" .. slot6)
				}
				slot9.img = slot9.go:GetComponent(gohelper.Type_Image)
				slot9.txt = gohelper.findChildText(slot9.go, "txt_Score")
				slot0.scoreList[slot6] = slot9
			end

			gohelper.setActive(slot9.go.gameObject, true)

			slot9.txt.text = slot10
			slot11 = false

			UISpriteSetMgr.instance:setV1a4BossRushSprite(slot9.img, BossRushConfig.instance:getSpriteRewardStatusSpriteName(slot10 <= slot2))
		end
	end
end

function slot0._refresh(slot0)
	slot0:_refreshRight()
	slot0:refreshScoreItem()
	slot0:refreshScore()
end

function slot0._refreshRight(slot0)
	V1a6_BossRush_BonusModel.instance:selectSpecialScheduleTab(slot0.stage)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if slot0._animatorPlayer then
		slot0._animatorPlayer:Play(slot1, slot2, slot3)
	end
end

function slot0._getPrefsSchedule(slot0, slot1)
	slot3 = string.split(GameUtil.playerPrefsGetStringByUserId(slot0:_getPrefsKey(slot1), "0|0"), "|")

	return tonumber(slot3[1]), tonumber(slot3[2])
end

function slot0._setPrefsSchedule(slot0, slot1, slot2, slot3)
	GameUtil.playerPrefsSetStringByUserId(slot0:_getPrefsKey(slot1), string.format("%s|%s", slot2, slot3))
end

function slot0._getPrefsKey(slot0, slot1)
	return "V2a1_BossRush_SpecialScheduleView_Schedule_" .. BossRushConfig.instance:getActivityId() .. "_" .. slot1
end

return slot0
