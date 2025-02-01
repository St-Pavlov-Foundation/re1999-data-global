module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_AssessIcon", package.seeall)

slot0 = class("V1a6_BossRush_AssessIcon", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._goAssessEmpty = gohelper.findChild(slot0.viewGO, "#go_AssessEmpty")
	slot0._goNotEmpty = gohelper.findChild(slot0.viewGO, "#go_NotEmpty")
	slot0._imageAssessIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_NotEmpty/#image_AssessIcon")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "Score/#txt_Score")
	slot0._txtScoreNum = gohelper.findChildText(slot0.viewGO, "Score/#txt_ScoreNum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goScore = gohelper.findChild(slot0.viewGO, "Score")

	gohelper.setActive(slot0._goScore, false)
	slot0:initVX()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imageAssessIcon:UnLoadImage()
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	if slot1 and slot2 then
		slot5, slot6, slot7 = BossRushConfig.instance:getAssessSpriteName(slot1, slot2, slot3)
		slot8 = string.nilorempty(slot5)

		gohelper.setActive(slot0._goNotEmpty, not slot8)
		gohelper.setActive(slot0._goAssessEmpty, slot8)

		if not slot8 then
			slot9 = gohelper.findChildImage(slot0.viewGO, "#go_NotEmpty/#image_AssessIcon")

			if not slot4 then
				slot10 = slot3 and 1.2 or 1

				transformhelper.setLocalScale(slot0._imageAssessIcon.transform, slot10, slot10, slot10)
			end

			slot0._imageAssessIcon:LoadImage(ResUrl.getV1a4BossRushAssessIcon(slot5), function ()
				if uv0 then
					uv1:SetNativeSize()
				end
			end)
			slot0:showVX(slot6)

			if slot6 > 0 then
				AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
			end

			return slot5, slot6, slot7
		end
	end
end

function slot0.initVX(slot0)
	slot0.vxassess = {
		[BossRushEnum.ScoreLevel.S] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_s"),
		[BossRushEnum.ScoreLevel.S_A] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_ss"),
		[BossRushEnum.ScoreLevel.S_AA] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_sss"),
		[BossRushEnum.ScoreLevel.S_AAA] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_sss2")
	}

	slot0:showVX(false)
end

function slot0.showVX(slot0, slot1)
	if slot0.vxassess then
		for slot5, slot6 in pairs(slot0.vxassess) do
			gohelper.setActive(slot6, slot1 == slot5)
		end
	end
end

return slot0
