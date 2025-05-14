module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapView", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullmask")
	arg_1_0._topLeftGo = gohelper.findChild(arg_1_0.viewGO, "top_left")
	arg_1_0._topRightGo = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._topLeftElementGo = gohelper.findChild(arg_1_0.viewGO, "top_left_element")
	arg_1_0._goversionactivity = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")
	arg_1_0._gores = gohelper.findChild(arg_1_0.viewGO, "#go_res")
	arg_1_0._btnactivitybuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_activitybuff")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	arg_1_0._gointeractiveroot = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnactivitybuff:AddClickListener(arg_2_0.btnActivityBuffOnClick, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnactivitybuff:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
end

function var_0_0.btnActivityBuffOnClick(arg_5_0)
	VersionActivity1_3BuffController.instance:openBuffView()
end

function var_0_0._updateBtns(arg_6_0)
	gohelper.setActive(arg_6_0._btnactivitybuff, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101))
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._goversionactivity, true)
	arg_7_0:_updateBtns()
	gohelper.setActive(arg_7_0._gomain, false)
	gohelper.setActive(arg_7_0._gores, false)

	arg_7_0.btnBuffAnimator = arg_7_0._btnactivitybuff.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0.modeAnimator = arg_7_0._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0.txtTaskGet = gohelper.findChildText(arg_7_0.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	arg_7_0.goTaskRedDot = gohelper.findChild(arg_7_0.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	arg_7_0.goAstrologyRedDot = gohelper.findChild(arg_7_0.viewGO, "#go_topright/#btn_activityastrology/#go_reddot")
	arg_7_0.goBuffRedDot = gohelper.findChild(arg_7_0.viewGO, "#go_topright/#btn_activitybuff/#go_reddot")

	RedDotController.instance:addRedDot(arg_7_0.goTaskRedDot, RedDotEnum.DotNode.Activity1_3RedDot1)
	RedDotController.instance:addRedDot(arg_7_0.goAstrologyRedDot, RedDotEnum.DotNode.Activity1_3RedDot3)
	RedDotController.instance:addRedDot(arg_7_0.goBuffRedDot, RedDotEnum.DotNode.Activity1_3RedDot2)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_7_0.refreshTaskUI, arg_7_0)
	gohelper.removeUIClickAudio(arg_7_0._btncloseview.gameObject)
end

function var_0_0._showDailyReddot(arg_8_0)
	local var_8_0 = Activity126Model.instance:receiveGetHoroscope()

	if var_8_0 and var_8_0 > 0 then
		return false
	end

	local var_8_1, var_8_2 = Activity126Model.instance:getRemainNum()

	if var_8_1 <= 0 then
		return false
	end

	if arg_8_0:_getZeroTime() ~= PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), 0) then
		return true
	end

	return false
end

function var_0_0._markDailyReddot(arg_9_0)
	local var_9_0 = arg_9_0:_getZeroTime()

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), var_9_0)
end

function var_0_0._getZeroTime(arg_10_0)
	local var_10_0 = os.date("*t", os.time() - 18000)

	var_10_0.hour = 0
	var_10_0.min = 0
	var_10_0.sec = 0

	return (os.time(var_10_0))
end

function var_0_0._showMask(arg_11_0)
	local var_11_0 = arg_11_0.activityDungeonMo:isHardMode() and "v1a3_dungeon_hardlevelmapmask" or "v1a3_dungeon_normallevelmapmask"

	arg_11_0._simagefullmask:LoadImage(string.format("singlebg/v1a3_dungeon_singlebg/%s.png", var_11_0))
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:refreshUI()
	arg_12_0:_directClickDaily()
end

