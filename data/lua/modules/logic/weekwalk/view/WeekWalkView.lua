module("modules.logic.weekwalk.view.WeekWalkView", package.seeall)

local var_0_0 = class("WeekWalkView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._simagefinishbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_finish/#simage_finishbg")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_reward")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_detail")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "GameObject/#btn_reset")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "levelbg/#txt_curprogress")
	arg_1_0._simagebgimgnext = gohelper.findChildSingleImage(arg_1_0.viewGO, "transition/ani/#simage_bgimg_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	WeekWalkController.instance:openWeekWalkResetView()
end

function var_0_0._btnrewardOnClick(arg_5_0)
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = arg_5_0._mapInfo.id
	})
end

function var_0_0._btndetailOnClick(arg_6_0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(arg_6_0._mapInfo.id)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._mapId = WeekWalkModel.instance:getCurMapId()
	arg_7_0._mapInfo = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	arg_7_0._mapConfig = WeekWalkConfig.instance:getMapConfig(arg_7_0._mapId)
	arg_7_0._viewAnim = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_7_0._simagefinishbg:LoadImage(ResUrl.getWeekWalkBg("bg_di.png"))
	arg_7_0._simagebgimgnext:LoadImage(ResUrl.getWeekWalkBg("bg3.png"))
	arg_7_0:_showDetail()
	arg_7_0:_updateReward()
	gohelper.addUIClickAudio(arg_7_0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(arg_7_0._btnreward.gameObject, AudioEnum.UI.Play_UI_Mainback)
	gohelper.addUIClickAudio(arg_7_0._btnreset.gameObject, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function var_0_0._showDetail(arg_8_0)
	local var_8_0 = WeekWalkModel.instance:getCurMapInfo()
	local var_8_1 = lua_weekwalk_type.configDict[arg_8_0._mapConfig.type]

	gohelper.setActive(arg_8_0._btndetail.gameObject, var_8_1.showDetail > 0 or var_8_0.isFinish > 0)
end

function var_0_0._updateReward(arg_9_0)
	local var_9_0 = arg_9_0._mapConfig.id
	local var_9_1 = WeekWalkRewardView.getTaskType(var_9_0)
	local var_9_2, var_9_3 = WeekWalkTaskListModel.instance:canGetRewardNum(var_9_1, var_9_0)
	local var_9_4 = var_9_2 > 0

	gohelper.setActive(arg_9_0._gorewardredpoint, var_9_4)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0._showRevive(arg_11_0)
	if arg_11_0._mapInfo.isShowSelectCd then
		WeekWalkController.instance:openWeekWalkReviveView()
	end
end

function var_0_0._showBuff(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._mapInfo.buffId

	if var_12_0 and var_12_0 > 0 and arg_12_0._mapInfo.isShowBuff then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_12_0._onSelectTarotViewClose, arg_12_0)

		if arg_12_1 then
			TaskDispatcher.runDelay(arg_12_0._delayShowTarotView, arg_12_0, 0)
		else
			arg_12_0:_delayShowTarotView()
		end

		return
	end

	arg_12_0:_onWeekWalkSelectTarotViewClose()
end

function var_0_0._delayShowTarotView(arg_13_0)
	local var_13_0 = arg_13_0._mapInfo.buffId

	ViewMgr.instance:openView(ViewName.WeekWalkSelectTarotView, {
		buffId = var_13_0
	})
end

function var_0_0._onSelectTarotViewClose(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == ViewName.WeekWalkSelectTarotView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_14_0._onSelectTarotViewClose, arg_14_0)
		arg_14_0:_onWeekWalkSelectTarotViewClose()
	end
end

function var_0_0._onWeekWalkSelectTarotViewClose(arg_15_0)
	arg_15_0.viewContainer:getWeekWalkMap():_playEnterAnim()
end

function var_0_0.onOpen(arg_16_0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetBuffReward, arg_16_0._OnGetBuffReward, arg_16_0)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, arg_16_0._onWeekwalkInfoUpdate, arg_16_0)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_16_0._onGetInfo, arg_16_0)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSetEpisodeListVisible, arg_16_0._setEpisodeListVisible, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_16_0._onCloseFullView, arg_16_0, LuaEventSystem.Low)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, arg_16_0._onWeekwalkResetLayer, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_16_0._onCloseViewFinish, arg_16_0)
	arg_16_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_16_0._onWeekwalkTaskUpdate, arg_16_0)
	arg_16_0:_checkExpire()
	arg_16_0:_showBuff(true)
	arg_16_0:_showRevive()
