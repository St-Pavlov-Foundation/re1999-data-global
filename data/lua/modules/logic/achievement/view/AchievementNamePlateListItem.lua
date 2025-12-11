module("modules.logic.achievement.view.AchievementNamePlateListItem", package.seeall)

local var_0_0 = class("AchievementNamePlateListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop1 = gohelper.findChild(arg_1_0.viewGO, "go_top")
	arg_1_0._gotop2 = gohelper.findChild(arg_1_0.viewGO, "go_top2")
	arg_1_0._txtachievementname = gohelper.findChildText(arg_1_0.viewGO, "go_top/image_AchievementNameBG/#txt_achievementname")
	arg_1_0._golayout1 = gohelper.findChild(arg_1_0.viewGO, "go_layout")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "go_layout_misihai")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "go_layout_misihai/go_taskitem")

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

	gohelper.setActive(arg_4_0._golayout1, false)
	gohelper.setActive(arg_4_0._gotop2, false)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:recycleAchievementMainIcon()
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	if AchievementMainCommonModel.instance:getCurrentViewType() ~= AchievementEnum.ViewType.List then
		return
	end

	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	if not AchievementMainCommonModel.instance:checkIsNamePlate() then
		return
	end

	local var_7_0 = AchievementConfig.instance:getAchievement(arg_7_0._mo.id)

	if var_7_0 then
		arg_7_0._groupId = var_7_0.groupId

		local var_7_1 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_7_2 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_7_3 = arg_7_0._mo:getFilterTaskList(var_7_1, var_7_2)

		arg_7_0:refreshTaskList(var_7_3)
		arg_7_0:refreshTopUI(var_7_0)
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
				local var_8_5 = AchievementConfig.instance:getAchievement(iter_8_1.achievementId)
				local var_8_6
				local var_8_7
				local var_8_8 = iter_8_1.listenerType
				local var_8_9 = AchievementUtils.getAchievementProgressBySourceType(var_8_5.rule)
				local var_8_10

				if var_8_8 and var_8_8 == "TowerPassLayer" then
					if iter_8_1.listenerParam and not string.nilorempty(iter_8_1.listenerParam) then
						local var_8_11 = string.split(iter_8_1.listenerParam, "#")

						var_8_10 = var_8_11 and var_8_11[3]
						var_8_10 = var_8_10 * 10
					end
				else
					var_8_10 = iter_8_1 and iter_8_1.maxProgress
				end

				local var_8_12 = var_8_10
				local var_8_13 = var_8_10 < var_8_9 and var_8_10 or var_8_9
				local var_8_14 = {
					iter_8_1.desc,
					var_8_13,
					var_8_12
				}

				var_8_2.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockPath"), var_8_14)
			end

			arg_8_0:_refreshIcon(var_8_2.levelItemList[iter_8_0], iter_8_1)
			arg_8_0:playTaskAnim(var_8_2)
			arg_8_0:tryPlayUpgradeEffect(var_8_3, var_8_2)
		end
	end

	arg_8_0:recycleUnuseTaskItem(var_8_0)
	arg_8_0:onTasksPlayUpgradeEffectFinished()
end

function var_0_0._refreshIcon(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = AchievementModel.instance:getById(arg_9_2.id)
	local var_9_1

	var_9_1 = var_9_0 and var_9_0.hasFinished

	local var_9_2
	local var_9_3
	local var_9_4

	if arg_9_2.image and not string.nilorempty(arg_9_2.image) then
		local var_9_5 = string.split(arg_9_2.image, "#")
		local var_9_6 = var_9_5[1]

		var_9_3 = var_9_5[2]
		var_9_4 = var_9_5[3]
	end

	arg_9_1.simagebg:LoadImage(ResUrl.getAchievementIcon(var_9_4))
	arg_9_1.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(var_9_3))

	local var_9_7 = arg_9_2.listenerType
	local var_9_8 = AchievementConfig.instance:getAchievement(arg_9_2.achievementId)
	local var_9_9 = AchievementUtils.getAchievementProgressBySourceType(var_9_8.rule)
	local var_9_10

	if var_9_7 and var_9_7 == "TowerPassLayer" then
		if arg_9_2.listenerParam and not string.nilorempty(arg_9_2.listenerParam) then
			local var_9_11 = string.split(arg_9_2.listenerParam, "#")

			var_9_10 = var_9_11 and var_9_11[3]
			var_9_10 = var_9_10 * 10
		end
	else
		var_9_10 = arg_9_2 and arg_9_2.maxProgress
	end

	arg_9_1.txtlevel.text = var_9_10
end

function var_0_0.tryPlayUpgradeEffect(arg_10_0, arg_10_1, arg_10_2)
	if AchievementMainCommonModel.instance:isCurrentScrollFocusing() or not arg_10_0.viewGO.activeInHierarchy or not arg_10_1 or not arg_10_2 then
		return
	end

	local var_10_0 = AchievementConfig.instance:getTask(arg_10_1.id)

	arg_10_0._achievementId = var_10_0 and var_10_0.achievementId

	local var_10_1 = AchievementMainCommonModel.instance:isAchievementPlayEffect(arg_10_0._achievementId)

	arg_10_0._isNeedPlayEffect = false

	if arg_10_1 and arg_10_1.hasFinished and arg_10_1.isNew and not var_10_1 then
		arg_10_0._isNeedPlayEffect = true
	end

	gohelper.setActive(arg_10_2.goupgrade, arg_10_0._isNeedPlayEffect)

	if arg_10_0._isNeedPlayEffect then
		local var_10_2 = AchievementMainCommonModel.instance:isTaskPlayFinishedEffect(arg_10_1.id)

		arg_10_2.goupgradeAnimator:Play("upgrade2", 0, var_10_2 and 1 or 0)

		if not var_10_2 then
			AchievementMainCommonModel.instance:markTaskPlayFinishedEffect(arg_10_1.id)
		end
	end
