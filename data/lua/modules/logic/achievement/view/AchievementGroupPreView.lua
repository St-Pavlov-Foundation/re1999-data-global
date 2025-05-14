module("modules.logic.achievement.view.AchievementGroupPreView", package.seeall)

local var_0_0 = class("AchievementGroupPreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_view")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnclose2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close2")
	arg_1_0._simagegroupbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_groupbg")
	arg_1_0._goherogroupcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_groupcontainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnview:AddClickListener(arg_2_0._btnviewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclose2:AddClickListener(arg_2_0._btnclose2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnview:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclose2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievements, arg_4_0.refreshGroup, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0:disposeAchievementMainIcon()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achievementgrouppreview_open)
	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._btncloseOnClick, arg_6_0)
	arg_6_0:refreshGroup()
end

var_0_0.LockedIconColor = "#808080"
var_0_0.UnLockedIconColor = "#FFFFFF"
var_0_0.LockedNameAlpha = 0.5
var_0_0.UnLockedNameAlpha = 1

function var_0_0.refreshGroup(arg_7_0)
	arg_7_0:refreshGroupBg()
	arg_7_0:refreshAchievementInGroup()
end

function var_0_0.refreshGroupBg(arg_8_0)
	local var_8_0 = AchievementConfig.instance:getGroup(arg_8_0.viewParam.groupId)

	if var_8_0 then
		local var_8_1 = AchievementModel.instance:isAchievementTaskFinished(var_8_0.unLockAchievement)
		local var_8_2 = AchievementConfig.instance:getGroupBgUrl(arg_8_0.viewParam.groupId, AchievementEnum.GroupParamType.List, var_8_1)

		arg_8_0._simagegroupbg:LoadImage(var_8_2)

		local var_8_3 = AchievementModel.instance:achievementGroupHasLocked(arg_8_0.viewParam.groupId)

		SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._groupBgImage, var_8_3 and var_0_0.LockedGroupBgColor or var_0_0.UnLockedGroupBgColor)
	end
end

function var_0_0.refreshAchievementInGroup(arg_9_0)
	local var_9_0 = AchievementConfig.instance:getGroupParamIdTab(arg_9_0.viewParam.groupId, AchievementEnum.GroupParamType.List)
	local var_9_1 = AchievementConfig.instance:getAchievementsByGroupId(arg_9_0.viewParam.groupId)
	local var_9_2 = {}
	local var_9_3 = false

	for iter_9_0 = 1, #var_9_0 do
		local var_9_4 = var_9_0[iter_9_0]
		local var_9_5 = var_9_1[var_9_4] and var_9_1[var_9_4].id
		local var_9_6 = arg_9_0:getOrCreateAchievementIcon(arg_9_0.viewParam.groupId, var_9_4, iter_9_0)

		var_9_2[var_9_6] = true

		local var_9_7 = AchievementController.instance:getMaxLevelFinishTask(var_9_5)

		gohelper.setActive(var_9_6.viewGO, var_9_7 ~= nil)

		if var_9_7 then
			var_9_6:setData(var_9_7)

			local var_9_8 = AchievementModel.instance:achievementHasLocked(var_9_5)

			var_9_6:setIsLocked(var_9_8)
			var_9_6:setIconColor(var_9_8 and var_0_0.LockedIconColor or var_0_0.UnLockedIconColor)
			var_9_6:setSelectIconVisible(false)
			var_9_6:setNameTxtVisible(false)
			var_9_6:setBgVisible(false)

			local var_9_9 = arg_9_0:playIconAnim(var_9_6, var_9_5)

			var_9_3 = var_9_3 or var_9_9
		end
	end

	if var_9_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_medal)
	end

	if arg_9_0._iconItems then
		for iter_9_1, iter_9_2 in pairs(arg_9_0._iconItems) do
			if not var_9_2[iter_9_2] then
				gohelper.setActive(iter_9_2.viewGO, false)
			end
		end
	end
end

