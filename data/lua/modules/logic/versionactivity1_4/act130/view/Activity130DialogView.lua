module("modules.logic.versionactivity1_4.act130.view.Activity130DialogView", package.seeall)

local var_0_0 = class("Activity130DialogView", BaseView)

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

	if arg_7_0.viewParam.isClient then
		if #string.split(arg_7_0.viewParam.dialogParam, "#") < arg_7_0._clientDialogIndex then
			arg_7_0:closeThis()
		end

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

	arg_9_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_9_0.viewGO)
	arg_9_0._nexticon = gohelper.findChild(arg_9_0.viewGO, "#go_content/nexticon")
	arg_9_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_9_0._txtdialogdesc.gameObject):GetComponent(gohelper.Type_TextMesh)
	arg_9_0._conMark = gohelper.onceAddComponent(arg_9_0._txtdialogdesc.gameObject, typeof(ZProj.TMPMark))

	arg_9_0._conMark:SetMarkTopGo(arg_9_0._txtmarktop.gameObject)
	arg_9_0._conMark:SetTopOffset(0, -7.3257)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.Activity130DialogView, arg_10_0._onSpace, arg_10_0)

	if arg_10_0.viewParam.isClient then
		arg_10_0._clientDialogIndex = 1
		arg_10_0.viewContainer:getSetting().viewType = ViewType.Normal

		arg_10_0:_showClientTalk()
	else
		arg_10_0._elementInfo = arg_10_0.viewParam.elementInfo
		arg_10_0.viewContainer:getSetting().viewType = ViewType.Full

		arg_10_0:_playStory()
	end
end

function var_0_0._showClientTalk(arg_11_0)
	gohelper.setActive(arg_11_0._gobottomcontent, false)
	gohelper.setActive(arg_11_0._gotopcontent, true)

	local var_11_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_11_1 = string.split(arg_11_0.viewParam.dialogParam, "#")
	local var_11_2 = string.splitToNumber(var_11_1[arg_11_0._clientDialogIndex], "_")
	local var_11_3 = Activity130Config.instance:getActivity130DialogCo(var_11_2[1], var_11_2[2])

	arg_11_0._clientDialogIndex = arg_11_0._clientDialogIndex + 1
	arg_11_0._txtdialogdesc.text = var_11_3.content

	local var_11_4 = string.splitToNumber(var_11_3.param, "#")
	local var_11_5 = string.format("singlebg/headicon_small/%s.png", var_11_4[1])

	arg_11_0._simagehead:LoadImage(var_11_5)

	if arg_11_0._audioId and arg_11_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_11_0._audioId, 0)
	end

	arg_11_0._audioId = var_11_4[2]

	AudioEffectMgr.instance:playAudio(arg_11_0._audioId)
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
	local var_16_0 = Activity130Config.instance:getDialog(arg_16_0._dialogId, arg_16_1)
	local var_16_1

	if arg_16_1 == arg_16_0._mainSectionId then
		var_16_1 = arg_16_2 > #var_16_0
	else
		var_16_1 = arg_16_2 >= #var_16_0
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_0 < arg_16_2 or var_16_1 then
			if iter_16_1.type == Activity130Enum.dialogType.options then
				local var_16_2 = string.split(iter_16_1.content, "#")
				local var_16_3 = string.split(iter_16_1.param, "#")
				local var_16_4 = {}
				local var_16_5 = {}

				for iter_16_2, iter_16_3 in ipairs(var_16_3) do
					local var_16_6 = Activity130Config.instance:getDialog(arg_16_0._dialogId, iter_16_3)

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
	arg_18_0._sectionList = Activity130Config.instance:getDialog(arg_18_0._dialogId, arg_18_1)

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

	if not var_19_0 then
		return
	end

	if var_19_0.type == Activity130Enum.dialogType.dialog then
		arg_19_0:_showDialog(Activity130Enum.dialogType.dialog, var_19_0.content, var_19_0.speaker)

		arg_19_0._dialogIndex = arg_19_0._dialogIndex + 1

		if #arg_19_0._sectionStack > 0 and #arg_19_0._sectionList < arg_19_0._dialogIndex then
			local var_19_1 = table.remove(arg_19_0._sectionStack)

			arg_19_0:_setSectionData(var_19_1[1], var_19_1[2])
		end

		arg_19_0:_refreshDialogBtnState()
	elseif var_19_0.type == Activity130Enum.dialogType.option then
		arg_19_0:_showOptionByConfig(var_19_0)
	elseif var_19_0.type == Activity130Enum.dialogType.talk then
		arg_19_0:_showTalk(Activity130Enum.dialogType.talk, var_19_0)

		arg_19_0._dialogIndex = arg_19_0._dialogIndex + 1

		if #arg_19_0._sectionStack > 0 and #arg_19_0._sectionList < arg_19_0._dialogIndex then
			local var_19_2 = table.remove(arg_19_0._sectionStack)

			arg_19_0:_setSectionData(var_19_2[1], var_19_2[2])
		end

		arg_19_0:_refreshDialogBtnState()
	end
