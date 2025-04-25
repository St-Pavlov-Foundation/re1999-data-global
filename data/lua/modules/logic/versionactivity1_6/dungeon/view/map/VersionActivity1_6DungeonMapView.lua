module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapView", package.seeall)

slot0 = class("VersionActivity1_6DungeonMapView", BaseView)
slot1 = VersionActivity1_6DungeonEnum
slot2 = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockSkillBtnAnim"
slot3 = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockBossBtnAnim"

function slot0.onInitView(slot0)
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._topRightGo = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0.simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._goSwitchModeContainer = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._btnactivityskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_wish")
	slot0._imageActivityskillProgress = gohelper.findChildImage(slot0.viewGO, "#go_topright/#btn_wish/circle_bar")
	slot0._goBtnBoss = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_bossmode")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	slot0._txtStoreRemainTime = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	slot0._imagestoreicon = gohelper.findChildImage(slot0.viewGO, "#go_topright/#btn_activitystore/icon")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnactivitystore:AddClickListener(slot0.btnActivityStoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0.btnActivityTaskOnClick, slot0)
	slot0._btnactivityskill:AddClickListener(slot0.btnActivitySkillOnClick, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btnactivityskill:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0.btnActivityStoreOnClick(slot0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function slot0.btnActivityTaskOnClick(slot0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function slot0.btnActivitySkillOnClick(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
		slot2, slot3 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60101)

		GameFacade.showToastWithTableParam(slot2, slot3)

		return
	end

	VersionActivity1_6DungeonController.instance:openSkillView()
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_6DungeonMapLevelView)
end

function slot0._editableInitView(slot0)
	slot0.playedSkillBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv0), 0) == 1
	slot0.playedBossBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(uv1), 0) == 1
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	slot0:addViewRedDot()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetSkillBtnActive, slot0.SetSkillBtnActive, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetBossBtnActive, slot0.SetBossBtnActive, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0.onFunUnlockRefreshUI, slot0)
	TaskDispatcher.runRepeat(slot0._everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
	VersionActivity1_6DungeonController.instance:_onOpenMapViewDone(slot0.viewName)

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot0.viewContainer.viewParam.needSelectFocusItem = true

		slot0.activityDungeonMo:changeEpisode(slot1)
	end
end

function slot0._onEscBtnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
	slot0:modifyBgm()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshActivityCurrency()
	slot0:refreshMask()
	slot0:refreshSkillProgress()
	slot0:refreshStoreRemainTime()
end

function slot0.onFunUnlockRefreshUI(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshSkillProgress()
end

function slot0.refreshBtnVisible(slot0)
	slot1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	gohelper.setActive(slot0._btnactivityskill.gameObject, slot1)

	if slot1 then
		slot0:playSkillBtnAnim()
	end

	slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	gohelper.setActive(slot0._goBtnBoss, slot2)

	if slot2 then
		slot0:playBossBtnAnim()
	end
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon) and slot1.quantity or 0)
end

function slot0.refreshSkillProgress(slot0)
	slot0._imageActivityskillProgress.fillAmount = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum() / (1 * tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)))
end

function slot0.refreshStoreRemainTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.ReactivityStore]:getRealEndTimeStamp() - ServerTime.now() then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot3 / TimeUtil.OneDaySecond) .. "d"

		return
	end

	if TimeUtil.OneHourSecond < slot3 then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot3 / TimeUtil.OneHourSecond) .. "h"

		return
	end

	slot0._txtStoreRemainTime.text = "1h"
end

function slot0.refreshMask(slot0)
	gohelper.setActive(slot0.simagemask.gameObject, slot0.activityDungeonMo:isHardMode())
end

slot0.BlockKey = "VersionActivity1_6DungeonMapView_OpenAnim"

function slot0.showBtnUI(slot0)
	gohelper.setActive(slot0._topLeftGo, true)
	gohelper.setActive(slot0._topRightGo, true)
	gohelper.setActive(slot0._goSwitchModeContainer, true)
	slot0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	TaskDispatcher.runDelay(slot0.onOpenAnimaDone, slot0, 0.667)
end

function slot0.onOpenAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.hideBtnUI(slot0)
	slot0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	TaskDispatcher.runDelay(slot0.onCloseAnimaDone, slot0, 0.667)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_6DungeonMapLevelView then
		slot0._rectmask2D.padding = Vector4(0, 0, 600, 0)

		gohelper.setActive(slot0._btncloseview, true)
		slot0:hideBtnUI()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_6DungeonMapLevelView then
		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(slot0._btncloseview, false)
		slot0:showBtnUI()
		slot0:playSkillBtnAnim()
		slot0:playBossBtnAnim()
	end
end

function slot0.onModeChange(slot0)
	slot0:refreshMask()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._everyMinuteCall, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._everyMinuteCall(slot0)
	slot0:refreshUI()
end

function slot0.SetSkillBtnActive(slot0, slot1)
	slot2 = slot1 == "1" and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	gohelper.setActive(slot0._btnactivityskill.gameObject, slot2)

	if slot2 then
		slot0:_playSkillBtnAnimImpl()
	end
end

function slot0.SetBossBtnActive(slot0, slot1)
	slot2 = slot1 == "1" and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	gohelper.setActive(slot0._goBtnBoss, slot2)

	if slot2 then
		slot0:_playBossBtnAnimImpl()
	end
end

function slot0.playSkillBtnAnim(slot0)
	if slot0.playedSkillBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0:_playSkillBtnAnimImpl()
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(uv0), 1)

	slot0.playedSkillBtnAnim = true
end

function slot0._playSkillBtnAnimImpl(slot0)
	slot0._btnactivityskill:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewUnlock)
end

function slot0.playBossBtnAnim(slot0)
	if slot0.playedBossBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0:_playBossBtnAnimImpl()
	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(uv0), 1)

	slot0.playedBossBtnAnim = true
end

function slot0._playBossBtnAnimImpl(slot0)
	slot0._goBtnBoss:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
end

function slot0.onCloseAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockKey)
	gohelper.setActive(slot0._goSwitchModeContainer, false)
	gohelper.setActive(slot0._topLeftGo, false)
	gohelper.setActive(slot0._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.modifyBgm(slot0)
	if DungeonModel.instance:hasPassLevelAndStory(uv0.ModifyBgmEpisodeId) then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

function slot0.addViewRedDot(slot0)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot"), RedDotEnum.DotNode.V1a6DungeonTask)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_topright/#btn_wish/#go_reddot"), RedDotEnum.DotNode.V1a6DungeonSkillPoint)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot"), RedDotEnum.DotNode.V1a6DungeonBossEnter)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot2"), RedDotEnum.DotNode.V1a6DungeonNewBoss)
end

return slot0