function var_0_0.playIconAnim(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = AchievementModel.instance:achievementHasNew(arg_10_2)
	local var_10_1 = arg_10_1:isPlaingAnimClip(AchievementMainIcon.AnimClip.New)
	local var_10_2 = arg_10_1:isPlaingAnimClip(AchievementMainIcon.AnimClip.Loop)
	local var_10_3 = false

	if var_10_0 then
		if not var_10_1 and not var_10_2 then
			arg_10_1:playAnim(AchievementMainIcon.AnimClip.New)

			var_10_3 = true
		end
	else
		arg_10_1:playAnim(AchievementMainIcon.AnimClip.Idle)
	end

	return var_10_3
end

function var_0_0.getOrCreateAchievementIcon(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._iconItems = arg_11_0._iconItems or {}

	local var_11_0 = arg_11_0._iconItems[arg_11_3]

	if not var_11_0 then
		var_11_0 = AchievementMainIcon.New()

		local var_11_1 = arg_11_0:getResInst(AchievementEnum.MainIconPath, arg_11_0._goherogroupcontainer, "icon" .. tostring(arg_11_3))

		var_11_0:init(var_11_1)
		var_11_0:setClickCall(arg_11_0.onClickAchievementIcon, arg_11_0, arg_11_2)

		arg_11_0._iconItems[arg_11_3] = var_11_0
	end

	arg_11_0:setGroupAchievementPosAndScale(var_11_0.viewGO, arg_11_1, arg_11_3)

	return var_11_0
end

function var_0_0.onClickAchievementIcon(arg_12_0, arg_12_1)
	local var_12_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_12_0.viewParam.groupId)
	local var_12_1 = var_12_0 and var_12_0[arg_12_1]

	if var_12_1 then
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			table.insert(var_12_2, iter_12_1.id)
		end

		local var_12_3 = {
			achievementId = var_12_1.id,
			achievementIds = var_12_2
		}

		ViewMgr.instance:openView(ViewName.AchievementLevelView, var_12_3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_weiqicard_saga)
		arg_12_0:cleanAchievementNewFlag(var_12_1.id)
	end
end

function var_0_0.setGroupAchievementPosAndScale(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0, var_13_1, var_13_2, var_13_3 = AchievementConfig.instance:getAchievementPosAndScaleInGroup(arg_13_2, arg_13_3, AchievementEnum.GroupParamType.List)

	if arg_13_1 then
		recthelper.setAnchor(arg_13_1.transform, var_13_0 or 0, var_13_1 or 0)
		transformhelper.setLocalScale(arg_13_1.transform, var_13_2 or 1, var_13_3 or 1, 1)
	end
end

function var_0_0.disposeAchievementMainIcon(arg_14_0)
	if arg_14_0._iconItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._iconItems) do
			if iter_14_1.dispose then
				iter_14_1:dispose()
			end
		end
	end
end

function var_0_0.cleanGroupNewFlag(arg_15_0)
	local var_15_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_15_0.viewParam.groupId)
	local var_15_1 = {}

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_2 = AchievementModel.instance:getAchievementTaskCoList(iter_15_1.id)

			if var_15_2 then
				for iter_15_2, iter_15_3 in ipairs(var_15_2) do
					local var_15_3 = AchievementModel.instance:getById(iter_15_3.id)

					if var_15_3 and var_15_3.isNew then
						table.insert(var_15_1, iter_15_3.id)
					end
				end
			end
		end
	end

	if #var_15_1 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(var_15_1)
	end
end

function var_0_0.cleanAchievementNewFlag(arg_16_0, arg_16_1)
	local var_16_0 = AchievementConfig.instance:getTasksByAchievementId(arg_16_1)
	local var_16_1 = {}

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_2 = AchievementModel.instance:getById(iter_16_1.id)

			if var_16_2 and var_16_2.isNew then
				table.insert(var_16_1, iter_16_1.id)
			end
		end
	end

	if #var_16_1 > 0 then
		AchievementRpc.instance:sendReadNewAchievementRequest(var_16_1)
	end
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:cleanGroupNewFlag()
end

function var_0_0._btnviewOnClick(arg_18_0)
	local var_18_0 = arg_18_0.viewParam and arg_18_0.viewParam.groupId

	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, var_18_0)
end

function var_0_0._btncloseOnClick(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0._btnclose2OnClick(arg_20_0)
	arg_20_0:closeThis()
end

return var_0_0