end

function var_0_0.onTasksPlayUpgradeEffectFinished(arg_11_0)
	if arg_11_0._isNeedPlayEffect and arg_11_0._achievementId then
		AchievementMainCommonModel.instance:markAchievementPlayEffect(arg_11_0._achievementId)
	end
end

function var_0_0._onFocusFinished(arg_12_0, arg_12_1)
	if arg_12_1 ~= AchievementEnum.ViewType.List then
		return
	end

	if not AchievementMainCommonModel.instance:checkIsNamePlate() then
		return
	end

	if arg_12_0._taskItemTab then
		local var_12_0 = AchievementMainCommonModel.instance:getCurrentSortType()
		local var_12_1 = AchievementMainCommonModel.instance:getCurrentFilterType()
		local var_12_2 = arg_12_0._mo:getFilterTaskList(var_12_0, var_12_1)

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			local var_12_3 = arg_12_0:getOrCreateTaskItem(iter_12_0)
			local var_12_4 = AchievementModel.instance:getById(iter_12_1.id)

			arg_12_0:tryPlayUpgradeEffect(var_12_4, var_12_3)
		end

		arg_12_0:onTasksPlayUpgradeEffectFinished()
	end
end

function var_0_0.playTaskAnim(arg_13_0, arg_13_1)
	if not arg_13_1 or not arg_13_1.viewGO.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_13_1.animator:Play("idle", 0, 0)
	else
		arg_13_1.animator:Play("open", 0, 0)
	end
end

function var_0_0.getOrCreateTaskItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._taskItemTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.viewGO = gohelper.cloneInPlace(arg_14_0._gotaskitem, "task_" .. arg_14_1)
		var_14_0.goNormalBG = gohelper.findChild(var_14_0.viewGO, "#go_NormalBG")
		var_14_0.golockedBG = gohelper.findChild(var_14_0.viewGO, "#go_lockedBG")
		var_14_0.txtTaskDesc = gohelper.findChildText(var_14_0.viewGO, "Descr/taskdesc/txt_taskdesc")
		var_14_0.txtTaskDesc2 = gohelper.findChildText(var_14_0.viewGO, "Descr/txt_taskdesc2")
		var_14_0.goUnLockTime = gohelper.findChild(var_14_0.viewGO, "UnLockedTime")
		var_14_0.txtUnLockedTime = gohelper.findChildText(var_14_0.viewGO, "UnLockedTime/#txt_UnLockedTime")
		var_14_0.goupgrade = gohelper.findChild(var_14_0.viewGO, "#go_upgrade")
		var_14_0.goupgradeAnimator = gohelper.onceAddComponent(var_14_0.goupgrade, gohelper.Type_Animator)
		var_14_0.goIcon = gohelper.findChild(var_14_0.viewGO, "go_icon")
		var_14_0.levelItemList = {}

		for iter_14_0 = 1, 3 do
			local var_14_1 = {
				go = gohelper.findChild(var_14_0.goIcon, "level" .. iter_14_0)
			}

			var_14_1.simagebg = gohelper.findChildSingleImage(var_14_1.go, "#simage_bg")
			var_14_1.simagetitle = gohelper.findChildSingleImage(var_14_1.go, "#simage_title")
			var_14_1.txtlevel = gohelper.findChildText(var_14_1.go, "#txt_level")

			gohelper.setActive(var_14_1.go, false)
			table.insert(var_14_0.levelItemList, var_14_1)
		end

		if var_14_0.levelItemList[arg_14_1] then
			gohelper.setActive(var_14_0.levelItemList[arg_14_1].go, true)
		end

		var_14_0.animator = gohelper.onceAddComponent(var_14_0.viewGO, gohelper.Type_Animator)
		arg_14_0._taskItemTab[arg_14_1] = var_14_0
	end

	gohelper.setActive(var_14_0.viewGO, true)

	return var_14_0
end

function var_0_0._iconClickCallBack(arg_15_0)
	return
end

function var_0_0.recycleUnuseTaskItem(arg_16_0, arg_16_1)
	if arg_16_1 and arg_16_0._taskItemTab then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._taskItemTab) do
			if not arg_16_1[iter_16_1] then
				gohelper.setActive(iter_16_1.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshTopUI(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._mo:getIsFold()

	if not var_17_0 then
		arg_17_0:refreshSingleTopUI(arg_17_1)
	end

	gohelper.setActive(arg_17_0._gotop1, not var_17_0)

	if not var_17_0 then
		arg_17_0:playTopAnim()
	end
end

function var_0_0.playTopAnim(arg_18_0)
	if not arg_18_0._gotop1.activeInHierarchy then
		return
	end

	if AchievementMainListModel.instance:isCurTaskNeedPlayIdleAnim() then
		arg_18_0._topAnimator:Play("idle", 0, 0)
	else
		arg_18_0._topAnimator:Play("open", 0, 0)
	end
end

local var_0_7 = 1
local var_0_8 = 0.5

function var_0_0.refreshSingleTopUI(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0._txtachievementname.text = arg_19_1.name

		local var_19_0 = arg_19_0._hasTaskFinished and var_0_7 or var_0_8

		ZProj.UGUIHelper.SetColorAlpha(arg_19_0._txtachievementname, var_19_0)
	end
end

function var_0_0.recycleAchievementMainIcon(arg_20_0)
	if arg_20_0._taskItemTab then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._taskItemTab) do
			-- block empty
		end
	end
end

return var_0_0
