module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotGuideDragTip", package.seeall)

slot0 = class("V1a6_CachotGuideDragTip", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "#guide")
	slot0._gohand = gohelper.findChild(slot1, "shou")
	slot0._guideAnimator = slot1:GetComponent("Animator")
	slot0._guideblock = gohelper.findChild(slot0.viewGO, "guideblock")

	gohelper.setActive(slot0._guideblock, false)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.GuideDragTip, slot0._guideDragTip, slot0)
	slot0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.PlayerMove, slot0._playerMove, slot0)
end

function slot0._playerMove(slot0)
end

function slot0._guideDragTip(slot0, slot1)
	if tonumber(slot1) == V1a6_CachotEnum.GuideDragTipType.Left then
		gohelper.setActive(slot0._guideAnimator.gameObject, true)
		gohelper.setActive(slot0._guideblock, true)
		slot0._guideAnimator:Play("left")
	elseif slot2 == V1a6_CachotEnum.GuideDragTipType.Right then
		gohelper.setActive(slot0._guideAnimator.gameObject, true)
		gohelper.setActive(slot0._guideblock, true)
		slot0._guideAnimator:Play("right")
	else
		gohelper.setActive(slot0._guideAnimator.gameObject, false)
		gohelper.setActive(slot0._guideblock, false)
	end
end

function slot0.isShowDragTip(slot0)
	return slot0._guideblock.activeSelf
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
