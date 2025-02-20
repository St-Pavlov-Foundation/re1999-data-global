module("modules.logic.guide.view.GuideHoleEffect", package.seeall)

slot0 = class("GuideHoleEffect", LuaCompBase)

function slot0.ctor(slot0)
	slot0.showMask = false
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._transform = slot1.transform
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	if slot0._animator then
		slot0._animator.enabled = false
	end

	slot0._childList = slot0:getUserDataTb_()

	for slot7 = 1, slot1.transform.childCount do
		table.insert(slot0._childList, slot2:GetChild(slot7 - 1))
	end
end

function slot0.setSize(slot0, slot1, slot2, slot3)
	if slot0._width == slot1 and slot0._height == slot2 then
		return
	end

	slot0:setVisible(true)

	slot7 = slot3

	slot0:_playEffect(slot7)

	slot0._width = slot1
	slot0._height = slot2

	for slot7, slot8 in ipairs(slot0._childList) do
		recthelper.setSize(slot8, slot1, slot2)
	end
end

function slot0._playEffect(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._playLoop, slot0)

	if not slot0.showMask or slot1 then
		slot0:_playLoop()
	else
		if not slot0._animator then
			return
		end

		slot0._animator.enabled = true

		slot0._animator:Play("edge_once")
	end
end

function slot0._playLoop(slot0)
	if not slot0._animator then
		return
	end

	slot0._animator.enabled = true

	slot0._animator:Play("edge_loop")
end

function slot0.setVisible(slot0, slot1)
	if not slot1 then
		slot0._width = nil
		slot0._height = nil
	end

	gohelper.setActive(slot0.go, slot1)
end

function slot0.addToParent(slot0, slot1)
	gohelper.addChild(slot1, slot0.go)
	gohelper.setAsFirstSibling(slot0.go)
	recthelper.setAnchor(slot0._transform, 0, 0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._playLoop, slot0)
end

return slot0
