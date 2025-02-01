module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelView", package.seeall)

slot0 = class("LoperaLevelView", BaseView)
slot1 = "<sprite=0>"
slot2 = {
	SelectDir = 1,
	OptionDesc = 3,
	SelectOption = 2
}
slot3 = LoperaEnum.MapCfgIdx
slot4 = LoperaEnum.DirEnum
slot5 = VersionActivity2_2Enum.ActivityId.Lopera
slot6 = "singlebg/v2a2_lopera_singlebg/"
slot7 = "v2a2_lopera_levelmap1.png"
slot8 = "<color=#403933>%s</color>"
slot9 = "<color=#b25712>%s</color>"
slot10 = 1.5
slot11 = 0.75
slot12 = "LoperaLevelViewMovingBlock"
slot13 = 150

function slot0.onInitView(slot0)
	slot0._goDir = gohelper.findChild(slot0.viewGO, "#go_Compass")
	slot0._btnN = gohelper.findChildClick(slot0._goDir, "Compass/ClickArea/clickN")
	slot0._btnW = gohelper.findChildClick(slot0._goDir, "Compass/ClickArea/clickW")
	slot0._btnE = gohelper.findChildClick(slot0._goDir, "Compass/ClickArea/clickE")
	slot0._btnS = gohelper.findChildClick(slot0._goDir, "Compass/ClickArea/clickS")
	slot0._goNPress = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG1/#go_N")
	slot0._goWPress = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG1/#go_W")
	slot0._goEPress = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG1/#go_E")
	slot0._goSPress = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG1/#go_S")
	slot0._goNNormal = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG2/#go_N")
	slot0._goWNormal = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG2/#go_W")
	slot0._goENormal = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG2/#go_E")
	slot0._goSNormal = gohelper.findChild(slot0._goDir, "Compass/#go_CompassFG2/#go_S")
	slot0._txtPowerCostNum = gohelper.findChildText(slot0._goDir, "image_PowerIcon/#txt_PowerNum")
	slot0._btnAlchemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Smelt")
	slot0._goSmeltRed = gohelper.findChild(slot0.viewGO, "#btn_Smelt/#go_reddot")
	slot0._goSmeltBtn = gohelper.findChild(slot0.viewGO, "#btn_Smelt")
	slot0._goOption = gohelper.findChild(slot0.viewGO, "#go_Question")
	slot0._goOptionItemRoot = gohelper.findChild(slot0._goOption, "List")
	slot0._goOptionItem = gohelper.findChild(slot0._goOption, "List/#go_Item")
	slot0._bgRoot = gohelper.findChild(slot0.viewGO, "BG")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "BG/bg")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "BG/bg1")
	slot0._bgAnimator = slot0._bgRoot:GetComponent(gohelper.Type_Animator)
	slot0._textLocation = gohelper.findChildText(slot0.viewGO, "TargetList/Title/image_TitleBG/#txt_Title")
	slot0._goLocationEffect = gohelper.findChild(slot0.viewGO, "TargetList/Title/vx_hint1")
	slot0._textStageName = gohelper.findChildText(slot0.viewGO, "TargetList/Title/image_TitleBG/txt_TitleEn")
	slot0._textActionPoint = gohelper.findChildText(slot0.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	slot0._gpActionPointEffect = gohelper.findChild(slot0.viewGO, "TargetList/mainTarget/vx_hint2")
	slot0._eventDescRoot = gohelper.findChild(slot0.viewGO, "#go_Descr")
	slot0._btnEventDesc = gohelper.findChildButtonWithAudio(slot0._eventDescRoot, "btn_descClose")
	slot0._btnEventDescViewPort = gohelper.findChildButtonWithAudio(slot0._eventDescRoot, "Scroll View/Viewport")
	slot0._textEventDesc = gohelper.findChildText(slot0.viewGO, "#go_Descr/Scroll View/Viewport/#txt_Descr")
	slot0._goDescArrow = gohelper.findChild(slot0.viewGO, "#go_Descr/#go_ArrowTips")
	slot0._goBuff = gohelper.findChild(slot0.viewGO, "#btn_State")
	slot0._btnState = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_State")
	slot0._goBuffItemRoot = gohelper.findChild(slot0.viewGO, "#btn_State/#go_StateBG")
	slot0._goBuffInfoItem = gohelper.findChild(slot0.viewGO, "#btn_State/#go_StateBG/#txt_State")
end

function slot0.addEvents(slot0)
	slot0._btnN:AddClickListener(slot0._onClickDir, slot0, uv0.North)
	slot0._btnN:AddClickDownListener(slot0._onClickDirDown, slot0, uv0.North)
	slot0._btnN:AddClickUpListener(slot0._onClickDirUp, slot0, uv0.North)
	slot0._btnW:AddClickListener(slot0._onClickDir, slot0, uv0.West)
	slot0._btnW:AddClickDownListener(slot0._onClickDirDown, slot0, uv0.West)
	slot0._btnW:AddClickUpListener(slot0._onClickDirUp, slot0, uv0.West)
	slot0._btnE:AddClickListener(slot0._onClickDir, slot0, uv0.East)
	slot0._btnE:AddClickDownListener(slot0._onClickDirDown, slot0, uv0.East)
	slot0._btnE:AddClickUpListener(slot0._onClickDirUp, slot0, uv0.East)
	slot0._btnS:AddClickListener(slot0._onClickDir, slot0, uv0.South)
	slot0._btnS:AddClickDownListener(slot0._onClickDirDown, slot0, uv0.South)
	slot0._btnS:AddClickUpListener(slot0._onClickDirUp, slot0, uv0.South)
	slot0._btnAlchemy:AddClickListener(slot0._onClickAlchemy, slot0)
	slot0._btnEventDesc:AddClickListener(slot0._onClickOptionResult, slot0)
	slot0._btnEventDescViewPort:AddClickListener(slot0._onClickOptionResult, slot0)
	slot0._btnState:AddClickListener(slot0._onClickBtnState, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnN:RemoveClickListener()
	slot0._btnN:RemoveClickDownListener()
	slot0._btnN:RemoveClickUpListener()
	slot0._btnW:RemoveClickListener()
	slot0._btnW:RemoveClickDownListener()
	slot0._btnW:RemoveClickUpListener()
	slot0._btnE:RemoveClickListener()
	slot0._btnE:RemoveClickDownListener()
	slot0._btnE:RemoveClickUpListener()
	slot0._btnS:RemoveClickListener()
	slot0._btnS:RemoveClickDownListener()
	slot0._btnS:RemoveClickUpListener()
	slot0._btnAlchemy:RemoveClickListener()
	slot0._btnEventDesc:RemoveClickListener()
	slot0._btnEventDescViewPort:RemoveClickListener()
	slot0._btnState:RemoveClickListener()
end

function slot0._onClickAlchemy(slot0)
	LoperaController.instance:openSmeltView()
end

function slot0._onClickDir(slot0, slot1)
	if not slot0._moveAbleDirs[slot1] then
		return
	end

	slot0._dir = slot1

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_common_click)
	LoperaController.instance:moveToDir(slot1)
end

function slot0._onClickDirDown(slot0, slot1)
	if not slot0._moveAbleDirs[slot1] then
		return
	end

	gohelper.setActive(slot0._dirBtnPressStatsGos[slot1], true)
end

function slot0._onClickDirUp(slot0, slot1)
	if not slot0._moveAbleDirs[slot1] then
		return
	end

	gohelper.setActive(slot0._dirBtnPressStatsGos[slot1], false)
end

function slot0._onClickOptionResult(slot0)
	if slot0._curState == uv0.OptionDesc then
		if slot0._isShowingDescTyping then
			slot0._isShowingDescTyping = false

			if slot0._tweenId then
				ZProj.TweenHelper.KillById(slot0._tweenId, true)

				slot0._tweenId = nil
			end

			if slot0._moveRectTweenId then
				ZProj.TweenHelper.KillById(slot0._moveRectTweenId)

				slot0._moveRectTweenId = nil
			end

			slot0._textEventDesc.text = slot0._descContent

			if uv1 < slot0._textEventDesc.preferredHeight then
				recthelper.setHeight(slot0._textEventDesc.transform, slot1 - uv1)
			end
		else
			slot0:_changeLevelState(uv0.SelectDir)
		end
	end
end

function slot0._onClickBtnState(slot0)
	gohelper.setActive(slot0._goBuffItemRoot, not slot0._goBuffItemRoot.activeSelf)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam

	slot0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, slot0.onExitGame, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeMove, slot0._onMoveInEpisode, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.SelectOption, slot0._onSelectedOption, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, slot0._onGetToDestination, slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, slot0._onSmeltResult, slot0)

	slot0._redDotComp = RedDotController.instance:addNotEventRedDot(slot0._goSmeltRed, slot0._hasSmeltRed, slot0)
	slot2 = Activity168Model.instance:getCurGameState()
	slot0._curEventId = slot2.eventId
	slot0._curActionPoint = Activity168Model.instance:getCurActionPoint()
	slot0._moveAbleDirs = {}
	slot0._endLessId = slot2.endlessId
	slot0._isEndLess = slot0._endLessId > 0
	slot0._curEpisode = Activity168Model.instance:getCurEpisodeId()
	slot3 = Activity168Config.instance:getEpisodeCfg(uv0, slot0._curEpisode)

	slot0:_initBgView()

	slot0._dirBtnNormalStateGos = slot0:getUserDataTb_()
	slot0._dirBtnNormalStateGos[uv1.North] = slot0._goNNormal
	slot0._dirBtnNormalStateGos[uv1.South] = slot0._goSNormal
	slot0._dirBtnNormalStateGos[uv1.West] = slot0._goWNormal
	slot0._dirBtnNormalStateGos[uv1.East] = slot0._goENormal
	slot0._dirBtnPressStatsGos = slot0:getUserDataTb_()
	slot0._dirBtnPressStatsGos[uv1.North] = slot0._goNPress
	slot0._dirBtnPressStatsGos[uv1.South] = slot0._goSPress
	slot0._dirBtnPressStatsGos[uv1.West] = slot0._goWPress
	slot0._dirBtnPressStatsGos[uv1.East] = slot0._goEPress

	slot0:_resetDirPressState()

	slot0._showTipsRoundNum = Activity168Config.instance:getConstCfg(uv0, 6).value1

	if slot0._curEventId ~= 0 then
		slot0._curState = slot2.option <= 0 and uv2.SelectOption or uv2.SelectDir
	else
		slot0._curState = uv2.SelectDir
	end

	slot4 = slot2.round == 1

	if not slot0._isEndLess then
		slot0._curMapCfg = Activity168Config.instance:getMapCfg(slot3.mapId)
		slot0._curCellIdx = (slot4 and Activity168Config.instance:getMapStartCell() or Activity168Config.instance:getMapCellByCoord({
			slot2.x,
			slot2.y
		}))[uv3.id] + 1
	end

	if slot4 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, "")
	end

	slot0:_initLeftInfoView()
	slot0:updatePowerInfoView()
	slot0:updateLocationInfoView()
	slot0:_changeLevelState(slot0._curState)
