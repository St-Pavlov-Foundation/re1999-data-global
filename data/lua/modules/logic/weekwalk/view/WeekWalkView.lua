module("modules.logic.weekwalk.view.WeekWalkView", package.seeall)

slot0 = class("WeekWalkView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._simagefinishbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_finish/#simage_finishbg")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_reward")
	slot0._gorewardredpoint = gohelper.findChild(slot0.viewGO, "GameObject/#btn_reward/#go_rewardredpoint")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_detail")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "GameObject/#btn_reset")
	slot0._txtcurprogress = gohelper.findChildText(slot0.viewGO, "levelbg/#txt_curprogress")
	slot0._simagebgimgnext = gohelper.findChildSingleImage(slot0.viewGO, "transition/ani/#simage_bgimg_next")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	WeekWalkController.instance:openWeekWalkResetView()
end

function slot0._btnrewardOnClick(slot0)
	WeekWalkController.instance:openWeekWalkLayerRewardView({
		mapId = slot0._mapInfo.id
	})
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(slot0._mapInfo.id)
end

function slot0._editableInitView(slot0)
	slot0._mapId = WeekWalkModel.instance:getCurMapId()
	slot0._mapInfo = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	slot0._mapConfig = WeekWalkConfig.instance:getMapConfig(slot0._mapId)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simagefinishbg:LoadImage(ResUrl.getWeekWalkBg("bg_di.png"))
	slot0._simagebgimgnext:LoadImage(ResUrl.getWeekWalkBg("bg3.png"))
	slot0:_showDetail()
	slot0:_updateReward()
	gohelper.addUIClickAudio(slot0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
	gohelper.addUIClickAudio(slot0._btnreward.gameObject, AudioEnum.UI.Play_UI_Mainback)
	gohelper.addUIClickAudio(slot0._btnreset.gameObject, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function slot0._showDetail(slot0)
	gohelper.setActive(slot0._btndetail.gameObject, lua_weekwalk_type.configDict[slot0._mapConfig.type].showDetail > 0 or WeekWalkModel.instance:getCurMapInfo().isFinish > 0)
end

function slot0._updateReward(slot0)
	slot1 = slot0._mapConfig.id
	slot3, slot4 = WeekWalkTaskListModel.instance:canGetRewardNum(WeekWalkRewardView.getTaskType(slot1), slot1)

	gohelper.setActive(slot0._gorewardredpoint, slot3 > 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._showRevive(slot0)
	if slot0._mapInfo.isShowSelectCd then
		WeekWalkController.instance:openWeekWalkReviveView()
	end
end

function slot0._showBuff(slot0, slot1)
	if slot0._mapInfo.buffId and slot2 > 0 and slot0._mapInfo.isShowBuff then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onSelectTarotViewClose, slot0)

		if slot1 then
			TaskDispatcher.runDelay(slot0._delayShowTarotView, slot0, 0)
		else
			slot0:_delayShowTarotView()
		end

		return
	end

	slot0:_onWeekWalkSelectTarotViewClose()
end

function slot0._delayShowTarotView(slot0)
	ViewMgr.instance:openView(ViewName.WeekWalkSelectTarotView, {
		buffId = slot0._mapInfo.buffId
	})
end

function slot0._onSelectTarotViewClose(slot0, slot1, slot2)
	if slot1 == ViewName.WeekWalkSelectTarotView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onSelectTarotViewClose, slot0)
		slot0:_onWeekWalkSelectTarotViewClose()
	end
end

function slot0._onWeekWalkSelectTarotViewClose(slot0)
	slot0.viewContainer:getWeekWalkMap():_playEnterAnim()
end

function slot0.onOpen(slot0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetBuffReward, slot0._OnGetBuffReward, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, slot0._onWeekwalkInfoUpdate, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._onGetInfo, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, slot0._onWeekwalkResetLayer, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, slot0._onWeekwalkTaskUpdate, slot0)
	slot0:_checkExpire()
	slot0:_showBuff(true)
	slot0:_showRevive()
end

function slot0.onOpenFinish(slot0)
	slot0.viewContainer:getNavBtnView():setHelpId(slot0._mapId <= 105 and 11302 or 11303)
end

function slot0._onWeekwalkTaskUpdate(slot0)
	slot0:_updateReward()
end

function slot0._onWeekwalkResetLayer(slot0)
	slot0._mapInfo = WeekWalkModel.instance:getMapInfo(slot0._mapId)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("transition", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_mist)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.WeekWalkResetView then
		slot0:_showBuff()
	end
end

function slot0._onGetInfo(slot0)
	slot0:_checkExpire(true)
end

function slot0._checkExpire(slot0, slot1)
	if WeekWalkModel.instance:infoNeedUpdate() or slot1 then
		WeekWalkModel.instance:clearOldInfo()

		if WeekWalkModel.isShallowLayer(slot0._mapConfig.layer) then
			return
		end

		UIBlockMgr.instance:startBlock("WeekWalkView _checkExpire")
		TaskDispatcher.runDelay(slot0._exitView, slot0, 0.5)
	end
end

function slot0._exitView(slot0)
	UIBlockMgr.instance:endBlock("WeekWalkView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function ()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView,
			ViewName.WeekWalkLayerView
		})
	end, nil, )
end

function slot0._setEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._gofullscreen, slot1)
end

function slot0._onWeekwalkInfoUpdate(slot0)
	slot0:_showDetail()
end

function slot0._canShowFinishAnim(slot0)
	if not WeekWalkModel.instance:getMapInfo(slot0) then
		return true
	end

	if not (slot1.isFinish == 1) then
		return
	end

	if not slot1.isShowFinished then
		return
	end

	return true
end

function slot0._OnGetBuffReward(slot0)
	TaskDispatcher.runDelay(slot0._showBuff, slot0, 1.4)
end

function slot0._showCurProgress(slot0)
	slot0._txtcurprogress.text = lua_weekwalk_scene.configDict[WeekWalkModel.instance:getCurMapInfo().sceneId].name
end

function slot0._onCloseFullView(slot0, slot1)
	if slot0._viewAnim and slot0:isEnterWeekWalkView() then
		slot0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function slot0.isEnterWeekWalkView(slot0)
	for slot5 = #ViewMgr.instance:getOpenViewNameList(), 1, -1 do
		if ViewMgr.instance:getSetting(slot1[slot5]).layer == ViewMgr.instance:getSetting(slot0.viewName).layer then
			return slot1[slot5] == slot0.viewName
		end
	end

	return false
end

function slot0.onClose(slot0)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	TaskDispatcher.cancelTask(slot0._exitView, slot0)
	TaskDispatcher.cancelTask(slot0._showBuff, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowTarotView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onSelectTarotViewClose, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagefinishbg:UnLoadImage()
	slot0._simagebgimgnext:UnLoadImage()
end

return slot0
