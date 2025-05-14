module("modules.logic.versionactivity1_4.act131.view.Activity131DialogView", package.seeall)

local var_0_0 = class("Activity131DialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._gotopcontent = gohelper.findChild(arg_1_0.viewGO, "#go_topcontent")
	arg_1_0._godialoghead = gohelper.findChild(arg_1_0.viewGO, "#go_topcontent/#go_dialoghead")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_topcontent/#go_dialoghead/#image_headicon")
	arg_1_0._txtdialogdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_topcontent/#txt_dialogdesc")
	arg_1_0._gobottomcontent = gohelper.findChild(arg_1_0.viewGO, "#go_bottomcontent")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_bottomcontent/#go_content")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bottomcontent/#go_content/#simage_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_bottomcontent/#go_content/#txt_info")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "#go_bottomcontent/#go_content/#go_options")
	arg_1_0._gotalkitem = gohelper.findChild(arg_1_0.viewGO, "#go_bottomcontent/#go_content/#go_options/#go_talkitem")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bottomcontent/#btn_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		arg_4_0:_skipStory()
	end)
end

function var_0_0._skipStory(arg_6_0)
	arg_6_0._isSkip = true

	if arg_6_0._skipOptionParams then
		arg_6_0:_skipOption(arg_6_0._skipOptionParams[1], arg_6_0._skipOptionParams[2])
	end

	for iter_6_0 = 1, 100 do
		arg_6_0:_playNextSectionOrDialog()

		if arg_6_0._finishClose then
			break
		end
	end
end

function var_0_0._btnnextOnClick(arg_7_0)
	if not arg_7_0._btnnext.gameObject.activeInHierarchy or arg_7_0._finishClose then
		return
	end

	if not arg_7_0:_checkClickCd() then
		return
	end

	arg_7_0:_playNextSectionOrDialog()
end

function var_0_0._checkClickCd(arg_8_0)
	if Time.time - arg_8_0._time < 0.5 then
		return
	end

	arg_8_0._time = Time.time

	return true
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._time = Time.time
	arg_9_0._optionBtnList = arg_9_0:getUserDataTb_()
	arg_9_0._dialogItemList = arg_9_0:getUserDataTb_()
	arg_9_0._dialogItemCacheList = arg_9_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_9_0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	arg_9_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_9_0._txtinfo.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_9_0._conMark = gohelper.onceAddComponent(arg_9_0._txtinfo.gameObject, typeof(ZProj.TMPMark))

	arg_9_0._conMark:SetMarkTopGo(arg_9_0._txtmarktop.gameObject)

	arg_9_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_9_0.viewGO)
	arg_9_0._nexticon = gohelper.findChild(arg_9_0.viewGO, "#go_content/nexticon")
end

function var_0_0.onOpen(arg_10_0)
	Activity131Controller.instance:dispatchEvent(Activity131Event.OnSetEpisodeListVisible, false)

	arg_10_0._elementInfo = arg_10_0.viewParam

	arg_10_0:_playStory()
	arg_10_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.Activity131DialogView, arg_10_0._onSpace, arg_10_0)
end

function var_0_0._onSpace(arg_11_0)
	if not arg_11_0._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	arg_11_0:_btnnextOnClick()
end

function var_0_0._playNextSectionOrDialog(arg_12_0)
	if #arg_12_0._sectionList >= arg_12_0._dialogIndex then
		arg_12_0:_playNextDialog()

		return
	end

	local var_12_0 = table.remove(arg_12_0._sectionStack)

	if var_12_0 then
		arg_12_0:_playSection(var_12_0[1], var_12_0[2])
	else
		arg_12_0:_refreshDialogBtnState()
	end
end