end

function slot0.onExitGame(slot0)
	slot0:closeThis()
end

function slot0.updateStateView(slot0)
	if slot0._redDotComp then
		slot0._redDotComp:refreshRedDot()
	end

	if Activity168Model.instance:getCurActionPoint() ~= slot0._curActionPoint then
		slot0:updatePowerInfoView()
	end

	slot0._curActionPoint = Activity168Model.instance:getCurActionPoint()

	if slot0._curState == uv0.SelectDir then
		gohelper.setActive(slot0._goDir, true)
		gohelper.setActive(slot0._goOption, false)
		gohelper.setActive(slot0._eventDescRoot, false)
		slot0:updateLeftInfoView()
		slot0:_resetDirPressState()
		slot0:updateDirView()

		if Activity168Model.instance:getCurMoveCost(Activity168Config.instance:getConstCfg(uv1, LoperaEnum.OriStepCostId).value1) <= slot0._curActionPoint then
			slot0:refreshDestinationTips()
		end
	elseif slot0._curState == uv0.SelectOption then
		slot0:_refreshOptionStateView()
	elseif slot0._curState == uv0.OptionDesc then
		gohelper.setActive(slot0._goOption, false)
		slot0:updateOptionReusltDescView()
		slot0:updateLeftInfoView()
	end
