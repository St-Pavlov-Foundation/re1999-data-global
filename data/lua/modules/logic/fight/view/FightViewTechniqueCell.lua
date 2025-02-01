module("modules.logic.fight.view.FightViewTechniqueCell", package.seeall)

slot0 = class("FightViewTechniqueCell", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._click = gohelper.getClickWithAudio(slot1)
	slot0._txtName = gohelper.findChildText(slot1, "effectname")
	slot0._img = gohelper.findChildSingleImage(slot1, "icon")
	slot0._animator = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._moPlayHistory = {}
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0._click:AddClickListener(slot0._onClickItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onStartSequenceFinish(slot0)
	if slot0._mo and not gohelper.isNil(slot0._animator) then
		slot0._animator:Play("fight_effecttips_loop")
		slot0._animator:Update(0)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	if (not slot0._mo or slot0._mo ~= slot1) and not slot1.hasPlayAnimin and not gohelper.isNil(slot0._animator) then
		slot1.hasPlayAnimin = true
		slot0._moPlayHistory[slot1] = true

		slot0._animator:Play("fight_effecttips")
		slot0._animator:Update(0)
	end

	slot0._mo = slot1
	slot0._txtName.text = lua_fight_technique.configDict[slot1.id] and slot2.title_cn or ""

	if slot2 and not string.nilorempty(slot2.icon) then
		slot0._img:LoadImage(ResUrl.getFightIcon(slot2.icon) .. ".png")
	end
end

function slot0.onDestroy(slot0)
	if slot0._img then
		slot0._img:UnLoadImage()

		slot0._img = nil
	end

	if slot0._moPlayHistory then
		for slot4, slot5 in pairs(slot0._moPlayHistory) do
			slot4.hasPlayAnimin = nil
		end

		slot0._moPlayHistory = nil
	end
end

function slot0._onClickItem(slot0)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightForbidClickTechnique) then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightMoveCard) then
		return
	end

	if not FightModel.instance:isStartFinish() and (GuideModel.instance:getDoingGuideIdList() and #slot2 or 0) > 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, lua_fight_technique.configDict[slot0._mo.id])
end

return slot0