end

function var_0_0.onOpenFinish(arg_17_0)
	arg_17_0.viewContainer:getNavBtnView():setHelpId(arg_17_0._mapId <= 105 and 11302 or 11303)
end

function var_0_0._onWeekwalkTaskUpdate(arg_18_0)
	arg_18_0:_updateReward()
end

function var_0_0._onWeekwalkResetLayer(arg_19_0)
	arg_19_0._mapInfo = WeekWalkModel.instance:getMapInfo(arg_19_0._mapId)
	arg_19_0._viewAnim.enabled = true

	arg_19_0._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
end

function var_0_0._onCloseViewFinish(arg_20_0, arg_20_1)
	if arg_20_1 == ViewName.WeekWalkResetView then
		arg_20_0:_showBuff()
	end
end

function var_0_0._onGetInfo(arg_21_0)
	arg_21_0:_checkExpire(true)
end

function var_0_0._checkExpire(arg_22_0, arg_22_1)
	if WeekWalkModel.instance:infoNeedUpdate() or arg_22_1 then
		WeekWalkModel.instance:clearOldInfo()

		if WeekWalkModel.isShallowLayer(arg_22_0._mapConfig.layer) then
			return
		end

		UIBlockMgr.instance:startBlock("WeekWalkView _checkExpire")
		TaskDispatcher.runDelay(arg_22_0._exitView, arg_22_0, 0.5)
	end
end

function var_0_0._exitView(arg_23_0)
	UIBlockMgr.instance:endBlock("WeekWalkView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView,
			ViewName.WeekWalkLayerView
		})
	end, nil, nil)
end

function var_0_0._setEpisodeListVisible(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._gofullscreen, arg_25_1)
end

function var_0_0._onWeekwalkInfoUpdate(arg_26_0)
	arg_26_0:_showDetail()
end

function var_0_0._canShowFinishAnim(arg_27_0)
	local var_27_0 = WeekWalkModel.instance:getMapInfo(arg_27_0)

	if not var_27_0 then
		return true
	end

	if not (var_27_0.isFinish == 1) then
		return
	end

	if not var_27_0.isShowFinished then
		return
	end

	return true
end

function var_0_0._OnGetBuffReward(arg_28_0)
	TaskDispatcher.runDelay(arg_28_0._showBuff, arg_28_0, 1.4)
end

function var_0_0._showCurProgress(arg_29_0)
	local var_29_0 = WeekWalkModel.instance:getCurMapInfo()
	local var_29_1 = lua_weekwalk_scene.configDict[var_29_0.sceneId]

	arg_29_0._txtcurprogress.text = var_29_1.name
end

function var_0_0._onCloseFullView(arg_30_0, arg_30_1)
	if arg_30_0._viewAnim and arg_30_0:isEnterWeekWalkView() then
		arg_30_0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function var_0_0.isEnterWeekWalkView(arg_31_0)
	local var_31_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_31_0 = #var_31_0, 1, -1 do
		if ViewMgr.instance:getSetting(var_31_0[iter_31_0]).layer == ViewMgr.instance:getSetting(arg_31_0.viewName).layer then
			return var_31_0[iter_31_0] == arg_31_0.viewName
		end
	end

	return false
end

function var_0_0.onClose(arg_32_0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	TaskDispatcher.cancelTask(arg_32_0._exitView, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._showBuff, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._delayShowTarotView, arg_32_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_32_0._onSelectTarotViewClose, arg_32_0)
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._simagefinishbg:UnLoadImage()
	arg_33_0._simagebgimgnext:UnLoadImage()
end

return var_0_0
