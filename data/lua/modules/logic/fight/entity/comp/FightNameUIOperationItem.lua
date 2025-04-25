module("modules.logic.fight.entity.comp.FightNameUIOperationItem", package.seeall)

slot0 = class("FightNameUIOperationItem", FightBaseView)

function slot0.onInitView(slot0)
	slot0._imgMat = gohelper.findChildImage(slot0.viewGO, "imgMat")
	slot0._imgTag = gohelper.findChildImage(slot0.viewGO, "imgTag")
	slot0._imgBgs = slot0:newUserDataTable()
	slot0._imgBgGos = slot0:newUserDataTable()

	for slot4 = 1, 4 do
		table.insert(slot0._imgBgs, gohelper.findChildImage(slot0.viewGO, "imgBg/" .. slot4))
		table.insert(slot0._imgBgGos, gohelper.findChild(slot0.viewGO, "imgBg/" .. slot4))
	end

	slot0._imgBg2 = gohelper.findChildImage(slot0.viewGO, "forbid/mask")

	if isDebugBuild then
		slot0._imgTag.raycastTarget = true

		slot0:com_registClick(gohelper.getClick(slot0.viewGO), slot0._onClickOp)
	end

	slot0.topPosRectTr = gohelper.findChildComponent(slot0.viewGO, "topPos", gohelper.Type_RectTransform)
	slot0.viewGOEmitNormal = gohelper.findChild(slot0.viewGO, "#emit_normal")
	slot0.viewGOEmitUitimate = gohelper.findChild(slot0.viewGO, "#emit_uitimate")
	slot0.animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0:com_registFightEvent(FightEvent.OnSelectMonsterCardMo, slot0.onSelectMonsterCardMo)
	slot0:com_registEvent(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView)
	slot0:com_registFightEvent(FightEvent.OnExPointChange, slot0._onExPointChange)
	slot0:com_registFightEvent(FightEvent.OnExSkillPointChange, slot0._onExSkillPointChange)
end

function slot0.refreshItemData(slot0, slot1)
	slot0._cardData = slot1
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot1.uid)

	gohelper.setActive(slot0.viewGO, lua_skill.configDict[slot1.skillId] ~= nil)

	if not slot2 then
		return
	end

	slot3 = slot0._cardData.skillId
	slot0._isUnique = FightCardModel.instance:isUniqueSkill(slot0._entityMO.id, slot3)

	if (not slot0._isUnique or not FightEnum.UniqueSkillCardLv) and FightCardModel.instance:getSkillLv(slot0._entityMO.uid, slot3) == FightEnum.UniqueSkillCardLv then
		slot5 = 1
	end

	slot10 = slot2.showTag
	slot9 = "jnk_gj" .. slot10

	UISpriteSetMgr.instance:setFightSprite(slot0._imgTag, slot9)

	for slot9, slot10 in ipairs(slot0._imgBgs) do
		gohelper.setActive(slot10.gameObject, slot9 == slot5)
	end

	if slot0._imgBg2 and slot0._imgBgs[slot5] then
		slot0._imgBg2.sprite = slot0._imgBgs[slot5].sprite
	end

	gohelper.setActive(slot0._imgTag.gameObject, slot5 ~= FightEnum.UniqueSkillCardLv)

	slot0._lastAniName = nil
	slot0._lastCanUse = true

	slot0:_refreshAni()
end

function slot0._refreshAni(slot0)
	slot0._canUse = FightViewHandCardItemLock.canUseCardSkill(slot0._entityMO.id, slot0._cardData.skillId)

	if slot0._isUnique and slot0._canUse then
		slot0._canUse = slot0._entityMO:getUniqueSkillPoint() <= slot0._entityMO.exPoint
	end

	slot0._curAniName = slot0._canUse and "fightname_op_in" or "fightname_forbid_in"

	if slot0._curAniName ~= slot0._lastAniName then
		if not slot0._lastCanUse and slot0._canUse then
			slot0._curAniName = "fightname_forbid_unlock"

			if slot0.viewGO.activeInHierarchy then
				slot0.animator:Play(slot0._curAniName, slot0._refreshAni, slot0)
			end
		elseif slot0.viewGO.activeInHierarchy then
			slot0.animator:Play(slot0._curAniName, nil, )
		end
	end

	slot0._lastAniName = slot0._curAniName
	slot0._lastCanUse = slot0._canUse
end

function slot0.onSelectMonsterCardMo(slot0, slot1)
	slot3 = FightCardModel.instance:isUniqueSkill(slot0._cardData.uid, slot0._cardData.skillId)

	gohelper.setActive(slot0.viewGOEmitNormal, FightHelper.compareData(slot1, slot0._cardData) and not slot3)
	gohelper.setActive(slot0.viewGOEmitUitimate, slot2 and slot3)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.FightEnemyActionView then
		gohelper.setActive(slot0.viewGOEmitNormal, false)
		gohelper.setActive(slot0.viewGOEmitUitimate, false)
	end
end

function slot0._onClickOp(slot0)
	if slot0._cardData then
		logNormal(slot0._cardData.skillId .. " " .. lua_skill.configDict[slot0._cardData.skillId].name)
	end
end

function slot0._onExSkillPointChange(slot0, slot1)
	if slot1 == slot0._entityMO.id and slot0._isUnique then
		slot0:_refreshAni()
	end
end

function slot0._onExPointChange(slot0, slot1)
	if slot1 == slot0._entityMO.id and slot0._isUnique then
		slot0:_refreshAni()
	end
end

function slot0.onDestructor(slot0)
	for slot4, slot5 in ipairs(slot0._imgBgs) do
		slot5.material = nil
	end
end

return slot0
