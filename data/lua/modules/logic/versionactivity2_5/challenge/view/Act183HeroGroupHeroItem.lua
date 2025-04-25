module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupHeroItem", package.seeall)

slot0 = class("Act183HeroGroupHeroItem", HeroGroupHeroItem)

function slot0.onUpdateMO(slot0, slot1)
	slot0._commonHeroCard:setGrayScale(false)

	slot3 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]
	slot0.mo = slot1
	slot0._posIndex = slot0.mo.id - 1
	slot0._heroMO = slot1:getHeroMO()
	slot0.monsterCO = slot1:getMonsterCO()
	slot0.trialCO = slot1:getTrialCO()

	gohelper.setActive(slot0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	slot4 = nil

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		slot4 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[slot0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._lvnumen, "#E9E9E9")

	for slot8 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(slot0._goRankList[slot8], "#F6F3EC")
	end

	if slot0._heroMO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot4 and slot4.skin or HeroModel.instance:getByHeroId(slot0._heroMO.heroId).skin))

		if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(slot0._goblackmask.transform, 125)
		else
			recthelper.setHeight(slot0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot0._heroMO.config.career))

		slot9 = nil

		if (slot4 and slot4.level or slot0._heroMO.level) < HeroGroupBalanceHelper.getHeroBalanceLv(slot0._heroMO.heroId) then
			slot7 = slot8
			slot9 = true
		end

		slot10, slot11 = HeroConfig.instance:getShowLevel(slot7)

		if slot9 then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			slot15 = ">"
			slot0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. slot15 .. slot10

			for slot15 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(slot0._goRankList[slot15], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			slot0._lvnum.text = slot10
		end

		for slot15 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot15], slot15 == slot11 - 1)
		end

		gohelper.setActive(slot0._goStars, true)

		for slot15 = 1, 6 do
			gohelper.setActive(slot0._goStarList[slot15], slot15 <= CharacterEnum.Star[slot0._heroMO.config.rare])
		end
	elseif slot0.monsterCO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot0.monsterCO.skinId))

		slot11 = slot0.monsterCO.career

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot11))

		slot0._lvnum.text, slot7 = HeroConfig.instance:getShowLevel(slot0.monsterCO.level)

		for slot11 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot11], slot11 == slot7 - 1)
		end

		gohelper.setActive(slot0._goStars, false)
	elseif slot0.trialCO then
		slot6 = nil
		slot6 = (slot0.trialCO.skin <= 0 or SkinConfig.instance:getSkinCo(slot0.trialCO.skin)) and SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(slot0.trialCO.heroId).skinId)

		if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(slot0._goblackmask.transform, 125)
		else
			recthelper.setHeight(slot0._goblackmask.transform, 300)
		end

		slot0._commonHeroCard:onUpdateMO(slot6)

		slot12 = slot5.career

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. tostring(slot12))

		slot0._lvnum.text, slot8 = HeroConfig.instance:getShowLevel(slot0.trialCO.level)

		for slot12 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot12], slot12 == slot8 - 1)
		end

		gohelper.setActive(slot0._goStars, true)

		for slot12 = 1, 6 do
			gohelper.setActive(slot0._goStarList[slot12], slot12 <= CharacterEnum.Star[slot5.rare])
		end
	end

	if slot0._heroItemContainer then
		slot0._heroItemContainer.compColor[slot0._lvnumen] = slot0._lvnumen.color

		for slot8 = 1, 3 do
			slot0._heroItemContainer.compColor[slot0._goRankList[slot8]] = slot0._goRankList[slot8].color
		end
	end

	slot0.isLock = false
	slot0.isAidLock = slot0.mo.aid and slot0.mo.aid == -1
	slot0.isAid = slot0.mo.aid ~= nil
	slot0.isTrialLock = (slot0.mo.trial and slot0.mo.trialPos) ~= nil
	slot5 = HeroGroupModel.instance:getBattleRoleNum()
	slot0.isRoleNumLock = false
	slot0.isEmpty = slot1:isEmpty()

	gohelper.setActive(slot0._heroGO, (slot0._heroMO ~= nil or slot0.monsterCO ~= nil or slot0.trialCO ~= nil) and not slot0.isLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._noneGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil or slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._addGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil and not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._lockGO, slot0:selfIsLock())
	gohelper.setActive(slot0._aidGO, slot0.mo.aid and slot0.mo.aid ~= -1)

	if slot3 then
		gohelper.setActive(slot0._subGO, not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock and slot3.playerMax < slot0.mo.id)
	else
		gohelper.setActive(slot0._subGO, not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock and slot0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(slot0._tagTr, 36.3, slot0._subGO.activeSelf and 144.1 or 212.1)

	if slot0.trialCO then
		gohelper.setActive(slot0._trialTagGO, true)

		slot0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(slot0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and slot0.isRoleNumLock and slot0._heroMO ~= nil and slot0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(slot0._heroMO.id)
	end

	slot0:initEquips()
	slot0:showCounterSign()

	if slot0._playDeathAnim then
		slot0._playDeathAnim = nil

		slot0:playAnim(UIAnimationName.Open)
	end

	slot0:_showMojingTip()
end

function slot0.selfIsLock(slot0)
	return false
end

function slot0.setScale(slot0, slot1, slot2, slot3)
	slot0._scaleX = slot1 or 1
	slot0._scaleY = slot2 or 1
	slot0._scaleZ = slot3 or 1

	transformhelper.setLocalScale(slot0.go.transform, slot0._scaleX, slot0._scaleY, slot0._scaleZ)
end

function slot0.onItemEndDrag(slot0, slot1, slot2)
	ZProj.TweenHelper.DOScale(slot0.go.transform, slot0._scaleX, slot0._scaleY, slot0._scaleZ, 0.2, nil, , , EaseType.Linear)
	slot0:_setHeroItemPressState(false)
end

return slot0
