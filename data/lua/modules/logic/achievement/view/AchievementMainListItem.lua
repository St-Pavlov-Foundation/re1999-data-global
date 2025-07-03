module("modules.logic.achievement.view.AchievementMainListItem", package.seeall)

local var_0_0 = class("AchievementMainListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop1 = gohelper.findChild(arg_1_0.viewGO, "go_top")
	arg_1_0._gotop2 = gohelper.findChild(arg_1_0.viewGO, "go_top2")
	arg_1_0._txtachievementname = gohelper.findChildText(arg_1_0.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	arg_1_0._simageAchievementGroupBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG")
	arg_1_0._txtachievementgroupname = gohelper.findChildText(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "go_layout")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "go_layout/go_taskitem")
	arg_1_0._btnpopup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_top2/#btn_popup")
	arg_1_0._goallcollect = gohelper.findChild(arg_1_0.viewGO, "go_top2/#simage_AchievementGroupBG/#txt_achievementgroupname/#go_allcollect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnFocusAchievementFinished, arg_2_0._onFocusFinished, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._taskItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._topAnimator = gohelper.onceAddComponent(arg_4_0._gotop1, gohelper.Type_Animator)
	arg_4_0._foldAnimComp = AchievementItemFoldAnimComp.Get(arg_4_0._btnpopup.gameObject, arg_4_0._gotop1)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._simageAchievementGroupBG:UnLoadImage()
	arg_5_0:recycleAchievementMainIcon()
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = AchievementConfig.instance:getAchievement(arg_7_0._mo.id)

	if var_7_0 then
		arg_7_0._groupId = var_7_0.groupId

		local var_7_1 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_7_2 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_7_3 = arg_7_0._mo:getFilterTaskList(var_7_1, var_7_2)

		arg_7_0:refreshTaskList(var_7_3)
		arg_7_0:refreshTopUI(var_7_0)
		arg_7_0._foldAnimComp:onUpdateMO(arg_7_0._mo)
	end
end

local var_0_1 = 1
local var_0_2 = 0.5
local var_0_3 = 1
local var_0_4 = 0.5
local var_0_5 = "#FFFFFF"
local var_0_6 = "#4D4D4D"

function var_0_0.refreshTaskList(arg_8_0, arg_8_1)
	local var_8_0
	local var_8_1 = arg_8_0._mo:getIsFold()

	gohelper.setActive(arg_8_0._golayout, not var_8_1)

	arg_8_0._hasTaskFinished = false

	if not var_8_1 and arg_8_1 then
		var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
			local var_8_2 = arg_8_0:getOrCreateTaskItem(iter_8_0)

			var_8_0[var_8_2] = true

			local var_8_3 = AchievementModel.instance:getById(iter_8_1.id)
			local var_8_4 = var_8_3 and var_8_3.hasFinished

			var_8_2.txtTaskDesc2.text = iter_8_1.extraDesc

			var_8_2.taskIcon:setData(iter_8_1)
			var_8_2.taskIcon:setIconColor(var_8_4 and var_0_5 or var_0_6)
			ZProj.UGUIHelper.SetColorAlpha(var_8_2.txtTaskDesc2, var_8_4 and var_0_3 or var_0_4)
			ZProj.UGUIHelper.SetColorAlpha(var_8_2.txtTaskDesc, var_8_4 and var_0_1 or var_0_2)
			gohelper.setActive(var_8_2.goUnLockTime, var_8_4)
			gohelper.setActive(var_8_2.goNormalBG, var_8_4)
			gohelper.setActive(var_8_2.golockedBG, not var_8_4)

			if var_8_4 then
				var_8_2.txtUnLockedTime.text = TimeUtil.localTime2ServerTimeString(var_8_3.finishTime)
				var_8_2.txtTaskDesc.text = iter_8_1.desc
				arg_8_0._hasTaskFinished = true
			else
				local var_8_5 = iter_8_1.maxProgress
				local var_8_6 = var_8_3 and var_8_3.progress or 0
				local var_8_7 = {
					iter_8_1.desc,
					var_8_6,
					var_8_5
				}

				var_8_2.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), var_8_7)
			end

			arg_8_0:playTaskAnim(var_8_2)
			arg_8_0:tryPlayUpgradeEffect(var_8_3, var_8_2)
		end
	end

	arg_8_0:recycleUnuseTaskItem(var_8_0)
	arg_8_0:onTasksPlayUpgradeEffectFinished()
