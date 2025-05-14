module("modules.logic.achievement.controller.AchievementToastController", package.seeall)

local var_0_0 = class("AchievementToastController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	arg_3_0:registerCallback(AchievementEvent.LoginShowToast, arg_3_0.handleLoginEnterMainScene, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0.checkToastTrigger, arg_3_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_3_0.checkToastTrigger, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._isLoginScene = false
	arg_4_0._isToastShowing = false

	if arg_4_0._toastLoader then
		arg_4_0._toastLoader:dispose()

		arg_4_0._toastLoader = nil
	end

	AchievementToastModel.instance:release()
end

function var_0_0.onUpdateAchievements(arg_5_0)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	if not var_5_0 or var_5_0.userId == 0 then
		return
	end

	if arg_5_0:canPopUpToast() then
		arg_5_0:showNextToast()
	end
end

function var_0_0.handleLoginEnterMainScene(arg_6_0)
	arg_6_0._isLoginScene = true

	if arg_6_0:canPopUpToast() then
		arg_6_0:showNextToast()
	end
end

function var_0_0.checkToastTrigger(arg_7_0)
	if arg_7_0:canPopUpToast() then
		arg_7_0:showNextToast()
	end
end

function var_0_0.canPopUpToast(arg_8_0)
	return arg_8_0._isLoginScene and not ViewMgr.instance:isOpen(ViewName.StoryView) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) and not ViewMgr.instance:isOpen(ViewName.AiZiLaGameView) and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
end

function var_0_0.showNextToast(arg_9_0)
	local var_9_0 = AchievementToastModel.instance:getWaitToastList()

	if var_9_0 and #var_9_0 > 0 then
		arg_9_0:tryShowToast(var_9_0)
		AchievementToastModel.instance:onToastFinished()
	end
end

function var_0_0.tryShowToast(arg_10_0, arg_10_1)
	if arg_10_1 then
		local var_10_0 = #arg_10_1
		local var_10_1 = var_10_0 - AchievementEnum.ShowMaxToastCount + 1

		for iter_10_0 = Mathf.Clamp(var_10_1, 1, var_10_0), var_10_0 do
			local var_10_2 = arg_10_1[iter_10_0]
			local var_10_3 = var_10_2.taskId
			local var_10_4 = var_10_2.toastType

			arg_10_0:showToastByTaskId(var_10_3, var_10_4)
		end
	end
end

function var_0_0.showToastByTaskId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = AchievementConfig.instance:getTask(arg_11_1)
	local var_11_1 = AchievementConfig.instance:getAchievement(var_11_0.achievementId)
	local var_11_2 = arg_11_0:getToastShowFunction(arg_11_2)
	local var_11_3 = false

	if var_11_2 then
		var_11_3 = var_11_2(arg_11_0, var_11_0, var_11_1)
	end

	return var_11_3
end

function var_0_0.getToastShowFunction(arg_12_0, arg_12_1)
	return var_0_0.AchievementToastShowFuncTab[arg_12_1]
end

