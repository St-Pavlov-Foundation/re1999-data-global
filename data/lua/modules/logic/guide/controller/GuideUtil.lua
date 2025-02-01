module("modules.logic.guide.controller.GuideUtil", package.seeall)

slot0 = _M
slot1 = typeof(UnityEngine.RectTransform)
slot2 = typeof(UnityEngine.CanvasGroup)
slot3 = nil

function slot0.isGOShowInScreen(slot0)
	if gohelper.isNil(slot0) or not slot0.activeInHierarchy then
		return false
	end

	if slot0:GetComponent(uv0) then
		uv1 = uv1 or ViewMgr.instance:getUIRoot().transform

		if ZProj.UGUIHelper.Overlaps(slot1, uv1, CameraMgr.instance:getUICamera()) then
			while slot1 do
				slot2, slot3, slot4 = transformhelper.getLocalScale(slot1, 0, 0, 0)

				if slot2 == 0 or slot3 == 0 then
					return false
				end

				if slot1:GetComponent(uv2) and slot5.alpha == 0 then
					return false
				end

				slot1 = slot1.parent
			end

			return true
		else
			return false
		end
	else
		return true
	end
end

function slot0.isGuideViewTarget(slot0)
	if ViewMgr.instance:isOpen(ViewName.GuideView) and gohelper.find(GuideViewMgr.instance.viewParam and slot1.goPath) and slot0 == slot3 then
		return true
	end

	return false
end

return slot0
