module("modules.logic.versionactivity1_3.act125.view.VersionActivity1_3RadioView", package.seeall)

slot0 = class("VersionActivity1_3RadioView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goVoicePrint1 = gohelper.findChild(slot0.viewGO, "Middle/#go_VoicePrint1")
	slot0._simageVoicePrint1 = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#go_VoicePrint1/#simage_VoicePrint1")
	slot0._goVoicePrint2 = gohelper.findChild(slot0.viewGO, "Middle/#go_VoicePrint2")
	slot0._simageVoicePrint2 = gohelper.findChildSingleImage(slot0.viewGO, "Middle/#go_VoicePrint2/#simage_VoicePrint2")
	slot0._txtFMChannelNum = gohelper.findChildText(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum")
	slot0._scrollFMChannelList = gohelper.findChildScrollRect(slot0.viewGO, "Middle/FMSlider/#scroll_FMChannelList")
	slot0._goradiochannelitem = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content/#go_radiochannelitem")
	slot0._imageFMSliderThumbLine = gohelper.findChildImage(slot0.viewGO, "Middle/FMSlider/Lower/#image_FMSliderThumbLine")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._scrollTaskTabList = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goradiotaskitem = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	slot0._txtTaskTitle = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/Title/#txt_TaskTitle")
	slot0._txtTaskFMChannelNum = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/Title/#txt_TaskFMChannelNum")
	slot0._scrollTaskDesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	slot0._txtTaskContent = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Right/RawardPanel/#scroll_Reward")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "Middle/spinecontainer/#go_spine")
	slot0._goWrongChannel = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	slot0._goUpper = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper")
	slot0._txtFMCHannelTip = gohelper.findChildText(slot0.viewGO, "Middle/FMSlider/Lower/txt_FMChannelTips")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	slot0._btnplayquickly = gohelper.findChildButton(slot0.viewGO, "#btn_playquickly")
	slot0._txtNoSignal = gohelper.findChildText(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_NoSignal")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._drag:AddDragListener(slot0._onRadioValueChanged, slot0)
	slot0._drag:AddDragEndListener(slot0._onRadioValueChangeEnd, slot0)
	slot0._drag:AddDragBeginListener(slot0._onRadioValueChangeBegin, slot0)
	slot0._btnplayquickly:AddClickListener(slot0._onClickPlayQuickly, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelSelected, slot0.onChannelSelected, slot0)
	Activity125Controller.instance:registerCallback(Activity125Event.OnChannelItemClick, slot0.onChannelPing, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._btnplayquickly:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, slot0.refreshUI, slot0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelSelected, slot0.onChannelSelected, slot0)
	Activity125Controller.instance:unregisterCallback(Activity125Event.OnChannelItemClick, slot0.onChannelPing, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onRewardRefresh, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._editableInitView(slot0)
	slot0._episodeItemTab = slot0:getUserDataTb_()
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._fmsliderPingPosX = transformhelper.getPos(slot0._imageFMSliderThumbLine.transform)
	slot0._channelScrollRect = gohelper.onceAddComponent(slot0._scrollFMChannelList, typeof(UnityEngine.UI.ScrollRect))
	slot0._FMChannelCanvasGroup = gohelper.onceAddComponent(slot0._scrollFMChannelList, typeof(UnityEngine.CanvasGroup))
	slot0._taskTabCanvasGroup = gohelper.onceAddComponent(slot0._scrollTaskTabList, typeof(UnityEngine.CanvasGroup))
	slot0._viewGOCanvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))

	slot0._simageFullBG:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_fullbg"))
	slot0._simageVoicePrint1:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_1"))
	slot0._simageVoicePrint2:LoadImage(ResUrl.getRadioIcon_1_3("v1a3_radio_voiceprint_2"))

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollFMChannelList.gameObject)
	slot0._goRewardContent = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	slot0._goChannelContent = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#scroll_FMChannelList/Viewport/Content")
	slot0._goTaskContent = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	slot0._goleftwave = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LeftWave")
	slot0._gorightwave = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RightWave")
	slot0._goleftwaveeffect = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/LWave_effect1")
	slot0._gorightwaveeffect = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle/#txt_FMChannelNum/RWave_effect1")
	slot0._middleAnim = gohelper.findChild(slot0.viewGO, "Middle"):GetComponent(typeof(UnityEngine.Animator))
	slot0._channelTitleAnim = gohelper.findChild(slot0.viewGO, "Middle/FMSlider/#go_Upper/ChannelTitle"):GetComponent(typeof(UnityEngine.Animator))
	slot0._isFirstInitUI = true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._parentViewCanvasGroup = gohelper.onceAddComponent(slot0.viewParam.root, typeof(UnityEngine.CanvasGroup))

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId
	slot0._config = Activity125Config.instance:getAct125Config(slot0._actId)

	Activity125Controller.instance:getAct125InfoFromServer(slot0._actId)
end

function slot0.refreshUI(slot0, slot1)
	slot0:_refreshData()
	slot0:_showDeadline()
	slot0:_initChannels()
	slot0:_refreshSpine()
	slot0:_initEpisodeList()

	if slot0._isFirstInitUI and not slot1 then
		slot1 = slot0._hasFindCorrectFM and uv0.AnimSwitchMode.Finish or uv0.AnimSwitchMode.UnFinish
		slot0._isFirstInitUI = false
	end

	slot0:_refreshFMUI(slot0._hasFindCorrectFM, slot1)
	slot0:_initRewards()
end

function slot0._refreshData(slot0)
	slot0._curChallengeLv = Activity125Model.instance:getCurChallengeEpisodeId()
	slot0._curSelectedLvId = slot0._curSelectedLvId or slot0._curChallengeLv
	slot0._inintFrequency = slot0._config[slot0._curSelectedLvId].initFrequency
	slot0._targetFrequencyIndex = tonumber(slot0._config[slot0._curSelectedLvId].targetFrequency)
	slot0._hasFindCorrectFM = Activity125Model.instance:isEpisodeFinished(slot0._curSelectedLvId)
	slot0._curSelectChannleIndex = slot0._hasFindCorrectFM and slot0._targetFrequencyIndex or slot0._config[slot0._curSelectedLvId].initFrequency
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 60)
end

