module("modules.logic.versionactivity1_6.act152.view.NewYearEveGiftView", package.seeall)

slot0 = class("NewYearEveGiftView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._simageItem = gohelper.findChildSingleImage(slot0.viewGO, "Item/#simage_Item")
	slot0._simagesign = gohelper.findChildSingleImage(slot0.viewGO, "Item/#simage_sign")
	slot0._gocontentroot = gohelper.findChild(slot0.viewGO, "#go_contentroot")
	slot0._goconversation = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation")
	slot0._gohead = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_head")
	slot0._goheadgrey = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_head/#go_headgrey")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "#go_contentroot/#go_conversation/#go_head/#simage_head")
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_name")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_namecn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_name/namelayout/#txt_nameen")
	slot0._gocontents = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/go_normalcontent/Viewport/#txt_content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._clickbg = gohelper.getClickWithAudio(slot0._simageFullBG.gameObject)

	slot0._clickbg:AddClickListener(slot0._onBgClick, slot0)
end

function slot0._onBgClick(slot0)
	slot0:_checkNextStep()
end

function slot0.onClickModalMask(slot0)
	slot0:_checkNextStep()
end

function slot0._checkNextStep(slot0)
	if slot0._dialogIndex >= #slot0._dialogs then
		slot0:closeThis()

		return
	end

	slot0._dialogIndex = slot0._dialogIndex + 1

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._presentId = slot0.viewParam

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_popup)

	slot0._dialogIndex = 1
	slot0._dialogs = string.split(Activity152Config.instance:getAct152Co(slot0._presentId).dialog, "|")

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = Activity152Config.instance:getAct152Co(slot0._presentId)

	slot0._simageItem:LoadImage(ResUrl.getAntiqueIcon(slot1.presentIcon))
	slot0._simagesign:LoadImage(ResUrl.getSignature(slot1.presentSign))
	slot0._simagehead:LoadImage(ResUrl.getHeadIconSmall(slot1.roleIcon))

	slot0._txtTitle.text = slot1.presentName
	slot0._txtnamecn.text = slot1.roleName
	slot0._txtnameen.text = "/ " .. slot1.roleNameEn
	slot0._txtcontent.text = slot0._dialogs[slot0._dialogIndex]
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageItem:UnLoadImage()
	slot0._simagesign:UnLoadImage()
	slot0._simagehead:UnLoadImage()
	slot0._clickbg:RemoveClickListener()
end

return slot0
