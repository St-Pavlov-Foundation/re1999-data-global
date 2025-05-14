module("modules.logic.versionactivity1_6.act152.view.NewYearEveGiftView", package.seeall)

local var_0_0 = class("NewYearEveGiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._simageItem = gohelper.findChildSingleImage(arg_1_0.viewGO, "Item/#simage_Item")
	arg_1_0._simagesign = gohelper.findChildSingleImage(arg_1_0.viewGO, "Item/#simage_sign")
	arg_1_0._gocontentroot = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot")
	arg_1_0._goconversation = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation")
	arg_1_0._gohead = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head")
	arg_1_0._goheadgrey = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head/#go_headgrey")
	arg_1_0._simagehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_head/#simage_head")
	arg_1_0._goname = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_nameen")
	arg_1_0._gocontents = gohelper.findChild(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._clickbg = gohelper.getClickWithAudio(arg_4_0._simageFullBG.gameObject)

	arg_4_0._clickbg:AddClickListener(arg_4_0._onBgClick, arg_4_0)
end

function var_0_0._onBgClick(arg_5_0)
	arg_5_0:_checkNextStep()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:_checkNextStep()
end

function var_0_0._checkNextStep(arg_7_0)
	if arg_7_0._dialogIndex >= #arg_7_0._dialogs then
		arg_7_0:closeThis()

		return
	end

	arg_7_0._dialogIndex = arg_7_0._dialogIndex + 1

	arg_7_0:_refreshUI()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._presentId = arg_8_0.viewParam

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)

	arg_8_0._dialogIndex = 1

	local var_8_0 = Activity152Config.instance:getAct152Co(arg_8_0._presentId)

	arg_8_0._dialogs = string.split(var_8_0.dialog, "|")

	arg_8_0:_refreshUI()
end

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = Activity152Config.instance:getAct152Co(arg_9_0._presentId)

	arg_9_0._simageItem:LoadImage(ResUrl.getAntiqueIcon(var_9_0.presentIcon))
	arg_9_0._simagesign:LoadImage(ResUrl.getSignature(var_9_0.presentSign))
	arg_9_0._simagehead:LoadImage(ResUrl.getHeadIconSmall(var_9_0.roleIcon))

	arg_9_0._txtTitle.text = var_9_0.presentName
	arg_9_0._txtnamecn.text = var_9_0.roleName
	arg_9_0._txtnameen.text = "/ " .. var_9_0.roleNameEn
	arg_9_0._txtcontent.text = arg_9_0._dialogs[arg_9_0._dialogIndex]
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageItem:UnLoadImage()
	arg_11_0._simagesign:UnLoadImage()
	arg_11_0._simagehead:UnLoadImage()
	arg_11_0._clickbg:RemoveClickListener()
end

return var_0_0