end

function slot0._refreshOptionStateView(slot0)
	gohelper.setActive(slot0._goDir, false)
	gohelper.setActive(slot0._eventDescRoot, true)
	slot0:updateLeftInfoView()
	slot0:updateEventDescView()
	slot0:createEventOptions()
	slot0:_playEventAni()
	TaskDispatcher.runDelay(slot0._delayShowOptionList, slot0, uv0)
end

function slot0._delayShowOptionList(slot0)
	gohelper.setActive(slot0._goOption, true)
end

function slot0._initLeftInfoView(slot0)
	slot0._curEpisode = Activity168Model.instance:getCurEpisodeId()
	slot0._textStageName.text = Activity168Config.instance:getEpisodeCfg(uv0, slot0._curEpisode).orderId
end

function slot0.updateLeftInfoView(slot0)
	slot0:updateBuffInfoView()
end

function slot0.updatePowerInfoView(slot0)
	if Activity168Model.instance:getCurActionPoint() < 0 then
		slot1 = 0
	end

	slot0._textActionPoint.text = formatLuaLang("remain", string.format(" <color=#ffd06b>%s</color>", slot1))

	gohelper.setActive(slot0._gpActionPointEffect, false)
	gohelper.setActive(slot0._gpActionPointEffect, true)
	slot0:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_exit_appear)