function var_0_0.onShowTaskFinishedToast(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = false

	if arg_13_1 then
		local var_13_1 = formatLuaLang("achievementtoastitem_achievementcompleted", arg_13_0:getToastName(arg_13_2, arg_13_1.level))
		local var_13_2 = ResUrl.getAchievementIcon("badgeicon/" .. arg_13_1.icon)
		local var_13_3 = {
			toastTip = var_13_1,
			icon = var_13_2
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementCompleted, arg_13_0.fillToastObj, arg_13_0, var_13_3, var_13_1)

		var_13_0 = true
	end

	return var_13_0
end

function var_0_0.onShowGroupUnlockedToast(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = false

	if arg_14_1 and arg_14_2 then
		local var_14_1 = AchievementConfig.instance:getAchievement(arg_14_1.achievementId)
		local var_14_2 = var_14_1 and var_14_1.groupId

		var_14_0 = arg_14_0:showToastByGroupId(var_14_2, ToastEnum.AchievementUnLockGroup)
	end

	return var_14_0
end

function var_0_0.onShowGroupUpgrade(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = AchievementConfig.instance:getGroup(arg_15_2.groupId)
	local var_15_1 = false

	if var_15_0 then
		local var_15_2 = formatLuaLang("achievementtoastitem_upgradegroup", var_15_0.name)
		local var_15_3 = ResUrl.getAchievementIcon("badgeicon/achievementgroupicon")
		local var_15_4 = {
			toastTip = var_15_2,
			icon = var_15_3
		}

		ToastController.instance:showToastWithCustomData(ToastEnum.AchievementGroupUpGrade, arg_15_0.fillToastObj, arg_15_0, var_15_4, var_15_0.name)

		var_15_1 = true
	end

	return var_15_1
end

function var_0_0.onShowGroupFinishedToast(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2 and arg_16_2.groupId
	local var_16_1 = false

	if var_16_0 ~= 0 then
		var_16_1 = arg_16_0:showToastByGroupId(var_16_0, ToastEnum.AchievementGroupCollect)
	end

	return var_16_1
end

function var_0_0.getToastName(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AchievementModel.instance:getAchievementTaskCoList(arg_17_1.id)

	if var_17_0 and #var_17_0 == 1 then
		return arg_17_1.name
	end

	if LangSettings.instance:isEn() then
		return string.format("%s %s", arg_17_1.name, GameUtil.getRomanNums(arg_17_2))
	else
		return string.format("%s%s", arg_17_1.name, GameUtil.getRomanNums(arg_17_2))
	end
end

function var_0_0.fillToastObj(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = ToastCallbackGroup.New()

	var_18_0.onClose = arg_18_0.onCloseWhenToastRemove
	var_18_0.onCloseObj = arg_18_0
	var_18_0.onCloseParam = arg_18_2
	var_18_0.onOpen = arg_18_0.onOpenToast
	var_18_0.onOpenObj = arg_18_0
	var_18_0.onOpenParam = arg_18_2
	arg_18_1.callbackGroup = var_18_0
end

function var_0_0.onOpenToast(arg_19_0, arg_19_1, arg_19_2)
	arg_19_1.item = AchievementToastItem.New()

	arg_19_1.item:init(arg_19_2, arg_19_1)
end

function var_0_0.onCloseWhenToastRemove(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1.item then
		arg_20_1.item:dispose()

		arg_20_1.item = nil
	end
end

function var_0_0.showToastByGroupId(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = AchievementConfig.instance:getGroup(arg_21_1)

	if var_21_0 then
		ToastController.instance:showToast(arg_21_2, var_21_0.name)

		return true
	end
end

function var_0_0.tryGetToastAsset(arg_22_0)
	if arg_22_0._toastLoader and not arg_22_0._toastLoader.isLoading then
		return (arg_22_0._toastLoader:getAssetItem(AchievementEnum.AchievementToastPath):GetResource(AchievementEnum.AchievementToastPath))
	end

	if not arg_22_0._toastLoader then
		arg_22_0._toastLoader = arg_22_0._toastLoader or MultiAbLoader.New()

		arg_22_0._toastLoader:addPath(AchievementEnum.AchievementToastPath)
		arg_22_0._toastLoader:startLoad()
	end

	return nil
end

var_0_0.AchievementToastShowFuncTab = {
	[AchievementEnum.ToastType.TaskFinished] = var_0_0.onShowTaskFinishedToast,
	[AchievementEnum.ToastType.GroupUnlocked] = var_0_0.onShowGroupUnlockedToast,
	[AchievementEnum.ToastType.GroupUpgrade] = var_0_0.onShowGroupUpgrade,
	[AchievementEnum.ToastType.GroupFinished] = var_0_0.onShowGroupFinishedToast
}
var_0_0.instance = var_0_0.New()

return var_0_0
