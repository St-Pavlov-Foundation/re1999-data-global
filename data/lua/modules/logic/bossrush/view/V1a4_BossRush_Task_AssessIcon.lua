module("modules.logic.bossrush.view.V1a4_BossRush_Task_AssessIcon", package.seeall)

slot0 = class("V1a4_BossRush_Task_AssessIcon", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._goAssessEmpty = gohelper.findChild(slot1, "#go_AssessEmpty")
	slot0._goNotEmpty = gohelper.findChild(slot1, "#go_NotEmpty")
	slot0._goVxCircle = gohelper.findChild(slot1, "#go_NotEmpty/#go_vx_circle")
	slot0._imageAssessIcon = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#image_AssessIcon")
	slot0._goAssessIconS = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#go_AssessIcon_s")
	slot0._goAssessIconSS = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#go_AssessIcon_ss")
	slot0._goAssessIconSSS = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#go_AssessIcon_sss")
	slot0._goAssessIconSSSS = gohelper.findChildSingleImage(slot1, "#go_NotEmpty/#go_AssessIcon_sss2")
	slot0._goAssessIcon = slot0._imageAssessIcon.gameObject

	gohelper.setActive(slot0._goAssessIcon, false)
	gohelper.setActive(slot0._goAssessIconS, false)
	gohelper.setActive(slot0._goAssessIconSS, false)
	gohelper.setActive(slot0._goAssessIconSSS, false)
	gohelper.setActive(slot0._goAssessIconSSSS, false)
	gohelper.setActive(slot0._goVxCircle, false)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = BossRushConfig.instance:getAssessSpriteName(slot1, slot2, slot3)
	slot8 = slot0["_goAssessIcon" .. slot6] or slot0._imageAssessIcon

	gohelper.setActive(slot8.gameObject, true)

	slot9 = slot8:GetComponent(gohelper.Type_Image)

	if not (slot4 == "") then
		slot8:LoadImage(ResUrl.getV1a4BossRushAssessIcon(slot4), function ()
			if uv0 then
				uv1:SetNativeSize()
			end
		end)
	end

	if slot5 >= 5 then
		gohelper.setActive(slot0._goVxCircle, true)
	end

	gohelper.setActive(slot0._goAssessEmpty, slot7)
	gohelper.setActive(slot0._goNotEmpty, not slot7)
end

function slot0.onDestroyView(slot0)
	slot0._imageAssessIcon:UnLoadImage()
	slot0._goAssessIconS:UnLoadImage()
	slot0._goAssessIconSS:UnLoadImage()
	slot0._goAssessIconSSS:UnLoadImage()
	slot0._goAssessIconSSSS:UnLoadImage()
end

return slot0
