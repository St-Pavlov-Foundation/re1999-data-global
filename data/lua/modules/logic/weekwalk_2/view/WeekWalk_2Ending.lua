module("modules.logic.weekwalk_2.view.WeekWalk_2Ending", package.seeall)

local var_0_0 = class("WeekWalk_2Ending", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._scrollnull = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null")
	arg_1_0._gostartemplate = gohelper.findChild(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist/#go_star_template")
	arg_1_0._gostartemplate2 = gohelper.findChild(arg_1_0.viewGO, "#go_finish/weekwalkending/#scroll_null/starlist2/#go_star_template2")

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
	arg_4_0._mapId = WeekWalk_2Model.instance:getCurMapId()
	arg_4_0._animEventWrap = arg_4_0._gofinish:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_4_0._animEventWrap:AddEventListener("star", arg_4_0._startShowStars, arg_4_0)

	arg_4_0._time2 = 0.2
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

	local var_7_1 = arg_7_0._starList[arg_7_0._curAppearIndex + arg_7_0._maxGroupNnum]

	gohelper.setActive(var_7_1, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_LuckDraw_Hero_Stars)

	arg_7_0._curAppearIndex = arg_7_0._curAppearIndex + 1

	if arg_7_0._curAppearIndex > arg_7_0._maxGroupNnum then
		TaskDispatcher.cancelTask(arg_7_0._oneStarAppear, arg_7_0)
	end
end

function var_0_0._addStarList(arg_8_0)
	arg_8_0._starList = arg_8_0:getUserDataTb_()

	local var_8_0 = WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(arg_8_0._mapId, WeekWalk_2Enum.BattleIndex.First)
	local var_8_1 = WeekWalk_2Model.instance:getBattleInfoByIdAndIndex(arg_8_0._mapId, WeekWalk_2Enum.BattleIndex.Second)
	local var_8_2 = arg_8_0._maxNum

	for iter_8_0 = 1, var_8_2 do
		local var_8_3 = iter_8_0 <= WeekWalk_2Enum.MaxStar
		local var_8_4 = var_8_3 and gohelper.cloneInPlace(arg_8_0._gostartemplate) or gohelper.cloneInPlace(arg_8_0._gostartemplate2)

		gohelper.setActive(var_8_4, true)

		local var_8_5 = gohelper.findChild(var_8_4, "star")

		gohelper.setActive(var_8_5, false)

		local var_8_6 = gohelper.findChildImage(var_8_4, "star/xingxing")

		var_8_6.enabled = false

		local var_8_7 = arg_8_0.viewContainer:getResInst(arg_8_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_8_6.gameObject)

		if var_8_3 then
			WeekWalk_2Helper.setCupEffect(var_8_7, var_8_0:getCupInfo(iter_8_0))
		else
			WeekWalk_2Helper.setCupEffect(var_8_7, var_8_1:getCupInfo(iter_8_0 - WeekWalk_2Enum.MaxStar))
		end

		table.insert(arg_8_0._starList, var_8_5)
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnWeekwalkResetLayer, arg_9_0._onWeekwalkResetLayer, arg_9_0)
	arg_9_0:_showFinishAnim()
end

function var_0_0._onWeekwalkResetLayer(arg_10_0)
	gohelper.setActive(arg_10_0._gofinish, false)
end

function var_0_0._onWeekwalkInfoUpdate(arg_11_0)
	arg_11_0:_showFinishAnim()
end

function var_0_0._showFinishAnim(arg_12_0)
	arg_12_0._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()

	if not arg_12_0._mapInfo then
		return
	end

	arg_12_0._maxGroupNnum = WeekWalk_2Enum.MaxStar
	arg_12_0._curNum, arg_12_0._maxNum = 6, 6

	if not arg_12_0._mapInfo.allPass or not not arg_12_0._mapInfo.showFinished then
		arg_12_0:_onShowFinishAnimDone()

		return
	end

	TaskDispatcher.runDelay(arg_12_0._playPadAudio, arg_12_0, arg_12_0._time2)
	arg_12_0:_addStarList()

	if not arg_12_0._mapInfo.showFinished then
		WeekWalk_2Model.instance:setFinishMapId(arg_12_0._mapId)
	end

	Weekwalk_2Rpc.instance:sendWeekwalkVer2MarkShowFinishedRequest(arg_12_0._mapId)

	arg_12_0._mapInfo.showFinished = true

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showFinishAnim")
	gohelper.setActive(arg_12_0._gofinish, true)

	arg_12_0._viewAnim.enabled = true

	local var_12_0 = 3.7

	if arg_12_0._curNum == arg_12_0._maxNum then
		arg_12_0._animator:Play("ending2")
		arg_12_0._viewAnim:Play("finish_map2")
	else
		arg_12_0._animator:Play("ending1")
		arg_12_0._viewAnim:Play("finish_map1")
	end

	TaskDispatcher.runDelay(arg_12_0._closeFinishAnim, arg_12_0, var_12_0)

	arg_12_0._isPlayMapFinishClip = nil

	TaskDispatcher.runRepeat(arg_12_0._checkAnimClip, arg_12_0, 0)
end

function var_0_0._playPadAudio(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_stars_pad)
end

function var_0_0._checkAnimClip(arg_14_0)
	if arg_14_0._isPlayMapFinishClip then
		TaskDispatcher.cancelTask(arg_14_0._checkAnimClip, arg_14_0)

		return
	end

	if arg_14_0._animator:GetCurrentAnimatorStateInfo(0):IsName("open") then
		arg_14_0._isPlayMapFinishClip = true

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_mapfinish)
	end
end

function var_0_0._closeFinishAnim(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._checkAnimClip, arg_15_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("showFinishAnim")
	gohelper.setActive(arg_15_0._gofinish, arg_15_0._curNum == arg_15_0._maxNum)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnShowFinishAnimDone)
	arg_15_0:_onShowFinishAnimDone()
end

function var_0_0._onShowFinishAnimDone(arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._showIdle, arg_16_0, 0)
end

function var_0_0._showIdle(arg_17_0)
	if arg_17_0._mapInfo.allPass and arg_17_0._curNum == arg_17_0._maxNum then
		gohelper.setActive(arg_17_0._gofinish, true)
		arg_17_0._animator:Play(UIAnimationName.Idle)
	end
end

function var_0_0.onClose(arg_18_0)
	gohelper.setActive(arg_18_0._gofinish, false)
	TaskDispatcher.cancelTask(arg_18_0._playPadAudio, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._checkAnimClip, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._oneStarAppear, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._closeFinishAnim, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._showIdle, arg_19_0)
	arg_19_0._animEventWrap:RemoveAllEventListener()
end

return var_0_0
