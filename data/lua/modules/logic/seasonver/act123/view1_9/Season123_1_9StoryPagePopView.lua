module("modules.logic.seasonver.act123.view1_9.Season123_1_9StoryPagePopView", package.seeall)

slot0 = class("Season123_1_9StoryPagePopView", BaseView)

function slot0.onInitView(slot0)
	slot0._godetailPage = gohelper.findChild(slot0.viewGO, "Root/#go_detailPage")
	slot0._txtdetailTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Left/Title/#txt_detailTitle")
	slot0._simagePolaroid = gohelper.findChildSingleImage(slot0.viewGO, "Root/#go_detailPage/Left/#simage_Polaroid")
	slot0._txtdetailPageTitle = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#txt_detailPageTitle")
	slot0._txtAuthor = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#txt_Author")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "Root/#go_detailPage/Right/#scroll_desc")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "Root/#go_detailPage/Right/#scroll_desc/Viewport/#txt_desc")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "Root/#go_detailPage/Right/#go_arrow")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.transScrollDesc = slot0._scrolldesc.gameObject:GetComponent(gohelper.Type_RectTransform)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_role_culture_open)

	slot0.actId = slot0.viewParam.actId
	slot0.stageId = slot0.viewParam.stageId

	slot0:refreshDetailPageUI()
	slot0:fitScrollHeight()
end

function slot0.refreshDetailPageUI(slot0)
	slot1 = Season123Config.instance:getStoryConfig(slot0.actId, slot0.stageId)
	slot0._txtdetailTitle.text = GameUtil.setFirstStrSize(slot1.title, 80)

	slot0._simagePolaroid:LoadImage(Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/storycover/%s.png", slot1.picture, slot0.actId))

	slot0._txtdetailPageTitle.text = slot1.subTitle
	slot0._txtAuthor.text = slot1.subContent

	gohelper.setActive(slot0._txtAuthor.gameObject, not string.nilorempty(slot1.subContent))
	recthelper.setHeight(slot0._scrolldesc.gameObject.transform, string.nilorempty(slot1.subContent) and 705 or 585)

	slot0._txtdesc.text = slot1.content
end

slot0.scrollDescHeight = 650
slot0.maxDescSpacing = 41
slot0.minDescSpacing = 35
slot0.minDescFontSize = 27

function slot0.fitScrollHeight(slot0)
	recthelper.setHeight(slot0.transScrollDesc, uv0.scrollDescHeight - (slot0._txtAuthor.preferredHeight - ZProj.GameHelper.GetTmpLineHeight(slot0._txtAuthor, 1)))
	TaskDispatcher.cancelTask(slot0.setDescSpacing, slot0)
	TaskDispatcher.runDelay(slot0.setDescSpacing, slot0, 0.01)
end

function slot0.setDescSpacing(slot0)
	slot0._txtdesc.lineSpacing = Mathf.Lerp(uv0.maxDescSpacing, uv0.minDescSpacing, slot0._txtdesc.fontSize - uv0.minDescFontSize)
end

function slot0.onClose(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	TaskDispatcher.cancelTask(slot0.setDescSpacing, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagePolaroid:UnLoadImage()
end

return slot0
