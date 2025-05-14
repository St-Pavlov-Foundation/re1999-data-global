module("modules.logic.weekwalk.view.WeekWalkDialogView", package.seeall)

local var_0_0 = class("WeekWalkDialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_info")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_options/#go_talkitem")
	arg_1_0._gopcbtn = gohelper.findChild(arg_1_0._gotalkitem, "#go_pcbtn")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogNext, arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_2_0.OnStoryDialogSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogNext, arg_3_0._btnnextOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_3_0._btnskipOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_3_0.OnStoryDialogSelect, arg_3_0)
end

function var_0_0._btnskipOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		arg_4_0:_skipStory()
	end)
end

function var_0_0.OnStoryDialogSelect(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._optionBtnList[arg_6_1]

	if var_6_0 and var_6_0[1].gameObject.activeInHierarchy then
		var_6_0[2]:Trigger()
	end
end

function var_0_0._skipStory(arg_7_0)
	arg_7_0._isSkip = true

	if arg_7_0._skipOptionParams then
		arg_7_0:_skipOption(arg_7_0._skipOptionParams[1], arg_7_0._skipOptionParams[2])
	end

	for iter_7_0 = 1, 100 do
		arg_7_0:_playNextSectionOrDialog()

		if arg_7_0._finishClose then
			break
		end
	end
end

function var_0_0._btnnextOnClick(arg_8_0)
	if not arg_8_0._btnnext.gameObject.activeInHierarchy or arg_8_0._finishClose then
		return
	end

	if not arg_8_0:_checkClickCd() then
		return
	end

	arg_8_0:_playNextSectionOrDialog()
end

function var_0_0._checkClickCd(arg_9_0)
	if Time.time - arg_9_0._time < 0.5 then
		return
	end

	arg_9_0._time = Time.time

	return true
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._time = Time.time
	arg_10_0._optionBtnList = arg_10_0:getUserDataTb_()
	arg_10_0._dialogItemList = arg_10_0:getUserDataTb_()
	arg_10_0._dialogItemCacheList = arg_10_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_10_0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	arg_10_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_10_0.viewGO)
	arg_10_0._nexticon = gohelper.findChild(arg_10_0.viewGO, "#go_content/nexticon")
	arg_10_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_10_0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_10_0._conMark = gohelper.onceAddComponent(arg_10_0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	arg_10_0._conMark:SetMarkTopGo(arg_10_0._txtmarktop.gameObject)
	arg_10_0._conMark:SetTopOffset(0, -2)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._mapElement = arg_11_0.viewParam

	arg_11_0._mapElement:setWenHaoVisible(false)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, false)

	arg_11_0._config = arg_11_0._mapElement._config
	arg_11_0._elementGo = arg_11_0._mapElement._go
	arg_11_0._elementInfo = arg_11_0._mapElement._info

	arg_11_0:_playStory()
	arg_11_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))

	local var_11_0 = WeekWalkModel.instance:getCurMapInfo()

	gohelper.setActive(arg_11_0._btnskip.gameObject, var_11_0:storyIsFinished(arg_11_0._dialogId))
	NavigateMgr.instance:addSpace(ViewName.WeekWalkDialogView, arg_11_0._onSpace, arg_11_0)
end

function var_0_0._onSpace(arg_12_0)
	if not arg_12_0._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	arg_12_0:_btnnextOnClick()
end

function var_0_0._playNextSectionOrDialog(arg_13_0)
	if #arg_13_0._sectionList >= arg_13_0._dialogIndex then
		arg_13_0:_playNextDialog()

		return
	end

	local var_13_0 = table.remove(arg_13_0._sectionStack)

	if var_13_0 then
		arg_13_0:_playSection(var_13_0[1], var_13_0[2])
	else
		arg_13_0:_refreshDialogBtnState()
	end
end

function var_0_0._playStory(arg_14_0, arg_14_1)
	arg_14_0._sectionStack = {}
	arg_14_0._optionId = 0
	arg_14_0._mainSectionId = "0"
	arg_14_0._sectionId = arg_14_0._mainSectionId
	arg_14_0._dialogIndex = nil
	arg_14_0._historyList = {}
	arg_14_0._dialogId = arg_14_1 or tonumber(arg_14_0._elementInfo:getParam())

	arg_14_0:_initHistoryItem()

	arg_14_0._historyList.id = arg_14_0._dialogId

	arg_14_0:_playSection(arg_14_0._sectionId, arg_14_0._dialogIndex)
end

