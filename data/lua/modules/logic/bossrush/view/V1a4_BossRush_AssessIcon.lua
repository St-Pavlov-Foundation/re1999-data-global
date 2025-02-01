module("modules.logic.bossrush.view.V1a4_BossRush_AssessIcon", package.seeall)

slot0 = class("V1a4_BossRush_AssessIcon", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goAssessEmpty = gohelper.findChild(slot1, "#go_AssessEmpty")
	slot0._goNotEmpty = gohelper.findChild(slot1, "#go_NotEmpty")
	slot0._imageAssessIcon = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#image_AssessIcon")
	slot0._imageAssessIconTran = slot0._imageAssessIcon:GetComponent(gohelper.Type_RectTransform)
	slot0._goAssessEmptyTran = slot0._goAssessEmpty.transform
	slot0.lastLevel = nil
end

slot1 = 1.6842105263157894

function slot0.setIconSize(slot0, slot1)
	recthelper.setSize(slot0._imageAssessIconTran, slot1, slot1)
	recthelper.setSize(slot0._goAssessEmptyTran, slot1 * uv0, slot1)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot4, slot5 = BossRushConfig.instance:getAssessSpriteName(slot1, slot2, slot3)
	slot7 = slot5 > 0 and slot5 ~= slot0.lastLevel

	if not (slot4 == "") then
		slot8 = slot3 and 1.2 or 1

		transformhelper.setLocalScale(slot0._imageAssessIcon.transform, slot8, slot8, slot8)
		slot0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(slot4))
	end

	gohelper.setActive(slot0._goAssessEmpty, slot6)
	gohelper.setActive(slot0._goNotEmpty, not slot6)

	if slot7 then
		slot0:playVX()

		slot0.lastLevel = slot5
	end
end

function slot0.playVX(slot0)
	if slot0._parentView and slot0._isPlayVX then
		TaskDispatcher.cancelTask(slot0.delayDisVX, slot0)
		slot0._parentView:playVX()
		TaskDispatcher.runDelay(slot0.delayDisVX, slot0, 0.8)
	end
end

function slot0.delayDisVX(slot0)
	TaskDispatcher.cancelTask(slot0.delayDisVX, slot0)

	if slot0._parentView and slot0._isPlayVX then
		slot0._parentView:stopVX()
	end
end

function slot0.initData(slot0, slot1, slot2)
	slot0._parentView = slot1
	slot0._isPlayVX = slot2

	TaskDispatcher.cancelTask(slot0.delayDisVX, slot0)
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onDestroyView(slot0)
	slot0._imageAssessIcon:UnLoadImage()
end

return slot0
