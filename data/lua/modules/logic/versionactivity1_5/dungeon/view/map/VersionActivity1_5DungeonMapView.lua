module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._topRightGo = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0.simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._goSwitchModeContainer = gohelper.findChild(slot0.viewGO, "#go_switchmodecontainer")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitystore")
	slot0._btnactivitytask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_activitytask")
	slot0._btnrevivaltask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_revivaltask")
	slot0._btnbuildingtask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/#btn_buildingtask")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	slot0._imagestoreicon = gohelper.findChildImage(slot0.viewGO, "#go_topright/#btn_activitystore/icon")
	slot0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	slot0.originalStateId = AudioMgr.instance:getIdFromString("original")
	slot0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnactivitystore:AddClickListener(slot0.btnActivityStoreOnClick, slot0)
	slot0._btnactivitytask:AddClickListener(slot0.btnActivityTaskOnClick, slot0)
	slot0._btnrevivaltask:AddClickListener(slot0.btnRevivalTaskOnClick, slot0)
	slot0._btnbuildingtask:AddClickListener(slot0.btnBuildingTaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnactivitystore:RemoveClickListener()
	slot0._btnactivitytask:RemoveClickListener()
	slot0._btnrevivaltask:RemoveClickListener()
	slot0._btnbuildingtask:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0.btnActivityStoreOnClick(slot0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function slot0.btnActivityTaskOnClick(slot0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function slot0.btnRevivalTaskOnClick(slot0)
	VersionActivity1_5DungeonController.instance:openRevivalTaskView()
end

function slot0.btnBuildingTaskOnClick(slot0)
	VersionActivity1_5DungeonController.instance:openBuildView()
end

function slot0._editableInitView(slot0)
	slot0.playedRevivalTaskAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim"), 0) == 1
	slot0.playedBuildAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim"), 0) == 1

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagestoreicon, "10501_1")

	slot0.goTaskRedDot = gohelper.findChild(slot0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	RedDotController.instance:addRedDot(slot0.goTaskRedDot, RedDotEnum.DotNode.V1a5DungeonTask)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.hideBtnUI, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, slot0.showBtnUI, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.refreshBtnVisible, slot0, LuaEventSystem.Low)
	slot0:addEventCb(StoryController.instance, StoryEvent.FinishFromServer, slot0.refreshBtnVisible, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, slot0.onDialogueInfoChange, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetRevivalTaskBtnActive, slot0.setRevivalTaskBtnActive, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetBuildingBtnActive, slot0.setBuildingBtnActive, slot0)
	gohelper.setActive(slot0._btnactivitystore.gameObject, false)
	gohelper.setActive(slot0._btnactivitytask.gameObject, false)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
	VersionActivity1_5DungeonController.instance:_onOpenMapViewDone(slot0.viewName)

	if slot0.viewParam and slot0.viewParam.episodeId then
		slot0.viewContainer.viewParam.needSelectFocusItem = true

		slot0.activityDungeonMo:changeEpisode(slot1)
	end
end

function slot0._onEscBtnClick(slot0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		slot0.viewContainer.interactView:hide()

		return
	end

	slot0:closeThis()
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)
	slot0:refreshUI()
	slot0:closeBgmLeadSinger()
end

function slot0.closeBgmLeadSinger(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.accompanimentStateId)
end

function slot0.openBgmLeadSinger(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.originalStateId)
end

function slot0.refreshUI(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshActivityCurrency()
	slot0:refreshMask()
end

function slot0.customRefreshExploreRedDot(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.refreshBtnVisible(slot0)
	slot1 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	gohelper.setActive(slot0._btnrevivaltask.gameObject, slot1)
	slot0:playRevivalAnim()

	if slot1 and not slot0.revivalTaskRedDot then
		slot0.revivalTaskRedDot = RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_topright/#btn_revivaltask/#go_reddot"), RedDotEnum.DotNode.V1a5DungeonRevivalTask, nil, slot0.customRefreshExploreRedDot, slot0)
	end

	slot1 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	gohelper.setActive(slot0._btnbuildingtask.gameObject, slot1)
	slot0:playBuildAnim()

	if slot1 and not slot0.buildTaskRedDot then
		slot0.buildTaskRedDot = RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "#go_topright/#btn_buildingtask/#go_reddot"), RedDotEnum.DotNode.V1a5DungeonBuildTask)
	end
end

function slot0.setRevivalTaskBtnActive(slot0, slot1)
	slot2 = slot1 == "1" and DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	gohelper.setActive(slot0._btnrevivaltask.gameObject, slot2)

	if slot2 then
		slot0:_playRevivalAnimImpl()
	end
end

function slot0.setBuildingBtnActive(slot0, slot1)
	slot3 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)
	slot2 = slot1 == "1" and slot3

	gohelper.setActive(slot0._btnbuildingtask.gameObject, slot2 and slot3)

	if slot2 then
		slot0:_playBuildAnimImpl()
	end
end

function slot0.playRevivalAnim(slot0)
	if slot0.playedRevivalTaskAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId) then
		slot0:_playRevivalAnimImpl()
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim"), 1)

		slot0.playedRevivalTaskAnim = true
	end
end

function slot0._playRevivalAnimImpl(slot0)
	slot0._btnrevivaltask:GetComponent(typeof(UnityEngine.Animator)):Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function slot0.playBuildAnim(slot0)
	if slot0.playedBuildAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
		slot0:_playBuildAnimImpl()
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim"), 1)

		slot0.playedBuildAnim = true
	end
end

function slot0._playBuildAnimImpl(slot0)
	slot0._btnbuildingtask:GetComponent(typeof(UnityEngine.Animator)):Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function slot0.refreshActivityCurrency(slot0)
	slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon) and slot1.quantity or 0)
end

function slot0.refreshMask(slot0)
	slot0.simagemask:LoadImage(slot0.activityDungeonMo:isHardMode() and ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_hardlevelmapmask") or ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_normallevelmapmask"))
end

slot0.BlockKey = "VersionActivity1_5DungeonMapView_OpenAnim"

function slot0.showBtnUI(slot0)
	gohelper.setActive(slot0._btncloseview, false)
	gohelper.setActive(slot0._topLeftGo, true)
	gohelper.setActive(slot0._topRightGo, true)
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
	gohelper.setActive(slot0._btncloseview, true)
	slot0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.BlockKey)
	TaskDispatcher.runDelay(slot0.onCloseAnimaDone, slot0, 0.667)
end

function slot0.onCloseAnimaDone(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockKey)
	gohelper.setActive(slot0._topLeftGo, false)
	gohelper.setActive(slot0._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0:hideBtnUI()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0:showBtnUI()
	end

	slot0:playRevivalAnim()
	slot0:playBuildAnim()
end

function slot0.onModeChange(slot0)
	slot0:refreshMask()
end

function slot0.onDialogueInfoChange(slot0)
	slot0:refreshExploreRedDot()
end

function slot0.onUpdateDungeonInfo(slot0)
	slot0:refreshBtnVisible()
	slot0:refreshExploreRedDot()
end

function slot0.refreshExploreRedDot(slot0)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[RedDotEnum.DotNode.V1a5DungeonExploreTask] = true
	})
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_5DungeonMapLevelView)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.BlockKey)
	TaskDispatcher.cancelTask(slot0.onCloseAnimaDone, slot0)
	TaskDispatcher.cancelTask(slot0.onOpenAnimaDone, slot0)
	slot0:openBgmLeadSinger()
end

function slot0.onDestroyView(slot0)
	slot0.simagemask:UnLoadImage()
end

return slot0
