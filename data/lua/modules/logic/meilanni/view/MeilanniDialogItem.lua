module("modules.logic.meilanni.view.MeilanniDialogItem", package.seeall)

local var_0_0 = class("MeilanniDialogItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_head/#txt_remaintime")
	arg_1_0._imageweather = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#go_head/#txt_remaintime/#image_weather")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_desc/#txt_info")
	arg_1_0._txttemplate = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_template")
	arg_1_0._txtnormalevent = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_normal/#txt_normalevent")
	arg_1_0._txtspecialevent = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_special/#txt_specialevent")
	arg_1_0._txtoverdueevent = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_overdue/#txt_overdueevent")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_options/#go_talkitem")
	arg_1_0._gohead = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_head")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_desc")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_normal")
	arg_1_0._gospecial = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_special")
	arg_1_0._gooverdue = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_overdue")
	arg_1_0._goenddaytip = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_enddaytip")
	arg_1_0._txtenddaytip = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#go_enddaytip/#txt_enddaytip")
	arg_1_0._goend = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_end")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1

	arg_4_0:onInitView()
	arg_4_0:addEvents()
	arg_4_0:onOpen()
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:onClose()
	arg_5_0:removeEvents()
	arg_5_0:onDestroyView()
end

function var_0_0._btnnextOnClick(arg_6_0)
	if not arg_6_0._btnnext.gameObject.activeInHierarchy or arg_6_0._finishClose then
		return
	end

	if not arg_6_0:_checkClickCd() then
		return
	end

	arg_6_0:_playNextSectionOrDialog()
end

function var_0_0._checkClickCd(arg_7_0)
	if Time.time - arg_7_0._time < 0.5 then
		return
	end

	arg_7_0._time = Time.time

	return true
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._time = Time.time
	arg_8_0._optionBtnList = arg_8_0:getUserDataTb_()
	arg_8_0._dialogItemList = arg_8_0:getUserDataTb_()
	arg_8_0._dialogItemCacheList = arg_8_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_8_0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	arg_8_0._animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._canvasGroup = gohelper.onceAddComponent(arg_8_0.viewGO, gohelper.Type_CanvasGroup)
	arg_8_0._txtList = arg_8_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0._playNextSectionOrDialog(arg_10_0)
	if #arg_10_0._sectionList >= arg_10_0._dialogIndex then
		arg_10_0:_playNextDialog()

		return
	end

	local var_10_0 = table.remove(arg_10_0._sectionStack)

	if var_10_0 then
		arg_10_0:_playSection(var_10_0[1], var_10_0[2])
	else
		arg_10_0:_refreshDialogBtnState()
	end
end

function var_0_0.setEpisodeInfo(arg_11_0, arg_11_1)
	if not arg_11_1 then
		logError("MeilanniDialogItem setEpisodeInfo info is nil")

		return
	end

	arg_11_0._episodeInfo = arg_11_1
end

function var_0_0.getEpisodeInfo(arg_12_0)
	return arg_12_0._episodeInfo
end

function var_0_0._startFadeIn(arg_13_0)
	arg_13_0._delayFadeTime = nil

	local var_13_0 = MeilanniModel.instance:getDialogItemFadeIndex()

	if not var_13_0 then
		return
	end

	arg_13_0._openFadeIn = true

	if var_13_0 <= 0 then
		return
	end

	arg_13_0._animator.enabled = false
	arg_13_0._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(arg_13_0._delayFadeIn, arg_13_0)

	arg_13_0._delayFadeTime = var_13_0 * 0.4

	TaskDispatcher.runDelay(arg_13_0._delayFadeIn, arg_13_0, arg_13_0._delayFadeTime)
end

function var_0_0._delayFadeIn(arg_14_0)
	arg_14_0._animator.enabled = true

	arg_14_0._animator:Play("open", 0, 0)

	arg_14_0._canvasGroup.alpha = 1
end

function var_0_0.playDesc(arg_15_0, arg_15_1)
	arg_15_0:_startFadeIn()
	gohelper.setActive(arg_15_0._godesc.gameObject, true)

	arg_15_0._txtinfo.text = arg_15_1

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, arg_15_0)
end

function var_0_0.showEpilogue(arg_16_0, arg_16_1)
	arg_16_0:_startFadeIn()
	gohelper.setActive(arg_16_0._goenddaytip, true)

	arg_16_0._txtenddaytip.text = arg_16_1

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, arg_16_0)
end

