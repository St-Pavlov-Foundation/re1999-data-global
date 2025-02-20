module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapView", package.seeall)

slot0 = class("VersionActivity1_3DungeonMapView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._simagefullmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullmask")
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "top_left")
	slot0._topRightGo = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._topLeftElementGo = gohelper.findChild(slot0.viewGO, "top_left_element")
	slot0._goversionactivity = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")
	slot0._gores = gohelper.findChild(slot0.viewGO, "#go_res")
	slot0._btnactivitybuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitybuff")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	slot0._gointeractiveroot = gohelper.findChild(slot0.viewGO, "#go_interactive_root")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnactivitybuff:AddClickListener(slot0.btnActivityBuffOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnactivitybuff:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
end

function slot0.btnActivityBuffOnClick(slot0)
	VersionActivity1_3BuffController.instance:openBuffView()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnactivitybuff, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101))
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goversionactivity, true)
	slot0:_updateBtns()
	gohelper.setActive(slot0._gomain, false)
	gohelper.setActive(slot0._gores, false)

	slot0.btnBuffAnimator = slot0._btnactivitybuff.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0.modeAnimator = slot0._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	slot0.txtTaskGet = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	slot0.goTaskRedDot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	slot0.goAstrologyRedDot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activityastrology/#go_reddot")
	slot0.goBuffRedDot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitybuff/#go_reddot")

	RedDotController.instance:addRedDot(slot0.goTaskRedDot, RedDotEnum.DotNode.Activity1_3RedDot1)
	RedDotController.instance:addRedDot(slot0.goAstrologyRedDot, RedDotEnum.DotNode.Activity1_3RedDot3)
	RedDotController.instance:addRedDot(slot0.goBuffRedDot, RedDotEnum.DotNode.Activity1_3RedDot2)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTaskUI, slot0)
	gohelper.removeUIClickAudio(slot0._btncloseview.gameObject)
end

function slot0._showDailyReddot(slot0)
	if Activity126Model.instance:receiveGetHoroscope() and slot1 > 0 then
		return false
	end

	slot3, slot4 = Activity126Model.instance:getRemainNum()

	if slot3 <= 0 then
		return false
	end

	if slot0:_getZeroTime() ~= PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), 0) then
		return true
	end

	return false
end

function slot0._markDailyReddot(slot0)
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), slot0:_getZeroTime())
end

function slot0._getZeroTime(slot0)
	slot1 = os.date("*t", os.time() - 18000)
	slot1.hour = 0
	slot1.min = 0
	slot1.sec = 0

	return os.time(slot1)
end

function slot0._showMask(slot0)
	slot0._simagefullmask:LoadImage(string.format("singlebg/v1a3_dungeon_singlebg/%s.png", slot0.activityDungeonMo:isHardMode() and "v1a3_dungeon_hardlevelmapmask" or "v1a3_dungeon_normallevelmapmask"))
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
	slot0:_directClickDaily()
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()
end

function slot0.openAmbientSound(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, slot1, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(slot1)
end

function slot0.closeAmbientSound(slot0)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function slot0.onOpen(slot0)
	slot0.activityDungeonMo = slot0.viewContainer.versionActivityDungeonBaseMo

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._setEpisodeListVisible, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._updateBtns, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, slot0._OnChangeMap, slot0)
	slot0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem, slot0._onOpenDailyInteractiveItem, slot0)
	slot0:refreshUI()
	slot0:_showMask()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_3DungeonMapView, slot0._onEscBtnClick, slot0)
	slot0:_directClickDaily()
end

function slot0._onOpenDailyInteractiveItem(slot0)
	slot0:_markDailyReddot()
end

function slot0._OnChangeMap(slot0)
	if slot0.viewContainer.mapScene:getMapTime() then
		VersionActivity1_3DungeonController.instance:openDungeonChangeView(slot1)
	end

	if VersionActivity1_3DungeonController.instance:isDayTime(slot0.activityDungeonMo.episodeId) then
		slot0:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound1)
	else
		slot0:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound2)
	end
end

function slot0._directClickDaily(slot0)
	if slot0.viewParam.showDaily then
		VersionActivity1_3DungeonController.instance.directFocusDaily = true

		slot0:_onClickDaily()

		slot0.viewParam.showDaily = nil
	end
end

function slot0.onModeChange(slot0)
	slot0:_showMask()
end

function slot0.refreshUI(slot0)
	slot0.btnBuffAnimator:Play(UIAnimationName.Open)
	slot0:refreshTaskUI()
	slot0:refreshActivityCurrency()
	slot0:_showMask()
end

function slot0.refreshTaskUI(slot0)
	slot0.txtTaskGet.text = string.format("%s/%s", slot0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivity1_3Enum.ActivityId.Dungeon))
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_3Enum.ActivityId.Dungeon)) and slot2.quantity or 0)
end

function slot0.getFinishTaskCount(slot0)
	slot2 = nil
	slot5 = VersionActivityConfig.instance
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.getAct113TaskList(slot7, VersionActivity1_3Enum.ActivityId.Dungeon)) do
		if TaskModel.instance:getTaskById(slot7.id) and slot7.maxFinishCount <= slot2.finishCount then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0._setEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._topLeftGo, slot1)

	if slot1 then
		slot0.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		slot0.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		slot0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_3DungeonMapLevelView then
		slot0.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		slot0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(slot0._btncloseview, true)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_3DungeonMapLevelView then
		slot0.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(slot0._btncloseview, false)
	end
end

function slot0.openMapInteractiveItem(slot0)
	slot0._interActiveItem = slot0._interActiveItem or slot0:openSubView(DungeonMapInteractive1_3Item, slot0._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return slot0._interActiveItem
end

function slot0.showInteractiveItem(slot0)
	if slot0._interActiveItem and slot0._interActiveItem:getChildViews() and #slot1 > 0 then
		return true
	end
end

function slot0.onClose(slot0)
	slot0:closeAmbientSound()
end

return slot0
