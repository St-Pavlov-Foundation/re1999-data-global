module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_ScheduleView", package.seeall)

local var_0_0 = class("V1a6_BossRush_ScheduleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTotalScore = gohelper.findChildText(arg_1_0.viewGO, "Left/Total/#txt_TotalScore")
	arg_1_0._goSlider = gohelper.findChild(arg_1_0.viewGO, "Left/Slider/#go_Slider")
	arg_1_0._scrollprogress = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	arg_1_0._imageSliderBG = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	arg_1_0._imageSliderFG1 = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	arg_1_0._imageSliderFG2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	arg_1_0._goprefabInst = gohelper.findChild(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	arg_1_0._scrollScoreList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_ScoreList")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "Right")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, arg_2_0._refresh, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, arg_2_0._refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnReceiveGet128SingleRewardReply, arg_3_0._refresh, arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnReceiveAct128GetTotalRewardsReply, arg_3_0._refresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.scoreList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.stage = arg_6_0.viewParam.stage

	gohelper.setActive(arg_6_0._goRight, true)
	arg_6_0:_refresh()
	gohelper.setActive(arg_6_0._gostatus, false)
	arg_6_0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.In)

	arg_6_0._scrollScoreList.verticalNormalizedPosition = 1
end

function var_0_0.onClose(arg_7_0)
	gohelper.setActive(arg_7_0._goRight, false)
	arg_7_0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	arg_7_0:_clearKillTween()
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.refreshScore(arg_9_0)
	local var_9_0 = BossRushModel.instance:getLastPointInfo(arg_9_0.stage)
	local var_9_1 = var_9_0.cur
	local var_9_2 = var_9_0.max
	local var_9_3 = Mathf.Min(var_9_1, var_9_2)
	local var_9_4 = {
		curNum = var_9_3,
		maxNum = var_9_2
	}

	arg_9_0._tweenTime = 1.5

	local var_9_5, var_9_6 = arg_9_0:_getPrefsSchedule(arg_9_0.stage)

	if var_9_5 < var_9_3 then
		arg_9_0:_refreshNumTxt(var_9_5, var_9_2)

		arg_9_0._tweenNumId = ZProj.TweenHelper.DOTweenFloat(0, var_9_3, arg_9_0._tweenTime, arg_9_0._onTweenNumUpdate, nil, arg_9_0, var_9_4, EaseType.OutQuad)
	else
		arg_9_0:_refreshNumTxt(var_9_3, var_9_2)
	end

	arg_9_0._goContent = arg_9_0._scrollprogress.content

	local var_9_7 = arg_9_0._goContent.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	local var_9_8 = arg_9_0._goprefabInst.transform.rect.width
	local var_9_9 = var_9_7.spacing + var_9_8
	local var_9_10 = 30 + var_9_8 * 0.5
	local var_9_11, var_9_12 = V1a6_BossRush_BonusModel.instance:getScheduleProgressWidth(arg_9_0.stage, var_9_9, var_9_10)
	local var_9_13 = {
		grayWidth = var_9_11,
		gotWidth = var_9_12
	}

	recthelper.setWidth(arg_9_0._imageSliderBG.transform, var_9_11)

	if var_9_6 < var_9_12 then
		arg_9_0:_refrehSlider(var_9_6, var_9_11, var_9_12)

		arg_9_0._tweenSliderId = ZProj.TweenHelper.DOTweenFloat(var_9_6, var_9_12, arg_9_0._tweenTime, arg_9_0._onTweenSliderUpdate, nil, arg_9_0, var_9_13, EaseType.Linear)
	else
		arg_9_0:_refrehSlider(var_9_12, var_9_11, var_9_12)
	end

	arg_9_0:_setPrefsSchedule(arg_9_0.stage, var_9_3, var_9_12)
end

function var_0_0._onTweenNumUpdate(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_refreshNumTxt(arg_10_1, arg_10_2.maxNum)
end

function var_0_0._onTweenSliderUpdate(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:_refrehSlider(arg_11_1, arg_11_2.grayWidth, arg_11_2.gotWidth)
end

function var_0_0._clearKillTween(arg_12_0)
	if arg_12_0._tweenSliderId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenSliderId)

		arg_12_0._tweenSliderId = nil
	end

	if arg_12_0._tweenNumId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenNumId)

		arg_12_0._tweenNumId = nil
	end
end

function var_0_0._refreshNumTxt(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._txtTotalScore then
		arg_13_1 = Mathf.Ceil(arg_13_1)
		arg_13_0._txtTotalScore.text = string.format("<color=#ff8640><size=50>%s</size></color>/%s", arg_13_1, arg_13_2)
	end
end

function var_0_0._refrehSlider(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_0._imageSliderFG1 then
		recthelper.setWidth(arg_14_0._imageSliderFG1.transform, arg_14_1)
		recthelper.setWidth(arg_14_0._imageSliderFG2.transform, arg_14_3 - arg_14_1)
	end

	if arg_14_0._scrollprogress then
		local var_14_0 = arg_14_2 and arg_14_2 > 0 and arg_14_1 / arg_14_2 or 0

		arg_14_0._scrollprogress.horizontalNormalizedPosition = var_14_0
	end
end

function var_0_0.refreshScoreItem(arg_15_0)
	local var_15_0 = BossRushModel.instance:getScheduleViewRewardList(arg_15_0.stage)
	local var_15_1 = BossRushModel.instance:getLastPointInfo(arg_15_0.stage).cur

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_2 = iter_15_1.stageRewardCO

		if var_15_2 then
			local var_15_3 = arg_15_0.scoreList[iter_15_0]
			local var_15_4 = var_15_2.rewardPointNum

			if not var_15_3 then
				var_15_3 = {
					go = gohelper.cloneInPlace(arg_15_0._goprefabInst, "scoreitem_" .. iter_15_0)
				}
				var_15_3.img = var_15_3.go:GetComponent(gohelper.Type_Image)
				var_15_3.txt = gohelper.findChildText(var_15_3.go, "txt_Score")
				arg_15_0.scoreList[iter_15_0] = var_15_3
			end

			gohelper.setActive(var_15_3.go.gameObject, true)

			var_15_3.txt.text = var_15_4

			local var_15_5 = var_15_2.display > 0
			local var_15_6 = var_15_4 <= var_15_1

			UISpriteSetMgr.instance:setV1a4BossRushSprite(var_15_3.img, BossRushConfig.instance:getRewardStatusSpriteName(var_15_5, var_15_6))
		end
	end
end

function var_0_0._refresh(arg_16_0)
	arg_16_0:_refreshRight()
	arg_16_0:refreshScoreItem()
	arg_16_0:refreshScore()
end

function var_0_0._refreshRight(arg_17_0)
	V1a6_BossRush_BonusModel.instance:selectScheduleTab(arg_17_0.stage)
end

function var_0_0.playAnim(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0._animatorPlayer then
		arg_18_0._animatorPlayer:Play(arg_18_1, arg_18_2, arg_18_3)
	end
end

function var_0_0._getPrefsSchedule(arg_19_0, arg_19_1)
	local var_19_0 = GameUtil.playerPrefsGetStringByUserId(arg_19_0:_getPrefsKey(arg_19_1), "0|0")
	local var_19_1 = string.split(var_19_0, "|")
	local var_19_2 = tonumber(var_19_1[1])
	local var_19_3 = tonumber(var_19_1[2])

	return var_19_2, var_19_3
end

function var_0_0._setPrefsSchedule(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	GameUtil.playerPrefsSetStringByUserId(arg_20_0:_getPrefsKey(arg_20_1), string.format("%s|%s", arg_20_2, arg_20_3))
end

function var_0_0._getPrefsKey(arg_21_0, arg_21_1)
	local var_21_0 = BossRushConfig.instance:getActivityId()

	return "V1a6_BossRush_ScheduleView_Schedule_" .. var_21_0 .. "_" .. arg_21_1
end

return var_0_0
