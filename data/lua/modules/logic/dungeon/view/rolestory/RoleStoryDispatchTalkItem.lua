module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItem", package.seeall)

slot0 = class("RoleStoryDispatchTalkItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.scrollconent = slot0.viewGO.transform.parent
	slot0.itemList = {}

	for slot4 = 1, 2 do
		slot5 = slot0:getUserDataTb_()
		slot0.itemList[slot4] = slot5
		slot5.txtInfo = gohelper.findChildTextMesh(slot0.viewGO, string.format("info%s", slot4))
		slot5.txtRole = gohelper.findChildTextMesh(slot0.viewGO, string.format("info%s/#txt_role", slot4))
		slot5.canvasGroup = slot5.txtInfo.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refreshItem(slot0)
	slot0:killTween()

	if not slot0.data then
		slot0:clear()
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.curItem = slot0.itemList[slot0.data.type]

	for slot5, slot6 in ipairs(slot0.itemList) do
		gohelper.setActive(slot6.txtInfo, slot1 == slot5)
	end

	if slot1 == RoleStoryEnum.TalkType.Special then
		SLFramework.UGUI.GuiHelper.SetColor(slot0.curItem.txtRole, string.format("#%s", slot0.data.color))
		SLFramework.UGUI.GuiHelper.SetColor(slot0.curItem.txtInfo, string.format("#%s", slot0.data.color))
	end

	slot0.curItem.canvasGroup.alpha = 1

	slot0:setText(slot0.data)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2

	slot0:refreshItem()
end

function slot0.startTween(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callbackObj = slot2

	if not slot0.data then
		slot0:finishTween()

		return
	end

	if not slot0.tween then
		slot0.tween = RoleStoryDispatchTalkItemTween.New()
	end

	slot0.curItem.txtInfo.text = slot0.data.content
	slot0.curItem.txtRole.text = ""

	slot0.tween:playTween(slot0.curItem.txtInfo, slot0.data.content, slot0.finishTween, slot0, slot0.scrollconent)
end

function slot0.finishTween(slot0)
	slot0:setText(slot0.data)

	slot0.callback = nil
	slot0.callbackObj = nil

	if slot0.callback then
		slot1(slot0.callbackObj)
	end
end

function slot0.clearText(slot0)
	slot0:setText()

	if slot0.curItem then
		slot0.curItem.canvasGroup.alpha = 0
	end
end

function slot0.setText(slot0, slot1)
	if not slot0.curItem then
		return
	end

	slot0.curItem.txtInfo.text = slot1 and slot1.content or ""
	slot0.curItem.txtRole.text = slot1 and slot1.speaker or ""
end

function slot0.killTween(slot0)
	if slot0.tween then
		slot0.tween:killTween()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.clear(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.tween then
		slot0.tween:destroy()
	end

	slot0:clear()
end

return slot0
