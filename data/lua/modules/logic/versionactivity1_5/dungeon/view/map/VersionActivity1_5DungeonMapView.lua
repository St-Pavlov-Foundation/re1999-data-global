module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeftGo = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._topRightGo = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0.simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._goSwitchModeContainer = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._btnrevivaltask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_revivaltask")
	arg_1_0._btnbuildingtask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_buildingtask")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	arg_1_0._imagestoreicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_topright/#btn_activitystore/icon")
	arg_1_0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	arg_1_0.originalStateId = AudioMgr.instance:getIdFromString("original")
	arg_1_0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0.btnActivityStoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0.btnActivityTaskOnClick, arg_2_0)
	arg_2_0._btnrevivaltask:AddClickListener(arg_2_0.btnRevivalTaskOnClick, arg_2_0)
	arg_2_0._btnbuildingtask:AddClickListener(arg_2_0.btnBuildingTaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btnrevivaltask:RemoveClickListener()
	arg_3_0._btnbuildingtask:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0.btnActivityStoreOnClick(arg_4_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function var_0_0.btnActivityTaskOnClick(arg_5_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function var_0_0.btnRevivalTaskOnClick(arg_6_0)
	VersionActivity1_5DungeonController.instance:openRevivalTaskView()
end

function var_0_0.btnBuildingTaskOnClick(arg_7_0)
	VersionActivity1_5DungeonController.instance:openBuildView()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.playedRevivalTaskAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim"), 0) == 1
	arg_8_0.playedBuildAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim"), 0) == 1

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._imagestoreicon, "10501_1")

	arg_8_0.goTaskRedDot = gohelper.findChild(arg_8_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	arg_8_0.animator = arg_8_0.viewGO:GetComponent(gohelper.Type_Animator)

	RedDotController.instance:addRedDot(arg_8_0.goTaskRedDot, RedDotEnum.DotNode.V1a5DungeonTask)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_8_0._onOpenView, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseView, arg_8_0)
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.refreshActivityCurrency, arg_8_0)
	arg_8_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_8_0.onModeChange, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_8_0.hideBtnUI, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, arg_8_0.showBtnUI, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_8_0.refreshBtnVisible, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(StoryController.instance, StoryEvent.FinishFromServer, arg_8_0.refreshBtnVisible, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(DialogueController.instance, DialogueEvent.OnDialogueInfoChange, arg_8_0.onDialogueInfoChange, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetRevivalTaskBtnActive, arg_8_0.setRevivalTaskBtnActive, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetBuildingBtnActive, arg_8_0.setBuildingBtnActive, arg_8_0)
	gohelper.setActive(arg_8_0._btnactivitystore.gameObject, false)
	gohelper.setActive(arg_8_0._btnactivitytask.gameObject, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshUI()
	VersionActivity1_5DungeonController.instance:_onOpenMapViewDone(arg_9_0.viewName)

	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.episodeId

	if var_9_0 then
		arg_9_0.viewContainer.viewParam.needSelectFocusItem = true

		arg_9_0.activityDungeonMo:changeEpisode(var_9_0)
	end
end

function var_0_0._onEscBtnClick(arg_10_0)
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		arg_10_0.viewContainer.interactView:hide()

		return
	end

	arg_10_0:closeThis()
end

function var_0_0.onOpen(arg_11_0)
	NavigateMgr.instance:addEscape(arg_11_0.viewName, arg_11_0._onEscBtnClick, arg_11_0)
	arg_11_0:refreshUI()
	arg_11_0:closeBgmLeadSinger()
end

function var_0_0.closeBgmLeadSinger(arg_12_0)
	AudioMgr.instance:setSwitch(arg_12_0.switchGroupId, arg_12_0.accompanimentStateId)
end

function var_0_0.openBgmLeadSinger(arg_13_0)
	AudioMgr.instance:setSwitch(arg_13_0.switchGroupId, arg_13_0.originalStateId)
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:refreshBtnVisible()
	arg_14_0:refreshActivityCurrency()
	arg_14_0:refreshMask()
end

function var_0_0.customRefreshExploreRedDot(arg_15_0, arg_15_1)
	arg_15_1:defaultRefreshDot()

	if not arg_15_1.show then
		arg_15_1.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		arg_15_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.refreshBtnVisible(arg_16_0)
	local var_16_0 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	gohelper.setActive(arg_16_0._btnrevivaltask.gameObject, var_16_0)
	arg_16_0:playRevivalAnim()

	if var_16_0 and not arg_16_0.revivalTaskRedDot then
		local var_16_1 = gohelper.findChild(arg_16_0.viewGO, "#go_topright/#btn_revivaltask/#go_reddot")

		arg_16_0.revivalTaskRedDot = RedDotController.instance:addRedDot(var_16_1, RedDotEnum.DotNode.V1a5DungeonRevivalTask, nil, arg_16_0.customRefreshExploreRedDot, arg_16_0)
	end

	local var_16_2 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	gohelper.setActive(arg_16_0._btnbuildingtask.gameObject, var_16_2)
	arg_16_0:playBuildAnim()

	if var_16_2 and not arg_16_0.buildTaskRedDot then
		local var_16_3 = gohelper.findChild(arg_16_0.viewGO, "#go_topright/#btn_buildingtask/#go_reddot")

		arg_16_0.buildTaskRedDot = RedDotController.instance:addRedDot(var_16_3, RedDotEnum.DotNode.V1a5DungeonBuildTask)
	end
end

function var_0_0.setRevivalTaskBtnActive(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 == "1"
	local var_17_1 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	var_17_0 = var_17_0 and var_17_1

	gohelper.setActive(arg_17_0._btnrevivaltask.gameObject, var_17_0)

	if var_17_0 then
		arg_17_0:_playRevivalAnimImpl()
	end
end

function var_0_0.setBuildingBtnActive(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1 == "1"
	local var_18_1 = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	var_18_0 = var_18_0 and var_18_1

	gohelper.setActive(arg_18_0._btnbuildingtask.gameObject, var_18_0 and var_18_1)

	if var_18_0 then
		arg_18_0:_playBuildAnimImpl()
	end
end

function var_0_0.playRevivalAnim(arg_19_0)
	if arg_19_0.playedRevivalTaskAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_19_0.viewName) then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId) then
		arg_19_0:_playRevivalAnimImpl()

		local var_19_0 = PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim")

		PlayerPrefsHelper.setNumber(var_19_0, 1)

		arg_19_0.playedRevivalTaskAnim = true
	end
end

function var_0_0._playRevivalAnimImpl(arg_20_0)
	arg_20_0._btnrevivaltask:GetComponent(typeof(UnityEngine.Animator)):Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function var_0_0.playBuildAnim(arg_21_0)
	if arg_21_0.playedBuildAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_21_0.viewName) then
		return
	end

	if DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId) then
		arg_21_0:_playBuildAnimImpl()

		local var_21_0 = PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim")

		PlayerPrefsHelper.setNumber(var_21_0, 1)

		arg_21_0.playedBuildAnim = true
	end
end

function var_0_0._playBuildAnimImpl(arg_22_0)
	arg_22_0._btnbuildingtask:GetComponent(typeof(UnityEngine.Animator)):Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function var_0_0.refreshActivityCurrency(arg_23_0)
	local var_23_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon)
	local var_23_1 = var_23_0 and var_23_0.quantity or 0

	arg_23_0._txtstorenum.text = GameUtil.numberDisplay(var_23_1)