function var_0_0.showEndDialog(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, arg_17_0)
	arg_17_0:_startFadeIn()
	gohelper.setActive(arg_17_0._goend, true)

	arg_17_0._endBtn = gohelper.findChildButtonWithAudio(arg_17_0._goend, "#btn_end", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	arg_17_0._endBtn:AddClickListener(arg_17_0._clickEndHandler, arg_17_0)
	gohelper.setActive(arg_17_0._endBtn, false)

	local var_17_0 = gohelper.findChildText(arg_17_0._goend, "#txt_enddesc")
	local var_17_1 = gohelper.findChildText(arg_17_0._goend, "#btn_end/#txt_endbtndesc")
	local var_17_2 = gohelper.findChildText(arg_17_0._goend, "tag/#txt_endtitle")
	local var_17_3 = gohelper.findChildImage(arg_17_0._goend, "#btn_end/icon")

	arg_17_0._mapId = MeilanniModel.instance:getCurMapId()
	arg_17_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_17_0._mapId)

	if arg_17_0._mapInfo.score <= 0 then
		var_17_0.text = luaLang("p_meilannidialogitem_enddesc4")
		var_17_1.text = luaLang("p_meilannidialogitem_endbtn4")
		var_17_2.text = luaLang("p_meilannidialogitem_endtitle4")

		SLFramework.UGUI.GuiHelper.SetColor(var_17_1, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(var_17_3, "bg_xuanzhe1")

		arg_17_0._isFail = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			var_17_1.text,
			arg_17_0,
			arg_17_0._clickEndHandler,
			arg_17_0._delayFadeTime
		})

		return
	end

	local var_17_4 = MeilanniConfig.instance:getLastEpisode(arg_17_0._mapId)

	if arg_17_0._episodeInfo.episodeConfig.day == var_17_4.day then
		var_17_0.text = arg_17_0._mapInfo.mapConfig.endContent
		var_17_1.text = luaLang("p_meilannidialogitem_endbtn3")
		var_17_2.text = luaLang("p_meilannidialogitem_endtitle3")

		SLFramework.UGUI.GuiHelper.SetColor(var_17_1, "#EB9A58")
		UISpriteSetMgr.instance:setMeilanniSprite(var_17_3, "bg_xuanzhe1")

		arg_17_0._isSuccess = true

		MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
			var_17_1.text,
			arg_17_0,
			arg_17_0._clickEndHandler,
			arg_17_0._delayFadeTime
		})

		return
	end

	if arg_17_0._mapId < MeilanniEnum.unlockMapId then
		var_17_0.text = luaLang("p_meilannidialogitem_enddesc1")
		var_17_1.text = luaLang("p_meilannidialogitem_endbtn1")
		var_17_2.text = luaLang("p_meilannidialogitem_endtitle1")

		SLFramework.UGUI.GuiHelper.SetColor(var_17_1, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(var_17_3, "bg_xuanzhe")
	else
		var_17_0.text = luaLang("p_meilannidialogitem_enddesc2")
		var_17_1.text = luaLang("p_meilannidialogitem_endbtn2")
		var_17_2.text = luaLang("p_meilannidialogitem_endtitle2")

		SLFramework.UGUI.GuiHelper.SetColor(var_17_1, "#D9CEBD")
		UISpriteSetMgr.instance:setMeilanniSprite(var_17_3, "bg_xuanzhe")
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogEndBtn, {
		var_17_1.text,
		arg_17_0,
		arg_17_0._clickEndHandler,
		arg_17_0._delayFadeTime
	})
end

function var_0_0._clickEndHandler(arg_18_0)
	MeilanniAnimationController.instance:startAnimation()
	Activity108Rpc.instance:sendEpisodeConfirmRequest(MeilanniEnum.activityId, arg_18_0._episodeInfo.episodeId, arg_18_0._endCallback, arg_18_0)
end

function var_0_0._endCallback(arg_19_0)
	gohelper.destroy(arg_19_0.viewGO)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, arg_19_0)

	if arg_19_0._isFail then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapFail)
	elseif arg_19_0._isSuccess then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.mapSuccess)
	end
end

