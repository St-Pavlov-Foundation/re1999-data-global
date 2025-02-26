module("modules.logic.dungeon.view.rolestory.RoleStoryReviewView", package.seeall)

slot0 = class("RoleStoryReviewView", BaseView)

function slot0.onInitView(slot0)
	slot0.storyItems = {}
	slot0.goStorytItem = gohelper.findChild(slot0.viewGO, "left/#go_herocontainer/#scroll_hero/Viewport/Content/#go_heroitem")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "right/#txt_title")
	slot0.goLayout = gohelper.findChild(slot0.viewGO, "right/layout")
	slot0.txtEnd = gohelper.findChildTextMesh(slot0.viewGO, "right/#txt_end")
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_close")
	slot0.goTalk = gohelper.findChild(slot0.goLayout, "#go_Talk")
	slot0.goArrow = gohelper.findChild(slot0.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/arrow")
	slot0.goChatItem = gohelper.findChild(slot0.goLayout, "#go_Talk/Scroll DecView/Viewport/Content/#go_chatitem")

	gohelper.setActive(slot0.goChatItem, false)

	slot0.scroll = gohelper.findChildScrollRect(slot0.goLayout, "#go_Talk/Scroll DecView")
	slot0.talkList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ClickReviewItem, slot0._onClickReviewItem, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0._onClickReviewItem(slot0, slot1)
	slot0:refreshDispatchView(slot1)
end

function slot0.onOpen(slot0)
	slot0.storyId = slot0.viewParam.storyId

	slot0:refreshDispatchList()

	if slot0.storyItems[1] then
		slot2:onClickBtnClick()
	end
end

function slot0.refreshDispatchList(slot0)
	slot1 = RoleStoryConfig.instance:getDispatchList(slot0.storyId, RoleStoryEnum.DispatchType.Story) or {}
	slot5 = #slot0.storyItems

	for slot5 = 1, math.max(#slot1, slot5) do
		slot0:refreshDispatchItem(slot0.storyItems[slot5], slot1[slot5], slot5)
	end
end

function slot0.refreshDispatchView(slot0, slot1)
	slot2 = RoleStoryConfig.instance:getDispatchConfig(slot1)
	slot0.txtTitle.text = slot2.name
	slot0.txtEnd.text = slot2.completeDesc

	slot0:refreshTalk(slot2)

	for slot6, slot7 in ipairs(slot0.storyItems) do
		slot7:updateSelect(slot1)
	end

	slot0:layoutView()
end

function slot0.refreshDispatchItem(slot0, slot1, slot2, slot3)
	(slot1 or slot0:createItem(slot3)):onUpdateMO(slot2, slot3)
end

function slot0.createItem(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goStorytItem), RoleStoryReviewItem)
	slot0.storyItems[slot1] = slot3

	return slot3
end

function slot0.refreshTalk(slot0, slot1)
	slot0:refreshTalkList(string.splitToNumber(slot1.talkIds, "#"))
end

function slot0.refreshTalkList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, RoleStoryConfig.instance:getTalkConfig(slot7))
	end

	slot6 = #slot0.talkList

	for slot6 = 1, math.max(#slot2, slot6) do
		slot0:refreshTalkItem(slot0.talkList[slot6], slot2[slot6], slot6)
	end
end

function slot0.refreshTalkItem(slot0, slot1, slot2, slot3)
	(slot1 or slot0:createTalkItem(slot3)):onUpdateMO(slot2, slot3)
end

function slot0.createTalkItem(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goChatItem, string.format("go%s", slot1)), RoleStoryDispatchTalkItem)
	slot0.talkList[slot1] = slot3

	return slot3
end

function slot0.layoutView(slot0)
	recthelper.setHeight(slot0.goTalk.transform, recthelper.getHeight(slot0.goLayout.transform))
end

function slot0.onClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
