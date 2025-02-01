module("modules.logic.battlepass.view.BpInformationView", package.seeall)

slot0 = class("BpInformationView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofirst = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_first")
	slot0._txtfirst = gohelper.findChildText(slot0.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_content")
	slot0._goconversation = gohelper.findChild(slot0.viewGO, "content/scrollview/viewport/content/#go_conversation")
	slot0._txtindenthelper = gohelper.findChildText(slot0.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "content/#go_mask")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_pic")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "content/#txt_title1")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "content/#txt_title2")
	slot0._txttitleen1 = gohelper.findChildText(slot0.viewGO, "content/#txt_titleen1")
	slot0._txttitleen3 = gohelper.findChildText(slot0.viewGO, "content/#txt_titleen3")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/pageicon/#btn_next")
	slot0._btnprevious = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/pageicon/#btn_previous")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "content/scrollview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnprevious:AddClickListener(slot0._btnpreviousOnClick, slot0)
	slot0._scrollview:AddOnValueChanged(slot0._onContentScrollValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0._btnprevious:RemoveClickListener()
	slot0._scrollview:RemoveOnValueChanged()
end

function slot0._onContentScrollValueChanged(slot0, slot1)
	gohelper.setActive(slot0._gomask, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) > 0)
end

function slot0._btnnextOnClick(slot0)
end

function slot0._btnpreviousOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scrollcontent = gohelper.findChild(slot0._scrollview.gameObject, "viewport/content")

	ZProj.UGUIHelper.RebuildLayout(slot0._scrollcontent.transform)

	slot0._scrollHeight = recthelper.getHeight(slot0._scrollview.transform)
	slot0._couldScroll = slot0._scrollHeight < recthelper.getHeight(slot0._scrollcontent.transform) and true or false

	gohelper.setActive(slot0._gomask, slot0._couldScroll)
	slot0._simagepic:LoadImage(ResUrl.getBpBg("img_ziliao_juke"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagepic:UnLoadImage()
end

return slot0
