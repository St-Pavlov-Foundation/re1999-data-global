module("modules.logic.tipdialog.view.TipDialogView", package.seeall)

local var_0_0 = class("TipDialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_next")
	arg_1_0._gotopcontent = gohelper.findChild(arg_1_0.viewGO, "go_normalcontent")
	arg_1_0._godialogbg = gohelper.findChild(arg_1_0.viewGO, "go_normalcontent/#go_dialogbg")
	arg_1_0._godialoghead = gohelper.findChild(arg_1_0.viewGO, "go_normalcontent/#go_dialoghead")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_normalcontent/#go_dialoghead/#image_headicon")
	arg_1_0._txtdialogdesc = gohelper.findChildText(arg_1_0.viewGO, "go_normalcontent/txt_contentcn")
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
	return
end

function var_0_0._btnnextOnClick(arg_5_0)
	if not arg_5_0._btnnext.gameObject.activeInHierarchy or arg_5_0._finishClose then
		return
	end

	if not arg_5_0:_checkClickCd() then
		return
	end

	arg_5_0:_playNextSectionOrDialog()
end

function var_0_0._checkClickCd(arg_6_0)
	if Time.time - arg_6_0._time < 0.5 then
		return
	end

	arg_6_0._time = Time.time

	return true
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0._txtdialogdesc.gameObject.transform
	local var_7_1 = arg_7_0._godialogbg.transform

	arg_7_0._ori_txtWidth = recthelper.getWidth(var_7_0)
	arg_7_0._ori_bgWidth = recthelper.getWidth(var_7_1)
	arg_7_0._time = Time.time
	arg_7_0._optionBtnList = arg_7_0:getUserDataTb_()
	arg_7_0._dialogItemList = arg_7_0:getUserDataTb_()
	arg_7_0._dialogItemCacheList = arg_7_0:getUserDataTb_()

	gohelper.addUIClickAudio(arg_7_0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	arg_7_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_7_0.viewGO)
	arg_7_0._nexticon = gohelper.findChild(arg_7_0.viewGO, "#go_content/nexticon")
	arg_7_0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(arg_7_0.viewGO, TMPFadeIn)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.TipDialogView, arg_8_0._onSpace, arg_8_0)

	if arg_8_0.viewParam.auto == nil then
		-- block empty
	end

	arg_8_0._auto = arg_8_0.viewParam.auto
	arg_8_0._autoTime = arg_8_0.viewParam.autoplayTime ~= nil and arg_8_0.viewParam.autoplayTime or 0.5

	gohelper.setActive(arg_8_0._btnnext, not arg_8_0._auto)
	arg_8_0:_playStory(arg_8_0.viewParam.dialogId)

	if arg_8_0._auto then
		TaskDispatcher.runDelay(arg_8_0._playNextSectionOrDialog, arg_8_0, arg_8_0._autoTime)
	end

	local var_8_0 = arg_8_0.viewParam.widthPercentage

	if var_8_0 then
		arg_8_0:calTxtWightAndSetBgWight(var_8_0)
	end
end

function var_0_0._onSpace(arg_9_0)
	if not arg_9_0._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	arg_9_0:_btnnextOnClick()
end

function var_0_0._playNextSectionOrDialog(arg_10_0)
	if arg_10_0._auto then
		TaskDispatcher.runDelay(arg_10_0._playNextSectionOrDialog, arg_10_0, arg_10_0._autoTime)
	end

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

function var_0_0._playStory(arg_11_0, arg_11_1)
	arg_11_0._sectionStack = {}
	arg_11_0._optionId = 0
	arg_11_0._mainSectionId = "0"
	arg_11_0._sectionId = arg_11_0._mainSectionId
	arg_11_0._dialogIndex = nil
	arg_11_0._dialogId = arg_11_1

	arg_11_0:_playSection(arg_11_0._sectionId, arg_11_0._dialogIndex)
end

