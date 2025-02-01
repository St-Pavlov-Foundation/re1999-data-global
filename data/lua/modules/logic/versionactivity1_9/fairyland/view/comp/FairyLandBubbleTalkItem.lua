module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubbleTalkItem", package.seeall)

slot0 = class("FairyLandBubbleTalkItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._go = slot1
	slot0.bubbleView = slot2
	slot0.transform = slot1.transform
	slot0.parent = slot0.transform.parent
	slot0.goRoot = gohelper.findChild(slot0._go, "root")
	slot0.goBubble = gohelper.findChild(slot0.goRoot, "image_Bubble")
	slot0.trsBubble = slot0.goBubble.transform
	slot0.goText = gohelper.findChild(slot0.goRoot, "image_Bubble/Scroll View/Viewport/#txt_Descr")
	slot0.textFade = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goText, FairyLandTextFade)
	slot0.goArrow = gohelper.findChild(slot0.goRoot, "image_Bubble/Scroll View/image_Arrow")
end

function slot0.showBubble(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._go, true)
	slot0.textFade:setText({
		content = slot1,
		tween = slot2,
		layoutCallback = slot0.layoutBubble,
		callback = slot0.onTextPlayFinish,
		callbackObj = slot0
	})
	gohelper.setActive(slot0.goArrow, slot3)
	slot0:addUpdate()
end

function slot0.addUpdate(slot0)
	if not slot0.addFlag then
		slot0.addFlag = true

		LateUpdateBeat:Add(slot0._forceUpdatePos, slot0)
	end
end

function slot0.layoutBubble(slot0, slot1)
	recthelper.setHeight(slot0.trsBubble, slot1 + 215)
end

function slot0.onTextPlayFinish(slot0)
	slot0.bubbleView:onTextPlayFinish()
end

function slot0.setTargetGO(slot0, slot1)
	slot0.targetGO = slot1
end

function slot0._forceUpdatePos(slot0)
	if gohelper.isNil(slot0.targetGO) then
		return
	end

	slot1, slot2 = recthelper.rectToRelativeAnchorPos2(slot0.targetGO.transform.position, slot0.parent)

	recthelper.setAnchor(slot0.transform, slot1, slot2)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)

	if slot0.addFlag then
		LateUpdateBeat:Remove(slot0._forceUpdatePos, slot0)

		slot0.addFlag = false
	end

	if slot0.textFade then
		slot0.textFade:killTween()
	end
end

function slot0.dispose(slot0)
	if slot0.addFlag then
		LateUpdateBeat:Remove(slot0._forceUpdatePos, slot0)

		slot0.addFlag = false
	end

	if slot0.textFade then
		slot0.textFade:onDestroy()
	end

	slot0:__onDispose()
end

return slot0
