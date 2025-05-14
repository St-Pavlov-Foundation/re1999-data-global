module("modules.logic.meilanni.view.MeilanniSettlementView", package.seeall)

local var_0_0 = class("MeilanniSettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._imagecurscore = gohelper.findChildImage(arg_1_0.viewGO, "left/score/bg/#image_curscore")
	arg_1_0._goscorestep = gohelper.findChild(arg_1_0.viewGO, "left/score/scorerange/#go_scorestep")
	arg_1_0._txtcurscore = gohelper.findChildText(arg_1_0.viewGO, "left/score/#txt_curscore")
	arg_1_0._simagerating = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_rating")
	arg_1_0._simageratingfail = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_rating_fail")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_icon")
	arg_1_0._scrolldays = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#scroll_days")
	arg_1_0._godayitem = gohelper.findChild(arg_1_0.viewGO, "right/#scroll_days/Viewport/Content/#go_dayitem")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_next")
	arg_1_0._btnfront = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_front")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnfront:AddClickListener(arg_2_0._btnfrontOnClick, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnfront:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	arg_4_0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function var_0_0._btncloseOnClick(arg_5_0)
	return
end

function var_0_0._btnnextOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(arg_6_0._aniDone, arg_6_0, 0.5)

	arg_6_0._episodeIndex = arg_6_0._episodeIndex + 1

	arg_6_0._animator:Play("fanye_left", 0, 0)
	arg_6_0:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function var_0_0._btnfrontOnClick(arg_7_0)
	UIBlockMgr.instance:startBlock("MeilanniSettlementView fanye")
	TaskDispatcher.runDelay(arg_7_0._aniDone, arg_7_0, 0.5)

	arg_7_0._episodeIndex = arg_7_0._episodeIndex - 1

	arg_7_0._animator:Play("fanye_right", 0, 0)
	arg_7_0:_updateBtns(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_page_turn)
end

function var_0_0._aniDone(arg_8_0)
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._godayitem, false)

	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "right")

	arg_9_0._animator = var_9_0:GetComponent(typeof(UnityEngine.Animator))

	local var_9_1 = var_9_0:GetComponent(typeof(ZProj.AnimationEventWrap))

	var_9_1:AddEventListener("right", arg_9_0._onFlipOver, arg_9_0)
	var_9_1:AddEventListener("left", arg_9_0._onFlipOver, arg_9_0)
end

function var_0_0._onFlipOver(arg_10_0)
	arg_10_0:_updateBtns()
end

function var_0_0._updateBtns(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._btnnext.gameObject, arg_11_0._episodeIndex < arg_11_0._episodeNum)
	gohelper.setActive(arg_11_0._btnfront.gameObject, arg_11_0._episodeIndex > 1)

	if arg_11_1 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._episodeHistory) do
		gohelper.setActive(iter_11_1, iter_11_0 == arg_11_0._episodeIndex)
	end

	arg_11_0:_showEpisodeHistory(arg_11_0._episodeIndex)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._mapId = arg_12_0.viewParam
	arg_12_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_12_0._mapId)
	arg_12_0._mapConfig = arg_12_0._mapInfo.mapConfig
	arg_12_0._episodeHistory = arg_12_0:getUserDataTb_()
	arg_12_0._eventItemList = arg_12_0:getUserDataTb_()
	arg_12_0._episodeNum = #arg_12_0._mapInfo.episodeInfos
	arg_12_0._episodeIndex = 1

	local var_12_0 = 100
	local var_12_1 = math.max(0, arg_12_0._mapInfo.score)
	local var_12_2 = math.min(var_12_1, var_12_0)

	arg_12_0._txtcurscore.text = string.format("<#8d3032><size=43>%s</size></color>/%s", var_12_2, var_12_0)

	local var_12_3 = MeilanniConfig.instance:getScoreIndex(var_12_2)

	if var_12_2 <= 0 then
		arg_12_0._simageratingfail:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_shibai_4"))
		gohelper.setActive(arg_12_0._simageratingfail, true)
		gohelper.setActive(arg_12_0._simagerating, false)
	else
		arg_12_0._simagerating:LoadImage(ResUrl.getMeilanniLangIcon("bg_pinfen_chenggong_" .. tostring(var_12_3)))
	end

	arg_12_0._simageicon:LoadImage(ResUrl.getMeilanniIcon(arg_12_0._mapConfig.exhibits))
	arg_12_0:_initScores(var_12_2)

	arg_12_0._curScore = var_12_2
	arg_12_0._imagecurscore.fillAmount = 0

	arg_12_0:_updateBtns()

	if var_12_2 == 0 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)

		return
	end

	TaskDispatcher.runDelay(arg_12_0._delayStartShowProgress, arg_12_0, 0.3)
