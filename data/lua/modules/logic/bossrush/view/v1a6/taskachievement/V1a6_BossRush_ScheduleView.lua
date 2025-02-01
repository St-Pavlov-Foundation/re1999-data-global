module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleView", package.seeall)

slot0 = class("V1a6_BossRush_ScheduleView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtTotalScore = gohelper.findChildText(slot0.viewGO, "Left/Total/#txt_TotalScore")
	slot0._goSlider = gohelper.findChild(slot0.viewGO, "Left/Slider/#go_Slider")
	slot0._scrollprogress = gohelper.findChildScrollRect(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	slot0._imageSliderBG = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	slot0._imageSliderFG1 = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	slot0._imageSliderFG2 = gohelper.findChildImage(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	slot0._goprefabInst = gohelper.findChild(slot0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	slot0._scrollScoreList = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_ScoreList")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, slot0._refresh, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, slot0._refresh, slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, slot0._refresh, slot0)
end

function slot0._editableInitView(slot0)
	slot0.scoreList = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.stage = slot0.viewParam.stage

	gohelper.setActive(slot0._goRight, true)
	slot0:_refresh()
	gohelper.setActive(slot0._gostatus, false)
	slot0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.In)

	slot0._scrollScoreList.verticalNormalizedPosition = 1
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0._goRight, false)
	slot0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	slot0:_clearKillTween()
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshScore(slot0)
	slot1 = BossRushModel.instance:getLastPointInfo(slot0.stage)
	slot3 = slot1.max
	slot2 = Mathf.Min(slot1.cur, slot3)
	slot0._tweenTime = 1.5
	slot5, slot6 = slot0:_getPrefsSchedule(slot0.stage)

	if slot5 < slot2 then
		slot0:_refreshNumTxt(slot5, slot3)

		slot0._tweenNumId = ZProj.TweenHelper.DOTweenFloat(0, slot2, slot0._tweenTime, slot0._onTweenNumUpdate, nil, slot0, {
			curNum = slot2,
			maxNum = slot3
		}, EaseType.OutQuad)
	else
		slot0:_refreshNumTxt(slot2, slot3)
	end

	slot0._goContent = slot0._scrollprogress.content
	slot9 = slot0._goprefabInst.transform.rect.width
	slot12, slot13 = V1a6_BossRush_BonusModel.instance:getScheduleProgressWidth(slot0.stage, slot0._goContent.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup)).spacing + slot9, 30 + slot9 * 0.5)

	recthelper.setWidth(slot0._imageSliderBG.transform, slot12)

	if slot6 < slot13 then
		slot0:_refrehSlider(slot6, slot12, slot13)

		slot0._tweenSliderId = ZProj.TweenHelper.DOTweenFloat(slot6, slot13, slot0._tweenTime, slot0._onTweenSliderUpdate, nil, slot0, {
			grayWidth = slot12,
			gotWidth = slot13
		}, EaseType.Linear)
	else
		slot0:_refrehSlider(slot13, slot12, slot13)
	end

	slot0:_setPrefsSchedule(slot0.stage, slot2, slot13)
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
		slot0._txtTotalScore.text = string.format("<color=#ff8640><size=50>%s</size></color>/%s", Mathf.Ceil(slot1), slot2)
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
	slot3 = BossRushModel.instance:getLastPointInfo(slot0.stage).cur

	for slot7, slot8 in pairs(BossRushModel.instance:getScheduleViewRewardList(slot0.stage)) do
		if slot8.stageRewardCO then
			slot11 = slot9.rewardPointNum

			if not slot0.scoreList[slot7] then
				slot10 = {
					go = gohelper.cloneInPlace(slot0._goprefabInst, "scoreitem_" .. slot7)
				}
				slot10.img = slot10.go:GetComponent(gohelper.Type_Image)
				slot10.txt = gohelper.findChildText(slot10.go, "txt_Score")
				slot0.scoreList[slot7] = slot10
			end

			gohelper.setActive(slot10.go.gameObject, true)

			slot10.txt.text = slot11

			UISpriteSetMgr.instance:setV1a4BossRushSprite(slot10.img, BossRushConfig.instance:getRewardStatusSpriteName(slot9.display > 0, slot11 <= slot3))
		end
	end
end

function slot0._refresh(slot0)
	slot0:_refreshRight()
	slot0:refreshScoreItem()
	slot0:refreshScore()
end

function slot0._refreshRight(slot0)
	V1a6_BossRush_BonusModel.instance:selectScheduleTab(slot0.stage)
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
	return "V1a6_BossRush_ScheduleView_Schedule_" .. BossRushConfig.instance:getActivityId() .. "_" .. slot1
end

return slot0