function var_0_0._initHistoryItem(arg_15_0)
	local var_15_0 = arg_15_0._elementInfo.historylist

	if #var_15_0 == 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = string.split(iter_15_1, "#")

		arg_15_0._historyList[var_15_1[1]] = tonumber(var_15_1[2])
	end

	local var_15_2 = arg_15_0._historyList.id

	if not var_15_2 or var_15_2 ~= arg_15_0._dialogId then
		arg_15_0._historyList = {}

		return
	end

	arg_15_0._option_param = arg_15_0._historyList.option

	local var_15_3 = arg_15_0._mainSectionId
	local var_15_4 = arg_15_0._historyList[var_15_3]

	arg_15_0:_addSectionHistory(var_15_3, var_15_4)

	if not arg_15_0._dialogIndex then
		arg_15_0._dialogIndex = var_15_4
		arg_15_0._sectionId = var_15_3
	end
end

function var_0_0._addSectionHistory(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = WeekWalkConfig.instance:getDialog(arg_16_0._dialogId, arg_16_1)
	local var_16_1

	if arg_16_1 == arg_16_0._mainSectionId then
		var_16_1 = arg_16_2 > #var_16_0
	else
		var_16_1 = arg_16_2 >= #var_16_0
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if (iter_16_0 < arg_16_2 or var_16_1) and (iter_16_1.type ~= "dialog" or true) then
			if iter_16_1.type == "options" then
				local var_16_2 = string.split(iter_16_1.content, "#")
				local var_16_3 = string.split(iter_16_1.param, "#")
				local var_16_4 = {}
				local var_16_5 = {}

				for iter_16_2, iter_16_3 in ipairs(var_16_3) do
					local var_16_6 = WeekWalkConfig.instance:getDialog(arg_16_0._dialogId, iter_16_3)

					if var_16_6 and var_16_6.type == "random" then
						for iter_16_4, iter_16_5 in ipairs(var_16_6) do
							local var_16_7 = string.split(iter_16_5.option_param, "#")
							local var_16_8 = var_16_7[2]
							local var_16_9 = var_16_7[3]

							table.insert(var_16_4, var_16_2[iter_16_2])
							table.insert(var_16_5, var_16_8)
							table.insert(var_16_4, var_16_2[iter_16_2])
							table.insert(var_16_5, var_16_9)
						end
					elseif var_16_6 then
						table.insert(var_16_4, var_16_2[iter_16_2])
						table.insert(var_16_5, iter_16_3)
					end
				end

				for iter_16_6, iter_16_7 in ipairs(var_16_5) do
					local var_16_10 = arg_16_0._historyList[iter_16_7]

					if var_16_10 then
						arg_16_0:_addSectionHistory(iter_16_7, var_16_10)
					end
				end
			end
		else
			break
		end
	end

	if not var_16_1 then
		if not arg_16_0._dialogIndex then
			arg_16_0._dialogIndex = arg_16_2
			arg_16_0._sectionId = arg_16_1

			return
		end

		table.insert(arg_16_0._sectionStack, 1, {
			arg_16_1,
			arg_16_2
		})
	end
end

function var_0_0._playSection(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_setSectionData(arg_17_1, arg_17_2)
	arg_17_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._sectionList = WeekWalkConfig.instance:getDialog(arg_18_0._dialogId, arg_18_1)

	if arg_18_0._sectionList and not string.nilorempty(arg_18_0._sectionList.option_param) then
		arg_18_0._option_param = arg_18_0._sectionList.option_param
	end

	if not string.nilorempty(arg_18_0._option_param) then
		arg_18_0._historyList.option = arg_18_0._option_param
	end

	arg_18_0._dialogIndex = arg_18_2 or 1
	arg_18_0._sectionId = arg_18_1
end

function var_0_0._playNextDialog(arg_19_0)
	local var_19_0 = arg_19_0._sectionList[arg_19_0._dialogIndex]

	if var_19_0 and var_19_0.type == "dialog" then
		arg_19_0:_showDialog("dialog", var_19_0.content, var_19_0.speaker)

		arg_19_0._dialogIndex = arg_19_0._dialogIndex + 1

		if #arg_19_0._sectionStack > 0 and #arg_19_0._sectionList < arg_19_0._dialogIndex then
			local var_19_1 = table.remove(arg_19_0._sectionStack)

			arg_19_0:_setSectionData(var_19_1[1], var_19_1[2])
		end

		arg_19_0:_refreshDialogBtnState()
	elseif var_19_0 and var_19_0.type == "options" then
		arg_19_0:_showOptionByConfig(var_19_0)
	end
end

function var_0_0._showOptionByConfig(arg_20_0, arg_20_1)
	local var_20_0 = false

	if arg_20_1 and arg_20_1.type == "options" then
		arg_20_0:_updateHistory()

		arg_20_0._dialogIndex = arg_20_0._dialogIndex + 1

		local var_20_1 = string.split(arg_20_1.content, "#")
		local var_20_2 = string.split(arg_20_1.param, "#")

		arg_20_0._isSingle = arg_20_1.single == 1

		if arg_20_0._isSkip then
			var_20_0 = true

			arg_20_0:_refreshDialogBtnState(var_20_0)
			arg_20_0:_skipOption(var_20_1, var_20_2)

			return
		else
			arg_20_0._skipOptionParams = {
				var_20_1,
				var_20_2
			}

			for iter_20_0, iter_20_1 in pairs(arg_20_0._optionBtnList) do
				gohelper.setActive(iter_20_1[1], false)
			end

			for iter_20_2, iter_20_3 in ipairs(var_20_1) do
				arg_20_0:_addDialogOption(iter_20_2, var_20_2[iter_20_2], var_20_1[iter_20_2], #var_20_1)
			end

			gohelper.setActive(arg_20_0._nexticon, false)
		end

		for iter_20_4, iter_20_5 in ipairs(arg_20_0._optionBtnList) do
			local var_20_3 = gohelper.findChild(iter_20_5[1], "#go_pcbtn")

			PCInputController.instance:showkeyTips(var_20_3, nil, nil, "Alpha" .. iter_20_4)
		end

		var_20_0 = true
	end

	arg_20_0:_refreshDialogBtnState(var_20_0)
end

function var_0_0._skipOption(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 1
	local var_21_1 = WeekWalkModel.instance:getCurMapId()

	if var_21_1 >= 201 and var_21_1 <= 205 then
		var_21_0 = #arg_21_1
	end

	local var_21_2 = var_21_0
	local var_21_3 = arg_21_2[var_21_0]
	local var_21_4 = arg_21_1[var_21_0]

	arg_21_0:_onOptionClick({
		var_21_3,
		var_21_4,
		var_21_2
	})
end

function var_0_0._refreshDialogBtnState(arg_22_0, arg_22_1)
	if arg_22_1 then
		gohelper.setActive(arg_22_0._gooptions, true)
	else
		arg_22_0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(arg_22_0._txtinfo, not arg_22_1)
	gohelper.setActive(arg_22_0._btnnext, not arg_22_1)

	if arg_22_1 then
		return
	end

	local var_22_0 = not (#arg_22_0._sectionStack > 0 or #arg_22_0._sectionList >= arg_22_0._dialogIndex)

	if arg_22_0._isFinish then
		SLFramework.AnimatorPlayer.Get(arg_22_0.viewGO):Play(UIAnimationName.Close, arg_22_0._fadeOutDone, arg_22_0)

		arg_22_0._finishClose = true
	end

	arg_22_0._isFinish = var_22_0
end

function var_0_0._fadeOutDone(arg_23_0)
	if arg_23_0._config.skipFinish ~= 1 then
		arg_23_0:_sendFinishDialog()
	end

	if arg_23_0._elementInfo:getNextType() == WeekWalkEnum.ElementType.Battle then
		local var_23_0 = arg_23_0._elementInfo.elementId

		var_0_0.startBattle(var_23_0)
	end

	arg_23_0:closeThis()
end

function var_0_0._playCloseTalkItemEffect(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._optionBtnList) do
		iter_24_1[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(arg_24_0._hideOption, arg_24_0, 0.133)
end

function var_0_0._hideOption(arg_25_0)
	gohelper.setActive(arg_25_0._gooptions, false)
end

function var_0_0.startBattle(arg_26_0)
	WeekWalkModel.instance:setBattleElementId(arg_26_0)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(arg_26_0)
end

function var_0_0._sendFinishDialog(arg_27_0)
	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	local var_27_0 = tonumber(arg_27_0._option_param) or 0
	local var_27_1 = WeekWalkConfig.instance:getOptionParamList(arg_27_0._dialogId)

	if var_27_1 and #var_27_1 > 0 then
		local var_27_2 = 1
		local var_27_3 = WeekWalkModel.instance:getCurMapId()

		if var_27_3 >= 201 and var_27_3 <= 205 then
			var_27_2 = 2
		end

		if var_27_0 ~= var_27_2 then
			var_27_0 = var_27_2
		end
	end

	WeekwalkRpc.instance:sendWeekwalkDialogRequest(arg_27_0._config.id, var_27_0)
end

function var_0_0._addDialogOption(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = arg_28_0._optionBtnList[arg_28_1] and arg_28_0._optionBtnList[arg_28_1][1] or gohelper.cloneInPlace(arg_28_0._gotalkitem)

	var_28_0.gameObject.transform:SetSiblingIndex(arg_28_4 - arg_28_1)
	gohelper.setActive(var_28_0, true)

	gohelper.findChildText(var_28_0, "txt_talkitem").text = arg_28_3

	local var_28_1 = gohelper.findChildButtonWithAudio(var_28_0, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	var_28_1:AddClickListener(arg_28_0._onOptionClick, arg_28_0, {
		arg_28_2,
		arg_28_3,
		arg_28_1
	})

	if not arg_28_0._optionBtnList[arg_28_1] then
		arg_28_0._optionBtnList[arg_28_1] = {
			var_28_0,
			var_28_1
		}
	end

	if not arg_28_0._isSingle then
		return
	end

	local var_28_2 = WeekWalkModel.instance:getCurMapConfig()

	if arg_28_1 == 1 then
		local var_28_3 = gohelper.findChild(var_28_0, "mask")
		local var_28_4 = var_28_2.type ~= 1

		gohelper.setActive(var_28_3, var_28_4)

		local var_28_5 = gohelper.findChild(var_28_0, "chaticon")

		gohelper.setActive(var_28_5, not var_28_4)
		gohelper.setActive(var_28_1.gameObject, not var_28_4)
	end

	if arg_28_1 == 2 then
		gohelper.setActive(var_28_0, var_28_2.type ~= 1)
	end
end

function var_0_0._onOptionClick(arg_29_0, arg_29_1)
	arg_29_0._skipOptionParams = nil

	if not arg_29_0:_checkClickCd() then
		return
	end

	local var_29_0 = arg_29_1[1]
	local var_29_1 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", arg_29_1[2])

	arg_29_0:_showDialog("option", var_29_1)

	arg_29_0._showOption = true
	arg_29_0._optionId = arg_29_1[3]

	arg_29_0:_checkOption(var_29_0)
end

function var_0_0._checkOption(arg_30_0, arg_30_1)
	local var_30_0 = WeekWalkConfig.instance:getDialog(arg_30_0._dialogId, arg_30_1)

	if not var_30_0 then
		arg_30_0:_playNextSectionOrDialog()

		return
	end

	if #arg_30_0._sectionList >= arg_30_0._dialogIndex then
		table.insert(arg_30_0._sectionStack, {
			arg_30_0._sectionId,
			arg_30_0._dialogIndex
		})
	end

	if var_30_0.type == "random" then
		for iter_30_0, iter_30_1 in ipairs(var_30_0) do
			local var_30_1 = string.split(iter_30_1.option_param, "#")
			local var_30_2 = tonumber(var_30_1[1])
			local var_30_3 = var_30_1[2]
			local var_30_4 = var_30_1[3]
			local var_30_5 = math.random(100)
			local var_30_6

			if var_30_5 <= var_30_2 then
				var_30_6 = var_30_3
			else
				var_30_6 = var_30_4
			end

			arg_30_0:_playSection(var_30_6)

			break
		end
	else
		arg_30_0:_playSection(arg_30_1)
	end
end

function var_0_0._showDialog(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	arg_31_0:_updateHistory()

	if arg_31_0._isSkip then
		return
	end

	local var_31_0 = arg_31_0:_addDialogItem(arg_31_1, arg_31_2, arg_31_3)
end

function var_0_0._updateHistory(arg_32_0)
	if arg_32_0._isSkip then
		return
	end

	if arg_32_0._config.skipFinish == 1 then
		return
	end

	arg_32_0._historyList[arg_32_0._sectionId] = arg_32_0._dialogIndex

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(arg_32_0._historyList) do
		table.insert(var_32_0, string.format("%s#%s", iter_32_0, iter_32_1))
	end

	arg_32_0._elementInfo:updateHistoryList(var_32_0)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	WeekwalkRpc.instance:sendWeekwalkDialogHistoryRequest(arg_32_0._config.id, var_32_0)
end

function var_0_0._addDialogItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = (not string.nilorempty(arg_33_3) and "<#FAFAFA>" .. arg_33_3 .. ":  " or "") .. arg_33_2
	local var_33_1 = StoryTool.getMarkTopTextList(var_33_0)
	local var_33_2 = StoryTool.filterMarkTop(var_33_0)

	arg_33_0._txtinfo.text = var_33_2

	TaskDispatcher.runDelay(function()
		arg_33_0._conMark:SetMarksTop(var_33_1)
	end, nil, 0.01)
	arg_33_0._animatorPlayer:Play(UIAnimationName.Click, arg_33_0._animDone, arg_33_0)
	gohelper.setActive(arg_33_0._nexticon, true)
end

function var_0_0._animDone(arg_35_0)
	return
end

function var_0_0.onClose(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0._optionBtnList) do
		iter_36_1[2]:RemoveClickListener()
	end

	arg_36_0._mapElement:setWenHaoVisible(true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSetEpisodeListVisible, true)
	TaskDispatcher.cancelTask(arg_36_0._hideOption, arg_36_0)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0._simagebg:UnLoadImage()
end

return var_0_0