end

function var_0_0._delayStartShowProgress(arg_13_0)
	arg_13_0._audioId = AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_progress_grow)
	arg_13_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.7, arg_13_0._onFrame, arg_13_0._showFinish, arg_13_0, nil, EaseType.Linear)
end

function var_0_0._showFinish(arg_14_0)
	AudioMgr.instance:stopPlayingID(arg_14_0._audioId)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_stamp)
end

function var_0_0._onFrame(arg_15_0, arg_15_1)
	arg_15_0._imagecurscore.fillAmount = arg_15_1 * arg_15_0._targetFillAmount

	local var_15_0 = arg_15_1 * arg_15_0._curScore

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._gradleList) do
		local var_15_1 = arg_15_0._ratingTxtList[iter_15_0]
		local var_15_2 = var_15_1 and var_15_1[1]

		if var_15_2 and var_15_0 >= iter_15_1.score then
			var_15_2.color = GameUtil.parseColor("#903C3C")

			gohelper.setActive(var_15_1[2], true)

			arg_15_0._ratingTxtList[iter_15_0] = nil
		end
	end
end

function var_0_0._initScores(arg_16_0, arg_16_1)
	local var_16_0 = {
		"",
		"A",
		"B",
		"C"
	}
	local var_16_1 = {
		442,
		442,
		272,
		115
	}
	local var_16_2 = {
		1,
		0.844,
		0.54,
		0.26
	}
	local var_16_3
	local var_16_4 = MeilanniConfig.instance:getGradleList(arg_16_0._mapId)
	local var_16_5 = {
		{
			score = 100
		}
	}

	tabletool.addValues(var_16_5, var_16_4)

	arg_16_0._gradleList = var_16_5
	arg_16_0._ratingTxtList = arg_16_0:getUserDataTb_()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._gradleList) do
		local var_16_6 = var_16_0[iter_16_0]

		if not string.nilorempty(var_16_6) then
			local var_16_7 = gohelper.cloneInPlace(arg_16_0._goscorestep)

			gohelper.setActive(var_16_7, true)

			local var_16_8 = gohelper.findChildText(var_16_7, "txt_value")
			local var_16_9 = gohelper.findChildText(var_16_7, "txt_rating")
			local var_16_10 = gohelper.findChild(var_16_7, "go_achive")

			gohelper.setActive(var_16_10, false)

			var_16_8.text = iter_16_1.score
			var_16_9.text = var_16_0[iter_16_0]

			recthelper.setAnchorX(var_16_7.transform, var_16_1[iter_16_0])

			arg_16_0._ratingTxtList[iter_16_0] = {
				var_16_9,
				var_16_10
			}
		end

		if arg_16_1 >= iter_16_1.score then
			var_16_3 = var_16_3 or iter_16_0
		end
	end

	if var_16_3 == 1 then
		arg_16_0._targetFillAmount = var_16_2[var_16_3]
		arg_16_0._imagecurscore.fillAmount = arg_16_0._targetFillAmount

		return
	end

	local var_16_11
	local var_16_12
	local var_16_13
	local var_16_14

	if not var_16_3 then
		var_16_11 = 0
		var_16_12 = var_16_2[#var_16_2]
		var_16_13 = 0
		var_16_14 = var_16_5[#var_16_5].score
	else
		var_16_11 = var_16_2[var_16_3]
		var_16_12 = var_16_2[var_16_3 - 1]
		var_16_13 = var_16_5[var_16_3].score
		var_16_14 = var_16_5[var_16_3 - 1].score
	end

	local var_16_15 = (arg_16_1 - var_16_13) / (var_16_14 - var_16_13)

	arg_16_0._targetFillAmount = (var_16_12 - var_16_11) * var_16_15 + var_16_11
	arg_16_0._imagecurscore.fillAmount = arg_16_0._targetFillAmount
end

function var_0_0._showCookieContent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = gohelper.cloneInPlace(arg_17_2)

	gohelper.setActive(var_17_0, true)

	gohelper.findChildText(var_17_0, "txt_desc").text = arg_17_1
end

function var_0_0._showEpisodeHistory(arg_18_0, arg_18_1)
	if arg_18_0._episodeHistory[arg_18_1] then
		return
	end

	local var_18_0 = arg_18_0:_getDialogItem()

	arg_18_0._episodeHistory[arg_18_1] = var_18_0

	local var_18_1 = arg_18_0._mapInfo.episodeInfos[arg_18_1]

	arg_18_0:_showTitle(var_18_1, var_18_0)

	local var_18_2 = gohelper.findChild(var_18_0, "events/go_eventitem")

	gohelper.setActive(var_18_2, false)

	if arg_18_1 == 1 and arg_18_0._curScore >= arg_18_0._mapConfig.cookie then
		arg_18_0:_showCookieContent(arg_18_0._mapConfig.cookieContent, var_18_2)
	end

	local var_18_3 = 1
	local var_18_4 = #var_18_1.historylist

	for iter_18_0, iter_18_1 in ipairs(var_18_1.historylist) do
		local var_18_5 = iter_18_1.eventId
		local var_18_6 = iter_18_1.index
		local var_18_7 = var_18_1:getEventInfo(var_18_5)

		if var_18_7.interactParam[var_18_6 + 1][1] == MeilanniEnum.ElementType.Dialog then
			arg_18_0:_showEvent(var_18_7, var_18_2, var_18_6, var_18_3, iter_18_0 == var_18_4)

			var_18_3 = var_18_3 + 1
		end
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_1.events) do
		if not iter_18_3.isFinish and iter_18_3:getSkipDialog() then
			arg_18_0:_showSkipDialog(iter_18_3, var_18_2, nil, var_18_3)

			var_18_3 = var_18_3 + 1
		end
	end
end

function var_0_0._showTitle(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.episodeConfig
	local var_19_1 = gohelper.findChildText(arg_19_2, "title/txt_countdown")

	if var_19_0.mapId <= 102 then
		var_19_1.text = formatLuaLang("meilannisettlementview_countdown", var_19_0.day)
	else
		var_19_1.text = formatLuaLang("meilannisettlementview_countdown2", var_19_0.day)
	end

	local var_19_2 = gohelper.findChildImage(arg_19_2, "title/txt_countdown/image_weather")

	if var_19_0.period == 1 then
		UISpriteSetMgr.instance:setMeilanniSprite(var_19_2, "bg_tianqi_settlement_2")
	else
		UISpriteSetMgr.instance:setMeilanniSprite(var_19_2, "bg_tianqi_settlement_1")
	end
end

function var_0_0._getEventItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._eventItemList[arg_20_1]

	if not var_20_0 then
		var_20_0 = gohelper.cloneInPlace(arg_20_2)

		gohelper.setActive(var_20_0, true)

		arg_20_0._eventItemList[arg_20_1] = var_20_0
		gohelper.findChildText(var_20_0, "txt_desc").text = ""
	end

	return var_20_0
end

var_0_0.DialogExteralParams = {
	featureTxtColor = "#27682E"
}

function var_0_0._showSkipDialog(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = arg_21_0:_getEventItem(arg_21_1.eventId, arg_21_2)
	local var_21_1 = gohelper.findChildText(var_21_0, "txt_desc")
	local var_21_2 = arg_21_1:getSkipDialog()
	local var_21_3 = var_21_2.content
	local var_21_4 = string.splitToNumber(var_21_2.result, "#")
	local var_21_5 = MeilanniDialogItem.getResult(nil, var_21_2, "", nil, var_0_0.DialogExteralParams)

	if not string.nilorempty(var_21_5) then
		var_21_3 = string.format("%s%s", var_21_3, var_21_5)
	end

	var_21_1.text = var_21_3
end

function var_0_0._showEvent(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local var_22_0 = arg_22_0:_getEventItem(arg_22_1.eventId, arg_22_2)
	local var_22_1 = gohelper.findChildText(var_22_0, "txt_desc")
	local var_22_2 = 0
	local var_22_3 = var_22_1.text
	local var_22_4 = arg_22_3 + 1
	local var_22_5 = arg_22_1.interactParam[var_22_4][2]
	local var_22_6 = arg_22_1.historylist[arg_22_3].history
	local var_22_7 = arg_22_1._historyResult or ""

	for iter_22_0, iter_22_1 in ipairs(var_22_6) do
		local var_22_8 = string.splitToNumber(iter_22_1, "#")
		local var_22_9 = var_22_8[1]
		local var_22_10 = var_22_8[2]
		local var_22_11 = lua_activity108_dialog.configDict[var_22_5][var_22_9]

		if var_22_11.type == "dialog" and not string.nilorempty(var_22_11.content) then
			if string.nilorempty(var_22_3) then
				var_22_3 = var_22_11.content
			else
				var_22_3 = string.format("%s\n%s", var_22_3, var_22_11.content)
			end
		elseif var_22_11.type == "options" then
			local var_22_12 = string.split(var_22_11.content, "#")
			local var_22_13 = string.split(var_22_11.param, "#")[var_22_10]
			local var_22_14 = var_22_12[var_22_10]
			local var_22_15 = MeilanniConfig.instance:getDialog(var_22_5, var_22_13)
			local var_22_16 = string.splitToNumber(var_22_15.result, "#")

			if var_22_14 then
				local var_22_17 = string.format("<size=26><color=#834d30>\"%s\"</color></size>", var_22_14)

				var_22_3 = string.format("%s\n%s", var_22_3, var_22_17)

				if string.len(var_22_7) <= 0 then
					local var_22_18 = MeilanniConfig.instance:getDialog(var_22_5, var_22_13)

					var_22_7 = MeilanniDialogItem.getResult(arg_22_1, var_22_18, var_22_7, true, var_0_0.DialogExteralParams)
				end
			end

			if var_22_16[1] == MeilanniEnum.ResultType.score then
				local var_22_19 = var_22_16[2]
			end
		end
	end

	if string.len(var_22_7) > 0 then
		arg_22_1._historyResult = var_22_7

		if var_22_4 == #arg_22_1.interactParam then
			var_22_3 = string.format("%s%s", var_22_3, var_22_7)
		end
	end

	var_22_1.text = var_22_3
end

function var_0_0._getDialogItem(arg_23_0)
	local var_23_0 = gohelper.cloneInPlace(arg_23_0._godayitem)

	gohelper.setActive(var_23_0, true)

	return var_23_0
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._delayStartShowProgress, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._aniDone, arg_24_0)
	UIBlockMgr.instance:endBlock("MeilanniSettlementView fanye")
end

function var_0_0.onDestroyView(arg_25_0)
	if arg_25_0.tweenId then
		ZProj.TweenHelper.KillById(arg_25_0.tweenId)

		arg_25_0.tweenId = nil
	end

	arg_25_0._simagerating:UnLoadImage()
	arg_25_0._simageicon:UnLoadImage()
end

return var_0_0