end

function var_0_0.refreshMask(arg_24_0)
	local var_24_0 = arg_24_0.activityDungeonMo:isHardMode() and ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_hardlevelmapmask") or ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_normallevelmapmask")

	arg_24_0.simagemask:LoadImage(var_24_0)
end

var_0_0.BlockKey = "VersionActivity1_5DungeonMapView_OpenAnim"

function var_0_0.showBtnUI(arg_25_0)
	gohelper.setActive(arg_25_0._btncloseview, false)
	gohelper.setActive(arg_25_0._topLeftGo, true)
	gohelper.setActive(arg_25_0._topRightGo, true)
	arg_25_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_25_0.onOpenAnimaDone, arg_25_0, 0.667)
end

function var_0_0.onOpenAnimaDone(arg_26_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.hideBtnUI(arg_27_0)
	gohelper.setActive(arg_27_0._btncloseview, true)
	arg_27_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_27_0.onCloseAnimaDone, arg_27_0, 0.667)
end

function var_0_0.onCloseAnimaDone(arg_28_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	gohelper.setActive(arg_28_0._topLeftGo, false)
	gohelper.setActive(arg_28_0._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0._onOpenView(arg_29_0, arg_29_1)
	if arg_29_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_29_0:hideBtnUI()
	end
end

function var_0_0._onCloseView(arg_30_0, arg_30_1)
	if arg_30_1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		arg_30_0:showBtnUI()
	end

	arg_30_0:playRevivalAnim()
	arg_30_0:playBuildAnim()
end

function var_0_0.onModeChange(arg_31_0)
	arg_31_0:refreshMask()
end

function var_0_0.onDialogueInfoChange(arg_32_0)
	arg_32_0:refreshExploreRedDot()
end

function var_0_0.onUpdateDungeonInfo(arg_33_0)
	arg_33_0:refreshBtnVisible()
	arg_33_0:refreshExploreRedDot()
end

function var_0_0.refreshExploreRedDot(arg_34_0)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[RedDotEnum.DotNode.V1a5DungeonExploreTask] = true
	})
end

function var_0_0._btncloseviewOnClick(arg_35_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_5DungeonMapLevelView)
end

function var_0_0.onClose(arg_36_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	TaskDispatcher.cancelTask(arg_36_0.onCloseAnimaDone, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.onOpenAnimaDone, arg_36_0)
	arg_36_0:openBgmLeadSinger()
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0.simagemask:UnLoadImage()
end

return var_0_0