function slot0._onRefreshDeadline(slot0)
	slot1, slot2 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), slot1, slot2)

	if slot1 <= 0 and slot2 <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end
end

function slot0._initChannels(slot0)
	slot1 = Activity125Config.instance:getChannelParseResult(slot0._actId, slot0._curSelectedLvId)
	slot0._targetChannelValue = slot1.targetFrequencyValue

	V1A3_RadioChannelListModel.instance:setCategoryList(slot0:buildChannelListModel(slot1))
	slot0.viewContainer._channelScrollView:selectCell(slot0._curSelectChannleIndex - slot1.wholeStartIndex + 1, true)
	gohelper.setActive(slot0._goWrongChannel, not slot0._hasFindCorrectFM)
	gohelper.setActive(slot0._scrollTaskDesc.gameObject, slot0._hasFindCorrectFM)

	slot0._txtFMChannelNum.text = string.format("FM.%s", slot0._targetChannelValue)
	slot0._txtTaskFMChannelNum.text = string.format("FM.%s", slot0._targetChannelValue)
	slot0._txtTaskTitle.text = slot0._config[slot0._curSelectedLvId].name
end

function slot0.buildChannelListModel(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot10 = slot7.endIndex
		slot11 = slot7.startValue
		slot12 = slot7.endValue

		if slot7.type == Activity125Config.ChannelCfgType.Point then
			slot10 = slot7.startIndex

			for slot16 = slot7.lastIndex + 1, slot7.startIndex - 1 do
				table.insert(slot2, {
					isEmpty = true,
					id = slot16
				})
			end
		end

		for slot16 = slot9, slot10 do
			table.insert(slot2, {
				id = slot16,
				value = Activity125Config.instance:getRealFrequencyValue(slot16, slot9, slot11, slot10, slot12)
			})
		end
	end

	return slot2
end

slot1 = 1

function slot0.onChannelSelected(slot0, slot1)
	if slot1 ~= slot0._curSelectChannleIndex and not slot0._hasFindCorrectFM then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_frequency)
	end

	slot0._curSelectChannleIndex = slot1

	TaskDispatcher.cancelTask(slot0._checkIsFindCorrectFM, slot0)

	if not slot0._isDragging then
		TaskDispatcher.runDelay(slot0._checkIsFindCorrectFM, slot0, uv0)
	end
