module("modules.logic.versionactivity2_5.challenge.view.enter.Act183DailyGroupEntranceItem", package.seeall)

local var_0_0 = class("Act183DailyGroupEntranceItem", Act183BaseGroupEntranceItem)

function var_0_0.Get(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_2 and arg_1_2:getGroupType()
	local var_1_1 = "daily_" .. arg_1_3
	local var_1_2 = "root/right/#scroll_daily/Viewport/Content/" .. var_1_1
	local var_1_3 = gohelper.findChild(arg_1_0, var_1_2)

	if gohelper.isNil(var_1_3) then
		var_1_3 = gohelper.cloneInPlace(arg_1_1, var_1_1)
	end

	local var_1_4 = Act183Enum.GroupEntranceItemClsType[var_1_0]

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_3, var_1_4, arg_1_3)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._golock = gohelper.findChild(arg_2_1, "go_lock")
	arg_2_0._gounlock = gohelper.findChild(arg_2_1, "go_unlock")
	arg_2_0._goempty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0._gofinish = gohelper.findChild(arg_2_1, "go_unlock/go_Finished")
	arg_2_0._txtunlocktime = gohelper.findChildText(arg_2_1, "go_lock/txt_unlocktime")
	arg_2_0._txtindex = gohelper.findChildText(arg_2_1, "go_unlock/txt_index")
	arg_2_0._txtprogress = gohelper.findChildText(arg_2_1, "go_unlock/txt_progress")
	arg_2_0._btnclick = gohelper.findChildButtonWithAudio(arg_2_1, "btn_click")
	arg_2_0._animlock = gohelper.onceAddComponent(arg_2_0._golock, gohelper.Type_Animator)
	arg_2_0._animfinish = gohelper.onceAddComponent(arg_2_0._gofinish, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	if not arg_5_0._groupMo then
		return
	end

	if arg_5_0._status == Act183Enum.GroupStatus.Locked then
		GameFacade.showToast(ToastEnum.Act183GroupNotOpen)

		return
	end

	local var_5_0 = arg_5_0._groupMo:getGroupId()
	local var_5_1 = Act183Helper.generateDungeonViewParams(Act183Enum.GroupType.Daily, var_5_0)

	Act183Controller.instance:openAct183DungeonView(var_5_1)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	var_0_0.super.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._status == Act183Enum.GroupStatus.Locked

	gohelper.setActive(arg_7_0._golock, false)
	gohelper.setActive(arg_7_0._goempty, var_7_0)
	gohelper.setActive(arg_7_0._gounlock, not var_7_0)

	if not var_7_0 then
		local var_7_1, var_7_2 = Act183Helper.getGroupEpisodeTaskProgress(arg_7_0._actId, arg_7_0._groupId)
		local var_7_3 = var_7_1 <= var_7_2

		arg_7_0._txtindex.text = string.format("<color=#E1E1E14D>RT</color><color=#E1E1E180><size=77>%s</size></color>", arg_7_0._index)
		arg_7_0._txtprogress.text = string.format("%s/%s", var_7_2, var_7_1)

		gohelper.setActive(arg_7_0._gofinish, var_7_3)
		arg_7_0:tryPlayUnlockAnim()
	end
end

function var_0_0.showUnlockCountDown(arg_8_0)
	if not (arg_8_0._status == Act183Enum.GroupStatus.Locked) then
		return
	end

	gohelper.setActive(arg_8_0._goempty, false)
	gohelper.setActive(arg_8_0._golock, true)

	local var_8_0, var_8_1 = TimeUtil.secondToRoughTime(arg_8_0._groupMo:getUnlockRemainTime())

	arg_8_0._txtunlocktime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("v2a5_challenge_mainview_unlock"), var_8_0, var_8_1)
end

function var_0_0.startPlayUnlockAnim(arg_9_0)
	gohelper.setActive(arg_9_0._golock, true)
	arg_9_0._animlock:Play("unlock", 0, 0)
	arg_9_0:onPlayUnlockAnimDone()
end

return var_0_0