end

function slot0.updateLocationInfoView(slot0)
	if slot0._isEndLess then
		slot0._textLocation.text = luaLang("p_v2a2_lopera_endless_location")
	else
		slot0._textLocation.text = slot0._curMapCfg[slot0._curCellIdx][uv0.name]

		if not string.nilorempty(slot0._textLocation.text) then
			slot0._textLocation.text = luaLang(string.format("LoperaLevelView_%s_%s", Activity168Config.instance:getEpisodeCfg(uv1, slot0._curEpisode).mapId, slot1[uv0.id]))
		end

		gohelper.setActive(slot0._goLocationEffect, false)
		gohelper.setActive(slot0._goLocationEffect, true)
		slot0:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_checkpoint_elementappear)
	end
end

function slot0.updateBuffInfoView(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(Activity168Model.instance:getCurGameState().buffs) do
		slot2[#slot2 + 1] = {
			id = slot7.id,
			round = slot7.round,
			ext = slot7.ext
		}
	end

	gohelper.setActive(slot0._goBuff, #slot2 > 0)
	gohelper.CreateObjList(slot0, slot0._createBuffItem, slot2, slot0._goBuffItemRoot, slot0._goBuffInfoItem)
end

function slot0._createBuffItem(slot0, slot1, slot2, slot3)
	gohelper.onceAddComponent(slot1, gohelper.Type_TextMesh).text = GameUtil.getSubPlaceholderLuaLang(luaLang("lopera_buff_info_desc1"), {
		string.splitToNumber(Activity168Config.instance:getOptionEffectCfg(slot2.id).effectParams, "#")[1] > 0 and "+" .. slot8 or slot8,
		slot2.round
	})
end

function slot0.updateDirView(slot0)
	slot1 = nil
	slot1 = (not slot0._isEndLess or Activity168Model.instance:getCurGameState().dirs) and string.splitToNumber(slot0._curMapCfg[slot0._curCellIdx][uv0.dir], "#")

	for slot5, slot6 in ipairs(slot0._dirBtnNormalStateGos) do
		gohelper.setActive(slot6, false)
	end

	slot0._moveAbleDirs = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._moveAbleDirs[slot6] = true

		gohelper.setActive(slot0._dirBtnNormalStateGos[slot6], true)
	end

	slot0._txtPowerCostNum.text = Activity168Model.instance:getCurMoveCost(Activity168Config.instance:getConstCfg(uv1, LoperaEnum.OriStepCostId).value1) <= 0 and 0 or "-" .. math.abs(slot3)
end

function slot0._resetDirPressState(slot0)
	for slot4, slot5 in pairs(slot0._dirBtnPressStatsGos) do
		gohelper.setActive(slot5, false)
	end
end

function slot0._initBgView(slot0)
	slot1 = nil

	gohelper.setActive(slot0._bgRoot, true)

	if slot0._isEndLess and uv1 .. Activity168Config.instance:getEndlessLevelCfg(uv0, slot0._endLessId).scene .. ".png" or uv1 .. uv2 then
		slot0._simagebg:LoadImage(slot1)
		slot0._simagebg1:LoadImage(slot1)
	end
end

function slot0.updateEventDescView(slot0)
	slot2 = ""

	if Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot0._curEventId) then
		slot2 = string.format(uv0, slot1.name)
	end

	slot0:beginShowDescContent(slot2)
	gohelper.setActive(slot0._goDescArrow, false)
	gohelper.setActive(slot0._btnEventDesc.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
end

function slot0.beginShowDescContent(slot0, slot1)
	slot0._isShowingDescTyping = true
	slot0._descContent = slot1
	slot0._tweenTime = 0
	slot0._separateChars = slot0:getSeparateChars(slot1)
	slot2 = #slot0._separateChars

	slot0:_destroyTween()

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, slot2, slot2 * 0.02, slot0._onTweenFrameCallback, slot0._onTypingTweenFinish, slot0, nil, EaseType.Linear)
end

function slot0._onTweenFrameCallback(slot0, slot1)
	if slot0._finsihShowTxt or slot1 - slot0._tweenTime < 1 then
		return
	end

	if slot1 <= #slot0._separateChars then
		slot0._textEventDesc.text = slot0._separateChars[math.floor(slot1)]

		if uv0 < slot0._textEventDesc.preferredHeight and not slot0._moveRectTweenId then
			slot4 = slot0._textEventDesc.transform
			slot0._moveRectTweenId = ZProj.TweenHelper.DOLocalMoveY(slot4, slot3 - uv0, 0.25, nil, )

			recthelper.setHeight(slot4, slot3 - uv0)
		end
	else
		slot0._textEventDesc.text = slot0._descContent
	end

	slot0._tweenTime = slot1
end

function slot0._onTypingTweenFinish(slot0)
	slot0:_destroyTween()

	slot0._isShowingDescTyping = false
	slot0._textEventDesc.text = slot0._descContent
end

function slot0.updateOptionReusltDescView(slot0)
	if not Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot0._curOptionId) then
		return
	end

	slot2 = ""

	if Activity168Config.instance:getOptionEffectCfg(slot1.effectId) then
		slot2 = string.format(uv0, slot1.desc) .. "\n" .. luaLang("lopera_event_effect_title")
		slot2 = slot3.effectType == LoperaEnum.EffectType.ActionPointChange and slot2 .. uv1 .. slot3.effectParams or slot2 .. GameUtil.getSubPlaceholderLuaLang(luaLang("lopera_event_effect_buff_info"), {
			uv1,
			string.splitToNumber(slot3.effectParams, "#")[1] > 0 and "+" .. slot4[1] or slot4[1],
			slot4[2]
		})
	end

	if Activity168Model.instance:getItemChangeDict() then
		slot5 = ""

		for slot9, slot10 in pairs(slot4) do
			if slot10 > 0 then
				slot5 = slot5 .. (slot5 == "" and "" or luaLang("sep_overseas")) .. Activity168Config.instance:getGameItemCfg(uv2, slot9).name .. luaLang("multiple") .. slot10
			end
		end

		slot2 = slot2 .. "\n" .. luaLang("p_seasonsettlementview_rewards") .. string.format(uv3, slot5)
	end

	slot0:beginShowDescContent(slot2)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
	gohelper.setActive(slot0._goDescArrow, false)
	gohelper.setActive(slot0._goDescArrow, true)
	gohelper.setActive(slot0._btnEventDesc.gameObject, true)