end

function var_0_0._showDialog(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0._audioId and arg_20_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_20_0._audioId, 0)
	end

	gohelper.setActive(arg_20_0._gobottomcontent, true)
	gohelper.setActive(arg_20_0._gotopcontent, false)
	arg_20_0:_updateHistory()

	if arg_20_0._isSkip then
		return
	end

	local var_20_0 = arg_20_0:_addDialogItem(arg_20_1, arg_20_2, arg_20_3)
end

function var_0_0._showTalk(arg_21_0, arg_21_1, arg_21_2)
	gohelper.setActive(arg_21_0._gobottomcontent, false)
	gohelper.setActive(arg_21_0._gotopcontent, true)
	arg_21_0:_updateHistory()

	arg_21_0._isSkip = false
	arg_21_0._txtdialogdesc.text = arg_21_0:_getDialogDesc(arg_21_2.content)

	local var_21_0 = string.splitToNumber(arg_21_2.param, "#")
	local var_21_1 = string.format("singlebg/headicon_small/%s.png", var_21_0[1])

	arg_21_0._simagehead:LoadImage(var_21_1)

	if arg_21_0._audioId and arg_21_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_21_0._audioId, 0)
	end

	arg_21_0._audioId = var_21_0[2]

	if arg_21_0._audioId > 0 then
		AudioEffectMgr.instance:playAudio(arg_21_0._audioId)
	end
end

function var_0_0._showOptionByConfig(arg_22_0, arg_22_1)
	local var_22_0 = false

	if arg_22_1 and arg_22_1.type == Activity130Enum.dialogType.option then
		arg_22_0:_updateHistory()

		arg_22_0._dialogIndex = arg_22_0._dialogIndex + 1

		local var_22_1 = string.split(arg_22_1.content, "#")
		local var_22_2 = string.split(arg_22_1.param, "#")

		arg_22_0._isSingle = arg_22_1.single == 1

		if arg_22_0._isSkip then
			var_22_0 = true

			arg_22_0:_refreshDialogBtnState(var_22_0)
			arg_22_0:_skipOption(var_22_1, var_22_2)

			return
		else
			arg_22_0._skipOptionParams = {
				var_22_1,
				var_22_2
			}

			for iter_22_0, iter_22_1 in pairs(arg_22_0._optionBtnList) do
				gohelper.setActive(iter_22_1[1], false)
			end

			for iter_22_2 = #var_22_1, 1, -1 do
				arg_22_0:_addDialogOption(iter_22_2, var_22_2[iter_22_2], var_22_1[iter_22_2])
			end

			gohelper.setActive(arg_22_0._nexticon, false)
		end

		var_22_0 = true
	end

	arg_22_0:_refreshDialogBtnState(var_22_0)
end

