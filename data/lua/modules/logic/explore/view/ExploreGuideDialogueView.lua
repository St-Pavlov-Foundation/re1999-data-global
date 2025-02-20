module("modules.logic.explore.view.ExploreGuideDialogueView", package.seeall)

slot0 = class("ExploreGuideDialogueView", BaseView)

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_hasIconDialogItem")
end

function slot0.onInitView(slot0)
	slot0._btnfullscreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullscreen")
	slot0._gochoicelist = gohelper.findChild(slot0.viewGO, "#go_choicelist")
	slot0._gochoiceitem = gohelper.findChild(slot0.viewGO, "#go_choicelist/#go_choiceitem")
	slot0._txttalkinfo = gohelper.findChildText(slot0.viewGO, "go_normalcontent/txt_contentcn")
	slot0._txttalker = gohelper.findChildText(slot0.viewGO, "#txt_talker")

	gohelper.setActive(slot0._gochoicelist, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfullscreen:AddClickListener(slot0.onClickFull, slot0)
	GuideController.instance:registerCallback(GuideEvent.OnClickSpace, slot0.onClickFull, slot0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.OnClickSpace, slot0.onClickFull, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, slot0.closeThis, slot0)
	slot0._btnfullscreen:RemoveClickListener()
end

function slot0.onClickFull(slot0)
	if slot0._hasIconDialogItem:isPlaying() then
		slot0._hasIconDialogItem:conFinished()

		return
	end

	slot1 = slot0.viewParam.closeCallBack
	slot2 = slot0.viewParam.guideKey

	if not slot0.viewParam.noClose then
		slot0:closeThis()
	end

	slot1(slot2)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
	slot0:_refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot1 = string.gsub(slot0.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:isEn() then
		slot1 = slot0.viewParam.tipsContent
	end

	if not slot0._hasIconDialogItem then
		slot0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(slot0.viewGO, TMPFadeIn)

		slot0._hasIconDialogItem:setTopOffset(0, -4.5)
		slot0._hasIconDialogItem:setLineSpacing(20)
	end

	slot0._hasIconDialogItem:playNormalText(slot1)

	slot0._txttalker.text = slot0.viewParam.tipsTalker
end

return slot0
