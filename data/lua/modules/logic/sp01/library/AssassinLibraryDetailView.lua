module("modules.logic.sp01.library.AssassinLibraryDetailView", package.seeall)

local var_0_0 = class("AssassinLibraryDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_Pic")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_title")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#scroll_content")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_content/Viewport/#go_content")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "root/#scroll_content/Viewport/#go_content/#txt_content")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "root/#scroll_content/#go_arrow")
	arg_1_0._btndialogue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Dialogue")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndialogue:AddClickListener(arg_2_0._btndialogueOnClick, arg_2_0)
	arg_2_0._scrollcontent:AddOnValueChanged(arg_2_0._onContentScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndialogue:RemoveClickListener()
	arg_3_0._scrollcontent:RemoveOnValueChanged()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btndialogueOnClick(arg_5_0)
	if arg_5_0._dialogId and arg_5_0._dialogId ~= 0 then
		DialogueController.instance:enterDialogue(arg_5_0._dialogId)
		OdysseyStatHelper.instance:sendLibraryDialogueClick("_btndialogueOnClick#" .. arg_5_0._libraryId)
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_openmap)
	arg_7_0:refresh()
	OdysseyStatHelper.instance:initViewStartTime()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refresh()
end

function var_0_0.refresh(arg_9_0)
	arg_9_0._libraryId = arg_9_0.viewParam and arg_9_0.viewParam.libraryId
	arg_9_0._libraryCo = AssassinConfig.instance:getLibrarConfig(arg_9_0._libraryId)
	arg_9_0._txttitle.text = arg_9_0._libraryCo and arg_9_0._libraryCo.title or ""
	arg_9_0._txtcontent.text = arg_9_0._libraryCo and arg_9_0._libraryCo.content or ""

	arg_9_0._simagepic:LoadImage(ResUrl.getSp01AssassinSingleBg("library/assassinlibrary_detail_pic/" .. arg_9_0._libraryCo.detail))
	ZProj.UGUIHelper.RebuildLayout(arg_9_0._gocontent.transform)

	arg_9_0._couldScroll = recthelper.getHeight(arg_9_0._gocontent.transform) > recthelper.getHeight(arg_9_0._scrollcontent.transform)

	gohelper.setActive(arg_9_0._goarrow, arg_9_0._couldScroll)

	arg_9_0._dialogId = arg_9_0._libraryCo and arg_9_0._libraryCo.talk

	gohelper.setActive(arg_9_0._btndialogue.gameObject, arg_9_0._dialogId and arg_9_0._dialogId ~= 0)
end

function var_0_0._onContentScrollValueChanged(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goarrow, arg_10_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_10_0._scrollcontent.verticalNormalizedPosition) <= 0))
end

function var_0_0.onClose(arg_11_0)
	arg_11_0._simagepic:UnLoadImage()
	AssassinLibraryModel.instance:readLibrary(arg_11_0._libraryId)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("AssassinLibraryDetailView", arg_11_0._libraryId)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
