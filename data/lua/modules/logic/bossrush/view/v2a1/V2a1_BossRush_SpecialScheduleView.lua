module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_SpecialScheduleView", package.seeall)

local var_0_0 = class("V2a1_BossRush_SpecialScheduleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtTotalScore = gohelper.findChildText(arg_1_0.viewGO, "Left/Total/#txt_TotalScore")
	arg_1_0._goSlider = gohelper.findChild(arg_1_0.viewGO, "Left/Slider/#go_Slider")
	arg_1_0._scrollprogress = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress")
	arg_1_0._imageSliderBG = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG")
	arg_1_0._imageSliderFG1 = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1")
	arg_1_0._imageSliderFG2 = gohelper.findChildImage(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#image_SliderBG/#image_SliderFG1/#image_SliderFG2")
	arg_1_0._goprefabInst = gohelper.findChild(arg_1_0.viewGO, "Left/Slider/#go_Slider/#scroll_progress/viewport/content/#go_prefabInst")
	arg_1_0._scrollScoreList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_ScoreList")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Left/#go_AssessIcon")
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
	arg_4_0.scoreList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.stage = arg_6_0.viewParam.stage

	gohelper.setActive(arg_6_0._goRight, true)
	arg_6_0:_initAssessIcon()
	arg_6_0:_refresh()
	gohelper.setActive(arg_6_0._gostatus, false)

	local var_6_0 = arg_6_0._isFirstOpen and BossRushEnum.V1a6_BonusViewAnimName.Open or BossRushEnum.V1a6_BonusViewAnimName.In

	arg_6_0:playAnim(var_6_0)

	arg_6_0._isFirstOpen = nil
	arg_6_0._scrollScoreList.verticalNormalizedPosition = 1
end

function var_0_0.onClose(arg_7_0)
	gohelper.setActive(arg_7_0._goRight, false)
	arg_7_0:playAnim(BossRushEnum.V1a6_BonusViewAnimName.Out)
	arg_7_0:_clearKillTween()
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

	local var_9_2 = BossRushModel.instance:getLayer4HightScore(arg_9_0.stage)

	arg_9_0._assessIcon:setData(arg_9_0.stage, var_9_2, true)
end

function var_0_0.refreshScore(arg_10_0)
	local var_10_0 = BossRushModel.instance:getLayer4CurScore(arg_10_0.stage)
	local var_10_1 = BossRushModel.instance:getLayer4MaxRewardScore(arg_10_0.stage)
	local var_10_2 = Mathf.Min(var_10_0, var_10_1)
	local var_10_3 = {
		curNum = var_10_2,
		maxNum = var_10_1
	}

	arg_10_0._tweenTime = 1.5

	local var_10_4, var_10_5 = arg_10_0:_getPrefsSchedule(arg_10_0.stage)

	if var_10_4 < var_10_2 then
		arg_10_0:_refreshNumTxt(var_10_4, var_10_1)

		arg_10_0._tweenNumId = ZProj.TweenHelper.DOTweenFloat(0, var_10_2, arg_10_0._tweenTime, arg_10_0._onTweenNumUpdate, nil, arg_10_0, var_10_3, EaseType.OutQuad)
	else
		arg_10_0:_refreshNumTxt(var_10_2, var_10_1)
	end

	arg_10_0._goContent = arg_10_0._scrollprogress.content

	local var_10_6 = arg_10_0._goContent.gameObject:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	local var_10_7 = arg_10_0._goprefabInst.transform.rect.width
	local var_10_8 = var_10_6.spacing + var_10_7
	local var_10_9 = 30 + var_10_7 * 0.5
	local var_10_10, var_10_11 = V1a6_BossRush_BonusModel.instance:getLayer4ProgressWidth(arg_10_0.stage, var_10_8, var_10_9)
	local var_10_12 = {
		grayWidth = var_10_10,
		gotWidth = var_10_11
	}

	recthelper.setWidth(arg_10_0._imageSliderBG.transform, var_10_10)

	if var_10_5 < var_10_11 then
		arg_10_0:_refrehSlider(var_10_5, var_10_10, var_10_11)

		arg_10_0._tweenSliderId = ZProj.TweenHelper.DOTweenFloat(var_10_5, var_10_11, arg_10_0._tweenTime, arg_10_0._onTweenSliderUpdate, nil, arg_10_0, var_10_12, EaseType.Linear)
	else
		arg_10_0:_refrehSlider(var_10_11, var_10_10, var_10_11)
	end

	arg_10_0:_setPrefsSchedule(arg_10_0.stage, var_10_2, var_10_11)
end

function var_0_0._onTweenNumUpdate(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:_refreshNumTxt(arg_11_1, arg_11_2.maxNum)
end

function var_0_0._onTweenSliderUpdate(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_refrehSlider(arg_12_1, arg_12_2.grayWidth, arg_12_2.gotWidth)
end

function var_0_0._clearKillTween(arg_13_0)
	if arg_13_0._tweenSliderId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenSliderId)

		arg_13_0._tweenSliderId = nil
	end

	if arg_13_0._tweenNumId then
		ZProj.TweenHelper.KillById(arg_13_0._tweenNumId)

		arg_13_0._tweenNumId = nil
	end
end

function var_0_0._refreshNumTxt(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._txtTotalScore then
		arg_14_1 = Mathf.Ceil(arg_14_1)
		arg_14_0._txtTotalScore.text = string.format("<color=#41D9C5><size=50>%s</size></color>/%s", arg_14_1, arg_14_2)
	end
end

function var_0_0._refrehSlider(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0._imageSliderFG1 then
		recthelper.setWidth(arg_15_0._imageSliderFG1.transform, arg_15_1)
		recthelper.setWidth(arg_15_0._imageSliderFG2.transform, arg_15_3 - arg_15_1)
	end

	if arg_15_0._scrollprogress then
		local var_15_0 = arg_15_2 and arg_15_2 > 0 and arg_15_1 / arg_15_2 or 0

		arg_15_0._scrollprogress.horizontalNormalizedPosition = var_15_0
	end
end

function var_0_0.refreshScoreItem(arg_16_0)
	local var_16_0 = BossRushModel.instance:getSpecialScheduleViewRewardList(arg_16_0.stage)
	local var_16_1 = BossRushModel.instance:getLayer4CurScore(arg_16_0.stage)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_2 = iter_16_1.config

		if var_16_2 then
			local var_16_3 = arg_16_0.scoreList[iter_16_0]
			local var_16_4 = var_16_2.maxProgress

			if not var_16_3 then
				var_16_3 = {
					go = gohelper.cloneInPlace(arg_16_0._goprefabInst, "scoreitem_" .. iter_16_0)
				}
				var_16_3.img = var_16_3.go:GetComponent(gohelper.Type_Image)
				var_16_3.txt = gohelper.findChildText(var_16_3.go, "txt_Score")
				arg_16_0.scoreList[iter_16_0] = var_16_3
			end

			gohelper.setActive(var_16_3.go.gameObject, true)

			var_16_3.txt.text = var_16_4

			local var_16_5 = false
			local var_16_6 = var_16_4 <= var_16_1

			UISpriteSetMgr.instance:setV1a4BossRushSprite(var_16_3.img, BossRushConfig.instance:getSpriteRewardStatusSpriteName(var_16_6))
		end
	end
end

function var_0_0._refresh(arg_17_0)
	arg_17_0:_refreshRight()
	arg_17_0:refreshScoreItem()
	arg_17_0:refreshScore()
end

function var_0_0._refreshRight(arg_18_0)
	V1a6_BossRush_BonusModel.instance:selectSpecialScheduleTab(arg_18_0.stage)
end

function var_0_0.playAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0._animatorPlayer then
		arg_19_0._animatorPlayer:Play(arg_19_1, arg_19_2, arg_19_3)
	end
end

function var_0_0._getPrefsSchedule(arg_20_0, arg_20_1)
	local var_20_0 = GameUtil.playerPrefsGetStringByUserId(arg_20_0:_getPrefsKey(arg_20_1), "0|0")
	local var_20_1 = string.split(var_20_0, "|")
	local var_20_2 = tonumber(var_20_1[1])
	local var_20_3 = tonumber(var_20_1[2])

	return var_20_2, var_20_3
end

function var_0_0._setPrefsSchedule(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	GameUtil.playerPrefsSetStringByUserId(arg_21_0:_getPrefsKey(arg_21_1), string.format("%s|%s", arg_21_2, arg_21_3))
end

function var_0_0._getPrefsKey(arg_22_0, arg_22_1)
	local var_22_0 = BossRushConfig.instance:getActivityId()

	return "V2a1_BossRush_SpecialScheduleView_Schedule_" .. var_22_0 .. "_" .. arg_22_1
end

return var_0_0