end

function var_0_0.tryPlayUpgradeEffect(arg_9_0, arg_9_1, arg_9_2)
	if AchievementMainCommonModel.instance:isCurrentScrollFocusing() or not arg_9_0.viewGO.activeInHierarchy or not arg_9_1 or not arg_9_2 then
		return
	end

	local var_9_0 = AchievementConfig.instance:getTask(arg_9_1.id)

	arg_9_0._achievementId = var_9_0 and var_9_0.achievementId

	local var_9_1 = AchievementMainCommonModel.instance:isAchievementPlayEffect(arg_9_0._achievementId)

	arg_9_0._isNeedPlayEffect = false

	if arg_9_1 and arg_9_1.hasFinished and arg_9_1.isNew and not var_9_1 then
		arg_9_0._isNeedPlayEffect = true
	end

	gohelper.setActive(arg_9_2.goupgrade, arg_9_0._isNeedPlayEffect)

	if arg_9_0._isNeedPlayEffect then
		local var_9_2 = AchievementMainCommonModel.instance:isTaskPlayFinishedEffect(arg_9_1.id)

		arg_9_2.goupgradeAnimator:Play("upgrade2", 0, var_9_2 and 1 or 0)

		if not var_9_2 then
			AchievementMainCommonModel.instance:markTaskPlayFinishedEffect(arg_9_1.id)
		end
	end
end

function var_0_0.onTasksPlayUpgradeEffectFinished(arg_10_0)
	if arg_10_0._isNeedPlayEffect and arg_10_0._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(arg_10_0._achievementId)
	end
end

function var_0_0._onFocusFinished(arg_11_0, arg_11_1)
	if arg_11_1 ~= AchievementEnum.ViewType.List then
		return
	end

	if arg_11_0._taskItemTab then
		local var_11_0 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_11_1 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_11_2 = arg_11_0._mo:getFilterTaskList(var_11_0, var_11_1)

		for iter_11_0, iter_11_1 in ipairs(var_11_2) do
			local var_11_3 = arg_11_0:getOrCreateTaskItem(iter_11_0)
			local var_11_4 = AchievementModel.instance:getById(iter_11_1.id)

			arg_11_0:tryPlayUpgradeEffect(var_11_4, var_11_3)
		end

		arg_11_0:onTasksPlayUpgradeEffectFinished()
	end
end

function var_0_0.playTaskAnim(arg_12_0, arg_12_1)
	if not arg_12_1 or not arg_12_1.viewGO.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_12_1.animator:Play("idle", 0, 0)
	else
		arg_12_1.animator:Play("open", 0, 0)
	end
end