function var_0_0.showSkipDialog(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		arg_20_0:_setDelayShowDialog()

		arg_20_0._topDialog = true
	end

	arg_20_0._config = arg_20_1.config
	arg_20_0._curText = arg_20_0._txtoverdueevent
	arg_20_0._curText.text = ""

	gohelper.setActive(arg_20_0._gooverdue, true)

	arg_20_0._maskline = gohelper.findChild(arg_20_0._gooverdue, "maskline")

	gohelper.setActive(arg_20_0._maskline, false)

	local var_20_0 = arg_20_1:getSkipDialog()

	arg_20_0:_showDialog(MeilanniEnum.ResultString.dialog, var_20_0.content, var_20_0.speaker)

	local var_20_1, var_20_2, var_20_3 = var_0_0.getResult(nil, var_20_0, "")

	if not string.nilorempty(var_20_1) then
		arg_20_0._scoreResult = var_20_2
		arg_20_0._customDialogTime = MeilanniEnum.selectedTime

		arg_20_0:_showDialog(MeilanniEnum.ResultString.result, var_20_1)
	end
end

function var_0_0.clearConfig(arg_21_0)
	arg_21_0._config = nil
	arg_21_0._content = nil
end

function var_0_0.showHistory(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_0:_startFadeIn()

	if MeilanniAnimationController.instance:isPlaying() then
		arg_22_0:_setDelayShowDialog()
	end

	if not arg_22_0._config then
		arg_22_0._config = arg_22_1.config

		arg_22_0:_setText(arg_22_0._config)
	end

	local var_22_0 = arg_22_2 + 1
	local var_22_1 = arg_22_1.interactParam[var_22_0][2]
	local var_22_2 = arg_22_1.historylist[arg_22_2]

	if not var_22_2 then
		logError(string.format("MeilanniDialogItem no eventHistory id:%s,index:%s", arg_22_0._config.id, arg_22_2))

		return
	end

	local var_22_3 = var_22_2.history
	local var_22_4 = arg_22_1._historyResult or ""
	local var_22_5
	local var_22_6

	for iter_22_0, iter_22_1 in ipairs(var_22_3) do
		local var_22_7 = string.splitToNumber(iter_22_1, "#")
		local var_22_8 = var_22_7[1]
		local var_22_9 = var_22_7[2]
		local var_22_10 = lua_activity108_dialog.configDict[var_22_1][var_22_8]

		if not var_22_10 then
			logError(string.format("MeilanniDialogItem showHistory no stepConfig dialogId:%s,stepId:%s", var_22_1, var_22_8))
		end

		if var_22_10 and var_22_10.type == MeilanniEnum.ResultString.dialog then
			arg_22_0:_showDialog(MeilanniEnum.ResultString.dialog, var_22_10.content, var_22_10.speaker)
		elseif var_22_10 and var_22_10.type == MeilanniEnum.ResultString.options then
			local var_22_11 = string.split(var_22_10.content, "#")
			local var_22_12 = string.split(var_22_10.param, "#")
			local var_22_13 = var_22_11[var_22_9]
			local var_22_14 = var_22_12[var_22_9]

			if var_22_13 then
				local var_22_15 = string.format("<color=#B95F0F>\"%s\"</color>", var_22_13)

				arg_22_0:_showDialog(MeilanniEnum.ResultString.options, var_22_15)

				if string.len(var_22_4) <= 0 then
					local var_22_16 = MeilanniConfig.instance:getDialog(var_22_1, var_22_14)
					local var_22_17, var_22_18, var_22_19 = var_0_0.getResult(arg_22_1, var_22_16, var_22_4, true)

					arg_22_0._featureResult, arg_22_0._scoreResult, var_22_4 = var_22_19, var_22_18, var_22_17
				end
			end
		end
	end

	if string.len(var_22_4) > 0 then
		arg_22_1._historyResult = var_22_4

		if var_22_0 == #arg_22_1.interactParam then
			arg_22_0:_showDialog(MeilanniEnum.ResultString.result, var_22_4)
		end
	end
end

function var_0_0.isTopDialog(arg_23_0)
	return arg_23_0._topDialog
end

function var_0_0.playDialog(arg_24_0, arg_24_1)
	arg_24_0._topDialog = true
	arg_24_0._mapElement = arg_24_1
	arg_24_0._elementInfo = arg_24_0._mapElement._info
	arg_24_0._mapId = MeilanniModel.instance:getCurMapId()
	arg_24_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_24_0._mapId)

	local var_24_0 = arg_24_0._mapInfo:getCurEpisodeInfo()

	if not arg_24_0._config then
		arg_24_0._config = arg_24_0._mapElement._config

		arg_24_0:_setText(arg_24_0._config)
	end

	arg_24_0:_playStory()
end

function var_0_0._setText(arg_25_0, arg_25_1)
	if arg_25_1.type == 0 then
		arg_25_0._curText = arg_25_0._txtnormalevent
	else
		arg_25_0._curText = arg_25_0._txtspecialevent
	end

	arg_25_0._curText.text = ""

	local var_25_0 = arg_25_1.type == 0

	gohelper.setActive(arg_25_0._gonormal, var_25_0)
	gohelper.setActive(arg_25_0._gospecial, not var_25_0)
	arg_25_0:_hideMaskline(arg_25_1)
end

function var_0_0._hideMaskline(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.type == 0

	arg_26_0._maskline = gohelper.findChild(var_26_0 and arg_26_0._gonormal or arg_26_0._gospecial, "maskline")

	gohelper.setActive(arg_26_0._maskline, false)
end

function var_0_0._playStory(arg_27_0)
	arg_27_0._sectionStack = {}
	arg_27_0._optionId = 0
	arg_27_0._mainSectionId = "0"
	arg_27_0._sectionId = arg_27_0._mainSectionId
	arg_27_0._dialogIndex = nil
	arg_27_0._historyList = {}
	arg_27_0._dialogId = tonumber(arg_27_0._elementInfo:getParam())
	arg_27_0._historyList.id = arg_27_0._dialogId
	arg_27_0._dialogHistoryList = {}

	arg_27_0:_playSection(arg_27_0._sectionId, arg_27_0._dialogIndex)
end

function var_0_0._initHistoryItem(arg_28_0)
	local var_28_0 = arg_28_0._elementInfo and arg_28_0._elementInfo.historylist

	if not var_28_0 or #var_28_0 == 0 then
		return
	end

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		local var_28_1 = string.split(iter_28_1, "#")

		arg_28_0._historyList[var_28_1[1]] = tonumber(var_28_1[2])
	end

	local var_28_2 = arg_28_0._historyList.id

	if not var_28_2 or var_28_2 ~= arg_28_0._dialogId then
		arg_28_0._historyList = {}

		return
	end

	arg_28_0._option_param = arg_28_0._historyList.option

	local var_28_3 = arg_28_0._mainSectionId
	local var_28_4 = arg_28_0._historyList[var_28_3]

	arg_28_0:_addSectionHistory(var_28_3, var_28_4)

	if not arg_28_0._dialogIndex then
		arg_28_0._dialogIndex = var_28_4
		arg_28_0._sectionId = var_28_3
	end
end

function var_0_0._addSectionHistory(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = MeilanniConfig.instance:getDialog(arg_29_0._dialogId, arg_29_1)
	local var_29_1

	if arg_29_1 == arg_29_0._mainSectionId then
		var_29_1 = arg_29_2 > #var_29_0
	else
		var_29_1 = arg_29_2 >= #var_29_0
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if (iter_29_0 < arg_29_2 or var_29_1) and (iter_29_1.type ~= MeilanniEnum.ResultString.dialog or true) then
			if iter_29_1.type == MeilanniEnum.ResultString.options then
				local var_29_2 = string.split(iter_29_1.content, "#")
				local var_29_3 = string.split(iter_29_1.param, "#")
				local var_29_4 = {}
				local var_29_5 = {}

				for iter_29_2, iter_29_3 in ipairs(var_29_3) do
					local var_29_6 = MeilanniConfig.instance:getDialog(arg_29_0._dialogId, iter_29_3)

					if var_29_6 and var_29_6.type == "random" then
						for iter_29_4, iter_29_5 in ipairs(var_29_6) do
							local var_29_7 = string.split(iter_29_5.option_param, "#")
							local var_29_8 = var_29_7[2]
							local var_29_9 = var_29_7[3]

							table.insert(var_29_4, var_29_2[iter_29_2])
							table.insert(var_29_5, var_29_8)
							table.insert(var_29_4, var_29_2[iter_29_2])
							table.insert(var_29_5, var_29_9)
						end
					elseif var_29_6 then
						table.insert(var_29_4, var_29_2[iter_29_2])
						table.insert(var_29_5, iter_29_3)
					end
				end

				for iter_29_6, iter_29_7 in ipairs(var_29_5) do
					local var_29_10 = arg_29_0._historyList[iter_29_7]

					if var_29_10 then
						arg_29_0:_addSectionHistory(iter_29_7, var_29_10)
					end
				end
			end
		else
			break
		end
	end

	if not var_29_1 then
		if not arg_29_0._dialogIndex then
			arg_29_0._dialogIndex = arg_29_2
			arg_29_0._sectionId = arg_29_1

			return
		end

		table.insert(arg_29_0._sectionStack, 1, {
			arg_29_1,
			arg_29_2
		})
	end
end

function var_0_0._playSection(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0:_setSectionData(arg_30_1, arg_30_2)
	arg_30_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._sectionList = MeilanniConfig.instance:getDialog(arg_31_0._dialogId, arg_31_1)

	if arg_31_0._sectionList and not string.nilorempty(arg_31_0._sectionList.option_param) then
		arg_31_0._option_param = arg_31_0._sectionList.option_param
	end

	if not string.nilorempty(arg_31_0._option_param) then
		arg_31_0._historyList.option = arg_31_0._option_param
	end

	arg_31_0._dialogIndex = arg_31_2 or 1
	arg_31_0._sectionId = arg_31_1
end

function var_0_0._autoPlay(arg_32_0)
	arg_32_0:_playNextSectionOrDialog()
end

function var_0_0._playNextDialog(arg_33_0)
	local var_33_0 = arg_33_0._sectionList[arg_33_0._dialogIndex]

	if var_33_0 and var_33_0.type == MeilanniEnum.ResultString.dialog then
		arg_33_0:_addDialogHistory(var_33_0.stepId)
		arg_33_0:_showDialog(MeilanniEnum.ResultString.dialog, var_33_0.content, var_33_0.speaker)

		arg_33_0._dialogIndex = arg_33_0._dialogIndex + 1

		if #arg_33_0._sectionStack > 0 and #arg_33_0._sectionList < arg_33_0._dialogIndex then
			local var_33_1 = table.remove(arg_33_0._sectionStack)

			arg_33_0:_setSectionData(var_33_1[1], var_33_1[2])
		end

		arg_33_0:_refreshDialogBtnState()
		arg_33_0:_autoPlay()
	elseif var_33_0 and var_33_0.type == MeilanniEnum.ResultString.options then
		arg_33_0:_showOptionByConfig(var_33_0)
	end
end

function var_0_0._showOptionByConfig(arg_34_0, arg_34_1)
	local var_34_0 = false

	if arg_34_1 and arg_34_1.type == MeilanniEnum.ResultString.options then
		arg_34_0._dialogIndex = arg_34_0._dialogIndex + 1

		local var_34_1 = string.split(arg_34_1.content, "#")
		local var_34_2 = string.split(arg_34_1.param, "#")

		arg_34_0._isSingle = arg_34_1.single == 1

		if arg_34_0._isSkip then
			var_34_0 = true

			arg_34_0:_refreshDialogBtnState(var_34_0)

			local var_34_3 = 1
			local var_34_4 = var_34_2[1]
			local var_34_5 = var_34_1[1]

			arg_34_0:_onOptionClick({
				var_34_4,
				var_34_5,
				var_34_3
			})

			return
		else
			MeilanniController.instance:dispatchEvent(MeilanniEvent.startShowDialogOptionBtn)

			for iter_34_0, iter_34_1 in pairs(arg_34_0._optionBtnList) do
				gohelper.setActive(iter_34_1[1], false)
			end

			local var_34_6 = #var_34_1 + 1

			for iter_34_2 = 1, #var_34_1 do
				arg_34_0:_addDialogOption(var_34_6, iter_34_2, var_34_2[iter_34_2], var_34_1[iter_34_2], arg_34_1.stepId)
			end

			arg_34_0:_addDialogOption(var_34_6, var_34_6, -1, luaLang("p_meilannidialogitem_shelve"), arg_34_1.stepId, "bg_xuanzhe")

			local var_34_7 = var_34_6 * MeilanniEnum.optionTime + 1.2

			TaskDispatcher.runDelay(arg_34_0._setOptionBtnEnabled, arg_34_0, var_34_7)
			MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, arg_34_0)
		end

		var_34_0 = true
	end

	arg_34_0:_refreshDialogBtnState(var_34_0)
end

function var_0_0._setOptionBtnEnabled(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0._optionBtnList) do
		iter_35_1[2].button.enabled = true
	end
end

function var_0_0._refreshDialogBtnState(arg_36_0, arg_36_1)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.refreshDialogBtnState, arg_36_1)
	gohelper.setActive(arg_36_0._gooptions, arg_36_1)

	if arg_36_1 then
		return
	end

	local var_36_0 = not (#arg_36_0._sectionStack > 0 or #arg_36_0._sectionList >= arg_36_0._dialogIndex)

	if arg_36_0._isFinish then
		arg_36_0:_fadeOutDone()

		arg_36_0._finishClose = true
	end

	arg_36_0._isFinish = var_36_0
end

function var_0_0._fadeOutDone(arg_37_0)
	if arg_37_0._config.skipFinish ~= 1 then
		arg_37_0:_sendFinishDialog()
	end

	TaskDispatcher.runDelay(arg_37_0._startBattle, arg_37_0, 1.5)
end

function var_0_0._startBattle(arg_38_0)
	if arg_38_0._elementInfo:getNextType() == MeilanniEnum.ElementType.Battle then
		MeilanniController.instance:startBattle(arg_38_0._config.id)
	end
end

function var_0_0._playCloseTalkItemEffect(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0._optionBtnList) do
		iter_39_1[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(arg_39_0._hideOption, arg_39_0, 0.133)
end

function var_0_0._hideOption(arg_40_0)
	gohelper.setActive(arg_40_0._gooptions, false)
end

function var_0_0.startBattle(arg_41_0)
	return
end

function var_0_0._sendFinishDialog(arg_42_0)
	MeilanniAnimationController.instance:startAnimation()
	arg_42_0:_setDelayShowDialog()
	MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
	Activity108Rpc.instance:sendDialogEventSelectRequest(MeilanniEnum.activityId, arg_42_0._config.id, arg_42_0._dialogHistoryList, tonumber(arg_42_0._option_param) or 0)
end

local var_0_1 = "#225D23"

function var_0_0.getResult(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	local var_43_0 = string.splitToNumber(arg_43_1.result, "#")
	local var_43_1
	local var_43_2

	if var_43_0[1] == MeilanniEnum.ResultType.score then
		local var_43_3 = var_43_0[2]

		if var_43_3 == 0 then
			arg_43_2 = formatLuaLang("meilannidialogitem_noscore", arg_43_2)
		else
			local var_43_4 = MeilanniController.getScoreDesc(var_43_3)

			arg_43_2 = string.format("%s  %s", arg_43_2, var_43_4)
		end

		var_43_1 = var_43_3
	elseif var_43_0[1] == MeilanniEnum.ResultType.feature then
		local var_43_5 = lua_activity108_rule.configDict[var_43_0[2]]
		local var_43_6 = tonumber(var_43_5.rules)
		local var_43_7 = lua_rule.configDict[var_43_6]
		local var_43_8 = arg_43_4 and arg_43_4.featureTxtColor or var_0_1
		local var_43_9 = {
			arg_43_2,
			var_43_8,
			var_43_7.name
		}

		arg_43_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("meilannidialogitem_eliminat"), var_43_9)
		var_43_2 = true
	elseif arg_43_0 and arg_43_0:getConfigBattleId() then
		if arg_43_3 then
			arg_43_2 = formatLuaLang("meilannidialogitem_fightsuccess", arg_43_2)
		else
			arg_43_2 = formatLuaLang("meilannidialogitem_fight", arg_43_2)
		end
	end

	return arg_43_2, var_43_1, var_43_2
end

function var_0_0._setAnimatorEnabled(arg_44_0)
	arg_44_0.enabled = true
end

function var_0_0._addDialogOption(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6)
	local var_45_0 = {
		arg_45_3,
		arg_45_4,
		arg_45_2,
		arg_45_5,
		arg_45_1,
		arg_45_6
	}

	MeilanniController.instance:dispatchEvent(MeilanniEvent.showDialogOptionBtn, {
		var_45_0,
		arg_45_0,
		arg_45_0._onOptionClick
	})
end

function var_0_0._setDelayShowDialog(arg_46_0)
	arg_46_0._delayStartTime = arg_46_0._delayStartTime or Time.realtimeSinceStartup
	arg_46_0._delayShowDialogList = arg_46_0._delayShowDialogList or {}
end

function var_0_0._getDelayShowDialogList(arg_47_0)
	return arg_47_0._delayShowDialogList
end

function var_0_0._onOptionClick(arg_48_0, arg_48_1)
	if not arg_48_0:_checkClickCd() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	local var_48_0 = arg_48_1[1]

	if var_48_0 == -1 then
		gohelper.destroy(arg_48_0.viewGO)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.setElementsVisible, true)
		MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogClose, arg_48_0)

		return
	end

	MeilanniAnimationController.instance:startAnimation()
	arg_48_0:_setDelayShowDialog()

	local var_48_1 = string.format("<color=#B95F0F>\"%s\"</color>", arg_48_1[2])

	arg_48_0:_addDialogHistory(arg_48_1[4], arg_48_1[3])
	arg_48_0:_showDialog(MeilanniEnum.ResultString.options, var_48_1)

	arg_48_0._showOption = true
	arg_48_0._optionId = arg_48_1[3]

	arg_48_0:_checkOption(var_48_0)
end

function var_0_0._addDialogHistory(arg_49_0, arg_49_1, arg_49_2)
	if arg_49_2 then
		table.insert(arg_49_0._dialogHistoryList, string.format("%s#%s", arg_49_1, arg_49_2))
	else
		table.insert(arg_49_0._dialogHistoryList, tostring(arg_49_1))
	end
end

function var_0_0._checkOption(arg_50_0, arg_50_1)
	local var_50_0 = MeilanniConfig.instance:getDialog(arg_50_0._dialogId, arg_50_1)

	if not var_50_0 then
		arg_50_0:_playNextSectionOrDialog()

		return
	end

	if #arg_50_0._sectionList >= arg_50_0._dialogIndex then
		table.insert(arg_50_0._sectionStack, {
			arg_50_0._sectionId,
			arg_50_0._dialogIndex
		})
	end

	if var_50_0.type == "random" then
		for iter_50_0, iter_50_1 in ipairs(var_50_0) do
			local var_50_1 = string.split(iter_50_1.option_param, "#")
			local var_50_2 = tonumber(var_50_1[1])
			local var_50_3 = var_50_1[2]
			local var_50_4 = var_50_1[3]
			local var_50_5 = math.random(100)
			local var_50_6

			if var_50_5 <= var_50_2 then
				var_50_6 = var_50_3
			else
				var_50_6 = var_50_4
			end

			arg_50_0:_playSection(var_50_6)

			break
		end
	else
		arg_50_0:_playSection(arg_50_1)
	end
end

function var_0_0._showDialog(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_0._isSkip then
		return
	end

	if string.nilorempty(arg_51_2) or arg_51_0._txtList[arg_51_2] then
		return
	end

	local var_51_0 = arg_51_0:_getDelayShowDialogList()

	if not var_51_0 then
		arg_51_0:_addDialogItem(arg_51_1, arg_51_2, arg_51_3)

		return
	end

	MeilanniAnimationController.instance:startDialogListAnim()
	table.insert(var_51_0, {
		arg_51_1,
		arg_51_2,
		arg_51_3,
		arg_51_1 == MeilanniEnum.ResultString.result
	})
	TaskDispatcher.runRepeat(arg_51_0._showDelayDialog, arg_51_0, 0)
end

function var_0_0._showDelayDialog(arg_52_0)
	local var_52_0 = arg_52_0:_getDelayShowDialogList()
	local var_52_1 = arg_52_0._customDialogTime or MeilanniEnum.dialogTime

	if var_52_0 and #var_52_0 ~= 0 and var_52_0[1][4] then
		var_52_1 = var_52_1 + MeilanniEnum.resultTime
	end

	if var_52_0 and var_52_1 <= Time.realtimeSinceStartup - arg_52_0._delayStartTime then
		arg_52_0._delayStartTime = Time.realtimeSinceStartup

		if #var_52_0 <= 0 then
			TaskDispatcher.cancelTask(arg_52_0._showDelayDialog, arg_52_0)
			MeilanniAnimationController.instance:endDialogListAnim()

			return
		end

		local var_52_2 = table.remove(var_52_0, 1)

		if var_52_2 then
			local var_52_3 = var_52_2[1]
			local var_52_4 = var_52_2[2]
			local var_52_5 = var_52_2[3]

			arg_52_0:_addDialogItem(var_52_3, var_52_4, var_52_5)
		end
	end
end

function var_0_0._updateHistory(arg_53_0)
	if arg_53_0._isSkip then
		return
	end

	if arg_53_0._config.skipFinish == 1 then
		return
	end

	arg_53_0._historyList[arg_53_0._sectionId] = arg_53_0._dialogIndex

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(arg_53_0._historyList) do
		table.insert(var_53_0, string.format("%s#%s", iter_53_0, iter_53_1))
	end
end

function var_0_0._addDialogItem(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if string.nilorempty(arg_54_2) then
		return
	end

	if string.nilorempty(arg_54_0._content) then
		arg_54_0._content = arg_54_2
		arg_54_0._eventIndexDesc = nil
	else
		arg_54_0._content = string.format("%s\n%s", arg_54_0._content, arg_54_2)
	end

	if not arg_54_0._txtList[arg_54_2] then
		local var_54_0 = gohelper.clone(arg_54_0._txttemplate.gameObject, arg_54_0._curText.transform.parent.gameObject)

		gohelper.setActive(var_54_0, true)

		local var_54_1 = var_54_0:GetComponent(gohelper.Type_TextMesh)

		var_54_1.text = arg_54_2

		local var_54_2 = var_54_0:GetComponent(typeof(UnityEngine.Animator))
		local var_54_3 = "fade"

		if arg_54_1 == MeilanniEnum.ResultString.dialog then
			local var_54_4 = var_54_0:GetComponent(typeof(ZProj.MaterialPropsTMPCtrl)).TMPList

			var_54_4:Clear()
			var_54_4:Add(var_54_1)

			var_54_3 = "open"
		elseif arg_54_1 == MeilanniEnum.ResultString.result then
			if MeilanniAnimationController.instance:isPlayingDialogListAnim() then
				if arg_54_0._scoreResult and arg_54_0._scoreResult > 0 then
					local var_54_5 = gohelper.findChild(var_54_0, "vx/1")

					gohelper.setActive(var_54_5, true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_correct)
				elseif arg_54_0._scoreResult and arg_54_0._scoreResult < 0 then
					local var_54_6 = gohelper.findChild(var_54_0, "vx/2")

					gohelper.setActive(var_54_6, true)
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_decrypt_incorrect)
				elseif arg_54_0._scoreResult and arg_54_0._scoreResult == 0 then
					local var_54_7 = gohelper.findChild(var_54_0, "vx/4")

					gohelper.setActive(var_54_7, true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_no_effect)
				elseif arg_54_0._featureResult then
					local var_54_8 = gohelper.findChild(var_54_0, "vx/3")

					gohelper.setActive(var_54_8, true)
					AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_remove_effect)
				end

				arg_54_0._scoreResult = nil
				arg_54_0._featureResult = nil
				arg_54_0._topDialog = false
			end

			if arg_54_0._maskline then
				gohelper.setActive(arg_54_0._maskline, true)
			end
		end

		if arg_54_0._openFadeIn then
			var_54_3 = "idle"
		end

		var_54_2:Play(var_54_3)

		arg_54_0._txtList[arg_54_2] = true
	end

	MeilanniController.instance:dispatchEvent(MeilanniEvent.dialogChange, arg_54_0)
end

function var_0_0.onClose(arg_55_0)
	for iter_55_0, iter_55_1 in pairs(arg_55_0._optionBtnList) do
		iter_55_1[2]:RemoveClickListener()
		TaskDispatcher.cancelTask(var_0_0._setAnimatorEnabled, iter_55_1[3])
	end

	if arg_55_0._endBtn then
		arg_55_0._endBtn:RemoveClickListener()

		arg_55_0._endBtn = nil
	end

	TaskDispatcher.cancelTask(arg_55_0._hideOption, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._delayFadeIn, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._showDelayDialog, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._startBattle, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._setOptionBtnEnable, arg_55_0)
end

function var_0_0.onDestroyView(arg_56_0)
	return
end

return var_0_0