end

function slot0._pingScrollContentPos(slot0, slot1)
	slot2, slot3 = Activity125Config.instance:getChannelIndexRange(slot0._actId, slot0._curSelectedLvId)
	slot0._scrollFMChannelList.horizontalNormalizedPosition = slot0:_getScrollTargetValue(slot2, slot3, slot1)
end

function slot0._onRadioValueChanged(slot0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, slot0._fmsliderPingPosX)
end

slot2 = 0.2

function slot0._onRadioValueChangeEnd(slot0)
	slot0._isDragging = false
	slot1, slot2 = Activity125Config.instance:getChannelIndexRange(slot0._actId, slot0._curSelectedLvId)

	if Mathf.Abs(slot0._curSelectChannleIndex - slot0._scrollFMChannelList.horizontalNormalizedPosition / (1 / (slot2 - slot1))) > 1 then
		slot0._curSelectChannleIndex = Mathf.Floor(slot3 / slot4)
	end

	slot8 = slot0:_findNearestScrollValue(slot3, slot4 * (slot0._curSelectChannleIndex - slot1), slot4 * (Mathf.Clamp(slot0._curSelectChannleIndex + 1, slot1, slot2) - slot1), slot4 * (Mathf.Clamp(slot0._curSelectChannleIndex - 1, slot1, slot2) - slot1))

	if slot0._fmTweenId then
		ZProj.TweenHelper.KillById(slot0._fmTweenId)

		slot0._fmTweenId = nil
	end

	slot0._fmTweenId = ZProj.TweenHelper.DOTweenFloat(slot3, slot8, uv0, slot0._fmScrollMovingCallBack, slot0._fmScrollMovedCallBack, slot0)
end

function slot0._findNearestScrollValue(slot0, slot1, ...)
	slot3, slot4 = nil

	for slot8, slot9 in pairs({
		...
	}) do
		slot10 = Mathf.Abs(slot9 - slot1)

		if not slot3 or slot10 < slot3 then
			slot3 = slot10
			slot4 = slot9
		end
	end

	return slot4
end

function slot0._onRadioValueChangeBegin(slot0)
	slot0._isDragging = true

	TaskDispatcher.cancelTask(slot0._checkIsFindCorrectFM, slot0)
end

function slot0._checkIsFindCorrectFM(slot0)
	if slot0._curSelectChannleIndex == slot0._targetFrequencyIndex and not slot0._hasFindCorrectFM then
		slot0:_onEpisodeFinished()
	end
end

function slot0._fmScrollMovingCallBack(slot0, slot1)
	slot0._scrollFMChannelList.horizontalNormalizedPosition = slot1
end

function slot0._getScrollTargetValue(slot0, slot1, slot2, slot3)
	return 1 / (slot2 - slot1) * (slot3 - slot1)
end

function slot0._fmScrollMovedCallBack(slot0)
	Activity125Controller.instance:dispatchEvent(Activity125Event.OnFMScrollValueChange, slot0._fmsliderPingPosX)
	TaskDispatcher.cancelTask(slot0._checkIsFindCorrectFM, slot0)
	TaskDispatcher.runDelay(slot0._checkIsFindCorrectFM, slot0, uv0)
end

slot3 = 6
slot4 = 0.1
slot0.AnimSwitchMode = {
	UnFinish2Finish = 3,
	Finish = 1,
	Finish2UnFinish = 4,
	UnFinish = 2,
	None = 0
}

