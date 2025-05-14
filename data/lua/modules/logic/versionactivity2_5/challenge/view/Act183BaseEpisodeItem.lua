module("modules.logic.versionactivity2_5.challenge.view.Act183BaseEpisodeItem", package.seeall)

local var_0_0 = class("Act183BaseEpisodeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._golock = gohelper.findChild(arg_1_0.go, "go_lock")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "go_unlock")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.go, "go_finish")
	arg_1_0._gocheck = gohelper.findChild(arg_1_0.go, "go_finish/image")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.go, "btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "go_select")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.go, "image_icon")
	arg_1_0._animfinish = gohelper.onceAddComponent(arg_1_0._gofinish, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, arg_2_0._onSelectEpisode, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_ClickEpisode)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode, arg_4_0._episodeId)
end

function var_0_0._onSelectEpisode(arg_5_0, arg_5_1)
	arg_5_0:onSelect(arg_5_1 == arg_5_0._episodeId)
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goselect, arg_6_1)
end

function var_0_0.onUpdateMo(arg_7_0, arg_7_1)
	arg_7_0._episodeMo = arg_7_1
	arg_7_0._status = arg_7_1:getStatus()
	arg_7_0._episodeId = arg_7_1:getEpisodeId()

	local var_7_0 = Act183Model.instance:getNewFinishEpisodeId()

	arg_7_0._isFinishedButNotNew = arg_7_0._status == Act183Enum.EpisodeStatus.Finished and var_7_0 ~= arg_7_0._episodeId

	gohelper.setActive(arg_7_0._goselect, false)
	gohelper.setActive(arg_7_0._golock, arg_7_0._status == Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_7_0._gounlock, arg_7_0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_7_0._gofinish, arg_7_0._isFinishedButNotNew)
	Act183Helper.setEpisodeIcon(arg_7_0._episodeId, arg_7_0._status, arg_7_0._simageicon)
	arg_7_0:setVisible(true)
	arg_7_0:setCheckIconPosition()
end

function var_0_0.getConfigOrder(arg_8_0)
	local var_8_0 = arg_8_0._episodeMo and arg_8_0._episodeMo:getConfig()

	return var_8_0 and var_8_0.order
end

function var_0_0.setVisible(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.go, arg_9_1)
end

function var_0_0.getIconTran(arg_10_0)
	return arg_10_0._simageicon.transform
end

function var_0_0.playFinishAnim(arg_11_0)
	gohelper.setActive(arg_11_0._gofinish, true)
	arg_11_0._animfinish:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished)
end

function var_0_0.setCheckIconPosition(arg_12_0)
	if arg_12_0._status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local var_12_0 = arg_12_0:getConfigOrder()
	local var_12_1 = arg_12_0:_getCheckIconPosAndRotConfig(var_12_0)
	local var_12_2 = var_12_1 and var_12_1[1] or 0
	local var_12_3 = var_12_1 and var_12_1[2] or 0
	local var_12_4 = var_12_1 and var_12_1[3] or 0
	local var_12_5 = var_12_1 and var_12_1[4] or 0
	local var_12_6 = var_12_1 and var_12_1[5] or 0

	transformhelper.setLocalRotation(arg_12_0._gocheck.transform, var_12_4, var_12_5, var_12_6)
	recthelper.setAnchor(arg_12_0._gocheck.transform, var_12_2, var_12_3)
end

function var_0_0._getCheckIconPosAndRotConfig(arg_13_0, arg_13_1)
	return {
		0,
		0,
		0,
		0,
		0
	}
end

function var_0_0.onDestroy(arg_14_0)
	return
end

return var_0_0
