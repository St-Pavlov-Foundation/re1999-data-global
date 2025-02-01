module("modules.logic.tipdialog.view.TipDialogView", package.seeall)

slot0 = class("TipDialogView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_next")
	slot0._gotopcontent = gohelper.findChild(slot0.viewGO, "go_normalcontent")
	slot0._godialogbg = gohelper.findChild(slot0.viewGO, "go_normalcontent/#go_dialogbg")
	slot0._godialoghead = gohelper.findChild(slot0.viewGO, "go_normalcontent/#go_dialoghead")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "go_normalcontent/#go_dialoghead/#image_headicon")
	slot0._txtdialogdesc = gohelper.findChildText(slot0.viewGO, "go_normalcontent/txt_contentcn")
	slot0._gobottomcontent = gohelper.findChild(slot0.viewGO, "#go_bottomcontent")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_bottomcontent/#go_content/#simage_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "#go_bottomcontent/#go_content/#txt_info")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content/#go_options")
	slot0._gotalkitem = gohelper.findChild(slot0.viewGO, "#go_bottomcontent/#go_content/#go_options/#go_talkitem")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bottomcontent/#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._btnskipOnClick(slot0)
end

function slot0._btnnextOnClick(slot0)
	if not slot0._btnnext.gameObject.activeInHierarchy or slot0._finishClose then
		return
	end

	if not slot0:_checkClickCd() then
		return
	end

	slot0:_playNextSectionOrDialog()
end

function slot0._checkClickCd(slot0)
	if Time.time - slot0._time < 0.5 then
		return
	end

	slot0._time = Time.time

	return true
end

function slot0._editableInitView(slot0)
	slot0._ori_txtWidth = recthelper.getWidth(slot0._txtdialogdesc.gameObject.transform)
	slot0._ori_bgWidth = recthelper.getWidth(slot0._godialogbg.transform)
	slot0._time = Time.time
	slot0._optionBtnList = slot0:getUserDataTb_()
	slot0._dialogItemList = slot0:getUserDataTb_()
	slot0._dialogItemCacheList = slot0:getUserDataTb_()

	gohelper.addUIClickAudio(slot0._btnnext.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)

	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._nexticon = gohelper.findChild(slot0.viewGO, "#go_content/nexticon")
	slot0._tmpFadeIn = MonoHelper.addLuaComOnceToGo(slot0.viewGO, TMPFadeIn)
end

function slot0.onOpen(slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("bg_wz.png"))
	NavigateMgr.instance:addSpace(ViewName.TipDialogView, slot0._onSpace, slot0)

	if slot0.viewParam.auto == nil then
		-- Nothing
	end

	slot0._auto = slot0.viewParam.auto
	slot0._autoTime = slot0.viewParam.autoplayTime ~= nil and slot0.viewParam.autoplayTime or 0.5

	gohelper.setActive(slot0._btnnext, not slot0._auto)
	slot0:_playStory(slot0.viewParam.dialogId)

	if slot0._auto then
		TaskDispatcher.runDelay(slot0._playNextSectionOrDialog, slot0, slot0._autoTime)
	end

	if slot0.viewParam.widthPercentage then
		slot0:calTxtWightAndSetBgWight(slot1)
	end
end

function slot0._onSpace(slot0)
	if not slot0._btnnext.gameObject.activeInHierarchy then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	slot0:_btnnextOnClick()
end

function slot0._playNextSectionOrDialog(slot0)
	if slot0._auto then
		TaskDispatcher.runDelay(slot0._playNextSectionOrDialog, slot0, slot0._autoTime)
	end

	if slot0._dialogIndex <= #slot0._sectionList then
		slot0:_playNextDialog()

		return
	end

	if table.remove(slot0._sectionStack) then
		slot0:_playSection(slot1[1], slot1[2])
	else
		slot0:_refreshDialogBtnState()
	end
end

function slot0._playStory(slot0, slot1)
	slot0._sectionStack = {}
	slot0._optionId = 0
	slot0._mainSectionId = "0"
	slot0._sectionId = slot0._mainSectionId
	slot0._dialogIndex = nil
	slot0._dialogId = slot1

	slot0:_playSection(slot0._sectionId, slot0._dialogIndex)
end

function slot0._playSection(slot0, slot1, slot2)
	slot0:_setSectionData(slot1, slot2)
	slot0:_playNextDialog()
end

function slot0._setSectionData(slot0, slot1, slot2)
	slot0._sectionList = TipDialogConfig.instance:getDialog(slot0._dialogId, slot1)

	if slot0._sectionList and not string.nilorempty(slot0._sectionList.option_param) then
		slot0._option_param = slot0._sectionList.option_param
	end

	slot0._dialogIndex = slot2 or 1
	slot0._sectionId = slot1
end