function var_0_0._playStory(arg_13_0, arg_13_1)
	arg_13_0._sectionStack = {}
	arg_13_0._optionId = 0
	arg_13_0._mainSectionId = "0"
	arg_13_0._sectionId = arg_13_0._mainSectionId
	arg_13_0._dialogIndex = nil
	arg_13_0._historyList = {}
	arg_13_0._dialogId = arg_13_1 or tonumber(arg_13_0._elementInfo:getParam())

	arg_13_0:_initHistoryItem()

	arg_13_0._historyList.id = arg_13_0._dialogId

	arg_13_0:_playSection(arg_13_0._sectionId, arg_13_0._dialogIndex)
end

function var_0_0._initHistoryItem(arg_14_0)
	local var_14_0 = arg_14_0._elementInfo.historylist

	if #var_14_0 == 0 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = string.split(iter_14_1, "#")

		arg_14_0._historyList[var_14_1[1]] = tonumber(var_14_1[2])
	end

	local var_14_2 = arg_14_0._historyList.id

	if not var_14_2 or var_14_2 ~= arg_14_0._dialogId then
		arg_14_0._historyList = {}

		return
	end

	arg_14_0._option_param = arg_14_0._historyList.option

	local var_14_3 = arg_14_0._mainSectionId
	local var_14_4 = arg_14_0._historyList[var_14_3]

	arg_14_0:_addSectionHistory(var_14_3, var_14_4)

	if not arg_14_0._dialogIndex then
		arg_14_0._dialogIndex = var_14_4
		arg_14_0._sectionId = var_14_3
	end
end

