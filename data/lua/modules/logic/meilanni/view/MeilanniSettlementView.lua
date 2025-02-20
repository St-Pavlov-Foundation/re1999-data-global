module("modules.logic.meilanni.view.MeilanniSettlementView", package.seeall)

slot0 = class("MeilanniSettlementView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._imagecurscore = gohelper.findChildImage(slot0.viewGO, "left/score/bg/#image_curscore")
	slot0._goscorestep = gohelper.findChild(slot0.viewGO, "left/score/scorerange/#go_scorestep")
	slot0._txtcurscore = gohelper.findChildText(slot0.viewGO, "left/score/#txt_curscore")
	slot0._simagerating = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_rating")
	slot0._simageratingfail = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_rating_fail")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_icon")
	slot0._scrolldays = gohelper.findChildScrollRect(slot0.viewGO, "right/#scroll_days")
	slot0._godayitem = gohelper.findChild(slot0.viewGO, "right/#scroll_days/Viewport/Content/#go_dayitem")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_next")
	slot0._btnfront = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_front")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnfront:AddClickListener(slot0._btnfrontOnClick, slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnfront:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function slot0._btncloseOnClick(slot0)
end

function slot0._btnnextOnClick(slot0)
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(slot0._aniDone, slot0, 0.5)

	slot0._episodeIndex = slot0._episodeIndex + 1

	slot0._animator:Play("fanye_left", 0, 0)
	slot0:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function slot0._btnfrontOnClick(slot0)
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(slot0._aniDone, slot0, 0.5)

	slot0._episodeIndex = slot0._episodeIndex - 1

	slot0._animator:Play("fanye_right", 0, 0)
	slot0:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function slot0._aniDone(slot0)
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._godayitem, false)

	slot1 = gohelper.findChild(slot0.viewGO, "right")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot2 = slot1:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot2:AddEventListener("right", slot0._onFlipOver, slot0)
	slot2:AddEventListener("left", slot0._onFlipOver, slot0)
end

function slot0._onFlipOver(slot0)
	slot0:_updateBtns()
end

function slot0._updateBtns(slot0, slot1)
	gohelper.setActive(slot0._btnnext.gameObject, slot0._episodeIndex < slot0._episodeNum)
	gohelper.setActive(slot0._btnfront.gameObject, slot0._episodeIndex > 1)

	if slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0._episodeHistory) do
		gohelper.setActive(slot6, slot5 == slot0._episodeIndex)
	end

	slot0:_showEpisodeHistory(slot0._episodeIndex)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot0._mapConfig = slot0._mapInfo.mapConfig
	slot0._episodeHistory = slot0:getUserDataTb_()
	slot0._eventItemList = slot0:getUserDataTb_()
	slot0._episodeNum = #slot0._mapInfo.episodeInfos
	slot0._episodeIndex = 1
	slot1 = 100
	slot2 = math.min(math.max(0, slot0._mapInfo.score), slot1)
	slot0._txtcurscore.text = string.format("<#8d3032><size=43>%s</size></color>/%s", slot2, slot1)
	slot3 = MeilanniConfig.instance:getScoreIndex(slot2)

	if slot2 <= 0 then
		slot0._simageratingfail:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_shibai_4"))
		gohelper.setActive(slot0._simageratingfail, true)
		gohelper.setActive(slot0._simagerating, false)
	else
		slot0._simagerating:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_chenggong_" .. tostring(slot3)))
	end

	slot0._simageicon:LoadImage(ResUrl.getMeilanniIcon(slot0._mapConfig.exhibits))
	slot0:_initScores(slot2)

	slot0._curScore = slot2
	slot0._imagecurscore.fillAmount = 0

	slot0:_updateBtns()

	if slot2 == 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)

		return
	end

	TaskDispatcher.runDelay(slot0._delayStartShowProgress, slot0, 0.3)
end

function slot0._delayStartShowProgress(slot0)
	slot0._audioId = AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_progress_grow)
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.7, slot0._onFrame, slot0._showFinish, slot0, nil, EaseType.Linear)
end