end

function slot0.createEventOptions(slot0)
	slot1 = {
		0
	}

	for slot7, slot8 in ipairs(string.splitToNumber(Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot0._curEventId).optionIds, "#")) do
		slot1[#slot1 + 1] = Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot8)
	end

	gohelper.CreateObjList(slot0, slot0._createOption, slot1, slot0._goOptionItemRoot, slot0._goOptionItem, LoperaLevelOptionItem, 2)
end

function slot0._createOption(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	slot1._view = slot0
end

function slot0._changeLevelState(slot0, slot1)
	slot0._curState = slot1

	if slot0._waitPopResult then
		slot0:_onGetToDestination(slot0._resultParams)

		slot0._waitPopResult = nil
	end

	slot0:updateStateView()
end

function slot0.refreshDestinationTips(slot0)
	slot1 = {}

	if slot0._isEndLess then
		if Activity168Model.instance:getCurGameState().round ~= 1 then
			return
		end

		slot1.isEndLess = slot0._isEndLess

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, slot1)

		return
	end

	if slot0._curMapCfg[slot0._curCellIdx][uv0.destination] then
		return
	end

	slot1.mapId = Activity168Config.instance:getEpisodeCfg(uv1, slot0._curEpisode).mapId

	if slot3 == 1 then
		slot1.isBeginning = true

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, slot1)
	elseif slot3 > 0 and slot3 % slot0._showTipsRoundNum == 0 and not slot0._isEndLess then
		slot1.cellIdx = slot0._curCellIdx

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, slot1)
	end
