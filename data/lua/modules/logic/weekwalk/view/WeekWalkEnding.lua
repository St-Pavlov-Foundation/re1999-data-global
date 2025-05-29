module("modules.logic.weekwalk.view.WeekWalkEnding", package.seeall)

local var_0_0 = class("WeekWalkEnding", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._scrollnull = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	arg_1_0._gostartemplate = gohelper.findChild(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewAnim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animator = arg_4_0._gofinish:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._mapId = WeekWalkModel.instance:getCurMapId()
	arg_4_0._animEventWrap = arg_4_0._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_4_0._animEventWrap:AddEventListener("star", arg_4_0._startShowStars, arg_4_0)
end

function var_0_0._startShowStars(arg_5_0)
	if not arg_5_0._starList then
		return
	end

	arg_5_0:_starsAppear()
end

function var_0_0._starsAppear(arg_6_0)
	arg_6_0._curAppearIndex = 1

	TaskDispatcher.cancelTask(arg_6_0._oneStarAppear, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._oneStarAppear, arg_6_0, 0.12)
end

function var_0_0._oneStarAppear(arg_7_0)
	local var_7_0 = arg_7_0._starList[arg_7_0._curAppearIndex]

	gohelper.setActive(var_7_0, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success_star)

	arg_7_0._curAppearIndex = arg_7_0._curAppearIndex + 1

	if arg_7_0._curAppearIndex > arg_7_0._curNum then
		TaskDispatcher.cancelTask(arg_7_0._oneStarAppear, arg_7_0)
	end
end

function var_0_0._addStarList(arg_8_0)
	arg_8_0._starList = arg_8_0:getUserDataTb_()

	local var_8_0 = arg_8_0._maxNum

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = gohelper.cloneInPlace(arg_8_0._gostartemplate)

		gohelper.setActive(var_8_1, true)

		local var_8_2 = gohelper.findChild(var_8_1, "star")

		gohelper.setActive(var_8_2, false)
		table.insert(arg_8_0._starList, var_8_2)
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, arg_9_0._onWeekwalkResetLayer, arg_9_0)
	arg_9_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, arg_9_0._onWeekwalkInfoUpdate, arg_9_0)
	arg_9_0:_showFinishAnim()
end

function var_0_0._onWeekwalkResetLayer(arg_10_0)
	gohelper.setActive(arg_10_0._gofinish, false)
end

function var_0_0._onWeekwalkInfoUpdate(arg_11_0)
	arg_11_0:_showFinishAnim()
end

function var_0_0._showFinishAnim(arg_12_0)
	arg_12_0._mapInfo = WeekWalkModel.instance:getCurMapInfo()

	if not arg_12_0._mapInfo then
		return
	end

	arg_12_0._curNum, arg_12_0._maxNum = arg_12_0._mapInfo:getCurStarInfo()

	if not WeekWalkView._canShowFinishAnim(arg_12_0._mapId) then
		arg_12_0:_onShowFinishAnimDone()

		return
	end

	arg_12_0:_addStarList()

	if arg_12_0._mapInfo.isFinished == 1 then
		WeekWalkModel.instance:setFinishMapId(arg_12_0._mapId)
	end

	WeekwalkRpc.instance:sendMarkShowFinishedRequest()

	if arg_12_0._mapInfo:getLayer() == WeekWalkEnum.LastShallowLayer then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnAllShallowLayerFinish)
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_challenge_success)
	gohelper.setActive(arg_12_0._gofinish, true)

	arg_12_0._viewAnim.enabled = true

	local var_12_0 = 2.83

	if arg_12_0._curNum == arg_12_0._maxNum then
		arg_12_0._animator:Play("ending2")
		arg_12_0._viewAnim:Play("finish_map2")

		var_12_0 = var_12_0 + 2
	else
		arg_12_0._animator:Play("ending1")
		arg_12_0._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(arg_12_0._closeFinishAnim, arg_12_0, var_12_0)

	arg_12_0._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(arg_12_0._checkAnimClip, arg_12_0, 0)
end

function var_0_0._checkAnimClip(arg_13_0)
	if arg_13_0._isPlayMapFinishClip then
		TaskDispatcher.cancelTask(arg_13_0._checkAnimClip, arg_13_0)

		return
	end

	if arg_13_0._animator:GetCurrentAnimatorStateInfo(0):IsName("open") then
		arg_13_0._isPlayMapFinishClip = true

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	end
end

function var_0_0._closeFinishAnim(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._checkAnimClip, arg_14_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(arg_14_0._gofinish, arg_14_0._curNum == arg_14_0._maxNum)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnShowFinishAnimDone)
	arg_14_0:_onShowFinishAnimDone()
end

function var_0_0._onShowFinishAnimDone(arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._showIdle, arg_15_0, 0)

	if WaitGuideActionOpenViewWithCondition.weekWalkFinishLayer() then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideFinishLayer)
	end
end

function var_0_0._showIdle(arg_16_0)
	if arg_16_0._mapInfo.isFinish == 1 and arg_16_0._curNum == arg_16_0._maxNum then
		gohelper.setActive(arg_16_0._gofinish, true)
		arg_16_0._animator:Play(UIAnimationName.Idle)
	end
end

function var_0_0.onClose(arg_17_0)
	gohelper.setActive(arg_17_0._gofinish, false)
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._checkAnimClip, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._oneStarAppear, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._closeFinishAnim, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._showIdle, arg_18_0)
	arg_18_0._animEventWrap:RemoveAllEventListener()
end

return var_0_0
