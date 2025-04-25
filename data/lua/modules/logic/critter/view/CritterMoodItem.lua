module("modules.logic.critter.view.CritterMoodItem", package.seeall)

slot0 = class("CritterMoodItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gohasMood = gohelper.findChild(slot0.go, "#go_hasMood")
	slot0._imagemood = gohelper.findChildImage(slot0.go, "#go_hasMood/#simage_mood")
	slot0._imagemoodvalue = gohelper.findChildImage(slot0.go, "#go_hasMood/#simage_progress")
	slot0._txtMoodValue = gohelper.findChildText(slot0.go, "#go_hasMood/#txt_mood")
	slot0._gonoMood = gohelper.findChild(slot0.go, "#go_noMood")
	slot0._txtmoodRestore = gohelper.findChildText(slot0.go, "#txt_moodRestore")
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))

	if slot0._txtmoodRestore then
		gohelper.setActive(slot0._txtmoodRestore, false)

		slot0._txtmoodRestore.text = ""
	end
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterFeedFood, slot0._onFeedFood, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onMoodChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._onAttrPreviewUpdate, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterFeedFood, slot0._onFeedFood, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onMoodChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._onAttrPreviewUpdate, slot0)
end

function slot0._onFeedFood(slot0, slot1, slot2)
	if not slot0.critterUid or slot1 and not slot1[slot0.critterUid] then
		return
	end

	if slot0._animator then
		slot0._animator:Play(slot2 and "love" or "like", 0, 0)
	end

	slot0:refreshMood()
end

function slot0._onMoodChange(slot0, slot1)
	if not slot0.critterUid or slot1 and not slot1[slot0.critterUid] then
		return
	end

	slot0:refreshMood()
end

function slot0._onAttrPreviewUpdate(slot0, slot1)
	slot0:_onMoodChange(slot1)
end

function slot0.setCritterUid(slot0, slot1)
	slot0.critterUid = slot1

	slot0:refreshMood()
end

function slot0.setShowMoodRestore(slot0, slot1)
	slot0._isNOShowRestore = slot1 == false

	gohelper.setActive(slot0._txtmoodRestore, slot1 ~= false)
end

function slot0.refreshMood(slot0)
	if not slot0.critterUid then
		logError("CritterMoodItem:refreshMood error,critterUid is nil")

		return
	end

	slot1 = 0

	if CritterModel.instance:getCritterMOByUid(slot0.critterUid) then
		slot1 = slot2:getMoodValue()
	end

	slot3 = slot1 ~= 0

	gohelper.setActive(slot0._gohasMood, slot3)
	gohelper.setActive(slot0._gonoMood, not slot3)

	if slot3 then
		slot5 = tonumber(ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)) or 0
		slot8 = "critter_manufacture_heart1"

		if slot1 <= tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.LowMood) or 0) then
			slot8 = "critter_manufacture_heart2"
		end

		UISpriteSetMgr.instance:setCritterSprite(slot0._imagemood, slot8)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imagemoodvalue, slot7 and "#B76D79" or "#FDB467")

		slot0._txtMoodValue.text = slot1
		slot9 = 0

		if slot1 and slot5 and slot5 ~= 0 then
			slot9 = Mathf.Clamp(slot1 / slot5, 0, 1)
		end

		slot0._imagemoodvalue.fillAmount = slot9
	end

	if slot0._isNOShowRestore ~= true and slot0._txtmoodRestore then
		slot4 = CritterHelper.getPreViewAttrValue(CritterEnum.AttributeType.MoodRestore, slot0.critterUid)
		slot0._txtmoodRestore.text = "+" .. CritterHelper.formatAttrValue(CritterEnum.AttributeType.MoodRestore, slot4)

		gohelper.setActive(slot0._txtmoodRestore, slot4 > 0)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtmoodRestore, CritterHelper.getPatienceChangeValue(RoomBuildingEnum.BuildingType.Rest) < slot4 and "#D9A06F" or "#D4C399")
	end
end

function slot0.onDestroy(slot0)
end

return slot0
