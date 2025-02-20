module("modules.logic.fight.view.FightOpItem", package.seeall)

slot0 = class("FightOpItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._imgMat = gohelper.findChildImage(slot1, "imgMat")
	slot5 = "imgTag"
	slot0._imgTag = gohelper.findChildImage(slot1, slot5)
	slot0._imgBgs = slot0:getUserDataTb_()
	slot0._imgBgGos = slot0:getUserDataTb_()

	for slot5 = 1, 4 do
		table.insert(slot0._imgBgs, gohelper.findChildImage(slot1, "imgBg/" .. slot5))
		table.insert(slot0._imgBgGos, gohelper.findChild(slot1, "imgBg/" .. slot5))
	end

	slot0._imgBg2 = gohelper.findChildImage(slot1, "forbid/mask")

	if isDebugBuild then
		slot0._imgTag.raycastTarget = true
		slot0._click = gohelper.getClick(slot0.go)

		slot0._click:AddClickListener(slot0._onClickOp, slot0)
	end

	slot0.topPosRectTr = gohelper.findChildComponent(slot1, "topPos", gohelper.Type_RectTransform)
	slot0.goEmitNormal = gohelper.findChild(slot1, "#emit_normal")
	slot0.goEmitUitimate = gohelper.findChild(slot1, "#emit_uitimate")

	slot0:addEventCb(FightController.instance, FightEvent.OnSelectMonsterCardMo, slot0.onSelectMonsterCardMo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.removeEventListeners(slot0)
	if isDebugBuild and slot0._click then
		slot0._click:RemoveClickListener()
	end

	slot0:removeEventCb(FightController.instance, FightEvent.OnSelectMonsterCardMo, slot0.onSelectMonsterCardMo, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.onSelectMonsterCardMo(slot0, slot1)
	slot3 = FightCardModel.instance:isUniqueSkill(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId)

	gohelper.setActive(slot0.goEmitNormal, FightHelper.isSameCardMo(slot1, slot0.cardInfoMO) and not slot3)
	gohelper.setActive(slot0.goEmitUitimate, slot2 and slot3)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0.goEmitNormal, false)
		gohelper.setActive(slot0.goEmitUitimate, false)
	end
end

function slot0._onClickOp(slot0)
	if slot0.cardInfoMO then
		logNormal(slot0.cardInfoMO.skillId .. " " .. lua_skill.configDict[slot0.cardInfoMO.skillId].name)
	end
end

function slot0.updateCardInfoMO(slot0, slot1)
	slot0.cardInfoMO = slot1

	gohelper.setActive(slot0.go, lua_skill.configDict[slot1.skillId] ~= nil)

	if not slot2 then
		return
	end

	slot4 = FightDataHelper.entityMgr:getById(slot1.uid)

	if (not FightCardModel.instance:isUniqueSkill(slot1.uid, slot1.skillId) or not FightEnum.UniqueSkillCardLv) and FightCardModel.instance:getSkillLv(slot1.uid, slot1.skillId) == FightEnum.UniqueSkillCardLv then
		slot3 = 1
	end

	slot9 = slot0._imgTag
	slot10 = "jnk_gj" .. slot2.showTag

	UISpriteSetMgr.instance:setFightSprite(slot9, slot10)

	for slot9, slot10 in ipairs(slot0._imgBgs) do
		gohelper.setActive(slot10.gameObject, slot9 == slot3)
	end

	if slot0._imgBg2 and slot0._imgBgs[slot3] then
		slot0._imgBg2.sprite = slot0._imgBgs[slot3].sprite
	end

	gohelper.setActive(slot0._imgTag.gameObject, slot3 ~= FightEnum.UniqueSkillCardLv)
end

function slot0.showOpForbid(slot0)
	if slot0._imgBgGos[FightCardModel.instance:getSkillLv(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId)] then
		gohelper.onceAddComponent(slot2, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

		if slot2:GetComponent(typeof(UnityEngine.Animation)) then
			slot3:Play("fightname_forbid_dissvelop")
		end

		slot0._imgBgs[slot1].material = slot0._imgMat.material
	end
end

function slot0.cancelOpForbid(slot0)
	for slot4, slot5 in ipairs(slot0._imgBgs) do
		slot5.material = nil
	end
end

return slot0
