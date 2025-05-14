module("modules.logic.achievement.view.AchievementSelectItem", package.seeall)

local var_0_0 = class("AchievementSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosingle = gohelper.findChild(arg_1_0.viewGO, "#go_single")
	arg_1_0._gogroup = gohelper.findChild(arg_1_0.viewGO, "#go_group")
	arg_1_0._gosingleitem = gohelper.findChild(arg_1_0.viewGO, "#go_single/#go_singleitem")
	arg_1_0._gogroupselected = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_groupselected")
	arg_1_0._btngroupselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_group/#btn_groupselect")
	arg_1_0._gogroupcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_groupcontainer")
	arg_1_0._simagegroupbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_group/#simage_groupbg")
	arg_1_0._goallcollect = gohelper.findChild(arg_1_0.viewGO, "#go_group/#go_allcollect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngroupselect:AddClickListener(arg_2_0._btngroupselectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngroupselect:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._anim = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._singleItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._singleItems) do
			iter_5_1:dispose()
		end

		arg_5_0._singleItems = nil
	end

	if arg_5_0._groupItems then
		for iter_5_2, iter_5_3 in pairs(arg_5_0._groupItems) do
			iter_5_3:dispose()
		end

		arg_5_0._groupItems = nil
	end

	arg_5_0._simagegroupbg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_5_0._playItemOpenAim, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._mo.groupId ~= 0

	gohelper.setActive(arg_7_0._gosingle, not var_7_0)
	gohelper.setActive(arg_7_0._gogroup, var_7_0)

	if var_7_0 then
		arg_7_0:refreshGroup()
	else
		arg_7_0:refreshSingle()
	end

	arg_7_0:_playAnim()
end

function var_0_0.refreshSingle(arg_8_0)
	arg_8_0:checkInitSingle()

	for iter_8_0 = 1, AchievementEnum.MainListLineCount do
		local var_8_0 = arg_8_0._singleItems[iter_8_0]
		local var_8_1 = arg_8_0._mo.achievementCfgs[iter_8_0]

		gohelper.setActive(var_8_0.viewGO, var_8_1 ~= nil)

		if var_8_1 then
			local var_8_2 = var_8_1.id
			local var_8_3 = AchievementController.instance:getMaxLevelFinishTask(var_8_2)

			if var_8_3 then
				var_8_0:setData(var_8_3)
			else
				gohelper.setActive(var_8_0.viewGO, false)
			end
		end
	end
end

function var_0_0.refreshGroup(arg_9_0)
	local var_9_0 = arg_9_0._mo.groupId
	local var_9_1 = AchievementConfig.instance:getGroup(var_9_0)

	if var_9_1 then
		local var_9_2 = AchievementModel.instance:isAchievementTaskFinished(var_9_1.unLockAchievement)
		local var_9_3 = AchievementConfig.instance:getGroupBgUrl(var_9_0, AchievementEnum.GroupParamType.List, var_9_2)

		arg_9_0._simagegroupbg:LoadImage(var_9_3)
		arg_9_0:refreshSingleInGroup()
	end

	gohelper.setActive(arg_9_0._gogroupselected, AchievementSelectListModel.instance:isGroupSelected(var_9_0))
end

function var_0_0.refreshSingleInGroup(arg_10_0)
	local var_10_0 = AchievementConfig.instance:getGroupParamIdTab(arg_10_0._mo.groupId, AchievementEnum.GroupParamType.List)
	local var_10_1 = {}

	if var_10_0 then
		local var_10_2 = AchievementConfig.instance:getAchievementsByGroupId(arg_10_0._mo.groupId)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_3 = arg_10_0:getOrCreateSingleItemInGroup(iter_10_0)

			var_10_1[var_10_3] = true

			arg_10_0:_setGroupAchievementPosAndScale(var_10_3.viewGO, arg_10_0._mo.groupId, iter_10_0)

			local var_10_4 = var_10_2[iter_10_1]

			gohelper.setActive(var_10_3.viewGO, var_10_4 ~= nil)

			if var_10_4 then
				local var_10_5 = AchievementController.instance:getMaxLevelFinishTask(var_10_4.id)

				if var_10_5 then
					var_10_3:setData(var_10_5)
					var_10_3:setNameTxtVisible(false)
					var_10_3:setSelectIconVisible(false)
					var_10_3:setBgVisible(false)

					local var_10_6 = AchievementModel.instance:achievementHasLocked(var_10_4.id)

					gohelper.setActive(var_10_3.viewGO, not var_10_6)
				else
					gohelper.setActive(var_10_3.viewGO, false)
				end
			end
		end
	end

	if var_10_1 and arg_10_0._groupItems then
		for iter_10_2, iter_10_3 in pairs(arg_10_0._groupItems) do
			if not var_10_1[iter_10_3] then
				gohelper.setActive(iter_10_3.viewGO, false)
			end
		end
	end

	local var_10_7 = AchievementModel.instance:isGroupFinished(arg_10_0._mo.groupId)

	gohelper.setActive(arg_10_0._goallcollect, var_10_7)
end

function var_0_0.getOrCreateSingleItemInGroup(arg_11_0, arg_11_1)
	arg_11_0._groupItems = arg_11_0._groupItems or {}

	local var_11_0 = arg_11_0._groupItems[arg_11_1]

	if not var_11_0 then
		var_11_0 = AchievementMainIcon.New()

		local var_11_1 = arg_11_0._view:getResInst(AchievementEnum.MainIconPath, arg_11_0._gogroupcontainer, "#go_icon" .. arg_11_1)

		var_11_0:init(var_11_1)

		arg_11_0._groupItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0._setGroupAchievementPosAndScale(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0, var_12_1, var_12_2, var_12_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_12_2, arg_12_3, AchievementEnum.GroupParamType.List)

	if arg_12_1 then
		recthelper.setAnchor(arg_12_1.transform, var_12_0 or 0, var_12_1 or 0)
		transformhelper.setLocalScale(arg_12_1.transform, var_12_2 or 1, var_12_3 or 1, 1)
	end
end

var_0_0.IconStartX = -535
var_0_0.IconIntervalX = 265

function var_0_0.checkInitSingle(arg_13_0)
	if arg_13_0._singleItems then
		return
	end

	arg_13_0._singleItems = {}

	for iter_13_0 = 1, AchievementEnum.MainListLineCount do
		local var_13_0 = AchievementSelectIcon.New()
		local var_13_1 = gohelper.cloneInPlace(arg_13_0._gosingleitem, "item" .. tostring(iter_13_0))
		local var_13_2 = arg_13_0._view:getResInst(AchievementEnum.MainIconPath, var_13_1, "#go_icon")

		var_13_0:init(var_13_1, var_13_2)

		local var_13_3 = var_13_1.transform

		recthelper.setAnchorX(var_13_3, var_0_0.IconStartX + (iter_13_0 - 1) * var_0_0.IconIntervalX)

		arg_13_0._singleItems[iter_13_0] = var_13_0
	end
end

function var_0_0._btngroupselectOnClick(arg_14_0)
	AchievementSelectController.instance:changeGroupSelect(arg_14_0._mo.groupId)

	local var_14_0 = AchievementSelectListModel.instance:isGroupSelected(arg_14_0._mo.groupId)

	AudioMgr.instance:trigger(var_14_0 and AudioEnum.UI.play_ui_hero_card_click or AudioEnum.UI.play_ui_hero_card_gone)
end

var_0_0.AnimDelayDelta = 0.06
var_0_0.OneScreenItemCountInSingle = 3
var_0_0.OneScreenItemCountInGroup = 2

function var_0_0._playAnim(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._playItemOpenAim, arg_15_0)
	arg_15_0._anim:Play("close", 0, 0)

	local var_15_0 = AchievementSelectListModel.instance:getItemAniHasShownIndex()

	if (arg_15_0._mo.groupId ~= 0 and var_0_0.OneScreenItemCountInGroup or var_0_0.OneScreenItemCountInSingle) >= arg_15_0._index and var_15_0 < arg_15_0._index then
		TaskDispatcher.runDelay(arg_15_0._playItemOpenAim, arg_15_0, var_0_0.AnimDelayDelta * (arg_15_0._index - 1))
	else
		arg_15_0._anim:Play("idle", 0, 0)
	end
end

function var_0_0._playItemOpenAim(arg_16_0)
	arg_16_0._anim:Play("open", 0, 0)
	AchievementSelectListModel.instance:setItemAniHasShownIndex(arg_16_0._index)
end

return var_0_0