function var_0_0._skipOption(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = 1
	local var_23_1 = Activity130Model.instance:getCurMapId()

	if var_23_1 >= 201 and var_23_1 <= 205 then
		var_23_0 = #arg_23_1
	end

	local var_23_2 = var_23_0
	local var_23_3 = arg_23_2[var_23_0]
	local var_23_4 = arg_23_1[var_23_0]

	arg_23_0:_onOptionClick({
		var_23_3,
		var_23_4,
		var_23_2
	})
end

function var_0_0._refreshDialogBtnState(arg_24_0, arg_24_1)
	if arg_24_1 then
		gohelper.setActive(arg_24_0._gooptions, true)
	else
		arg_24_0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(arg_24_0._txtinfo, not arg_24_1)
	gohelper.setActive(arg_24_0._btnnext, not arg_24_1)

	if arg_24_1 then
		return
	end

	local var_24_0 = not (#arg_24_0._sectionStack > 0 or #arg_24_0._sectionList >= arg_24_0._dialogIndex)

	if arg_24_0._isFinish then
		SLFramework.AnimatorPlayer.Get(arg_24_0.viewGO):Play(UIAnimationName.Close, arg_24_0._fadeOutDone, arg_24_0)

		arg_24_0._finishClose = true
	end

	arg_24_0._isFinish = var_24_0
end

function var_0_0._fadeOutDone(arg_25_0)
	if arg_25_0._elementInfo.config.skipFinish ~= 1 then
		arg_25_0:_sendFinishDialog()
	end

	if arg_25_0._elementInfo:getNextType() == Activity130Enum.ElementType.Battle then
		local var_25_0 = arg_25_0._elementInfo.elementId

		var_0_0.startBattle(var_25_0)
	end

	arg_25_0:closeThis()
end

function var_0_0._playCloseTalkItemEffect(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._optionBtnList) do
		iter_26_1[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(arg_26_0._hideOption, arg_26_0, 0.133)
end

function var_0_0._hideOption(arg_27_0)
	gohelper.setActive(arg_27_0._gooptions, false)
end

function var_0_0.startBattle(arg_28_0)
	return
end

function var_0_0._sendFinishDialog(arg_29_0)
	local var_29_0 = tonumber(arg_29_0._option_param) or 0
	local var_29_1 = Activity130Config.instance:getOptionParamList(arg_29_0._dialogId)

	if var_29_1 and #var_29_1 > 0 then
		local var_29_2 = 1
		local var_29_3 = Activity130Model.instance:getCurMapId()

		if var_29_3 >= 201 and var_29_3 <= 205 then
			var_29_2 = 2
		end

		if var_29_0 ~= var_29_2 then
			var_29_0 = var_29_2
		end
	end

	local var_29_4 = VersionActivity1_4Enum.ActivityId.Role37
	local var_29_5 = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130DialogRequest(var_29_4, var_29_5, arg_29_0._elementInfo.elementId, var_29_0)
end

function var_0_0._addDialogOption(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_0._optionBtnList[arg_30_1] and arg_30_0._optionBtnList[arg_30_1][1] or gohelper.cloneInPlace(arg_30_0._gotalkitem)

	gohelper.setActive(var_30_0, true)

	gohelper.findChildText(var_30_0, "txt_talkitem").text = arg_30_3

	local var_30_1 = gohelper.findChildButtonWithAudio(var_30_0, "btn_talkitem", AudioEnum.WeekWalk.play_artificial_ui_talkchoose)

	var_30_1:AddClickListener(arg_30_0._onOptionClick, arg_30_0, {
		arg_30_2,
		arg_30_3,
		arg_30_1
	})

	if not arg_30_0._optionBtnList[arg_30_1] then
		arg_30_0._optionBtnList[arg_30_1] = {
			var_30_0,
			var_30_1
		}
	end

	if not arg_30_0._isSingle then
		return
	end

	local var_30_2 = Activity130Model.instance:getCurMapConfig()

	if arg_30_1 == 1 then
		local var_30_3 = gohelper.findChild(var_30_0, "mask")
		local var_30_4 = var_30_2.type ~= 1

		gohelper.setActive(var_30_3, var_30_4)

		local var_30_5 = gohelper.findChild(var_30_0, "chaticon")

		gohelper.setActive(var_30_5, not var_30_4)
		gohelper.setActive(var_30_1.gameObject, not var_30_4)
	end

	if arg_30_1 == 2 then
		gohelper.setActive(var_30_0, var_30_2.type ~= 1)
	end
end

function var_0_0._onOptionClick(arg_31_0, arg_31_1)
	arg_31_0._skipOptionParams = nil

	if not arg_31_0:_checkClickCd() then
		return
	end

	local var_31_0 = arg_31_1[1]
	local var_31_1 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", arg_31_1[2])

	arg_31_0:_showDialog("option", var_31_1)

	arg_31_0._showOption = true
	arg_31_0._optionId = arg_31_1[3]

	arg_31_0:_checkOption(var_31_0)
end

function var_0_0._checkOption(arg_32_0, arg_32_1)
	local var_32_0 = Activity130Config.instance:getDialog(arg_32_0._dialogId, arg_32_1)

	if not var_32_0 then
		arg_32_0:_playNextSectionOrDialog()

		return
	end

	if #arg_32_0._sectionList >= arg_32_0._dialogIndex then
		table.insert(arg_32_0._sectionStack, {
			arg_32_0._sectionId,
			arg_32_0._dialogIndex
		})
	end

	if var_32_0.type == "random" then
		for iter_32_0, iter_32_1 in ipairs(var_32_0) do
			local var_32_1 = string.split(iter_32_1.option_param, "#")
			local var_32_2 = tonumber(var_32_1[1])
			local var_32_3 = var_32_1[2]
			local var_32_4 = var_32_1[3]
			local var_32_5 = math.random(100)
			local var_32_6

			if var_32_5 <= var_32_2 then
				var_32_6 = var_32_3
			else
				var_32_6 = var_32_4
			end

			arg_32_0:_playSection(var_32_6)

			break
		end
	else
		arg_32_0:_playSection(arg_32_1)
	end
end

function var_0_0._updateHistory(arg_33_0)
	if arg_33_0._isSkip then
		return
	end

	if arg_33_0._elementInfo.config.skipFinish == 1 then
		return
	end

	arg_33_0._historyList[arg_33_0._sectionId] = arg_33_0._dialogIndex

	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(arg_33_0._historyList) do
		table.insert(var_33_0, string.format("%s#%s", iter_33_0, iter_33_1))
	end

	arg_33_0._elementInfo:updateHistoryList(var_33_0)

	local var_33_1 = VersionActivity1_4Enum.ActivityId.Role37
	local var_33_2 = Activity130Model.instance:getCurEpisodeId()

	Activity130Rpc.instance:sendAct130DialogHistoryRequest(var_33_1, var_33_2, arg_33_0._elementInfo.elementId, var_33_0)
end

function var_0_0._addDialogItem(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = not string.nilorempty(arg_34_3) and "<#FAFAFA>" .. arg_34_3 .. ":  " or ""

	arg_34_0._txtinfo.text = var_34_0 .. arg_34_2

	arg_34_0._animatorPlayer:Play(UIAnimationName.Click, arg_34_0._animDone, arg_34_0)
	gohelper.setActive(arg_34_0._nexticon, true)
end

function var_0_0._animDone(arg_35_0)
	return
end

function var_0_0.onClose(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(arg_36_0._optionBtnList) do
		iter_36_1[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_36_0._hideOption, arg_36_0)
	FrameTimerController.instance:unregister(arg_36_0._fTimer)
end

function var_0_0.onDestroyView(arg_37_0)
	arg_37_0._simagebg:UnLoadImage()
end

function var_0_0._getDialogDesc(arg_38_0, arg_38_1)
	local var_38_0 = StoryTool.getMarkTopTextList(arg_38_1)

	arg_38_0._fTimer = FrameTimerController.instance:register(function()
		if arg_38_0._txtmarktop and not gohelper.isNil(arg_38_0._txtmarktop.gameObject) then
			arg_38_0._conMark:SetMarksTop(var_38_0)
		end
	end, nil, 1)

	arg_38_0._fTimer:Start()

	return StoryTool.filterMarkTop(arg_38_1)
end

return var_0_0
