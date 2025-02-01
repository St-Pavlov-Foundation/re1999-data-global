module("modules.logic.guide.view.GuideViewMgr", package.seeall)

slot0 = class("GuideViewMgr")

function slot0.open(slot0, slot1, slot2)
	slot0.guideId = slot1
	slot0.stepId = slot2
	slot0.viewParam = GuideViewParam.New()

	slot0.viewParam:setStep(slot0.guideId, slot0.stepId)

	if string.find(slot0.viewParam.goPath, "/MESSAGE") then
		ViewMgr.instance:openView(ViewName.GuideView2, slot0.viewParam, true)
	else
		ViewMgr.instance:openView(ViewName.GuideView, slot0.viewParam, true)
	end
end

function slot0.close(slot0)
	slot0.viewParam = nil

	ViewMgr.instance:closeView(ViewName.GuideView, true)
	ViewMgr.instance:closeView(ViewName.GuideView2, true)
end

function slot0.enableHoleClick(slot0)
	if slot0.viewParam then
		slot0.viewParam.enableHoleClick = true

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.disableHoleClick(slot0)
	if slot0.viewParam then
		slot0.viewParam.enableHoleClick = false

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.setHoleClickCallback(slot0, slot1, slot2)
	slot0._clickCallback = slot1
	slot0._clickCallbackTarget = slot2
end

function slot0.enableClick(slot0, slot1)
	if slot0.viewParam then
		slot0.viewParam.enableClick = slot1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.enablePress(slot0, slot1)
	if slot0.viewParam then
		slot0.viewParam.enablePress = slot1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.enableDrag(slot0, slot1)
	if slot0.viewParam then
		slot0.viewParam.enableDrag = slot1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.setMaskAlpha(slot0, slot1)
	if slot0.viewParam then
		slot0.viewParam.maskAlpha = slot1

		GuideController.instance:dispatchEvent(GuideEvent.UpdateMaskView)
	end
end

function slot0.enableSpaceBtn(slot0, slot1)
	if slot0.viewParam then
		slot0.viewParam.enableSpaceBtn = slot1
	end
end

function slot0.onClickCallback(slot0, slot1)
	if slot0._clickCallback then
		if GuideController.EnableLog then
			logNormal("guidelog: " .. ((slot0.guideId or "nil") .. "_" .. (slot0.stepId or "nil")) .. " GuideViewMgr.onClickCallback inside " .. (slot1 and "true" or "false") .. debug.traceback("", 2))
		end

		if slot0._clickCallbackTarget then
			slot0._clickCallback(slot0._clickCallbackTarget, slot1)
		else
			slot0._clickCallback(slot1)
		end
	elseif GuideController.EnableLog then
		logNormal("guidelog: " .. ((slot0.guideId or "nil") .. "_" .. (slot0.stepId or "nil")) .. "GuideViewMgr.onClickCallback callback not exist inside " .. (slot1 and "true" or "false") .. debug.traceback("", 2))
	end
end

function slot0.isGuidingGO(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return gohelper.find(uv0.instance.viewParam and slot2.goPath) == slot1
	end
end

slot0.instance = slot0.New()

return slot0