function var_0_0._addSectionHistory(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = Activity131Config.instance:getDialog(arg_15_0._dialogId, arg_15_1)
	local var_15_1

	if arg_15_1 == arg_15_0._mainSectionId then
		var_15_1 = arg_15_2 > #var_15_0
	else
		var_15_1 = arg_15_2 >= #var_15_0
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_0 < arg_15_2 or var_15_1 then
			if iter_15_1.type == Activity131Enum.dialogType.options then
				local var_15_2 = string.split(iter_15_1.content, "#")
				local var_15_3 = string.split(iter_15_1.param, "#")
				local var_15_4 = {}
				local var_15_5 = {}

				for iter_15_2, iter_15_3 in ipairs(var_15_3) do
					local var_15_6 = Activity131Config.instance:getDialog(arg_15_0._dialogId, iter_15_3)

					if var_15_6 and var_15_6.type == "random" then
						for iter_15_4, iter_15_5 in ipairs(var_15_6) do
							local var_15_7 = string.split(iter_15_5.option_param, "#")
							local var_15_8 = var_15_7[2]
							local var_15_9 = var_15_7[3]

							table.insert(var_15_4, var_15_2[iter_15_2])
							table.insert(var_15_5, var_15_8)
							table.insert(var_15_4, var_15_2[iter_15_2])
							table.insert(var_15_5, var_15_9)
						end
					elseif var_15_6 then
						table.insert(var_15_4, var_15_2[iter_15_2])
						table.insert(var_15_5, iter_15_3)
					end
				end

				for iter_15_6, iter_15_7 in ipairs(var_15_5) do
					local var_15_10 = arg_15_0._historyList[iter_15_7]

					if var_15_10 then
						arg_15_0:_addSectionHistory(iter_15_7, var_15_10)
					end
				end
			end
		else
			break
		end
	end

	if not var_15_1 then
		if not arg_15_0._dialogIndex then
			arg_15_0._dialogIndex = arg_15_2
			arg_15_0._sectionId = arg_15_1

			return
		end

		table.insert(arg_15_0._sectionStack, 1, {
			arg_15_1,
			arg_15_2
		})
	end
end

function var_0_0._playSection(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:_setSectionData(arg_16_1, arg_16_2)
	arg_16_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._sectionList = Activity131Config.instance:getDialog(arg_17_0._dialogId, arg_17_1)

	if arg_17_0._sectionList and not string.nilorempty(arg_17_0._sectionList.option_param) then
		arg_17_0._option_param = arg_17_0._sectionList.option_param
	end

	if not string.nilorempty(arg_17_0._option_param) then
		arg_17_0._historyList.option = arg_17_0._option_param
	end

	arg_17_0._dialogIndex = arg_17_2 or 1
	arg_17_0._sectionId = arg_17_1
end

function var_0_0._playNextDialog(arg_18_0)
	local var_18_0 = arg_18_0._sectionList[arg_18_0._dialogIndex]

	if not var_18_0 then
		return
	end

	if var_18_0.type == Activity131Enum.dialogType.dialog then
		arg_18_0:_showDialog(Activity131Enum.dialogType.dialog, var_18_0.content, var_18_0.speaker)

		arg_18_0._dialogIndex = arg_18_0._dialogIndex + 1

		if #arg_18_0._sectionStack > 0 and #arg_18_0._sectionList < arg_18_0._dialogIndex then
			local var_18_1 = table.remove(arg_18_0._sectionStack)

			arg_18_0:_setSectionData(var_18_1[1], var_18_1[2])
		end

		arg_18_0:_refreshDialogBtnState()
	elseif var_18_0.type == Activity131Enum.dialogType.option then
		arg_18_0:_showOptionByConfig(var_18_0)
	elseif var_18_0.type == Activity131Enum.dialogType.talk then
		arg_18_0:_showTalk(Activity131Enum.dialogType.talk, var_18_0)

		arg_18_0._dialogIndex = arg_18_0._dialogIndex + 1

		if #arg_18_0._sectionStack > 0 and #arg_18_0._sectionList < arg_18_0._dialogIndex then
			local var_18_2 = table.remove(arg_18_0._sectionStack)

			arg_18_0:_setSectionData(var_18_2[1], var_18_2[2])
		end

		arg_18_0:_refreshDialogBtnState()
	end
end

function var_0_0._showDialog(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_0._audioId and arg_19_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_19_0._audioId, 0)
	end

	gohelper.setActive(arg_19_0._gobottomcontent, true)
	gohelper.setActive(arg_19_0._gotopcontent, false)
	arg_19_0:_updateHistory()

	if arg_19_0._isSkip then
		return
	end

	local var_19_0 = arg_19_0:_addDialogItem(arg_19_1, arg_19_2, arg_19_3)
end

function var_0_0._showTalk(arg_20_0, arg_20_1, arg_20_2)
	gohelper.setActive(arg_20_0._gobottomcontent, false)
	gohelper.setActive(arg_20_0._gotopcontent, true)
	arg_20_0:_updateHistory()

	arg_20_0._isSkip = false
	arg_20_0._txtdialogdesc.text = arg_20_2.content

	local var_20_0 = string.splitToNumber(arg_20_2.param, "#")
	local var_20_1 = string.format("singlebg/headicon_small/%s.png", var_20_0[1])

	arg_20_0._simagehead:LoadImage(var_20_1)

	if arg_20_0._audioId and arg_20_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_20_0._audioId, 0)
	end

	arg_20_0._audioId = var_20_0[2]

	if arg_20_0._audioId > 0 then
		AudioEffectMgr.instance:playAudio(arg_20_0._audioId)
	end
end

function var_0_0._showOptionByConfig(arg_21_0, arg_21_1)
	local var_21_0 = false

	if arg_21_1 and arg_21_1.type == Activity131Enum.dialogType.option then
		arg_21_0:_updateHistory()

		arg_21_0._dialogIndex = arg_21_0._dialogIndex + 1

		local var_21_1 = string.split(arg_21_1.content, "#")
		local var_21_2 = string.split(arg_21_1.param, "#")

		arg_21_0._isSingle = arg_21_1.single == 1

		if arg_21_0._isSkip then
			var_21_0 = true

			arg_21_0:_refreshDialogBtnState(var_21_0)
			arg_21_0:_skipOption(var_21_1, var_21_2)

			return
		else
			arg_21_0._skipOptionParams = {
				var_21_1,
				var_21_2
			}

			for iter_21_0, iter_21_1 in pairs(arg_21_0._optionBtnList) do
				gohelper.setActive(iter_21_1[1], false)
			end

			for iter_21_2 = #var_21_1, 1, -1 do
				arg_21_0:_addDialogOption(iter_21_2, var_21_2[iter_21_2], var_21_1[iter_21_2])
			end

			gohelper.setActive(arg_21_0._nexticon, false)
		end

		var_21_0 = true
	end

	arg_21_0:_refreshDialogBtnState(var_21_0)
end

function var_0_0._skipOption(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = 1
	local var_22_1 = Activity131Model.instance:getCurMapId()

	if var_22_1 >= 201 and var_22_1 <= 205 then
		var_22_0 = #arg_22_1
	end

	local var_22_2 = var_22_0
	local var_22_3 = arg_22_2[var_22_0]
	local var_22_4 = arg_22_1[var_22_0]

	arg_22_0:_onOptionClick({
		var_22_3,
		var_22_4,
		var_22_2
	})
end

function var_0_0._refreshDialogBtnState(arg_23_0, arg_23_1)
	if arg_23_1 then
		gohelper.setActive(arg_23_0._gooptions, true)
	else
		arg_23_0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(arg_23_0._txtinfo, not arg_23_1)
	gohelper.setActive(arg_23_0._btnnext, not arg_23_1)

	if arg_23_1 then
		return
	end

	local var_23_0 = not (#arg_23_0._sectionStack > 0 or #arg_23_0._sectionList >= arg_23_0._dialogIndex)

	if arg_23_0._isFinish then
		SLFramework.AnimatorPlayer.Get(arg_23_0.viewGO):Play(UIAnimationName.Close, arg_23_0._fadeOutDone, arg_23_0)

		arg_23_0._finishClose = true
	end

	arg_23_0._isFinish = var_23_0
end

function var_0_0._fadeOutDone(arg_24_0)
	if arg_24_0._elementInfo.config.skipFinish ~= 1 then
		arg_24_0:_sendFinishDialog()
	end

	if arg_24_0._elementInfo:getNextType() == Activity131Enum.ElementType.Battle then
		local var_24_0 = arg_24_0._elementInfo.elementId

		var_0_0.startBattle(var_24_0)
	end

	arg_24_0:closeThis()
end

function var_0_0._playCloseTalkItemEffect(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._optionBtnList) do
		iter_25_1[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(arg_25_0._hideOption, arg_25_0, 0.133)
end

function var_0_0._hideOption(arg_26_0)
	gohelper.setActive(arg_26_0._gooptions, false)
end

function var_0_0.startBattle(arg_27_0)
	return
end

function var_0_0._sendFinishDialog(arg_28_0)
	local var_28_0 = tonumber(arg_28_0._option_param) or 0
	local var_28_1 = Activity131Config.instance:getOptionParamList(arg_28_0._dialogId)

	if var_28_1 and #var_28_1 > 0 then
		local var_28_2 = 1
		local var_28_3 = Activity131Model.instance:getCurMapId()

		if var_28_3 >= 201 and var_28_3 <= 205 then
			var_28_2 = 2
		end

		if var_28_0 ~= var_28_2 then
			var_28_0 = var_28_2
		end
	end

	local var_28_4 = VersionActivity1_4Enum.ActivityId.Role6
	local var_28_5 = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendAct131DialogRequest(var_28_4, var_28_5, arg_28_0._elementInfo.elementId, var_28_0)
end

function var_0_0._addDialogOption(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0._optionBtnList[arg_29_1] and arg_29_0._optionBtnList[arg_29_1][1] or gohelper.cloneInPlace(arg_29_0._gotalkitem)

	gohelper.setActive(var_29_0, true)

	gohelper.findChildText(var_29_0, "txt_talkitem").text = arg_29_3

	local var_29_1 = gohelper.findChildButtonWithAudio(var_29_0, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	var_29_1:AddClickListener(arg_29_0._onOptionClick, arg_29_0, {
		arg_29_2,
		arg_29_3,
		arg_29_1
	})

	if not arg_29_0._optionBtnList[arg_29_1] then
		arg_29_0._optionBtnList[arg_29_1] = {
			var_29_0,
			var_29_1
		}
	end

	if not arg_29_0._isSingle then
		return
	end

	local var_29_2 = Activity131Model.instance:getCurMapConfig()

	if arg_29_1 == 1 then
		local var_29_3 = gohelper.findChild(var_29_0, "mask")
		local var_29_4 = var_29_2.type ~= 1

		gohelper.setActive(var_29_3, var_29_4)

		local var_29_5 = gohelper.findChild(var_29_0, "chaticon")

		gohelper.setActive(var_29_5, not var_29_4)
		gohelper.setActive(var_29_1.gameObject, not var_29_4)
	end

	if arg_29_1 == 2 then
		gohelper.setActive(var_29_0, var_29_2.type ~= 1)
	end
end

function var_0_0._onOptionClick(arg_30_0, arg_30_1)
	arg_30_0._skipOptionParams = nil

	if not arg_30_0:_checkClickCd() then
		return
	end

	local var_30_0 = arg_30_1[1]
	local var_30_1 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", arg_30_1[2])

	arg_30_0:_showDialog("option", var_30_1)

	arg_30_0._showOption = true
	arg_30_0._optionId = arg_30_1[3]

	arg_30_0:_checkOption(var_30_0)
end

function var_0_0._checkOption(arg_31_0, arg_31_1)
	local var_31_0 = Activity131Config.instance:getDialog(arg_31_0._dialogId, arg_31_1)

	if not var_31_0 then
		arg_31_0:_playNextSectionOrDialog()

		return
	end

	if #arg_31_0._sectionList >= arg_31_0._dialogIndex then
		table.insert(arg_31_0._sectionStack, {
			arg_31_0._sectionId,
			arg_31_0._dialogIndex
		})
	end

	if var_31_0.type == "random" then
		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			local var_31_1 = string.split(iter_31_1.option_param, "#")
			local var_31_2 = tonumber(var_31_1[1])
			local var_31_3 = var_31_1[2]
			local var_31_4 = var_31_1[3]
			local var_31_5 = math.random(100)
			local var_31_6

			if var_31_5 <= var_31_2 then
				var_31_6 = var_31_3
			else
				var_31_6 = var_31_4
			end

			arg_31_0:_playSection(var_31_6)

			break
		end
	else
		arg_31_0:_playSection(arg_31_1)
	end
end

function var_0_0._updateHistory(arg_32_0)
	if arg_32_0._isSkip then
		return
	end

	if arg_32_0._elementInfo.config.skipFinish == 1 then
		return
	end

	arg_32_0._historyList[arg_32_0._sectionId] = arg_32_0._dialogIndex

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(arg_32_0._historyList) do
		table.insert(var_32_0, string.format("%s#%s", iter_32_0, iter_32_1))
	end

	arg_32_0._elementInfo:updateHistoryList(var_32_0)

	local var_32_1 = VersionActivity1_4Enum.ActivityId.Role6
	local var_32_2 = Activity131Model.instance:getCurEpisodeId()

	Activity131Rpc.instance:sendAct131DialogHistoryRequest(var_32_1, var_32_2, arg_32_0._elementInfo.elementId, var_32_0)
end

function var_0_0._addDialogItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = not string.nilorempty(arg_33_3) and "<#FAFAFA>" .. arg_33_3 .. ":  " .. arg_33_2 or arg_33_2
	local var_33_1 = StoryTool.getMarkTopTextList(var_33_0)
	local var_33_2 = StoryTool.filterMarkTop(var_33_0)

	arg_33_0._txtinfo.text = var_33_2

	TaskDispatcher.runDelay(function()
		arg_33_0._conMark:SetMarksTop(var_33_1)
	end, nil, 0.01)

	arg_33_0._txtinfo.text = var_33_2

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

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnSetEpisodeListVisible, true)
	TaskDispatcher.cancelTask(arg_36_0._hideOption, arg_36_0)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0._simagebg:UnLoadImage()
end

return var_0_0
