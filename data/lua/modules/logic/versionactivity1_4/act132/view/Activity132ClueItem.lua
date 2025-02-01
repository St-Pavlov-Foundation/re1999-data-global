module("modules.logic.versionactivity1_4.act132.view.Activity132ClueItem", package.seeall)

slot0 = class("Activity132ClueItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.index = slot2
	slot0._viewGO = slot1
	slot0._goRoot = gohelper.findChild(slot1, "root")
	slot0._maskGO = gohelper.findChild(slot0._goRoot, "mask")
	slot0._mask = slot0._maskGO:GetComponent(typeof(Coffee.UISoftMask.SoftMask))
	slot0._txtNode = gohelper.findChildTextMesh(slot0._goRoot, "#txt_note")
	slot0._goReddot = gohelper.findChild(slot0._goRoot, "#go_reddot")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0._goRoot, "btn_click")
	slot0._rect = slot1.transform
	slot0._redDot = RedDotController.instance:addRedDot(slot0._goReddot, 1081, nil, slot0.refreshRed, slot0)

	slot0:addClickCb(slot0._btnClick, slot0.onClickBtn, slot0)
	slot0:addEventCb(Activity132Controller.instance, Activity132Event.OnContentUnlock, slot0.onRefreshRed, slot0)
end

function slot0.refreshRed(slot0)
	if not slot0.data then
		return
	end

	slot0._redDot.show = Activity132Model.instance:checkClueRed(slot0.data.activityId, slot0.data.clueId)

	slot0._redDot:showRedDot(1)
end

function slot0.onClickBtn(slot0)
	if not slot0.data then
		return
	end

	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, slot0.index)
end

function slot0.resetMask(slot0)
	gohelper.addChild(slot0._goRoot, slot0._maskGO)
	gohelper.setAsFirstSibling(slot0._maskGO)
	recthelper.setAnchor(slot0._maskGO.transform, 0, 0)
	transformhelper.setLocalScale(slot0._maskGO.transform, 2, 2, 2)
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	slot0:resetMask()

	if not slot1 then
		slot0:setActive(false)

		return
	end

	slot0:setActive(false)
	slot0:setActive(true)

	slot0._txtNode.text = slot0.data:getName()
	slot2, slot3 = slot0.data:getPos()

	recthelper.setAnchor(slot0._rect, slot2, slot3)

	slot0.posX, slot0.posY, slot0.posZ = transformhelper.getPos(slot0._rect)

	slot0._redDot:refreshDot()

	if slot0._fadeTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId)

		slot0._fadeTweenId = nil
	end

	slot0._fadeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.34, slot0.fadeUpdateCallback, nil, slot0)
end

function slot0.fadeUpdateCallback(slot0, slot1)
	slot0._mask.alpha = slot1
end

function slot0.onRefreshRed(slot0)
	if not slot0.data then
		return
	end

	slot0._redDot:refreshDot()
end

function slot0.setActive(slot0, slot1)
	if slot0.isVisible == slot1 then
		return
	end

	slot0.isVisible = slot1

	gohelper.setActive(slot0._maskGO, slot1)
	gohelper.setActive(slot0._viewGO, slot1)
end

function slot0.setRootVisible(slot0, slot1)
	gohelper.setActive(slot0._goRoot, slot1)
end

function slot0.destroy(slot0)
	if slot0._fadeTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId)

		slot0._fadeTweenId = nil
	end

	gohelper.destroy(slot0._viewGO)
	slot0:__onDispose()
end

function slot0.getMask(slot0)
	return slot0._maskGO
end

function slot0.getPos(slot0)
	return slot0.posX, slot0.posY, slot0.posZ
end

function slot0.getRealPos(slot0)
	return transformhelper.getPos(slot0._rect)
end

return slot0