function slot0._refreshFMUI(slot0, slot1, slot2)
	gohelper.setActive(slot0._goWrongChannel, not slot1)
	gohelper.setActive(slot0._txtFMCHannelTip.gameObject, not slot1)
	gohelper.setActive(slot0._txtNoSignal.gameObject, not slot1)
	gohelper.setActive(slot0._scrollTaskDesc.gameObject, slot1)
	gohelper.setActive(slot0._txtFMChannelNum.gameObject, slot1)
	gohelper.setActive(slot0._btnplayquickly, false)

	slot0._channelScrollRect.horizontal = not slot1
	slot0._FMChannelCanvasGroup.blocksRaycasts = not slot1
	slot0._FMChannelCanvasGroup.interactable = not slot1
	slot0._txtTaskContent.text = slot0._config[slot0._curSelectedLvId].text

	slot0:_pingScrollContentPos(slot1 and slot0._targetFrequencyIndex or slot0._inintFrequency)

	slot2 = slot2 or uv0.AnimSwitchMode.None

	slot0:_playAnimOnRefreshFMUI(slot2)
	slot0:_playAnimWhenFindCorrectFM(slot2)
end

function slot0._onEpisodeFinished(slot0)
	slot0._hasFindCorrectFM = true

	slot0:_refreshFMUI(slot0._hasFindCorrectFM, uv0.AnimSwitchMode.UnFinish2Finish)

	slot1 = slot0._config[slot0._curSelectedLvId].text

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._txtTaskContent.text = ""
	slot0._fmPlayStartTime = Time.time
	slot0._taskTabCanvasGroup.blocksRaycasts = false
	slot0._taskTabCanvasGroup.interactable = false
	slot0._parentViewCanvasGroup.blocksRaycasts = false
	slot0._viewGOCanvasGroup.ignoreParentGroups = true

	gohelper.setActive(slot0._btnplayquickly, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_reach_frequency)

	slot0._broadcastAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_broadcast)
	slot0._tweenId = ZProj.TweenHelper.DOText(slot0._txtTaskContent, slot1, uv1, slot0._onPlayFMFinished, slot0)
end

function slot0._playAnimOnRefreshFMUI(slot0, slot1)
	slot2, slot3 = nil

	if slot1 == uv0.AnimSwitchMode.UnFinish2Finish then
		slot2 = "go2"
		slot3 = "go2"
	elseif slot1 == uv0.AnimSwitchMode.Finish2UnFinish then
		slot2 = "go1"
	elseif slot1 == uv0.AnimSwitchMode.Finish then
		slot3 = "idle2"
	elseif slot1 == uv0.AnimSwitchMode.UnFinish then
		slot2 = "idle1"
		slot3 = "idle1"
	end

	if slot2 then
		slot0._middleAnim:Play(slot2, 0, 0)
	end

	if slot3 then
		slot0._channelTitleAnim:Play(slot3, 0, 0)
	end
end

function slot0._playAnimWhenFindCorrectFM(slot0, slot1)
	slot2 = slot1 == uv0.AnimSwitchMode.UnFinish2Finish

	gohelper.setActive(slot0._goleftwave, not slot2)
	gohelper.setActive(slot0._gorightwave, not slot2)
	gohelper.setActive(slot0._goleftwaveeffect, slot2)
	gohelper.setActive(slot0._gorightwaveeffect, slot2)
	gohelper.setActive(slot0._episodeItemTab[slot0._curSelectedLvId].imagewave, not slot2)
	gohelper.setActive(slot0._episodeItemTab[slot0._curSelectedLvId].finishEffectGo, slot2)
end

function slot0.onChannelPing(slot0, slot1)
	slot0:_pingScrollContentPos(slot1)

	slot0._isDragging = false
end

slot5 = 3027

