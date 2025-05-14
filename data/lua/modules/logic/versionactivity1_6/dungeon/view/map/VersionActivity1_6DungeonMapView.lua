module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapView", BaseView)
local var_0_1 = VersionActivity1_6DungeonEnum
local var_0_2 = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockSkillBtnAnim"
local var_0_3 = VersionActivity1_6Enum.ActivityId.Dungeon .. "UnlockBossBtnAnim"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topLeftGo = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._topRightGo = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0.simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._goSwitchModeContainer = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer")
	arg_1_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitystore")
	arg_1_0._btnactivitytask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitytask")
	arg_1_0._btnactivityskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_wish")
	arg_1_0._imageActivityskillProgress = gohelper.findChildImage(arg_1_0.viewGO, "#go_topright/#btn_wish/circle_bar")
	arg_1_0._goBtnBoss = gohelper.findChild(arg_1_0.viewGO, "#go_switchmodecontainer/#go_bossmode")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	arg_1_0._txtStoreRemainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	arg_1_0._imagestoreicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_topright/#btn_activitystore/icon")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._rectmask2D = arg_1_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnactivitystore:AddClickListener(arg_2_0.btnActivityStoreOnClick, arg_2_0)
	arg_2_0._btnactivitytask:AddClickListener(arg_2_0.btnActivityTaskOnClick, arg_2_0)
	arg_2_0._btnactivityskill:AddClickListener(arg_2_0.btnActivitySkillOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnactivitystore:RemoveClickListener()
	arg_3_0._btnactivitytask:RemoveClickListener()
	arg_3_0._btnactivityskill:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0.btnActivityStoreOnClick(arg_4_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function var_0_0.btnActivityTaskOnClick(arg_5_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_5Enum.ActivityId.Reactivity)
end

function var_0_0.btnActivitySkillOnClick(arg_6_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
		local var_6_0, var_6_1 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60101)

		GameFacade.showToastWithTableParam(var_6_0, var_6_1)

		return
	end

	VersionActivity1_6DungeonController.instance:openSkillView()
end

function var_0_0._btncloseviewOnClick(arg_7_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_6DungeonMapLevelView)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.playedSkillBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(var_0_2), 0) == 1
	arg_8_0.playedBossBtnAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(var_0_3), 0) == 1
	arg_8_0.animator = arg_8_0.viewGO:GetComponent(gohelper.Type_Animator)

	arg_8_0:addViewRedDot()
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_8_0._onOpenView, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._onCloseView, arg_8_0)
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.refreshActivityCurrency, arg_8_0)
	arg_8_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_8_0.onModeChange, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetSkillBtnActive, arg_8_0.SetSkillBtnActive, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SetBossBtnActive, arg_8_0.SetBossBtnActive, arg_8_0)
	arg_8_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_8_0.onFunUnlockRefreshUI, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._everyMinuteCall, arg_8_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshUI()
	VersionActivity1_6DungeonController.instance:_onOpenMapViewDone(arg_9_0.viewName)

	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.episodeId

	if var_9_0 then
		arg_9_0.viewContainer.viewParam.needSelectFocusItem = true

		arg_9_0.activityDungeonMo:changeEpisode(var_9_0)
	end
end

function var_0_0._onEscBtnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onOpen(arg_11_0)
	NavigateMgr.instance:addEscape(arg_11_0.viewName, arg_11_0._onEscBtnClick, arg_11_0)
	arg_11_0:modifyBgm()
	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshBtnVisible()
	arg_12_0:refreshActivityCurrency()
	arg_12_0:refreshMask()
	arg_12_0:refreshSkillProgress()
	arg_12_0:refreshStoreRemainTime()
end

function var_0_0.onFunUnlockRefreshUI(arg_13_0)
	arg_13_0:refreshBtnVisible()
	arg_13_0:refreshSkillProgress()
end

function var_0_0.refreshBtnVisible(arg_14_0)
	local var_14_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	gohelper.setActive(arg_14_0._btnactivityskill.gameObject, var_14_0)

	if var_14_0 then
		arg_14_0:playSkillBtnAnim()
	end

	local var_14_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	gohelper.setActive(arg_14_0._goBtnBoss, var_14_1)

	if var_14_1 then
		arg_14_0:playBossBtnAnim()
	end
end

function var_0_0.refreshActivityCurrency(arg_15_0)
	local var_15_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon)
	local var_15_1 = var_15_0 and var_15_0.quantity or 0

	arg_15_0._txtstorenum.text = GameUtil.numberDisplay(var_15_1)
end

function var_0_0.refreshSkillProgress(arg_16_0)
	local var_16_0 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local var_16_1 = tonumber(var_16_0)
	local var_16_2 = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()

	arg_16_0._imageActivityskillProgress.fillAmount = var_16_2 / (1 * var_16_1)
end

function var_0_0.refreshStoreRemainTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.ReactivityStore]:getRealEndTimeStamp() - ServerTime.now()

	if var_17_0 > TimeUtil.OneDaySecond then
		local var_17_1 = Mathf.Floor(var_17_0 / TimeUtil.OneDaySecond) .. "d"

		arg_17_0._txtStoreRemainTime.text = var_17_1

		return
	end

	if var_17_0 > TimeUtil.OneHourSecond then
		local var_17_2 = Mathf.Floor(var_17_0 / TimeUtil.OneHourSecond) .. "h"

		arg_17_0._txtStoreRemainTime.text = var_17_2

		return
	end

	arg_17_0._txtStoreRemainTime.text = "1h"
