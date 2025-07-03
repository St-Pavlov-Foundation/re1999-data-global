module("modules.logic.versionactivity2_5.challenge.view.dungeon.category.Act183DungeonBaseGroupItem", package.seeall)

local var_0_0 = class("Act183DungeonBaseGroupItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "go_select")
	arg_1_0._txtselecttitle = gohelper.findChildText(arg_1_0.go, "go_select/txt_title")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.go, "go_unselect")
	arg_1_0._txtunselecttitle = gohelper.findChildText(arg_1_0.go, "go_unselect/txt_title")
	arg_1_0._golock = gohelper.findChild(arg_1_0.go, "go_lock")
	arg_1_0._imagelockicon = gohelper.findChildImage(arg_1_0.go, "go_lock/icon")
	arg_1_0._txtlocktitle = gohelper.findChildText(arg_1_0.go, "go_lock/txt_title")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")
	arg_1_0._imageselect = gohelper.findChildImage(arg_1_0.go, "go_select/image_Selected")
	arg_1_0._imageunselect = gohelper.findChildImage(arg_1_0.go, "go_unselect/image_UnSelected")
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.go, "go_lock/image_Locked")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.go, "go_finished")
	arg_1_0._goselect_normaleffect = gohelper.findChild(arg_1_0.go, "go_select/vx_normal")
	arg_1_0._goselect_hardeffect = gohelper.findChild(arg_1_0.go, "go_select/vx_hard")
	arg_1_0._animfinish = gohelper.onceAddComponent(arg_1_0._gofinished, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnClickSwitchGroup, arg_2_0._onClickSwitchGroup, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnGroupAllTaskFinished, arg_2_0._onGroupAllTaskFinished, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._isUnlock then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	gohelper.setActive(arg_4_0._goselect_normaleffect, arg_4_0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_4_0._goselect_hardeffect, arg_4_0._groupType == Act183Enum.GroupType.HardMain)

	if arg_4_0._groupType ~= Act183Enum.GroupType.Daily then
		local var_4_0 = Act183Model.instance:getActivityId()

		Act183Helper.saveLastEnterMainGroupTypeInLocal(var_4_0, arg_4_0._groupType)
	end

	Act183Controller.instance:dispatchEvent(Act183Event.OnClickSwitchGroup, arg_4_0._groupId)
end

function var_0_0._onClickSwitchGroup(arg_5_0, arg_5_1)
	arg_5_0:onSelect(arg_5_0._groupId == arg_5_1)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._groupMo = arg_6_1
	arg_6_0._groupId = arg_6_1:getGroupId()
	arg_6_0._groupType = arg_6_1:getGroupType()
	arg_6_0._status = arg_6_1:getStatus()
	arg_6_0._index = arg_6_2
	arg_6_0._isUnlock = arg_6_0._status ~= Act183Enum.GroupStatus.Locked

	gohelper.setActive(arg_6_0.go, true)
	gohelper.setActive(arg_6_0._golock, not arg_6_0._isUnlock)
	arg_6_0:refreshTitleAndBg()
	arg_6_0:refreshGroupTaskProgress()
end

function var_0_0.refreshTitleAndBg(arg_7_0)
	local var_7_0 = ""
	local var_7_1 = "#E1E1E1"
	local var_7_2 = "#969696"
	local var_7_3 = ""
	local var_7_4 = ""
	local var_7_5

	if arg_7_0._groupType == Act183Enum.GroupType.NormalMain then
		var_7_0 = luaLang("act183dungeonview_normalmainepisode")
		var_7_3 = "v2a5_challenge_dungeon_normaltabselected"
		var_7_5 = "v2a5_challenge_dungeon_normaltabunselected"
	elseif arg_7_0._groupType == Act183Enum.GroupType.HardMain then
		var_7_0 = luaLang("act183dungeonview_hardmainepisode")
		var_7_1 = "#C04E40"
		var_7_2 = "#C04E40"
		var_7_3 = "v2a5_challenge_dungeon_hardtabselected"
		var_7_5 = "v2a5_challenge_dungeon_hardtabunselected"
	else
		var_7_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act183dungeonview_dailyepisode"), GameUtil.getRomanNums(arg_7_0._index))
		var_7_3 = "v2a5_challenge_dungeon_dailytabselected"
		var_7_5 = "v2a5_challenge_dungeon_dailytabunselected"
	end

	arg_7_0._txtselecttitle.text = var_7_0
	arg_7_0._txtunselecttitle.text = var_7_0
	arg_7_0._txtlocktitle.text = var_7_0

	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtselecttitle, var_7_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._txtunselecttitle, var_7_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_7_0._imagelockicon, var_7_2)
	ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtselecttitle, 1)
	ZProj.UGUIHelper.SetColorAlpha(arg_7_0._txtunselecttitle, 0.5)
	UISpriteSetMgr.instance:setChallengeSprite(arg_7_0._imageselect, var_7_3)
	UISpriteSetMgr.instance:setChallengeSprite(arg_7_0._imageunselect, var_7_5)
	UISpriteSetMgr.instance:setChallengeSprite(arg_7_0._imagelock, var_7_5)
	gohelper.setActive(arg_7_0._goselect_normaleffect, arg_7_0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_7_0._goselect_hardeffect, arg_7_0._groupType == Act183Enum.GroupType.HardMain)
end

function var_0_0._onFinishTask(arg_8_0)
	arg_8_0:refreshGroupTaskProgress()
end

function var_0_0.refreshGroupTaskProgress(arg_9_0)
	local var_9_0 = Act183Model.instance:getActivityId()
	local var_9_1, var_9_2 = Act183Helper.getGroupEpisodeTaskProgress(var_9_0, arg_9_0._groupId)
	local var_9_3 = var_9_1 <= var_9_2

	gohelper.setActive(arg_9_0._gofinished, var_9_3)
end

function var_0_0._onGroupAllTaskFinished(arg_10_0, arg_10_1)
	if arg_10_0._groupId ~= arg_10_1 then
		return
	end

	arg_10_0._animfinish:Play("in", 0, 0)
end

function var_0_0.onUnlock(arg_11_0)
	return
end

function var_0_0.onLocked(arg_12_0)
	return
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goselect, arg_13_0._isUnlock and arg_13_1)
	gohelper.setActive(arg_13_0._gounselect, arg_13_0._isUnlock and not arg_13_1)
end

function var_0_0.getHeight(arg_14_0)
	return recthelper.getHeight(arg_14_0.go.transform)
end

function var_0_0.destroySelf(arg_15_0)
	gohelper.destroy(arg_15_0.go)
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0
