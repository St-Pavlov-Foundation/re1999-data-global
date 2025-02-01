module("modules.logic.story.view.StoryPrologueSkipView", package.seeall)

slot0 = class("StoryPrologueSkipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_fg")
	slot0._simagefg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/simage_fg")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "ani/simage_1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "ani/simage_2")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_close")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#txt_content")
	slot0._bgClick = gohelper.getClickWithAudio(slot0._simagefg.gameObject)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._bgClick:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:_hideStoryViewContent(false)
	slot0:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnSkipClick)
end

function slot0._onBgClick(slot0)
	slot0:_hideStoryViewContent(false)
	slot0:closeThis()
	StoryController.instance:dispatchEvent(StoryEvent.OnSkipClick)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)

	slot0._txtcontent.text = slot0.viewParam.content

	slot0._simagefg:LoadImage(ResUrl.getStoryPrologueSkip("prologueskip_fullbg2"))
	slot0._simagefg2:LoadImage(ResUrl.getStoryPrologueSkip("bg1"))
	slot0._simagebg1:LoadImage(ResUrl.getStoryPrologueSkip("bg2"))
	slot0._simagebg2:LoadImage(ResUrl.getStoryPrologueSkip("bg3"))
	slot0:_hideStoryViewContent(true)
end

function slot0._hideStoryViewContent(slot0, slot1)
	gohelper.setActive(ViewMgr.instance:getContainer(ViewName.StoryHeroView).viewGO, not slot1)
	gohelper.setActive(gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryView).viewGO, "#go_contentroot"), not slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagefg:UnLoadImage()
	slot0._simagefg2:UnLoadImage()
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