function slot0._showFinish(slot0)
	AudioMgr.instance:stopPlayingID(slot0._audioId)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function slot0._onFrame(slot0, slot1)
	slot0._imagecurscore.fillAmount = slot1 * slot0._targetFillAmount

	for slot6, slot7 in ipairs(slot0._gradleList) do
		if slot0._ratingTxtList[slot6] and slot8[1] and slot7.score <= slot1 * slot0._curScore then
			slot9.color = GameUtil.parseColor("#903C3C")

			gohelper.setActive(slot8[2], true)

			slot0._ratingTxtList[slot6] = nil
		end
	end
end

function slot0._initScores(slot0, slot1)
	slot2 = {
		"",
		"A",
		"B",
		"C"
	}
	slot4 = {
		1,
		0.844,
		0.54,
		0.26
	}
	slot5 = nil
	slot7 = {
		{
			score = 100
		}
	}
	slot11 = MeilanniConfig.instance:getGradleList(slot0._mapId)

	tabletool.addValues(slot7, slot11)

	slot0._gradleList = slot7
	slot0._ratingTxtList = slot0:getUserDataTb_()

	for slot11, slot12 in ipairs(slot0._gradleList) do
		if not string.nilorempty(slot2[slot11]) then
			slot14 = gohelper.cloneInPlace(slot0._goscorestep)

			gohelper.setActive(slot14, true)

			slot16 = gohelper.findChildText(slot14, "txt_rating")
			slot17 = gohelper.findChild(slot14, "go_achive")

			gohelper.setActive(slot17, false)

			gohelper.findChildText(slot14, "txt_value").text = slot12.score
			slot16.text = slot2[slot11]

			recthelper.setAnchorX(slot14.transform, ({
				442,
				442,
				272,
				115
			})[slot11])

			slot0._ratingTxtList[slot11] = {
				slot16,
				slot17
			}
		end

		if slot12.score <= slot1 then
			slot5 = slot5 or slot11
		end
	end

	if slot5 == 1 then
		slot0._targetFillAmount = slot4[slot5]
		slot0._imagecurscore.fillAmount = slot0._targetFillAmount

		return
	end

	slot8, slot9, slot10, slot11 = nil

	if not slot5 then
		slot8 = 0
		slot9 = slot4[#slot4]
		slot10 = 0
		slot11 = slot7[#slot7].score
	else
		slot8 = slot4[slot5]
		slot9 = slot4[slot5 - 1]
		slot10 = slot7[slot5].score
		slot11 = slot7[slot5 - 1].score
	end

	slot0._targetFillAmount = (slot9 - slot8) * (slot1 - slot10) / (slot11 - slot10) + slot8
	slot0._imagecurscore.fillAmount = slot0._targetFillAmount
end

function slot0._showCookieContent(slot0, slot1, slot2)
	slot3 = gohelper.cloneInPlace(slot2)

	gohelper.setActive(slot3, true)

	gohelper.findChildText(slot3, "txt_desc").text = slot1
end

function slot0._showEpisodeHistory(slot0, slot1)
	if slot0._episodeHistory[slot1] then
		return
	end

	slot2 = slot0:_getDialogItem()
	slot0._episodeHistory[slot1] = slot2

	slot0:_showTitle(slot0._mapInfo.episodeInfos[slot1], slot2)
	gohelper.setActive(gohelper.findChild(slot2, "events/go_eventitem"), false)

	if slot1 == 1 and slot0._mapConfig.cookie <= slot0._curScore then
		slot0:_showCookieContent(slot0._mapConfig.cookieContent, slot4)
	end

	slot5 = 1

	for slot10, slot11 in ipairs(slot3.historylist) do
		if slot3:getEventInfo(slot11.eventId).interactParam[slot11.index + 1][1] == MeilanniEnum.ElementType.Dialog then
			slot0:_showEvent(slot14, slot4, slot13, slot5, slot10 == #slot3.historylist)

			slot5 = slot5 + 1
		end
	end

	for slot10, slot11 in ipairs(slot3.events) do
		if not slot11.isFinish and slot11:getSkipDialog() then
			slot0:_showSkipDialog(slot11, slot4, nil, slot5)

			slot5 = slot5 + 1
		end
	end
end

function slot0._showTitle(slot0, slot1, slot2)
	if slot1.episodeConfig.mapId <= 102 then
		gohelper.findChildText(slot2, "title/txt_countdown").text = formatLuaLang("meilannisettlementview_countdown", slot3.day)
	else
		slot4.text = formatLuaLang("meilannisettlementview_countdown2", slot3.day)
	end

	if slot3.period == 1 then
		UISpriteSetMgr.instance:setMeilanniSprite(gohelper.findChildImage(slot2, "title/txt_countdown/image_weather"), "bg_tianqi_settlement_2")
	else
		UISpriteSetMgr.instance:setMeilanniSprite(slot5, "bg_tianqi_settlement_1")
	end
end

function slot0._getEventItem(slot0, slot1, slot2)
	if not slot0._eventItemList[slot1] then
		slot3 = gohelper.cloneInPlace(slot2)

		gohelper.setActive(slot3, true)

		slot0._eventItemList[slot1] = slot3
		gohelper.findChildText(slot3, "txt_desc").text = ""
	end

	return slot3
end

slot0.DialogExteralParams = {
	featureTxtColor = "#27682E"
}

function slot0._showSkipDialog(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = gohelper.findChildText(slot0:_getEventItem(slot1.eventId, slot2), "txt_desc")
	slot8 = slot1:getSkipDialog()
	slot10 = string.splitToNumber(slot8.result, "#")

	if not string.nilorempty(MeilanniDialogItem.getResult(nil, slot8, "", nil, uv0.DialogExteralParams)) then
		slot9 = string.format("%s%s", slot8.content, slot11)
	end

	slot7.text = slot9
end

function slot0._showEvent(slot0, slot1, slot2, slot3, slot4, slot5)
	slot8 = 0
	slot15 = slot1._historyResult or ""

	for slot19, slot20 in ipairs(slot1.historylist[slot3].history) do
		slot21 = string.splitToNumber(slot20, "#")
		slot23 = slot21[2]

		if lua_activity108_dialog.configDict[slot1.interactParam[slot3 + 1][2]][slot21[1]].type == "dialog" and not string.nilorempty(slot24.content) then
			if string.nilorempty(gohelper.findChildText(slot0:_getEventItem(slot1.eventId, slot2), "txt_desc").text) then
				slot9 = slot24.content
			else
				slot9 = string.format("%s\n%s", slot9, slot24.content)
			end
		elseif slot24.type == "options" then
			slot30 = string.splitToNumber(MeilanniConfig.instance:getDialog(slot12, string.split(slot24.param, "#")[slot23]).result, "#")

			if string.split(slot24.content, "#")[slot23] then
				slot9 = string.format("%s\n%s", slot9, string.format("<size=26><color=#834d30>\"%s\"</color></size>", slot28))

				if string.len(slot15) <= 0 then
					slot15 = MeilanniDialogItem.getResult(slot1, MeilanniConfig.instance:getDialog(slot12, slot27), slot15, true, uv0.DialogExteralParams)
				end
			end

			if slot30[1] == MeilanniEnum.ResultType.score then
				slot8 = slot30[2]
			end
		end
	end

	if string.len(slot15) > 0 then
		slot1._historyResult = slot15

		if slot10 == #slot1.interactParam then
			slot9 = string.format("%s%s", slot9, slot15)
		end
	end

	slot7.text = slot9
end

function slot0._getDialogItem(slot0)
	slot1 = gohelper.cloneInPlace(slot0._godayitem)

	gohelper.setActive(slot1, true)

	return slot1
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayStartShowProgress, slot0)
	TaskDispatcher.cancelTask(slot0._aniDone, slot0)
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function slot0.onDestroyView(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	slot0._simagerating:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

return slot0