function var_0_0._playSection(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_setSectionData(arg_12_1, arg_12_2)
	arg_12_0:_playNextDialog()
end

function var_0_0._setSectionData(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._sectionList = TipDialogConfig.instance:getDialog(arg_13_0._dialogId, arg_13_1)

	if arg_13_0._sectionList and not string.nilorempty(arg_13_0._sectionList.option_param) then
		arg_13_0._option_param = arg_13_0._sectionList.option_param
	end

	arg_13_0._dialogIndex = arg_13_2 or 1
	arg_13_0._sectionId = arg_13_1
end

function var_0_0._playNextDialog(arg_14_0)
	local var_14_0 = arg_14_0._sectionList[arg_14_0._dialogIndex]

	if not var_14_0 then
		return
	end

	if var_14_0.type == TipDialogEnum.dialogType.dialog then
		arg_14_0:_showDialog(TipDialogEnum.dialogType.dialog, var_14_0, var_14_0.speaker)

		arg_14_0._dialogIndex = arg_14_0._dialogIndex + 1

		if #arg_14_0._sectionStack > 0 and #arg_14_0._sectionList < arg_14_0._dialogIndex then
			local var_14_1 = table.remove(arg_14_0._sectionStack)

			arg_14_0:_setSectionData(var_14_1[1], var_14_1[2])
		end

		arg_14_0:_refreshDialogBtnState()
	elseif var_14_0.type == TipDialogEnum.dialogType.talk then
		arg_14_0:_showTalk(TipDialogEnum.dialogType.talk, var_14_0)

		arg_14_0._dialogIndex = arg_14_0._dialogIndex + 1

		if #arg_14_0._sectionStack > 0 and #arg_14_0._sectionList < arg_14_0._dialogIndex then
			local var_14_2 = table.remove(arg_14_0._sectionStack)

			arg_14_0:_setSectionData(var_14_2[1], var_14_2[2])
		end

		arg_14_0:_refreshDialogBtnState()
	end
end

function var_0_0._showDialog(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:_playAudio(arg_15_2)
	gohelper.setActive(arg_15_0._gobottomcontent, true)
	gohelper.setActive(arg_15_0._gotopcontent, false)

	local var_15_0 = arg_15_2.content
	local var_15_1 = arg_15_0:_addDialogItem(arg_15_1, var_15_0, arg_15_3)
end

function var_0_0._showTalk(arg_16_0, arg_16_1, arg_16_2)
	gohelper.setActive(arg_16_0._gobottomcontent, false)
	gohelper.setActive(arg_16_0._gotopcontent, true)
	arg_16_0._tmpFadeIn:playNormalText(arg_16_2.content)

	local var_16_0 = string.splitToNumber(arg_16_2.pos, "#")

	recthelper.setAnchor(arg_16_0._gotopcontent.transform, var_16_0[1], var_16_0[2])

	local var_16_1 = string.format("singlebg/headicon_small/%s.png", arg_16_2.icon)

	arg_16_0._simagehead:LoadImage(var_16_1)
	arg_16_0:_playAudio(arg_16_2)
end

function var_0_0._playAudio(arg_17_0, arg_17_1)
	if arg_17_0._audioId and arg_17_0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(arg_17_0._audioId, 0)
	end

	arg_17_0._audioId = arg_17_1.audio

	if arg_17_0._audioId > 0 then
		AudioEffectMgr.instance:playAudio(arg_17_0._audioId)
	end
end

function var_0_0._skipOption(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 1
	local var_18_1 = var_18_0
	local var_18_2 = arg_18_2[var_18_0]
	local var_18_3 = arg_18_1[var_18_0]

	arg_18_0:_onOptionClick({
		var_18_2,
		var_18_3,
		var_18_1
	})
end

function var_0_0._refreshDialogBtnState(arg_19_0, arg_19_1)
	if arg_19_1 then
		gohelper.setActive(arg_19_0._gooptions, true)
	else
		arg_19_0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(arg_19_0._txtinfo, not arg_19_1)

	if not arg_19_0._auto then
		gohelper.setActive(arg_19_0._btnnext, not arg_19_1)
	end

	if arg_19_1 then
		return
	end

	local var_19_0 = not (#arg_19_0._sectionStack > 0 or #arg_19_0._sectionList >= arg_19_0._dialogIndex)

	if arg_19_0._isFinish then
		SLFramework.AnimatorPlayer.Get(arg_19_0.viewGO):Play(UIAnimationName.Close, arg_19_0._fadeOutDone, arg_19_0)

		arg_19_0._finishClose = true

		if arg_19_0._auto then
			TaskDispatcher.cancelTask(arg_19_0._playNextSectionOrDialog, arg_19_0)
		end
	end

	arg_19_0._isFinish = var_19_0
end

function var_0_0._fadeOutDone(arg_20_0)
	arg_20_0:closeThis()
end

function var_0_0._playCloseTalkItemEffect(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._optionBtnList) do
		iter_21_1[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(arg_21_0._hideOption, arg_21_0, 0.133)
end

function var_0_0._hideOption(arg_22_0)
	gohelper.setActive(arg_22_0._gooptions, false)
end

function var_0_0._onOptionClick(arg_23_0, arg_23_1)
	arg_23_0._skipOptionParams = nil

	if not arg_23_0:_checkClickCd() then
		return
	end

	local var_23_0 = arg_23_1[1]
	local var_23_1 = string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", arg_23_1[2])

	arg_23_0:_showDialog("option", var_23_1)

	arg_23_0._showOption = true
	arg_23_0._optionId = arg_23_1[3]

	arg_23_0:_checkOption(var_23_0)
end

function var_0_0._checkOption(arg_24_0, arg_24_1)
	if not TipDialogConfig.instance:getDialog(arg_24_0._dialogId, arg_24_1) then
		arg_24_0:_playNextSectionOrDialog()

		return
	end

	if #arg_24_0._sectionList >= arg_24_0._dialogIndex then
		table.insert(arg_24_0._sectionStack, {
			arg_24_0._sectionId,
			arg_24_0._dialogIndex
		})
	end

	arg_24_0:_playSection(arg_24_1)
end

function var_0_0._addDialogItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._txtinfo.text = arg_25_2

	arg_25_0._animatorPlayer:Play(UIAnimationName.Click, arg_25_0._animDone, arg_25_0)
	gohelper.setActive(arg_25_0._nexticon, true)
end

function var_0_0._animDone(arg_26_0)
	return
end

function var_0_0.onClose(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._optionBtnList) do
		iter_27_1[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_27_0._hideOption, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._playNextSectionOrDialog, arg_27_0)

	local var_27_0 = arg_27_0.viewParam.callback
	local var_27_1 = arg_27_0.viewParam.callbackTarget

	if var_27_0 then
		var_27_0(var_27_1)
	end
end

function var_0_0.calTxtWightAndSetBgWight(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._txtdialogdesc.gameObject.transform
	local var_28_1 = arg_28_0._godialogbg.transform
	local var_28_2 = recthelper.getWidth(var_28_0)
	local var_28_3 = recthelper.getWidth(var_28_1)
	local var_28_4 = var_28_3 - var_28_2

	recthelper.setWidth(var_28_0, var_28_2 * arg_28_1)

	local var_28_5 = var_28_2 * arg_28_1 - arg_28_0._ori_txtWidth

	arg_28_1 = 1

	local var_28_6 = (var_28_3 + var_28_5) * arg_28_1

	recthelper.setWidth(var_28_1, var_28_6)
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._simagebg:UnLoadImage()
end

return var_0_0
