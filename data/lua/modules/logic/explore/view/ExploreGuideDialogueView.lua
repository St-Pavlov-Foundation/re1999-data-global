module("modules.logic.explore.view.ExploreGuideDialogueView", package.seeall)

local var_0_0 = class("ExploreGuideDialogueView", BaseView)

function var_0_0.onClose(arg_1_0)
	GameUtil.onDestroyViewMember(arg_1_0, "_hasIconDialogItem")
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_fullscreen")
	arg_2_0._gochoicelist = gohelper.findChild(arg_2_0.viewGO, "#go_choicelist")
	arg_2_0._gochoiceitem = gohelper.findChild(arg_2_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_2_0._txttalkinfo = gohelper.findChildText(arg_2_0.viewGO, "go_normalcontent/txt_contentcn")
	arg_2_0._txttalker = gohelper.findChildText(arg_2_0.viewGO, "#txt_talker")

	gohelper.setActive(arg_2_0._gochoicelist, false)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnfullscreen:AddClickListener(arg_3_0.onClickFull, arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.OnClickSpace, arg_3_0.onClickFull, arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, arg_3_0.closeThis, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.OnClickSpace, arg_4_0.onClickFull, arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, arg_4_0.closeThis, arg_4_0)
	arg_4_0._btnfullscreen:RemoveClickListener()
end

function var_0_0.onClickFull(arg_5_0)
	if arg_5_0._hasIconDialogItem:isPlaying() then
		arg_5_0._hasIconDialogItem:conFinished()

		return
	end

	local var_5_0 = arg_5_0.viewParam.closeCallBack
	local var_5_1 = arg_5_0.viewParam.guideKey

	if not arg_5_0.viewParam.noClose then
		arg_5_0:closeThis()
	end

	var_5_0(var_5_1)
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
	arg_6_0:_refreshView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_refreshView()
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = string.gsub(arg_8_0.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:isEn() then
		var_8_0 = arg_8_0.viewParam.tipsContent
	end

	if not arg_8_0._hasIconDialogItem then
		arg_8_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_8_0.viewGO, TMPFadeIn)

		arg_8_0._hasIconDialogItem:setTopOffset(0, -4.5)
		arg_8_0._hasIconDialogItem:setLineSpacing(20)
	end

	arg_8_0._hasIconDialogItem:playNormalText(var_8_0)

	arg_8_0._txttalker.text = arg_8_0.viewParam.tipsTalker
end

return var_0_0