end

function var_0_0.refreshMask(arg_18_0)
	gohelper.setActive(arg_18_0.simagemask.gameObject, arg_18_0.activityDungeonMo:isHardMode())
end

var_0_0.BlockKey = "VersionActivity1_6DungeonMapView_OpenAnim"

function var_0_0.showBtnUI(arg_19_0)
	gohelper.setActive(arg_19_0._topLeftGo, true)
	gohelper.setActive(arg_19_0._topRightGo, true)
	gohelper.setActive(arg_19_0._goSwitchModeContainer, true)
	arg_19_0.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_19_0.onOpenAnimaDone, arg_19_0, 0.667)
end

function var_0_0.onOpenAnimaDone(arg_20_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.hideBtnUI(arg_21_0)
	arg_21_0.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_21_0.onCloseAnimaDone, arg_21_0, 0.667)
end

function var_0_0._onOpenView(arg_22_0, arg_22_1)
	if arg_22_1 == ViewName.VersionActivity1_6DungeonMapLevelView then
		arg_22_0._rectmask2D.padding = Vector4(0, 0, 600, 0)

		gohelper.setActive(arg_22_0._btncloseview, true)
		arg_22_0:hideBtnUI()
	end
end

function var_0_0._onCloseView(arg_23_0, arg_23_1)
	if arg_23_1 == ViewName.VersionActivity1_6DungeonMapLevelView then
		arg_23_0._rectmask2D.padding = Vector4(0, 0, 0, 0)

		gohelper.setActive(arg_23_0._btncloseview, false)
		arg_23_0:showBtnUI()
		arg_23_0:playSkillBtnAnim()
		arg_23_0:playBossBtnAnim()
	end
end

function var_0_0.onModeChange(arg_24_0)
	arg_24_0:refreshMask()
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._everyMinuteCall, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

function var_0_0._everyMinuteCall(arg_27_0)
	arg_27_0:refreshUI()
end

function var_0_0.SetSkillBtnActive(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 == "1"
	local var_28_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	var_28_0 = var_28_0 and var_28_1

	gohelper.setActive(arg_28_0._btnactivityskill.gameObject, var_28_0)

	if var_28_0 then
		arg_28_0:_playSkillBtnAnimImpl()
	end
end

function var_0_0.SetBossBtnActive(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1 == "1"
	local var_29_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	var_29_0 = var_29_0 and var_29_1

	gohelper.setActive(arg_29_0._goBtnBoss, var_29_0)

	if var_29_0 then
		arg_29_0:_playBossBtnAnimImpl()
	end
end

function var_0_0.playSkillBtnAnim(arg_30_0)
	if arg_30_0.playedSkillBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_30_0.viewName) then
		return
	end

	arg_30_0:_playSkillBtnAnimImpl()

	local var_30_0 = PlayerModel.instance:getPlayerPrefsKey(var_0_2)

	PlayerPrefsHelper.setNumber(var_30_0, 1)

	arg_30_0.playedSkillBtnAnim = true
end

function var_0_0._playSkillBtnAnimImpl(arg_31_0)
	arg_31_0._btnactivityskill:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewUnlock)
end

function var_0_0.playBossBtnAnim(arg_32_0)
	if arg_32_0.playedBossBtnAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_32_0.viewName) then
		return
	end

	arg_32_0:_playBossBtnAnimImpl()

	local var_32_0 = PlayerModel.instance:getPlayerPrefsKey(var_0_3)

	PlayerPrefsHelper.setNumber(var_32_0, 1)

	arg_32_0.playedBossBtnAnim = true
end

function var_0_0._playBossBtnAnimImpl(arg_33_0)
	arg_33_0._goBtnBoss:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Unlock)
end

function var_0_0.onCloseAnimaDone(arg_34_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	gohelper.setActive(arg_34_0._goSwitchModeContainer, false)
	gohelper.setActive(arg_34_0._topLeftGo, false)
	gohelper.setActive(arg_34_0._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.modifyBgm(arg_35_0)
	local var_35_0 = var_0_1.ModifyBgmEpisodeId

	if DungeonModel.instance:hasPassLevelAndStory(var_35_0) then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

function var_0_0.addViewRedDot(arg_36_0)
	local var_36_0 = gohelper.findChild(arg_36_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")

	RedDotController.instance:addRedDot(var_36_0, RedDotEnum.DotNode.V1a6DungeonTask)

	local var_36_1 = gohelper.findChild(arg_36_0.viewGO, "#go_topright/#btn_wish/#go_reddot")

	RedDotController.instance:addRedDot(var_36_1, RedDotEnum.DotNode.V1a6DungeonSkillPoint)

	local var_36_2 = gohelper.findChild(arg_36_0.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot")
	local var_36_3 = gohelper.findChild(arg_36_0.viewGO, "#go_switchmodecontainer/#go_bossmode/#go_reddot2")

	RedDotController.instance:addRedDot(var_36_2, RedDotEnum.DotNode.V1a6DungeonBossEnter)
	RedDotController.instance:addRedDot(var_36_3, RedDotEnum.DotNode.V1a6DungeonNewBoss)
end

return var_0_0
