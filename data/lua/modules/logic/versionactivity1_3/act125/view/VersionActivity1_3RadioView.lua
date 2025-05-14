module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioView", package.seeall)

local var_0_0 = class("VersionActivity1_3RadioView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goVoicePrint1 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_VoicePrint1")
	arg_1_0._simageVoicePrint1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#go_VoicePrint1/#simage_VoicePrint1")
	arg_1_0._goVoicePrint2 = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_VoicePrint2")
	arg_1_0._simageVoicePrint2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Middle/#go_VoicePrint2/#simage_VoicePrint2")
	arg_1_0._txtFMChannelNum = gohelper.findChildText(arg_1_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum")
	arg_1_0._scrollFMChannelList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Middle/FMSlider/#scroll_FMChannelList")
	arg_1_0._goradiochannelitem = gohelper.findChild(arg_1_0.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem")
	arg_1_0._imageFMSliderThumbLine = gohelper.findChildImage(arg_1_0.viewGO, "Middle/FMSlider/Lower/#image_FMSliderThumbLine")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollTaskTabList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	arg_1_0._goradiotaskitem = gohelper.findChild(arg_1_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	arg_1_0._txtTaskTitle = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	arg_1_0._txtTaskFMChannelNum = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	arg_1_0._scrollTaskDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	arg_1_0._txtTaskContent = gohelper.findChildText(arg_1_0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "Middle/spinecontainer/#go_spine")
	arg_1_0._goWrongChannel = gohelper.findChild(arg_1_0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	arg_1_0._goUpper = gohelper.findChild(arg_1_0.viewGO, "Middle/FMSlider/#go_Upper")
	arg_1_0._txtFMCHannelTip = gohelper.findChildText(arg_1_0.viewGO, "Middle/FMSlider/Lower/txt_FMChannelTips")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btnplayquickly = gohelper.findChildButton(arg_1_0.viewGO, "#btn_playquickly")
	arg_1_0._txtNoSignal = gohelper.findChildText(arg_1_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_NoSignal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onRadioValueChanged, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onRadioValueChangeEnd, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onRadioValueChangeBegin, arg_2_0)
	arg_2_0._btnplayquickly:AddClickListener(arg_2_0._onClickPlayQuickly, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_2_0.refreshUI, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelSelected, arg_2_0.onChannelSelected, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelItemClick, arg_2_0.onChannelPing, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onRewardRefresh, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._btnplayquickly:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_3_0.refreshUI, arg_3_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelSelected, arg_3_0.onChannelSelected, arg_3_0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelItemClick, arg_3_0.onChannelPing, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onRewardRefresh, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._episodeItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._rewardItemTab = arg_4_0:getUserDataTb_()
	arg_4_0._fmsliderPingPosX = transformhelper.getPos(arg_4_0._imageFMSliderThumbLine.transform)
	arg_4_0._channelScrollRect = gohelper.onceAddComponent(arg_4_0._scrollFMChannelList, typeof(UnityEngine.UI.ScrollRect))
	arg_4_0._FMChannelCanvasGroup = gohelper.onceAddComponent(arg_4_0._scrollFMChannelList, typeof(UnityEngine.CanvasGroup))
	arg_4_0._taskTabCanvasGroup = gohelper.onceAddComponent(arg_4_0._scrollTaskTabList, typeof(UnityEngine.CanvasGroup))
	arg_4_0._viewGOCanvasGroup = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.CanvasGroup))

	arg_4_0._simageFullBG:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_fullbg"))
	arg_4_0._simageVoicePrint1:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_1"))
	arg_4_0._simageVoicePrint2:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_2"))

	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollFMChannelList.gameObject)
	arg_4_0._goRewardContent = gohelper.findChild(arg_4_0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	arg_4_0._goChannelContent = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content")
	arg_4_0._goTaskContent = gohelper.findChild(arg_4_0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	arg_4_0._goleftwave = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LeftWave")
	arg_4_0._gorightwave = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RightWave")
	arg_4_0._goleftwaveeffect = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LWave_effect1")
	arg_4_0._gorightwaveeffect = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RWave_effect1")
	arg_4_0._middleAnim = gohelper.findChild(arg_4_0.viewGO, "Middle"):GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._channelTitleAnim = gohelper.findChild(arg_4_0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle"):GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._isFirstInitUI = true
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	arg_6_0._parentViewCanvasGroup = gohelper.onceAddComponent(arg_6_0.viewParam.root, typeof(UnityEngine.CanvasGroup))

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0._actId = arg_6_0.viewParam.actId
	arg_6_0._config = Activity125Config.instance:getAct125Config(arg_6_0._actId)

	Activity125Controller.instance:getAct125InfoFromServer(arg_6_0._actId)
end

function var_0_0.refreshUI(arg_7_0, arg_7_1)
	arg_7_0:_refreshData()
	arg_7_0:_showDeadline()
	arg_7_0:_initChannels()
	arg_7_0:_refreshSpine()
	arg_7_0:_initEpisodeList()

	if arg_7_0._isFirstInitUI and not arg_7_1 then
		arg_7_1 = arg_7_0._hasFindCorrectFM and var_0_0.AnimSwitchMode.Finish or var_0_0.AnimSwitchMode.UnFinish
		arg_7_0._isFirstInitUI = false
	end

	arg_7_0:_refreshFMUI(arg_7_0._hasFindCorrectFM, arg_7_1)
	arg_7_0:_initRewards()
end

function var_0_0._refreshData(arg_8_0)
	arg_8_0._curChallengeLv = Activity125Model.instance:getCurChallengeEpisodeId()
	arg_8_0._curSelectedLvId = arg_8_0._curSelectedLvId or arg_8_0._curChallengeLv
	arg_8_0._inintFrequency = arg_8_0._config[arg_8_0._curSelectedLvId].initFrequency
	arg_8_0._targetFrequencyIndex = tonumber(arg_8_0._config[arg_8_0._curSelectedLvId].targetFrequency)
	arg_8_0._hasFindCorrectFM = Activity125Model.instance:isEpisodeFinished(arg_8_0._curSelectedLvId)
	arg_8_0._curSelectChannleIndex = arg_8_0._hasFindCorrectFM and arg_8_0._targetFrequencyIndex or arg_8_0._config[arg_8_0._curSelectedLvId].initFrequency
end

function var_0_0._showDeadline(arg_9_0)
	arg_9_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_9_0._onRefreshDeadline, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0._onRefreshDeadline, arg_9_0, 60)
end

function var_0_0._onRefreshDeadline(arg_10_0)
	local var_10_0, var_10_1 = ActivityModel.instance:getRemainTime(arg_10_0._actId)

	arg_10_0._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), var_10_0, var_10_1)

	if var_10_0 <= 0 and var_10_1 <= 0 then
		TaskDispatcher.cancelTask(arg_10_0._onRefreshDeadline, arg_10_0)
	end
end

function var_0_0._initChannels(arg_11_0)
	local var_11_0 = Activity125Config.instance:getChannelParseResult(arg_11_0._actId, arg_11_0._curSelectedLvId)

	arg_11_0._targetChannelValue = var_11_0.targetFrequencyValue

	local var_11_1 = arg_11_0:buildChannelListModel(var_11_0)

	V1A3_RadioChannelListModel.instance:setCategoryList(var_11_1)

	local var_11_2 = arg_11_0._curSelectChannleIndex - var_11_0.wholeStartIndex + 1

	arg_11_0.viewContainer._channelScrollView:selectCell(var_11_2, true)
	gohelper.setActive(arg_11_0._goWrongChannel, not arg_11_0._hasFindCorrectFM)
	gohelper.setActive(arg_11_0._scrollTaskDesc.gameObject, arg_11_0._hasFindCorrectFM)

	arg_11_0._txtFMChannelNum.text = string.format("FM.%s", arg_11_0._targetChannelValue)
	arg_11_0._txtTaskFMChannelNum.text = string.format("FM.%s", arg_11_0._targetChannelValue)
	arg_11_0._txtTaskTitle.text = arg_11_0._config[arg_11_0._curSelectedLvId].name
end

function var_0_0.buildChannelListModel(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = iter_12_1.type
		local var_12_2 = iter_12_1.startIndex
		local var_12_3 = iter_12_1.endIndex
		local var_12_4 = iter_12_1.startValue
		local var_12_5 = iter_12_1.endValue

		if var_12_1 == Activity125Config.ChannelCfgType.Point then
			var_12_3 = var_12_2

			for iter_12_2 = iter_12_1.lastIndex + 1, iter_12_1.startIndex - 1 do
				table.insert(var_12_0, {
					isEmpty = true,
					id = iter_12_2
				})
			end
		end

		for iter_12_3 = var_12_2, var_12_3 do
			local var_12_6 = Activity125Config.instance:getRealFrequencyValue(iter_12_3, var_12_2, var_12_4, var_12_3, var_12_5)

			table.insert(var_12_0, {
				id = iter_12_3,
				value = var_12_6
			})
		end
	end

	return var_12_0
end

local var_0_1 = 1

function var_0_0.onChannelSelected(arg_13_0, arg_13_1)
	if arg_13_1 ~= arg_13_0._curSelectChannleIndex and not arg_13_0._hasFindCorrectFM then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_frequency)
	end

	arg_13_0._curSelectChannleIndex = arg_13_1

	TaskDispatcher.cancelTask(arg_13_0._checkIsFindCorrectFM, arg_13_0)

	if not arg_13_0._isDragging then
		TaskDispatcher.runDelay(arg_13_0._checkIsFindCorrectFM, arg_13_0, var_0_1)
	end
end

function var_0_0._pingScrollContentPos(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = Activity125Config.instance:getChannelIndexRange(arg_14_0._actId, arg_14_0._curSelectedLvId)

	arg_14_0._scrollFMChannelList.horizontalNormalizedPosition = arg_14_0:_getScrollTargetValue(var_14_0, var_14_1, arg_14_1)
end

function var_0_0._onRadioValueChanged(arg_15_0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, arg_15_0._fmsliderPingPosX)
end

local var_0_2 = 0.2

function var_0_0._onRadioValueChangeEnd(arg_16_0)
	arg_16_0._isDragging = false

	local var_16_0, var_16_1 = Activity125Config.instance:getChannelIndexRange(arg_16_0._actId, arg_16_0._curSelectedLvId)
	local var_16_2 = arg_16_0._scrollFMChannelList.horizontalNormalizedPosition
	local var_16_3 = 1 / (var_16_1 - var_16_0)

	if Mathf.Abs(arg_16_0._curSelectChannleIndex - var_16_2 / var_16_3) > 1 then
		arg_16_0._curSelectChannleIndex = Mathf.Floor(var_16_2 / var_16_3)
	end

	local var_16_4 = var_16_3 * (arg_16_0._curSelectChannleIndex - var_16_0)
	local var_16_5 = var_16_3 * (Mathf.Clamp(arg_16_0._curSelectChannleIndex + 1, var_16_0, var_16_1) - var_16_0)
	local var_16_6 = var_16_3 * (Mathf.Clamp(arg_16_0._curSelectChannleIndex - 1, var_16_0, var_16_1) - var_16_0)
	local var_16_7 = arg_16_0:_findNearestScrollValue(var_16_2, var_16_4, var_16_5, var_16_6)

	if arg_16_0._fmTweenId then
		ZProj.TweenHelper.KillById(arg_16_0._fmTweenId)

		arg_16_0._fmTweenId = nil
	end

	arg_16_0._fmTweenId = ZProj.TweenHelper.DOTweenFloat(var_16_2, var_16_7, var_0_2, arg_16_0._fmScrollMovingCallBack, arg_16_0._fmScrollMovedCallBack, arg_16_0)
end

function var_0_0._findNearestScrollValue(arg_17_0, arg_17_1, ...)
	local var_17_0 = {
		...
	}
	local var_17_1
	local var_17_2

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_3 = Mathf.Abs(iter_17_1 - arg_17_1)

		if not var_17_1 or var_17_3 < var_17_1 then
			var_17_1 = var_17_3
			var_17_2 = iter_17_1
		end
	end

	return var_17_2
end

function var_0_0._onRadioValueChangeBegin(arg_18_0)
	arg_18_0._isDragging = true

	TaskDispatcher.cancelTask(arg_18_0._checkIsFindCorrectFM, arg_18_0)
end

function var_0_0._checkIsFindCorrectFM(arg_19_0)
	if arg_19_0._curSelectChannleIndex == arg_19_0._targetFrequencyIndex and not arg_19_0._hasFindCorrectFM then
		arg_19_0:_onEpisodeFinished()
	end
end

function var_0_0._fmScrollMovingCallBack(arg_20_0, arg_20_1)
	arg_20_0._scrollFMChannelList.horizontalNormalizedPosition = arg_20_1
end

function var_0_0._getScrollTargetValue(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	return 1 / (arg_21_2 - arg_21_1) * (arg_21_3 - arg_21_1)
end

function var_0_0._fmScrollMovedCallBack(arg_22_0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, arg_22_0._fmsliderPingPosX)
	TaskDispatcher.cancelTask(arg_22_0._checkIsFindCorrectFM, arg_22_0)
	TaskDispatcher.runDelay(arg_22_0._checkIsFindCorrectFM, arg_22_0, var_0_1)
end

local var_0_3 = 6
local var_0_4 = 0.1

var_0_0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function var_0_0._refreshFMUI(arg_23_0, arg_23_1, arg_23_2)
	gohelper.setActive(arg_23_0._goWrongChannel, not arg_23_1)
	gohelper.setActive(arg_23_0._txtFMCHannelTip.gameObject, not arg_23_1)
	gohelper.setActive(arg_23_0._txtNoSignal.gameObject, not arg_23_1)
	gohelper.setActive(arg_23_0._scrollTaskDesc.gameObject, arg_23_1)
	gohelper.setActive(arg_23_0._txtFMChannelNum.gameObject, arg_23_1)
	gohelper.setActive(arg_23_0._btnplayquickly, false)

	arg_23_0._channelScrollRect.horizontal = not arg_23_1
	arg_23_0._FMChannelCanvasGroup.blocksRaycasts = not arg_23_1
	arg_23_0._FMChannelCanvasGroup.interactable = not arg_23_1
	arg_23_0._txtTaskContent.text = arg_23_0._config[arg_23_0._curSelectedLvId].text

	local var_23_0 = arg_23_1 and arg_23_0._targetFrequencyIndex or arg_23_0._inintFrequency

	arg_23_0:_pingScrollContentPos(var_23_0)

	arg_23_2 = arg_23_2 or var_0_0.AnimSwitchMode.None

	arg_23_0:_playAnimOnRefreshFMUI(arg_23_2)
	arg_23_0:_playAnimWhenFindCorrectFM(arg_23_2)
end

function var_0_0._onEpisodeFinished(arg_24_0)
	arg_24_0._hasFindCorrectFM = true

	arg_24_0:_refreshFMUI(arg_24_0._hasFindCorrectFM, var_0_0.AnimSwitchMode.UnFinish2Finish)

	local var_24_0 = arg_24_0._config[arg_24_0._curSelectedLvId].text

	if arg_24_0._tweenId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenId)

		arg_24_0._tweenId = nil
	end

	arg_24_0._txtTaskContent.text = ""
	arg_24_0._fmPlayStartTime = Time.time
	arg_24_0._taskTabCanvasGroup.blocksRaycasts = false
	arg_24_0._taskTabCanvasGroup.interactable = false
	arg_24_0._parentViewCanvasGroup.blocksRaycasts = false
	arg_24_0._viewGOCanvasGroup.ignoreParentGroups = true

	gohelper.setActive(arg_24_0._btnplayquickly, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_reach_frequency)

	arg_24_0._broadcastAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_broadcast)
	arg_24_0._tweenId = ZProj.TweenHelper.DOText(arg_24_0._txtTaskContent, var_24_0, var_0_3, arg_24_0._onPlayFMFinished, arg_24_0)
end

function var_0_0._playAnimOnRefreshFMUI(arg_25_0, arg_25_1)
	local var_25_0
	local var_25_1

	if arg_25_1 == var_0_0.AnimSwitchMode.UnFinish2Finish then
		var_25_0 = "go2"
		var_25_1 = "go2"
	elseif arg_25_1 == var_0_0.AnimSwitchMode.Finish2UnFinish then
		var_25_0 = "go1"
	elseif arg_25_1 == var_0_0.AnimSwitchMode.Finish then
		var_25_1 = "idle2"
	elseif arg_25_1 == var_0_0.AnimSwitchMode.UnFinish then
		var_25_0 = "idle1"
		var_25_1 = "idle1"
	end

	if var_25_0 then
		arg_25_0._middleAnim:Play(var_25_0, 0, 0)
	end

	if var_25_1 then
		arg_25_0._channelTitleAnim:Play(var_25_1, 0, 0)
	end
end

function var_0_0._playAnimWhenFindCorrectFM(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1 == var_0_0.AnimSwitchMode.UnFinish2Finish

	gohelper.setActive(arg_26_0._goleftwave, not var_26_0)
	gohelper.setActive(arg_26_0._gorightwave, not var_26_0)
	gohelper.setActive(arg_26_0._goleftwaveeffect, var_26_0)
	gohelper.setActive(arg_26_0._gorightwaveeffect, var_26_0)
	gohelper.setActive(arg_26_0._episodeItemTab[arg_26_0._curSelectedLvId].imagewave, not var_26_0)
	gohelper.setActive(arg_26_0._episodeItemTab[arg_26_0._curSelectedLvId].finishEffectGo, var_26_0)
end

function var_0_0.onChannelPing(arg_27_0, arg_27_1)
	arg_27_0:_pingScrollContentPos(arg_27_1)

	arg_27_0._isDragging = false
end

local var_0_5 = 3027

function var_0_0._refreshSpine(arg_28_0)
	if not arg_28_0._uiSpine then
		arg_28_0._uiSpine = GuiModelAgent.Create(arg_28_0._gospine, true)

		local var_28_0 = HeroConfig.instance:getHeroCO(var_0_5).skinId
		local var_28_1 = SkinConfig.instance:getSkinCo(var_28_0)

		arg_28_0._uiSpine:setResPath(var_28_1)

		local var_28_2 = SkinConfig.instance:getSkinOffset(var_28_1.characterViewOffset)

		recthelper.setAnchor(arg_28_0._gospine.transform, tonumber(var_28_2[1]), tonumber(var_28_2[2]))
		transformhelper.setLocalScale(arg_28_0._gospine.transform, tonumber(var_28_2[3]), tonumber(var_28_2[3]), tonumber(var_28_2[3]))

		arg_28_0._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)
	end
end

function var_0_0._initEpisodeList(arg_29_0)
	local var_29_0 = Activity125Config.instance:getEpisodeCount(arg_29_0._actId)

	for iter_29_0 = 1, var_29_0 do
		local var_29_1 = arg_29_0._episodeItemTab[iter_29_0]

		if not var_29_1 then
			local var_29_2 = gohelper.cloneInPlace(arg_29_0._goradiotaskitem, "taskItem" .. iter_29_0)
			local var_29_3 = gohelper.findChildText(var_29_2, "txt_DateUnSelected")
			local var_29_4 = gohelper.findChild(var_29_2, "image_Selected")
			local var_29_5 = gohelper.findChildText(var_29_2, "image_Selected/txt_DateSelected")
			local var_29_6 = gohelper.findChild(var_29_2, "image_Selected/Wave_effect2")
			local var_29_7 = gohelper.findChildImage(var_29_2, "image_Selected/image_wave")
			local var_29_8 = gohelper.findChild(var_29_2, "image_Locked")
			local var_29_9 = gohelper.getClick(var_29_2)

			var_29_9:AddClickListener(arg_29_0._taskItemOnClick, arg_29_0, iter_29_0)

			var_29_1 = {
				episodeItemGo = var_29_2,
				goDateSelected = var_29_4,
				txtDateSelected = var_29_5,
				imagewave = var_29_7,
				finishEffectGo = var_29_6,
				goLocked = var_29_8,
				txtDateUnSelected = var_29_3,
				click = var_29_9
			}
			arg_29_0._episodeItemTab[iter_29_0] = var_29_1
		end

		var_29_1.txtDateUnSelected.text = string.format("Day.%s", iter_29_0)
		var_29_1.txtDateSelected.text = string.format("Day.%s", iter_29_0)

		gohelper.setActive(var_29_1.episodeItemGo, true)
		gohelper.setActive(var_29_1.goDateSelected, iter_29_0 == arg_29_0._curSelectedLvId and iter_29_0 <= arg_29_0._curChallengeLv)
		gohelper.setActive(var_29_1.txtDateUnSelected.gameObject, iter_29_0 ~= arg_29_0._curSelectedLvId)
		gohelper.setActive(var_29_1.goLocked, iter_29_0 > arg_29_0._curChallengeLv)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_29_0._goTaskContent.transform)

	arg_29_0._scrollTaskTabList.horizontalNormalizedPosition = arg_29_0:_getScrollTargetValue(1, var_29_0, arg_29_0._curSelectedLvId)
end

function var_0_0._taskItemOnClick(arg_30_0, arg_30_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)

	if arg_30_1 == arg_30_0._curSelectedLvId then
		return
	end

	if arg_30_1 > arg_30_0._curChallengeLv then
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	arg_30_0._curSelectedLvId = arg_30_1
	arg_30_0._delayPlayRewardAnim = false

	local var_30_0 = Activity125Model.instance:isEpisodeFinished(arg_30_0._curSelectedLvId) and var_0_0.AnimSwitchMode.Finish or var_0_0.AnimSwitchMode.UnFinish

	arg_30_0:refreshUI(var_30_0)
end

function var_0_0._initRewards(arg_31_0)
	local var_31_0 = arg_31_0._config[arg_31_0._curSelectedLvId].bonus
	local var_31_1 = string.split(var_31_0, "|")

	arg_31_0._rewardCount = #var_31_1

	for iter_31_0 = 1, arg_31_0._rewardCount do
		if not arg_31_0._rewardItemTab[iter_31_0] then
			local var_31_2 = {
				go = gohelper.cloneInPlace(arg_31_0._gorewarditem, "rewarditem" .. iter_31_0)
			}
			local var_31_3 = gohelper.findChild(var_31_2.go, "go_icon")

			var_31_2.icon = IconMgr.instance:getCommonPropItemIcon(var_31_3)
			var_31_2.goreceive = gohelper.findChild(var_31_2.go, "go_receive")
			var_31_2.hasgetAnim = gohelper.findChild(var_31_2.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(arg_31_0._rewardItemTab, var_31_2)
		end

		gohelper.setActive(arg_31_0._rewardItemTab[iter_31_0].go, true)

		local var_31_4 = Activity125Model.instance:isEpisodeFinished(arg_31_0._curSelectedLvId)

		gohelper.setActive(arg_31_0._rewardItemTab[iter_31_0].goreceive, var_31_4 and not arg_31_0._delayPlayRewardAnim)

		local var_31_5 = string.splitToNumber(var_31_1[iter_31_0], "#")

		arg_31_0._rewardItemTab[iter_31_0].icon:setMOValue(var_31_5[1], var_31_5[2], var_31_5[3])
		arg_31_0._rewardItemTab[iter_31_0].icon:setCountFontSize(42)
		arg_31_0._rewardItemTab[iter_31_0].icon:setScale(0.5)
	end

	for iter_31_1 = arg_31_0._rewardCount + 1, #arg_31_0._rewardItemTab do
		gohelper.setActive(arg_31_0._rewardItemTab[iter_31_1].go, false)
	end
end

function var_0_0._onGetRewardAnim(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 == var_0_0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle"

	for iter_32_0 = 1, arg_32_0._rewardCount do
		gohelper.setActive(arg_32_0._rewardItemTab[iter_32_0].goreceive, true)
		arg_32_0._rewardItemTab[iter_32_0].hasgetAnim:Play(var_32_0, 0, 0)
	end

	arg_32_0._delayPlayRewardAnim = false
end

function var_0_0._onRewardRefresh(arg_33_0, arg_33_1)
	if arg_33_1 == ViewName.CommonPropView and arg_33_0._hasFindCorrectFM then
		arg_33_0._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)

		arg_33_0:_onGetRewardAnim(var_0_0.AnimSwitchMode.UnFinish2Finish)
	end
end

function var_0_0._onPlayFMFinished(arg_34_0)
	if arg_34_0._hasFindCorrectFM and arg_34_0._curSelectedLvId == arg_34_0._curChallengeLv then
		arg_34_0._delayPlayRewardAnim = true

		Activity125Controller.instance:onFinishActEpisode(arg_34_0._actId, arg_34_0._curSelectedLvId, arg_34_0._targetFrequencyIndex)

		if arg_34_0._broadcastAudioId then
			AudioMgr.instance:stopPlayingID(arg_34_0._broadcastAudioId)
		end

		if arg_34_0._spineAudioId then
			AudioMgr.instance:stopPlayingID(arg_34_0._spineAudioId)
		end
	end

	gohelper.setActive(arg_34_0._btnplayquickly, false)

	arg_34_0._taskTabCanvasGroup.blocksRaycasts = true
	arg_34_0._taskTabCanvasGroup.interactable = true
	arg_34_0._parentViewCanvasGroup.blocksRaycasts = true
	arg_34_0._viewGOCanvasGroup.ignoreParentGroups = false

	arg_34_0:_playAnimWhenFindCorrectFM(var_0_0.AnimSwitchMode.Finish)
	arg_34_0:_playAnimOnRefreshFMUI(var_0_0.AnimSwitchMode.Finish2UnFinish)
end

function var_0_0._onClickPlayQuickly(arg_35_0)
	if arg_35_0._tweenId then
		local var_35_0 = arg_35_0._config[arg_35_0._curSelectedLvId].text
		local var_35_1 = GameUtil.utf8len(var_35_0)
		local var_35_2 = (var_35_1 - var_35_1 / var_0_3 * (Time.time - arg_35_0._fmPlayStartTime)) / var_35_1 * var_0_4

		ZProj.TweenHelper.KillById(arg_35_0._tweenId)

		arg_35_0._tweenId = ZProj.TweenHelper.DOText(arg_35_0._txtTaskContent, var_35_0, var_35_2, arg_35_0._onPlayFMFinished, arg_35_0)

		gohelper.setActive(arg_35_0._btnplayquickly, false)
	end
end

function var_0_0._onDailyRefresh(arg_36_0)
	if arg_36_0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(arg_36_0._actId)
	end
end

function var_0_0.onClose(arg_37_0)
	arg_37_0._parentViewCanvasGroup.blocksRaycasts = true
	arg_37_0._viewGOCanvasGroup.ignoreParentGroups = false

	if arg_37_0._broadcastAudioId then
		AudioMgr.instance:stopPlayingID(arg_37_0._broadcastAudioId)
	end

	if arg_37_0._spineAudioId then
		AudioMgr.instance:stopPlayingID(arg_37_0._spineAudioId)
	end
end

function var_0_0.onDestroyView(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._checkIsFindCorrectFM, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._onRefreshDeadline, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._refreshSelectedFMSliderItem, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._delaySelectCell, arg_38_0)

	if arg_38_0._uiSpine then
		arg_38_0._uiSpine:onDestroy()

		arg_38_0._uiSpine = nil
	end

	if arg_38_0._episodeItemTab then
		for iter_38_0, iter_38_1 in pairs(arg_38_0._episodeItemTab) do
			iter_38_1.click:RemoveClickListener()
		end
	end

	if arg_38_0._tweenId then
		ZProj.TweenHelper.KillById(arg_38_0._tweenId)

		arg_38_0._tweenId = nil
	end

	if arg_38_0._fmTweenId then
		ZProj.TweenHelper.KillById(arg_38_0._fmTweenId)

		arg_38_0._fmTweenId = nil
	end

	arg_38_0._config = nil

	arg_38_0._simageFullBG:UnLoadImage()
	arg_38_0._simageVoicePrint1:UnLoadImage()
	arg_38_0._simageVoicePrint2:UnLoadImage()
end

return var_0_0
