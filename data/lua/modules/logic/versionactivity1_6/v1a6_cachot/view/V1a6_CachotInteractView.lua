module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractView", package.seeall)

slot0 = class("V1a6_CachotInteractView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnFullScreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullscreen")
	slot0._goChoiceItemParent = gohelper.findChild(slot0.viewGO, "choices/#go_choicelist")
	slot0._goChoiceItem = gohelper.findChild(slot0.viewGO, "choices/#go_choicelist/#go_choiceitem")
end

function slot0.addEvents(slot0)
	slot0._btnFullScreen:AddClickListener(slot0._clickFull, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ShowHideChoice, slot0.showHideChoice, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnFullScreen:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ShowHideChoice, slot0.showHideChoice, slot0)
end

function slot0._clickFull(slot0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, -1)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goChoiceItemParent, false)
end

function slot0.showHideChoice(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goChoiceItemParent, true)
		gohelper.CreateObjList(slot0, slot0._createItem, slot1, slot0._goChoiceItemParent, slot0._goChoiceItem, V1a6_CachotInteractChoiceItem)
	else
		gohelper.setActive(slot0._goChoiceItemParent, false)
	end
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot1:updateMo(slot2, slot3)
end

function slot0.onClose(slot0)
end

return slot0