function slot0._refreshSpine(slot0)
	if not slot0._uiSpine then
		slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)
		slot2 = SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(uv0).skinId)

		slot0._uiSpine:setResPath(slot2)

		slot3 = SkinConfig.instance:getSkinOffset(slot2.characterViewOffset)

		recthelper.setAnchor(slot0._gospine.transform, tonumber(slot3[1]), tonumber(slot3[2]))
		transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot3[3]), tonumber(slot3[3]), tonumber(slot3[3]))

		slot0._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)
	end
end

function slot0._initEpisodeList(slot0)
	for slot5 = 1, Activity125Config.instance:getEpisodeCount(slot0._actId) do
		if not slot0._episodeItemTab[slot5] then
			slot7 = gohelper.cloneInPlace(slot0._goradiotaskitem, "taskItem" .. slot5)
			slot14 = gohelper.getClick(slot7)

			slot14:AddClickListener(slot0._taskItemOnClick, slot0, slot5)

			slot0._episodeItemTab[slot5] = {
				episodeItemGo = slot7,
				goDateSelected = gohelper.findChild(slot7, "image_Selected"),
				txtDateSelected = gohelper.findChildText(slot7, "image_Selected/txt_DateSelected"),
				imagewave = gohelper.findChildImage(slot7, "image_Selected/image_wave"),
				finishEffectGo = gohelper.findChild(slot7, "image_Selected/Wave_effect2"),
				goLocked = gohelper.findChild(slot7, "image_Locked"),
				txtDateUnSelected = gohelper.findChildText(slot7, "txt_DateUnSelected"),
				click = slot14
			}
		end

		slot6.txtDateUnSelected.text = string.format("Day.%s", slot5)
		slot6.txtDateSelected.text = string.format("Day.%s", slot5)

		gohelper.setActive(slot6.episodeItemGo, true)
		gohelper.setActive(slot6.goDateSelected, slot5 == slot0._curSelectedLvId and slot5 <= slot0._curChallengeLv)
		gohelper.setActive(slot6.txtDateUnSelected.gameObject, slot5 ~= slot0._curSelectedLvId)
		gohelper.setActive(slot6.goLocked, slot0._curChallengeLv < slot5)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContent.transform)

	slot0._scrollTaskTabList.horizontalNormalizedPosition = slot0:_getScrollTargetValue(1, slot1, slot0._curSelectedLvId)
end

function slot0._taskItemOnClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)

	if slot1 == slot0._curSelectedLvId then
		return
	end

	if slot0._curChallengeLv < slot1 then
		GameFacade.showToast(ToastEnum.ConditionLock)

		return
	end

	slot0._curSelectedLvId = slot1
	slot0._delayPlayRewardAnim = false

	slot0:refreshUI(Activity125Model.instance:isEpisodeFinished(slot0._curSelectedLvId) and uv0.AnimSwitchMode.Finish or uv0.AnimSwitchMode.UnFinish)
end

function slot0._initRewards(slot0)
	slot0._rewardCount = #string.split(slot0._config[slot0._curSelectedLvId].bonus, "|")

	for slot6 = 1, slot0._rewardCount do
		if not slot0._rewardItemTab[slot6] then
			slot7 = {
				go = gohelper.cloneInPlace(slot0._gorewarditem, "rewarditem" .. slot6)
			}
			slot7.icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot7.go, "go_icon"))
			slot7.goreceive = gohelper.findChild(slot7.go, "go_receive")
			slot7.hasgetAnim = gohelper.findChild(slot7.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))

			table.insert(slot0._rewardItemTab, slot7)
		end

		gohelper.setActive(slot0._rewardItemTab[slot6].go, true)
		gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, Activity125Model.instance:isEpisodeFinished(slot0._curSelectedLvId) and not slot0._delayPlayRewardAnim)

		slot9 = string.splitToNumber(slot2[slot6], "#")

		slot0._rewardItemTab[slot6].icon:setMOValue(slot9[1], slot9[2], slot9[3])
		slot0._rewardItemTab[slot6].icon:setCountFontSize(42)
		slot0._rewardItemTab[slot6].icon:setScale(0.5)
	end

	for slot6 = slot0._rewardCount + 1, #slot0._rewardItemTab do
		gohelper.setActive(slot0._rewardItemTab[slot6].go, false)
	end
