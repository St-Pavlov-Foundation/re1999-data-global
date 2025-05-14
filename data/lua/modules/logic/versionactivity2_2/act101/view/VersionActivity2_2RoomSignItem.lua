module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignItem", package.seeall)

local var_0_0 = class("VersionActivity2_2RoomSignItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Root/#txt_title")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "Root/lock")
	arg_1_0._txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Root/lock/#txt_LimitTime")
	arg_1_0._goUnlock = gohelper.findChild(arg_1_0.viewGO, "Root/unlock")
	arg_1_0._simagePic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/unlock/#image_pic")
	arg_1_0._txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Root/unlock/#scroll_ItemList/Viewport/Content/#txt_dec")
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "Root/unlock/#go_reward/go_icon")
	arg_1_0._goHasGet = gohelper.findChild(arg_1_0.viewGO, "Root/unlock/#go_reward/hasget")
	arg_1_0._goCanGet = gohelper.findChild(arg_1_0.viewGO, "Root/unlock/#go_reward/canget")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/lock/btn_click")
	arg_1_0._btnGetReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/unlock/#go_reward/canget")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnLock, arg_2_0.onClickBtnLock, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnGetReward, arg_2_0.onClickBtnReward, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnLock)
	arg_3_0:removeClickCb(arg_3_0._btnGetReward)
end

function var_0_0.onClickBtnLock(arg_4_0)
	arg_4_0:onClickBtn()
end

function var_0_0.onClickBtnReward(arg_5_0)
	arg_5_0:onClickBtn()
end

function var_0_0.onClickBtn(arg_6_0)
	if not arg_6_0.id then
		return
	end

	local var_6_0, var_6_1 = arg_6_0.actInfo:isEpisodeDayOpen(arg_6_0.id)
	local var_6_2 = arg_6_0.actInfo:isEpisodeFinished(arg_6_0.id)

	if var_6_0 and not var_6_2 then
		Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_6_0.activityId, arg_6_0.id, arg_6_0.config.targetFrequency)
	end

	if not var_6_0 then
		GameFacade.showToastString(formatLuaLang("versionactivity_1_2_119_unlock", var_6_1))
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.config = arg_7_1
	arg_7_0.actInfo = arg_7_2
	arg_7_0.activityId = nil
	arg_7_0.id = nil

	gohelper.setActive(arg_7_0.viewGO, arg_7_1 ~= nil)

	if not arg_7_1 then
		TaskDispatcher.cancelTask(arg_7_0._onRefreshDeadline, arg_7_0)

		return
	end

	arg_7_0.activityId = arg_7_0.config.activityId
	arg_7_0.id = arg_7_0.config.id

	if arg_7_0.actInfo:isEpisodeDayOpen(arg_7_0.id) and not arg_7_0.actInfo:checkLocalIsPlay(arg_7_0.id) then
		arg_7_0:refreshItem(false)
		TaskDispatcher.runDelay(arg_7_0.refreshItem, arg_7_0, 0.4)
	else
		arg_7_0:refreshItem()
	end
end

function var_0_0.refreshItem(arg_8_0, arg_8_1)
	local var_8_0 = 506 * arg_8_0._index - 488
	local var_8_1 = -28

	recthelper.setAnchor(arg_8_0.viewGO.transform, var_8_0, var_8_1)
	transformhelper.setEulerAngles(arg_8_0.viewGO.transform, 0, 0, arg_8_0._index % 2 == 1 and -1.64 or 0)

	arg_8_0._txtTitle.text = arg_8_0.config.name
	arg_8_0._txtDesc.text = arg_8_0.config.text

	if arg_8_1 == nil then
		arg_8_1 = arg_8_0.actInfo:isEpisodeDayOpen(arg_8_0.id)
	end

	if arg_8_1 and not arg_8_0.actInfo:checkLocalIsPlay(arg_8_0.id) then
		arg_8_0.actInfo:setLocalIsPlay(arg_8_0.id)
		arg_8_0._anim:Play("unlock")
	end

	gohelper.setActive(arg_8_0._goLock, not arg_8_1)
	gohelper.setActive(arg_8_0._txtTime, not arg_8_1)
	gohelper.setActive(arg_8_0._goUnlock, arg_8_1)

	local var_8_2 = arg_8_0.actInfo:isEpisodeFinished(arg_8_0.id)
	local var_8_3 = arg_8_1 and not var_8_2

	gohelper.setActive(arg_8_0._goHasGet, var_8_2)
	gohelper.setActive(arg_8_0._goCanGet, var_8_3)

	if arg_8_1 then
		arg_8_0._simagePic:LoadImage(string.format("singlebg/v2a2_mainactivity_singlebg/v2a2_room_pic%s.png", arg_8_0.id))
		arg_8_0:refreshIcon()
	end

	arg_8_0:_showDeadline()
end

function var_0_0.refreshIcon(arg_9_0)
	local var_9_0 = GameUtil.splitString2(arg_9_0.config.bonus, true)

	if not arg_9_0.itemIcon then
		arg_9_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_9_0._goIcon)
	end

	local var_9_1 = var_9_0[1]

	if var_9_1 then
		arg_9_0.itemIcon:setMOValue(var_9_1[1], var_9_1[2], var_9_1[3], nil, true)
		arg_9_0.itemIcon:setScale(0.5)
	end
end

function var_0_0._showDeadline(arg_10_0)
	arg_10_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_10_0._onRefreshDeadline, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._onRefreshDeadline, arg_10_0, 1)
end

function var_0_0._onRefreshDeadline(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = arg_11_0.actInfo:isEpisodeDayOpen(arg_11_0.id)

	if var_11_0 then
		TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)
		gohelper.setActive(arg_11_0._txtTime, false)

		return
	end

	if var_11_2 < TimeUtil.OneDaySecond then
		local var_11_3 = TimeUtil.getFormatTime_overseas(var_11_2)

		arg_11_0._txtTime.text = formatLuaLang("season123_overview_unlocktime_custom", var_11_3)
	else
		arg_11_0._txtTime.text = formatLuaLang("season123_overview_unlocktime", var_11_1)
	end
end

function var_0_0.onDestroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshItem, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onRefreshDeadline, arg_12_0)
	arg_12_0._simagePic:UnLoadImage()
end

return var_0_0
