module("modules.logic.battlepass.view.BpInformationView", package.seeall)

local var_0_0 = class("BpInformationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofirst = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_first")
	arg_1_0._txtfirst = gohelper.findChildText(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_content")
	arg_1_0._goconversation = gohelper.findChild(arg_1_0.viewGO, "content/scrollview/viewport/content/#go_conversation")
	arg_1_0._txtindenthelper = gohelper.findChildText(arg_1_0.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "content/#go_mask")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_pic")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_title1")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_title2")
	arg_1_0._txttitleen1 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_titleen1")
	arg_1_0._txttitleen3 = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_titleen3")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/pageicon/#btn_next")
	arg_1_0._btnprevious = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/pageicon/#btn_previous")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/scrollview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnprevious:AddClickListener(arg_2_0._btnpreviousOnClick, arg_2_0)
	arg_2_0._scrollview:AddOnValueChanged(arg_2_0._onContentScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnprevious:RemoveClickListener()
	arg_3_0._scrollview:RemoveOnValueChanged()
end

function var_0_0._onContentScrollValueChanged(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gomask, arg_4_0._couldScroll and not (gohelper.getRemindFourNumberFloat(arg_4_0._scrollview.verticalNormalizedPosition) <= 0))
end

function var_0_0._btnnextOnClick(arg_5_0)
	return
end

function var_0_0._btnpreviousOnClick(arg_6_0)
	return
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._scrollcontent = gohelper.findChild(arg_7_0._scrollview.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(arg_7_0._scrollcontent.transform)

	local var_7_0 = recthelper.getHeight(arg_7_0._scrollcontent.transform)

	arg_7_0._scrollHeight = recthelper.getHeight(arg_7_0._scrollview.transform)
	arg_7_0._couldScroll = var_7_0 > arg_7_0._scrollHeight and true or false

	gohelper.setActive(arg_7_0._gomask, arg_7_0._couldScroll)
	arg_7_0._simagepic:LoadImage(ResUrl.getBpBg("img_ziliao_juke"))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagepic:UnLoadImage()
end

return var_0_0