end

function slot0._onGetRewardAnim(slot0, slot1)
	for slot6 = 1, slot0._rewardCount do
		gohelper.setActive(slot0._rewardItemTab[slot6].goreceive, true)
		slot0._rewardItemTab[slot6].hasgetAnim:Play(slot1 == uv0.AnimSwitchMode.UnFinish2Finish and "go_hasget_in" or "go_hasget_idle", 0, 0)
	end

	slot0._delayPlayRewardAnim = false
end

function slot0._onRewardRefresh(slot0, slot1)
	if slot1 == ViewName.CommonPropView and slot0._hasFindCorrectFM then
		slot0._spineAudioId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_radio_resident_status_loop)

		slot0:_onGetRewardAnim(uv0.AnimSwitchMode.UnFinish2Finish)
	end
end

function slot0._onPlayFMFinished(slot0)
	if slot0._hasFindCorrectFM and slot0._curSelectedLvId == slot0._curChallengeLv then
		slot0._delayPlayRewardAnim = true

		Activity125Controller.instance:onFinishActEpisode(slot0._actId, slot0._curSelectedLvId, slot0._targetFrequencyIndex)

		if slot0._broadcastAudioId then
			AudioMgr.instance:stopPlayingID(slot0._broadcastAudioId)
		end

		if slot0._spineAudioId then
			AudioMgr.instance:stopPlayingID(slot0._spineAudioId)
		end
	end

	gohelper.setActive(slot0._btnplayquickly, false)

	slot0._taskTabCanvasGroup.blocksRaycasts = true
	slot0._taskTabCanvasGroup.interactable = true
	slot0._parentViewCanvasGroup.blocksRaycasts = true
	slot0._viewGOCanvasGroup.ignoreParentGroups = false

	slot0:_playAnimWhenFindCorrectFM(uv0.AnimSwitchMode.Finish)
	slot0:_playAnimOnRefreshFMUI(uv0.AnimSwitchMode.Finish2UnFinish)
end

function slot0._onClickPlayQuickly(slot0)
	if slot0._tweenId then
		slot1 = slot0._config[slot0._curSelectedLvId].text
		slot2 = GameUtil.utf8len(slot1)

		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = ZProj.TweenHelper.DOText(slot0._txtTaskContent, slot1, (slot2 - slot2 / uv0 * (Time.time - slot0._fmPlayStartTime)) / slot2 * uv1, slot0._onPlayFMFinished, slot0)

		gohelper.setActive(slot0._btnplayquickly, false)
	end
end

function slot0._onDailyRefresh(slot0)
	if slot0._actId then
		Activity125Controller.instance:getAct125InfoFromServer(slot0._actId)
	end
end

function slot0.onClose(slot0)
	slot0._parentViewCanvasGroup.blocksRaycasts = true
	slot0._viewGOCanvasGroup.ignoreParentGroups = false

	if slot0._broadcastAudioId then
		AudioMgr.instance:stopPlayingID(slot0._broadcastAudioId)
	end

	if slot0._spineAudioId then
		AudioMgr.instance:stopPlayingID(slot0._spineAudioId)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._checkIsFindCorrectFM, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._refreshSelectedFMSliderItem, slot0)
	TaskDispatcher.cancelTask(slot0._delaySelectCell, slot0)

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	if slot0._episodeItemTab then
		for slot4, slot5 in pairs(slot0._episodeItemTab) do
			slot5.click:RemoveClickListener()
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._fmTweenId then
		ZProj.TweenHelper.KillById(slot0._fmTweenId)

		slot0._fmTweenId = nil
	end

	slot0._config = nil

	slot0._simageFullBG:UnLoadImage()
	slot0._simageVoicePrint1:UnLoadImage()
	slot0._simageVoicePrint2:UnLoadImage()
end

return slot0