end

function slot0.refreshFinishTips(slot0)
	slot1 = {
		mapId = Activity168Config.instance:getEpisodeCfg(uv0, slot0._curEpisode).mapId,
		isFinished = true
	}

	if ViewMgr.instance:isOpen(ViewName.LoperaLevelTipsView) then
		ViewMgr.instance:closeView(ViewName.LoperaLevelTipsView)
	end

	ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, slot1)
end

function slot0._onGetToDestination(slot0, slot1)
	gohelper.setActive(slot0._goSmeltBtn, false)

	slot0._resultParams = slot1

	if slot0._curState == uv0.OptionDesc then
		slot0._waitPopResult = true

		return
	end

	if LoperaEnum.ResultEnum.Quit == slot1.settleReason then
		return
	elseif LoperaEnum.ResultEnum.PowerUseup == slot2 then
		LoperaController.instance:openGameResultView(slot1)

		return
	end

	if slot0._playingMoving then
		TaskDispatcher.runDelay(slot0._doFinishAction, slot0, uv1)
	else
		slot0:_doFinishAction()
	end
end

function slot0._doFinishAction(slot0)
	if slot0._isEndLess then
		LoperaController.instance:openGameResultView(slot0._resultParams)
	else
		slot0:_playFinishStory()
	end
end

function slot0._playFinishStory(slot0)
	if Activity168Config.instance:getMapEndCell()[uv0.storyId] == 0 then
		slot0:_onFinishStoryEnd()
	else
		StoryController.instance:playStory(slot2, nil, slot0._onFinishStoryEnd, slot0)

		slot0._playingCellStory = true
	end
end

function slot0._onFinishStoryEnd(slot0)
	slot0._playingCellStory = false

	LoperaController.instance:openGameResultView(slot0._resultParams)
	slot0:refreshFinishTips()
end

function slot0._onMoveInEpisode(slot0)
	UIBlockMgr.instance:startBlock(uv0)
	slot0:_playMoveAni()
	TaskDispatcher.runDelay(slot0._onMoveEnd, slot0, uv1)
end

function slot0._playMoveAni(slot0)
	slot0._playingMoving = true
	slot1 = true

	if slot0._isEndLess and true or not Activity168Config.instance:getMapCellByCoord(slot0:_addDirCoord(slot0._curMapCfg[slot0._curCellIdx][uv0.coord], slot0._dir))[uv0.destination] then
		if slot0._endLessId == 2 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_wood)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_jungle)
		end
	end

	slot0._bgAnimator:Play("move", 0, 0)
end

function slot0._playEventAni(slot0)
	slot0._bgAnimator:Play("wiggle", 0, 0)
end

