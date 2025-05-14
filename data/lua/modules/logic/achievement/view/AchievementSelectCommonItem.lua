module("modules.logic.achievement.view.AchievementSelectCommonItem", package.seeall)

local var_0_0 = class("AchievementSelectCommonItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animator = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))
	arg_4_0._isFirstEnter = true
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:releaseAchievementMainIcons()
	TaskDispatcher.cancelTask(arg_5_0.playItemOpenAim, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:buildAchievementCfgs()
	arg_6_0:refreshUI()
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshAchievements()
	arg_8_0:playAchievementOpenAnim()
end

var_0_0.LockedIconColor = "#808080"
var_0_0.UnLockedIconColor = "#FFFFFF"
var_0_0.LockedNameAlpha = 0.5
var_0_0.UnLockedNameAlpha = 1

function var_0_0.refreshAchievements(arg_9_0)
	local var_9_0 = arg_9_0:getAchievementCfgs()
	local var_9_1 = var_9_0 and #var_9_0
	local var_9_2 = {}

	for iter_9_0 = 1, var_9_1 do
		local var_9_3 = var_9_0[iter_9_0]
		local var_9_4 = arg_9_0:getOrCreateAchievementIcon(iter_9_0)

		gohelper.setActive(var_9_4.viewGO, true)

		var_9_2[var_9_4] = true

		arg_9_0:refreshAchievement(var_9_4, var_9_3, iter_9_0)
		arg_9_0:refreshAchievementIconPositionAndScale(var_9_4, var_9_3, iter_9_0)
	end

	arg_9_0:recycleUnuseAchievementIcon(var_9_2)
end

function var_0_0.buildAchievementCfgs(arg_10_0)
	arg_10_0._achievementCfgs = arg_10_0._mo.achievementCfgs
end

function var_0_0.getAchievementCfgs(arg_11_0)
	return arg_11_0._achievementCfgs
end

function var_0_0.refreshAchievement(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_2.id
	local var_12_1 = AchievementController.instance:getMaxLevelFinishTask(var_12_0)

	if var_12_1 then
		arg_12_1:setData(var_12_1)
		arg_12_1:setNameTxtVisible(false)
		arg_12_1:setBgVisible(false)

		local var_12_2 = AchievementModel.instance:achievementHasLocked(var_12_0)

		gohelper.setActive(arg_12_1.viewGO, not var_12_2)
	else
		gohelper.setActive(arg_12_1.viewGO, false)
	end
end

function var_0_0.refreshAchievementIconPositionAndScale(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return
end

function var_0_0.getOrCreateAchievementIcon(arg_14_0, arg_14_1)
	arg_14_0._achievementIconTab = arg_14_0._achievementIconTab or arg_14_0:getUserDataTb_()

	local var_14_0 = arg_14_0._achievementIconTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:createAchievementIcon(arg_14_1)
		arg_14_0._achievementIconTab[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.createAchievementIcon(arg_15_0, arg_15_1)
	local var_15_0 = AchievementMainIcon.New()
	local var_15_1 = arg_15_0:getAchievementIconParentGO()
	local var_15_2 = arg_15_0:getAchievementIconResUrl()
	local var_15_3 = arg_15_0._view:getResInst(var_15_2, var_15_1, "icon" .. tostring(arg_15_1))

	var_15_0:init(var_15_3)
	var_15_0:setClickCall(arg_15_0.onClickSingleAchievementIcon, arg_15_0, arg_15_1)

	return var_15_0
end

function var_0_0.getAchievementIconParentGO(arg_16_0)
	return arg_16_0.viewGO
end

function var_0_0.getAchievementIconResUrl(arg_17_0)
	return AchievementEnum.MainIconPath
end

function var_0_0.recycleUnuseAchievementIcon(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_0._achievementIconTab then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._achievementIconTab) do
			if not arg_18_1[iter_18_1] then
				gohelper.setActive(iter_18_1.viewGO, false)
			end
		end
	end
end

function var_0_0.releaseAchievementMainIcons(arg_19_0)
	if arg_19_0._achievementIconTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._achievementIconTab) do
			if iter_19_1 and iter_19_1.dispose then
				iter_19_1:dispose()
			end
		end
	end

	arg_19_0._achievementIconTab = nil
end

var_0_0.AnimDelayDelta = 0.06

function var_0_0.playAchievementAnim(arg_20_0, arg_20_1)
	arg_20_0:playAchievementOpenAnim(arg_20_1)
end

function var_0_0.playAchievementOpenAnim(arg_21_0, arg_21_1)
	TaskDispatcher.cancelTask(arg_21_0.playItemOpenAim, arg_21_0)

	if arg_21_0._isNeedPlayOpenAnim then
		arg_21_0._animator:Play("close", 0, 0)

		arg_21_1 = arg_21_1 or 1

		local var_21_0 = var_0_0.AnimDelayDelta * Mathf.Clamp(arg_21_0._index - arg_21_1, 0, arg_21_0._index)

		TaskDispatcher.runDelay(arg_21_0.playItemOpenAim, arg_21_0, var_21_0)

		arg_21_0._isNeedPlayOpenAnim = false
	else
		arg_21_0._animator:Play("idle", 0, 0)
	end
end

function var_0_0.playItemOpenAim(arg_22_0)
	arg_22_0._animator:Play("open", 0, 0)

	arg_22_0._isFirstEnter = false
end

function var_0_0.resetFistEnter(arg_23_0, arg_23_1)
	arg_23_0._isNeedPlayOpenAnim = true

	arg_23_0:playAchievementAnim(arg_23_1)
end

return var_0_0
