module("modules.logic.guide.view.GuideStoryView", package.seeall)

slot0 = class("GuideStoryView", BaseView)

function slot0.onInitView(slot0)
	slot0._storyGO = gohelper.findChild(slot0.viewGO, "story")
	slot0._txtContent = gohelper.findChildText(slot0.viewGO, "story/go_content/txt_content")
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
	slot0:addEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_updateUI()
	slot0:removeEventCb(GuideController.instance, GuideEvent.UpdateMaskView, slot0._updateUI, slot0)
end

function slot0._updateUI(slot0)
	if not slot0.viewParam then
		return
	end

	gohelper.setActive(slot0._storyGO, slot0.viewParam.hasStory)

	if not slot0.viewParam.hasStory then
		return
	end

	slot0._txtContent.text = LuaUtil.replaceSpace(slot0.viewParam.storyContent)
end

function slot0.onClose(slot0)
end

return slot0