function var_0_0._onEscBtnClick(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0.openAmbientSound(arg_14_0, arg_14_1)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, arg_14_1, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(arg_14_1)
end

function var_0_0.closeAmbientSound(arg_15_0)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.activityDungeonMo = arg_16_0.viewContainer.versionActivityDungeonBaseMo

	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_16_0._onOpenView, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_16_0._onCloseView, arg_16_0)
	arg_16_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_16_0._setEpisodeListVisible, arg_16_0)
	arg_16_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_16_0.refreshActivityCurrency, arg_16_0)
	arg_16_0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, arg_16_0.onModeChange, arg_16_0)
	arg_16_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_16_0._updateBtns, arg_16_0)
	arg_16_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_16_0._OnChangeMap, arg_16_0)
	arg_16_0:addEventCb(VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem, arg_16_0._onOpenDailyInteractiveItem, arg_16_0)
	arg_16_0:refreshUI()
	arg_16_0:_showMask()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_3DungeonMapView, arg_16_0._onEscBtnClick, arg_16_0)
	arg_16_0:_directClickDaily()
end

function var_0_0._onOpenDailyInteractiveItem(arg_17_0)
	arg_17_0:_markDailyReddot()
end

function var_0_0._OnChangeMap(arg_18_0)
	local var_18_0 = arg_18_0.viewContainer.mapScene:getMapTime()

	if var_18_0 then
		VersionActivity1_3DungeonController.instance:openDungeonChangeView(var_18_0)
	end

	if VersionActivity1_3DungeonController.instance:isDayTime(arg_18_0.activityDungeonMo.episodeId) then
		arg_18_0:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound1)
	else
		arg_18_0:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound2)
	end
end

function var_0_0._directClickDaily(arg_19_0)
	if arg_19_0.viewParam.showDaily then
		VersionActivity1_3DungeonController.instance.directFocusDaily = true

		arg_19_0:_onClickDaily()

		arg_19_0.viewParam.showDaily = nil
	end
end

function var_0_0.onModeChange(arg_20_0)
	arg_20_0:_showMask()
end

function var_0_0.refreshUI(arg_21_0)
	arg_21_0.btnBuffAnimator:Play(UIAnimationName.Open)
	arg_21_0:refreshTaskUI()
	arg_21_0:refreshActivityCurrency()
	arg_21_0:_showMask()
end

function var_0_0.refreshTaskUI(arg_22_0)
	arg_22_0.txtTaskGet.text = string.format("%s/%s", arg_22_0:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivity1_3Enum.ActivityId.Dungeon))
end

function var_0_0.refreshActivityCurrency(arg_23_0)
	local var_23_0 = ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_3Enum.ActivityId.Dungeon)
	local var_23_1 = CurrencyModel.instance:getCurrency(var_23_0)
	local var_23_2 = var_23_1 and var_23_1.quantity or 0

	arg_23_0._txtstorenum.text = GameUtil.numberDisplay(var_23_2)
end

function var_0_0.getFinishTaskCount(arg_24_0)
	local var_24_0 = 0
	local var_24_1

	for iter_24_0, iter_24_1 in ipairs(VersionActivityConfig.instance:getAct113TaskList(VersionActivity1_3Enum.ActivityId.Dungeon)) do
		local var_24_2 = TaskModel.instance:getTaskById(iter_24_1.id)

		if var_24_2 and var_24_2.finishCount >= iter_24_1.maxFinishCount then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_0._setEpisodeListVisible(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._topLeftGo, arg_25_1)

	if arg_25_1 then
		arg_25_0.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_25_0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		arg_25_0.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		arg_25_0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function var_0_0._onOpenView(arg_26_0, arg_26_1)
	if arg_26_1 == ViewName.VersionActivity1_3DungeonMapLevelView then
		arg_26_0.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		arg_26_0.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(arg_26_0._btncloseview, true)
	end
end

function var_0_0._onCloseView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.VersionActivity1_3DungeonMapLevelView then
		arg_27_0.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_27_0.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(arg_27_0._btncloseview, false)
	end
end

function var_0_0.openMapInteractiveItem(arg_28_0)
	arg_28_0._interActiveItem = arg_28_0._interActiveItem or arg_28_0:openSubView(DungeonMapInteractive1_3Item, arg_28_0._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return arg_28_0._interActiveItem
end

function var_0_0.showInteractiveItem(arg_29_0)
	if arg_29_0._interActiveItem then
		local var_29_0 = arg_29_0._interActiveItem:getChildViews()

		if var_29_0 and #var_29_0 > 0 then
			return true
		end
	end
end

function var_0_0.onClose(arg_30_0)
	arg_30_0:closeAmbientSound()
end

return var_0_0
