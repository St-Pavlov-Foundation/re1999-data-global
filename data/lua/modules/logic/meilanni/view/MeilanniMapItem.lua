module("modules.logic.meilanni.view.MeilanniMapItem", package.seeall)

local var_0_0 = class("MeilanniMapItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_click")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_finish/btn_story")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "go_lock")
	arg_1_0._godoing = gohelper.findChild(arg_1_0.viewGO, "go_doing")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "go_finish")
	arg_1_0._imagegrade = gohelper.findChildImage(arg_1_0.viewGO, "image_grade")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
end

function var_0_0._btnstoryOnClick(arg_4_0)
	var_0_0.playStoryList(arg_4_0._mapIndex)
end

function var_0_0.playStoryList(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_activity108_story.configList) do
		if iter_5_1.bind == arg_5_0 then
			table.insert(var_5_0, iter_5_1.story)
		end
	end

	if not var_5_0 or #var_5_0 < 1 then
		return
	end

	StoryController.instance:playStories(var_5_0)
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0._lockStatus then
		arg_6_0:_showLockToast(arg_6_0._mapConfig)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	var_0_0.gotoMap(arg_6_0._mapId)
end

function var_0_0.gotoMap(arg_7_0)
	local var_7_0 = MeilanniModel.instance:getMapInfo(arg_7_0)

	if not var_7_0 or var_7_0:checkFinish() then
		MeilanniController.instance:openMeilanniEntrustView({
			mapId = arg_7_0
		})

		return
	end

	MeilanniController.instance:openMeilanniView({
		mapId = arg_7_0
	})
end

function var_0_0.ctor(arg_8_0, arg_8_1)
	arg_8_0._mapConfig = arg_8_1
	arg_8_0._mapId = arg_8_0._mapConfig.id
	arg_8_0._mapIndex = arg_8_0._mapId - 100
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.updateLockStatus(arg_10_0)
	if arg_10_0._needPlayUnlockAnim then
		return
	end

	gohelper.setActive(arg_10_0._godoing, false)
	gohelper.setActive(arg_10_0._gofinish, false)

	local var_10_0 = arg_10_0._lockStatus

	arg_10_0._lockStatus = var_0_0.isLock(arg_10_0._mapConfig)

	gohelper.setActive(arg_10_0._golock, arg_10_0._lockStatus)
	gohelper.setActive(arg_10_0._imagegrade.gameObject, false)

	if arg_10_0._lockStatus then
		return
	end

	local var_10_1 = MeilanniModel.instance:getMapInfo(arg_10_0._mapId)

	if var_10_1 and var_10_1.highestScore > 0 then
		gohelper.setActive(arg_10_0._imagegrade.gameObject, true)

		local var_10_2 = MeilanniConfig.instance:getScoreIndex(var_10_1.highestScore)

		UISpriteSetMgr.instance:setMeilanniSprite(arg_10_0._imagegrade, "bg_pingfen_xiao_" .. tostring(var_10_2))
		gohelper.setActive(arg_10_0._gofinish, true)
		gohelper.setActive(arg_10_0._godoing, false)
	else
		gohelper.setActive(arg_10_0._gofinish, false)
		gohelper.setActive(arg_10_0._godoing, true)
	end

	if var_10_0 then
		arg_10_0._needPlayUnlockAnim = true
	end

	if arg_10_0._needPlayUnlockAnim then
		gohelper.setActive(arg_10_0._golock, true)
		TaskDispatcher.runDelay(arg_10_0._playUnlockAnim, arg_10_0, 0.5)
	end
end

function var_0_0._playUnlockAnim(arg_11_0)
	arg_11_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_11_0.viewGO)

	arg_11_0._animatorPlayer:Play("unlock", arg_11_0._unlockDone, arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)
end

function var_0_0._unlockDone(arg_12_0)
	arg_12_0._needPlayUnlockAnim = nil

	gohelper.setActive(arg_12_0._golock, false)
end

function var_0_0.isLock(arg_13_0)
	if arg_13_0.preId <= 0 then
		return false
	end

	if MeilanniModel.instance:getMapInfo(arg_13_0.id) then
		return false
	end

	if arg_13_0.onlineDay > 0 and ActivityModel.instance:getActMO(MeilanniEnum.activityId):getRealStartTimeStamp() + (arg_13_0.onlineDay - 1) * 86400 - ServerTime.now() > 0 then
		return true
	end

	local var_13_0 = MeilanniModel.instance:getMapInfo(arg_13_0.preId)

	return not var_13_0 or not (var_13_0.highestScore > 0)
end

function var_0_0._showLockToast(arg_14_0, arg_14_1)
	if arg_14_1.onlineDay > 0 then
		local var_14_0 = ActivityModel.instance:getActMO(MeilanniEnum.activityId):getRealStartTimeStamp() + (arg_14_1.onlineDay - 1) * 86400 - ServerTime.now()

		if var_14_0 > 86400 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock2, math.ceil(var_14_0 / 86400))

			return
		elseif var_14_0 > 3600 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock3, math.ceil(var_14_0 / 3600))

			return
		elseif var_14_0 > 0 then
			GameFacade.showToast(ToastEnum.MeilanniEntranceLock4)

			return
		end
	end

	if arg_14_1.preId <= 0 then
		return
	end

	local var_14_1 = MeilanniModel.instance:getMapInfo(arg_14_1.preId)

	if not var_14_1 or var_14_1.highestScore <= 0 then
		GameFacade.showToast(ToastEnum.MeilanniEntranceLock5)
	end
end

function var_0_0._editableAddEvents(arg_15_0)
	return
end

function var_0_0._editableRemoveEvents(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._playUnlockAnim, arg_17_0)
end

return var_0_0