function var_0_0.getOrCreateTaskItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._taskItemTab[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.viewGO = gohelper.cloneInPlace(arg_13_0._gotaskitem, "task_" .. arg_13_1)
		var_13_0.goNormalBG = gohelper.findChild(var_13_0.viewGO, "#go_NormalBG")
		var_13_0.golockedBG = gohelper.findChild(var_13_0.viewGO, "#go_lockedBG")
		var_13_0.txtTaskDesc = gohelper.findChildText(var_13_0.viewGO, "Descr/txt_taskdesc")
		var_13_0.txtTaskDesc2 = gohelper.findChildText(var_13_0.viewGO, "Descr/txt_taskdesc2")
		var_13_0.goUnLockTime = gohelper.findChild(var_13_0.viewGO, "UnLockedTime")
		var_13_0.txtUnLockedTime = gohelper.findChildText(var_13_0.viewGO, "UnLockedTime/#txt_UnLockedTime")
		var_13_0.goupgrade = gohelper.findChild(var_13_0.viewGO, "#go_upgrade")
		var_13_0.goupgradeAnimator = gohelper.onceAddComponent(var_13_0.goupgrade, gohelper.Type_Animator)
		var_13_0.goIcon = gohelper.findChild(var_13_0.viewGO, "go_icon")
		var_13_0.animator = gohelper.onceAddComponent(var_13_0.viewGO, gohelper.Type_Animator)

		if arg_13_0._view and arg_13_0._view.viewContainer then
			local var_13_1 = arg_13_0._view.viewContainer:getPoolView()

			if var_13_1 then
				var_13_0.taskIcon = var_13_1:getIcon(var_13_0.goIcon)

				var_13_0.taskIcon:setNameTxtVisible(false)
				var_13_0.taskIcon:setClickCall(arg_13_0._iconClickCallBack, arg_13_0)
			end
		end

		arg_13_0._taskItemTab[arg_13_1] = var_13_0
	end

	gohelper.setActive(var_13_0.viewGO, true)

	return var_13_0
end

function var_0_0._iconClickCallBack(arg_14_0)
	return
end

function var_0_0.recycleUnuseTaskItem(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_0._taskItemTab then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._taskItemTab) do
			if not arg_15_1[iter_15_1] then
				gohelper.setActive(iter_15_1.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshTopUI(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 and arg_16_1.groupId ~= 0 and arg_16_0._mo.isGroupTop

	if var_16_0 then
		arg_16_0:refreshGroupTopUI(arg_16_1.groupId)
	end

	local var_16_1 = arg_16_0._mo:getIsFold()

	if not var_16_1 then
		arg_16_0:refreshSingleTopUI(arg_16_1)
	end

	gohelper.setActive(arg_16_0._gotop1, not var_16_1)
	gohelper.setActive(arg_16_0._gotop2, var_16_0)

	if not var_16_1 then
		arg_16_0:playTopAnim()
	end
end

function var_0_0.playTopAnim(arg_17_0)
	if not arg_17_0._gotop1.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_17_0._topAnimator:Play("idle", 0, 0)
	else
		arg_17_0._topAnimator:Play("open", 0, 0)
	end
end

local var_0_7 = 1
local var_0_8 = 0.5

function var_0_0.refreshSingleTopUI(arg_18_0, arg_18_1)
	if arg_18_1 then
		arg_18_0._txtachievementname.text = arg_18_1.name

		local var_18_0 = arg_18_0._hasTaskFinished and var_0_7 or var_0_8

		ZProj.UGUIHelper.SetColorAlpha(arg_18_0._txtachievementname, var_18_0)
	end
end

function var_0_0.refreshGroupTopUI(arg_19_0, arg_19_1)
	arg_19_0._txtachievementgroupname.text = AchievementConfig.instance:getGroupName(arg_19_1)

	local var_19_0 = AchievementModel.instance:isGroupFinished(arg_19_1)

	gohelper.setActive(arg_19_0._goallcollect, arg_19_1 > 100 and var_19_0)

	local var_19_1 = "#F4FFBD"

	if arg_19_1 > 100 then
		var_19_1 = AchievementConfig.instance:getGroupTitleColorConfig(arg_19_1, AchievementEnum.GroupParamType.Player)
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_19_0._txtachievementgroupname, var_19_1)
	arg_19_0._simageAchievementGroupBG:LoadImage(ResUrl.getAchievementIcon(string.format("grouptitle/%s", arg_19_1)))
end

function var_0_0.recycleAchievementMainIcon(arg_20_0)
	if arg_20_0._taskItemTab then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._taskItemTab) do
			iter_20_1.taskIcon:dispose()
		end
	end
end

return var_0_0