function slot0._playNextDialog(slot0)
	if not slot0._sectionList[slot0._dialogIndex] then
		return
	end

	if slot1.type == TipDialogEnum.dialogType.dialog then
		slot0:_showDialog(TipDialogEnum.dialogType.dialog, slot1, slot1.speaker)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
	elseif slot1.type == TipDialogEnum.dialogType.talk then
		slot0:_showTalk(TipDialogEnum.dialogType.talk, slot1)

		slot0._dialogIndex = slot0._dialogIndex + 1

		if #slot0._sectionStack > 0 and #slot0._sectionList < slot0._dialogIndex then
			slot2 = table.remove(slot0._sectionStack)

			slot0:_setSectionData(slot2[1], slot2[2])
		end

		slot0:_refreshDialogBtnState()
	end
end

function slot0._showDialog(slot0, slot1, slot2, slot3)
	slot0:_playAudio(slot2)
	gohelper.setActive(slot0._gobottomcontent, true)
	gohelper.setActive(slot0._gotopcontent, false)

	slot5 = slot0:_addDialogItem(slot1, slot2.content, slot3)
end

function slot0._showTalk(slot0, slot1, slot2)
	gohelper.setActive(slot0._gobottomcontent, false)
	gohelper.setActive(slot0._gotopcontent, true)
	slot0._tmpFadeIn:playNormalText(slot2.content)

	slot3 = string.splitToNumber(slot2.pos, "#")

	recthelper.setAnchor(slot0._gotopcontent.transform, slot3[1], slot3[2])
	slot0._simagehead:LoadImage(string.format("singlebg/headicon_small/%s.png", slot2.icon))
	slot0:_playAudio(slot2)
end

function slot0._playAudio(slot0, slot1)
	if slot0._audioId and slot0._audioId > 0 then
		AudioEffectMgr.instance:stopAudio(slot0._audioId, 0)
	end

	slot0._audioId = slot1.audio

	if slot0._audioId > 0 then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0._skipOption(slot0, slot1, slot2)
	slot3 = 1

	slot0:_onOptionClick({
		slot2[slot3],
		slot1[slot3],
		slot3
	})
end

function slot0._refreshDialogBtnState(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._gooptions, true)
	else
		slot0:_playCloseTalkItemEffect()
	end

	gohelper.setActive(slot0._txtinfo, not slot1)

	if not slot0._auto then
		gohelper.setActive(slot0._btnnext, not slot1)
	end

	if slot1 then
		return
	end

	slot3 = not (#slot0._sectionStack > 0 or slot0._dialogIndex <= #slot0._sectionList)

	if slot0._isFinish then
		SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0._fadeOutDone, slot0)

		slot0._finishClose = true

		if slot0._auto then
			TaskDispatcher.cancelTask(slot0._playNextSectionOrDialog, slot0)
		end
	end

	slot0._isFinish = slot3
end

function slot0._fadeOutDone(slot0)
	slot0:closeThis()
end

function slot0._playCloseTalkItemEffect(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[1]:GetComponent(typeof(UnityEngine.Animator)):Play("weekwalk_options_out")
	end

	TaskDispatcher.runDelay(slot0._hideOption, slot0, 0.133)
end

function slot0._hideOption(slot0)
	gohelper.setActive(slot0._gooptions, false)
end

function slot0._onOptionClick(slot0, slot1)
	slot0._skipOptionParams = nil

	if not slot0:_checkClickCd() then
		return
	end

	slot0:_showDialog("option", string.format("<indent=4.7em><color=#C66030>\"%s\"</color>", slot1[2]))

	slot0._showOption = true
	slot0._optionId = slot1[3]

	slot0:_checkOption(slot1[1])
end

function slot0._checkOption(slot0, slot1)
	if not TipDialogConfig.instance:getDialog(slot0._dialogId, slot1) then
		slot0:_playNextSectionOrDialog()

		return
	end

	if slot0._dialogIndex <= #slot0._sectionList then
		table.insert(slot0._sectionStack, {
			slot0._sectionId,
			slot0._dialogIndex
		})
	end

	slot0:_playSection(slot1)
end

function slot0._addDialogItem(slot0, slot1, slot2, slot3)
	slot0._txtinfo.text = slot2

	slot0._animatorPlayer:Play(UIAnimationName.Click, slot0._animDone, slot0)
	gohelper.setActive(slot0._nexticon, true)
end

function slot0._animDone(slot0)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0._hideOption, slot0)
	TaskDispatcher.cancelTask(slot0._playNextSectionOrDialog, slot0)

	if slot0.viewParam.callback then
		slot1(slot0.viewParam.callbackTarget)
	end
end

function slot0.calTxtWightAndSetBgWight(slot0, slot1)
	slot2 = slot0._txtdialogdesc.gameObject.transform
	slot3 = slot0._godialogbg.transform
	slot4 = recthelper.getWidth(slot2)
	slot5 = recthelper.getWidth(slot3)
	slot6 = slot5 - slot4

	recthelper.setWidth(slot2, slot4 * slot1)
	recthelper.setWidth(slot3, (slot5 + slot4 * slot1 - slot0._ori_txtWidth) * 1)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