function slot0._onMoveEnd(slot0)
	UIBlockMgr.instance:endBlock(uv0)

	slot0._playingMoving = false
	slot0._curEventId = Activity168Model.instance:getCurGameState().eventId

	if slot0._isEndLess then
		slot0:_changeLevelState(slot0._curEventId and slot0._curEventId ~= 0 and uv1.SelectOption or uv1.SelectDir)
	else
		slot4 = Activity168Config.instance:getMapCellByCoord(slot0:_addDirCoord(slot0._curMapCfg[slot0._curCellIdx][uv2.coord], slot0._dir))
		slot0._curCellIdx = slot4[uv2.id] + 1
		slot8 = Activity168Model.instance:getCurGameState().round
		slot9 = true

		if slot4[uv2.storyId] and slot5 ~= 0 and slot4[uv2.storyEvent] == 0 and not slot4[uv2.destination] then
			for slot15, slot16 in pairs(string.splitToNumber(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, ""), "#")) do
				if slot16 == slot5 then
					slot9 = false

					break
				end
			end

			if slot4[uv2.start] and slot8 > 1 then
				slot9 = false
			end

			if slot9 then
				GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, slot10 .. "#" .. slot5)
				StoryController.instance:playStory(slot5, nil, slot0._onPlayCellStoryEnd, slot0)

				slot0._playingCellStory = true
			else
				slot0:_onPlayCellStoryEnd()
			end
		elseif slot0._curEventId and slot0._curEventId ~= 0 then
			slot0:_changeLevelState(uv1.SelectOption)
		else
			slot0:_changeLevelState(uv1.SelectDir)
		end

		slot0:updateLocationInfoView()
	end
end

function slot0._onPlayCellStoryEnd(slot0)
	slot0._playingCellStory = false

	slot0:_changeLevelState(uv0.SelectOption)
end

function slot0._onSelectedOption(slot0)
	if slot0._isEndLess then
		slot0._curOptionId = Activity168Model.instance:getCurGameState().option
	else
		slot0._curOptionId = slot1.option

		if slot0._curMapCfg[slot0._curCellIdx] and slot2[uv0.storyId] and slot2[uv0.storyId] ~= 0 then
			if slot0._curEventId == slot2[uv0.storyEvent] then
				StoryController.instance:playStory(slot2[uv0.storyId], nil, , slot0)
			end
		end
	end

	slot0:_changeLevelState(uv1.OptionDesc)
end

function slot0._hasSmeltRed(slot0)
	return LoperaController.instance:checkAnyComposable()
end

function slot0._onSmeltResult(slot0)
	if slot0._redDotComp then
		slot0._redDotComp:refreshRedDot()
	end
end

function slot0._playViewAudio(slot0, slot1)
	if slot0._playingCellStory then
		return
	end

	slot2 = ViewMgr.instance:getOpenViewNameList()

	if slot2[#slot2] ~= ViewName.LoperaLevelView and slot3 ~= ViewName.LoperaLevelTipsView then
		return
	end

	AudioMgr.instance:trigger(slot1)
end

function slot0._addDirCoord(slot0, slot1, slot2)
	slot3 = {
		slot1[1],
		slot1[2]
	}

	if slot2 == uv0.North then
		slot3[2] = slot3[2] + 1
	end

	if slot2 == uv0.South then
		slot3[2] = slot3[2] - 1
	end

	if slot2 == uv0.West then
		slot3[1] = slot3[1] - 1
	end

	if slot2 == uv0.East then
		slot3[1] = slot3[1] + 1
	end

	return slot3
end

function slot0.getSeparateChars(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		slot4 = ""

		for slot8 = 1, #string.split(slot1, "\n") do
			slot9 = false

			if not string.nilorempty(slot3[slot8]) then
				for slot14 = 1, #LuaUtil.getUCharArr(slot3[slot8]) do
					if slot10[slot14] == "<" then
						slot9 = true
					elseif slot10[slot14] == ">" then
						slot9 = false
					end

					if not slot9 then
						table.insert(slot2, slot4 .. slot10[slot14])
					end
				end

				table.insert(slot2, slot4 .. "\n")
			end
		end
	end

	return slot2
end

function slot0._destroyTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._moveRectTweenId then
		ZProj.TweenHelper.KillById(slot0._moveRectTweenId)

		slot0._moveRectTweenId = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebg1:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._doFinishAction, slot0)
	TaskDispatcher.cancelTask(slot0._onMoveEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowOptionList, slot0)
	slot0:_destroyTween()
end

return slot0
