module("modules.logic.achievement.view.AchievementMainViewFocus", package.seeall)

local var_0_0 = class("AchievementMainViewFocus", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, arg_2_0.onSwitchCategory, arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, arg_2_0.onSwitchViewType, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchCategory, arg_3_0.onSwitchCategory, arg_3_0)
	arg_3_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnSwitchViewType, arg_3_0.onSwitchViewType, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.focus2OriginAchievement, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.triggerAchievementUnLockAduio, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.setHasPlayOpenAnim, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.onFocusNewestUpgradeGroupSucc, arg_5_0)

	if arg_5_0._scrollFocusTweenId then
		ZProj.TweenHelper.KillById(arg_5_0._scrollFocusTweenId)

		arg_5_0._scrollFocusTweenId = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:checkIsNeedFocusAchievement()
end

function var_0_0.onClose(arg_7_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")
end

local var_0_1 = 2

function var_0_0.checkIsNeedFocusAchievement(arg_8_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_FocusOrigin")

	local var_8_0 = arg_8_0:checkIsNeedFocusNewest() and var_0_1 or 0

	TaskDispatcher.cancelTask(arg_8_0.focus2OriginAchievement, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.focus2OriginAchievement, arg_8_0, var_8_0)
end

function var_0_0.checkIsNeedFocusNewest(arg_9_0)
	return arg_9_0:try2FocusNewestUpgradeGroup() or arg_9_0:try2FocusNewestUnlockAchievement()
end

function var_0_0.focus2OriginAchievement(arg_10_0)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_FocusOrigin")

	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.achievementType
	local var_10_1 = arg_10_0.viewParam and arg_10_0.viewParam.focusDataId
	local var_10_2 = false

	if var_10_0 and var_10_1 and var_10_1 ~= 0 then
		var_10_2 = arg_10_0:try2FocusAchievement(var_10_0, var_10_1)
	else
		arg_10_0:setHasPlayOpenAnim()
	end

	return var_10_2
end

function var_0_0.onSwitchCategory(arg_11_0)
	if not arg_11_0:checkIsNeedFocusNewest() then
		arg_11_0:resetViewScrollPixel()
	end
end

function var_0_0.onSwitchViewType(arg_12_0)
	if not arg_12_0:checkIsNeedFocusNewest() then
		arg_12_0:resetViewScrollPixel()
	end
end

function var_0_0.try2FocusAchievement(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = AchievementMainCommonModel.instance:getCurrentViewType()
	local var_13_1, var_13_2, var_13_3 = AchievementMainCommonModel.instance:getViewAchievementIndex(var_13_0, arg_13_1, arg_13_2)
	local var_13_4 = 0

	if var_13_1 then
		var_13_4 = arg_13_0:scrollView2TargetPixel(var_13_0, var_13_3, var_13_2)
	else
		logError(string.format("focus achievement failed, achievementType = %s, dataId = %s", arg_13_1, arg_13_2))
	end

	return var_13_1, var_13_4
end

local var_0_2 = 0.0001
local var_0_3 = 0
local var_0_4 = 1

function var_0_0.scrollView2TargetPixel(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	UIBlockMgr.instance:startBlock("AchievementMainViewFocus_Focus")
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(true)

	local var_14_0 = arg_14_0.viewContainer:getScrollView(arg_14_1)
	local var_14_1 = var_14_0 and var_14_0:getCsScroll()

	arg_14_0._curFocusAchievementIndex = arg_14_3

	local var_14_2 = 0

	if var_14_0 and var_14_1 then
		arg_14_0._curFocusCsScroll = var_14_1

		local var_14_3 = var_14_1.VerticalScrollPixel
		local var_14_4 = arg_14_2 or 0
		local var_14_5 = math.abs(var_14_4 - var_14_3)

		var_14_2 = var_14_5 * var_0_2
		var_14_2 = Mathf.Clamp(var_14_2, var_0_3, var_0_4)

		if var_14_5 <= 0 then
			arg_14_0:_onFocusTweenFrameCallback(var_14_4)
			arg_14_0:_onFocusTweenFinishCallback()
		else
			if arg_14_0._scrollFocusTweenId then
				ZProj.TweenHelper.KillById(arg_14_0._scrollFocusTweenId)
			end

			arg_14_0._scrollFocusTweenId = ZProj.TweenHelper.DOTweenFloat(var_14_3, var_14_4, var_14_2, arg_14_0._onFocusTweenFrameCallback, arg_14_0._onFocusTweenFinishCallback, arg_14_0)
		end
	end

	return var_14_2
end

function var_0_0._onFocusTweenFrameCallback(arg_15_0, arg_15_1)
	if arg_15_0._curFocusCsScroll then
		arg_15_0._curFocusCsScroll.VerticalScrollPixel = arg_15_1
	end
end

local var_0_5 = 0.05

function var_0_0._onFocusTweenFinishCallback(arg_16_0)
	local var_16_0 = Mathf.Clamp(arg_16_0._curFocusAchievementIndex - 1, 1, arg_16_0._curFocusAchievementIndex)

	AchievementMainTileModel.instance:markScrollFocusIndex(var_16_0)
	TaskDispatcher.cancelTask(arg_16_0.setHasPlayOpenAnim, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.setHasPlayOpenAnim, arg_16_0, var_0_5)
	UIBlockMgr.instance:endBlock("AchievementMainViewFocus_Focus")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.setHasPlayOpenAnim(arg_17_0)
	AchievementMainCommonModel.instance:markCurrentScrollFocusing(false)

	local var_17_0 = AchievementMainCommonModel.instance:getCurrentViewType()

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnFocusAchievementFinished, var_17_0)
	AchievementMainTileModel.instance:setHasPlayOpenAnim(true)
end

function var_0_0.try2FocusNewestUpgradeGroup(arg_18_0)
	local var_18_0 = arg_18_0:getNewestUpgradeGroup()
	local var_18_1 = false
	local var_18_2 = 0

	if var_18_0 and var_18_0 ~= 0 then
		local var_18_3

		var_18_1, var_18_3 = arg_18_0:try2FocusAchievement(AchievementEnum.AchievementType.Group, var_18_0)

		if var_18_1 then
			arg_18_0._focusUpgradeGroupId = var_18_0

			AchievementMainCommonModel.instance:markGroupPlayUpgradeEffect(var_18_0)

			local var_18_4 = var_18_3 + var_0_5 + 0.1

			TaskDispatcher.cancelTask(arg_18_0.onFocusNewestUpgradeGroupSucc, arg_18_0)
			TaskDispatcher.runDelay(arg_18_0.onFocusNewestUpgradeGroupSucc, arg_18_0, var_18_4)
		end
	end

	return var_18_1
end

function var_0_0.onFocusNewestUpgradeGroupSucc(arg_19_0)
	AchievementController.instance:dispatchEvent(AchievementEvent.OnGroupUpGrade, arg_19_0._focusUpgradeGroupId)
	arg_19_0:triggerAchievementUnLockAduio()
end

function var_0_0.getNewestUpgradeGroup(arg_20_0)
	local var_20_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_20_1 = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUpgradeGroupId(var_20_0, var_20_1))
end

function var_0_0.try2FocusNewestUnlockAchievement(arg_21_0)
	local var_21_0 = arg_21_0:getNewestUnlockAchievement()
	local var_21_1 = false
	local var_21_2 = 0

	if var_21_0 and var_21_0 ~= 0 then
		local var_21_3 = AchievementConfig.instance:getAchievement(var_21_0)
		local var_21_4 = AchievementMainCommonModel.instance:getCurrentViewType()
		local var_21_5 = AchievementEnum.AchievementType.Single
		local var_21_6 = var_21_0

		if var_21_4 == AchievementEnum.ViewType.Tile and var_21_3.groupId ~= 0 then
			var_21_5 = AchievementEnum.AchievementType.Group
			var_21_6 = var_21_3.groupId
		end

		local var_21_7

		var_21_1, var_21_7 = arg_21_0:try2FocusAchievement(var_21_5, var_21_6)

		if var_21_1 then
			local var_21_8 = var_21_7 + var_0_5

			TaskDispatcher.cancelTask(arg_21_0.triggerAchievementUnLockAduio, arg_21_0)
			TaskDispatcher.runDelay(arg_21_0.triggerAchievementUnLockAduio, arg_21_0, var_21_8)
		end
	end

	return var_21_1
end

function var_0_0.triggerAchievementUnLockAduio(arg_22_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
end

function var_0_0.getNewestUnlockAchievement(arg_23_0)
	local var_23_0 = AchievementMainCommonModel.instance:getCurrentCategory()
	local var_23_1 = AchievementMainCommonModel.instance:getCurrentFilterType()

	return (AchievementMainCommonModel.instance:getNewestUnlockAchievementId(var_23_0, var_23_1))
end

function var_0_0.resetViewScrollPixel(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(AchievementEnum.ViewType) do
		local var_24_0 = arg_24_0.viewContainer:getScrollView(iter_24_1)

		;(var_24_0 and var_24_0:getCsScroll()).VerticalScrollPixel = 0

		arg_24_0:scrollView2TargetPixel(iter_24_1, 0, 1)
	end
end

return var_0_0
