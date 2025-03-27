module("modules.logic.fight.view.FightStatItem", package.seeall)

slot0 = class("FightStatItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._heroIcon = gohelper.findChildSingleImage(slot1, "heroinfo/hero/icon")
	slot0._career = gohelper.findChildImage(slot1, "heroinfo/career")
	slot0._rare = gohelper.findChildImage(slot1, "heroinfo/rare")
	slot0.goLayout = gohelper.findChild(slot1, "heroinfo/layout")
	slot0.goRare = gohelper.findChild(slot1, "heroinfo/rare")
	slot0.goCareer = gohelper.findChild(slot1, "heroinfo/career")
	slot0._gorankobj = gohelper.findChild(slot1, "heroinfo/layout/rankobj")
	slot0._rankGOs = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0._rankGOs[slot5] = gohelper.findChildImage(slot0._gorankobj, "rank" .. tostring(slot5))
	end

	slot0._txtLv = gohelper.findChildText(slot1, "heroinfo/layout/txtLv")
	slot0._txtName = gohelper.findChildText(slot1, "heroinfo/txtName")
	slot0._txtHarm = gohelper.findChildText(slot1, "data/txtHarm")
	slot0._txtHurt = gohelper.findChildText(slot1, "data/txtHurt")
	slot0._txtHeal = gohelper.findChildText(slot1, "data/txtHeal")
	slot0._txtHarmRate = gohelper.findChildText(slot1, "data/txtHarmRate")
	slot0._txtHurtRate = gohelper.findChildText(slot1, "data/txtHurtRate")
	slot0._txtHealRate = gohelper.findChildText(slot1, "data/txtHealRate")
	slot0._imgProgressHarm = gohelper.findChildImage(slot1, "data/progressHarm/progress")
	slot0._imgProgressHurt = gohelper.findChildImage(slot1, "data/progressHurt/progress")
	slot0._imgProgressHeal = gohelper.findChildImage(slot1, "data/progressHeal/progress")
	slot0._godata = gohelper.findChild(slot1, "data")
	slot0._goskill = gohelper.findChild(slot1, "skill")
	slot0._scrollUseSkill = gohelper.findChild(slot1, "skill/scroll_useskill"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._goskillContent = gohelper.findChild(slot1, "skill/scroll_useskill/Viewport/Content")
	slot0._goskillItem = gohelper.findChild(slot1, "skill/scroll_useskill/Viewport/Content/skillItem")
	slot0._goscrolluseskill = gohelper.findChild(slot1, "skill/scroll_useskill")
	slot0._goskillempty = gohelper.findChild(slot1, "skill/go_skillempty")
	slot0._skillItems = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goskillItem, false)

	slot0._statType = FightEnum.FightStatType.DataView
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SwitchInfoState, slot0._refreshInfoUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SwitchInfoState, slot0._refreshInfoUI, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0.entityMO = slot1.entityMO or FightDataHelper.entityMgr:getById(slot1.entityId)
	slot2 = ViewMgr.instance:isOpen(ViewName.Act174FightResultView)
	slot3 = slot0._mo.fromOtherFight
	slot4 = lua_character.configDict[slot0.entityMO.modelId]

	gohelper.setActive(slot0.goLayout, true)
	gohelper.setActive(slot0.goRare, true)
	gohelper.setActive(slot0.goCareer, true)

	if slot0.entityMO:isAssistBoss() then
		slot0:refreshAssistBossInfo()
	elseif slot0.entityMO:isASFDEmitter() then
		slot0:refreshASFDInfo()
	elseif slot2 then
		slot0:refreshAct174Info()
	elseif not slot4 then
		slot0._txtName.text = FightConfig.instance:getNewMonsterConfig(lua_monster.configDict[slot0.entityMO.modelId]) and slot5.highPriorityName or slot5.name

		if slot5 then
			slot6, slot7 = HeroConfig.instance:getShowLevel(slot5.level)
			slot0._txtLv.text = string.format("<size=20>Lv.</size>%d", slot6)

			gohelper.setActive(slot0._gorankobj, slot7 > 1)

			for slot11 = 1, 3 do
				gohelper.setActive(slot0._rankGOs[slot11], slot7 > 1 and slot11 == slot7 - 1 or false)
			end

			slot0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot5.skinId).retangleIcon))
			UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot5.career))
			UISpriteSetMgr.instance:setCommonSprite(slot0._rare, "bgequip" .. 1)
		end
	else
		slot0._txtName.text = slot4 and slot4.name or ""

		if slot0.entityMO:getTrialAttrCo() then
			slot0._txtName.text = slot5.name
		end

		if not slot3 and FightReplayModel.instance:isReplay() then
			slot6, slot7 = HeroConfig.instance:getShowLevel(slot0.entityMO.level)
			slot0._txtLv.text = string.format("<size=20>Lv.</size>%d", slot6)

			gohelper.setActive(slot0._gorankobj, slot7 > 1)

			for slot11 = 1, 3 do
				gohelper.setActive(slot0._rankGOs[slot11], slot7 > 1 and slot11 == slot7 - 1 or false)
			end

			slot0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot0.entityMO.skin).retangleIcon))
			UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot4.career))
			UISpriteSetMgr.instance:setCommonSprite(slot0._rare, "bgequip" .. CharacterEnum.Star[slot4.rare])
		else
			if not HeroModel.instance:getByHeroId(slot0.entityMO.modelId) and slot4 or tonumber(slot0.entityMO.uid) < 0 or slot3 then
				slot6 = HeroMo.New()

				slot6:initFromConfig(slot4)

				slot6.level = slot0.entityMO.level
				slot6.skin = slot0.entityMO.skin
			end

			if slot6 then
				slot8 = nil

				if HeroGroupBalanceHelper.getHeroBalanceLv(slot6.heroId) and slot6.level < slot7 and not slot3 then
					slot8 = true

					for slot12 = 1, 3 do
						SLFramework.UGUI.GuiHelper.SetColor(slot0._rankGOs[slot12], "#547a99")
					end
				else
					for slot12 = 1, 3 do
						SLFramework.UGUI.GuiHelper.SetColor(slot0._rankGOs[slot12], "#342929")
					end
				end

				slot10, slot11 = HeroConfig.instance:getShowLevel(slot8 and slot7 or (slot0.entityMO and slot0.entityMO.level or slot6.level))
				slot0._txtLv.text = (slot8 and "<color=#547a99>" or "") .. string.format("<size=20>Lv.</size>%d", slot10)

				gohelper.setActive(slot0._gorankobj, slot11 > 1)

				for slot15 = 1, 3 do
					gohelper.setActive(slot0._rankGOs[slot15], slot11 > 1 and slot15 == slot11 - 1 or false)
				end

				slot0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot0.entityMO and slot0.entityMO.skin or slot6.skin).retangleIcon))
				UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot6.config.career))
				UISpriteSetMgr.instance:setCommonSprite(slot0._rare, "bgequip" .. CharacterEnum.Star[slot6.config.rare])
			end
		end
	end

	slot0._txtHarm.text = slot1.harm
	slot0._txtHurt.text = slot1.hurt
	slot0._txtHeal.text = slot1.heal
	slot6 = FightStatModel.instance:getTotalHurt()
	slot7 = FightStatModel.instance:getTotalHeal()
	slot0._txtHarmRate.text = string.format("%.2f%%", (FightStatModel.instance:getTotalHarm() > 0 and slot1.harm / slot5 or 0) * 100)
	slot0._txtHurtRate.text = string.format("%.2f%%", (slot6 > 0 and slot1.hurt / slot6 or 0) * 100)
	slot0._txtHealRate.text = string.format("%.2f%%", (slot7 > 0 and slot1.heal / slot7 or 0) * 100)

	if not slot0._tweenHarm then
		slot0._tweenHarm = ZProj.TweenHelper.DOFillAmount(slot0._imgProgressHarm, slot8, slot8 * 2)
		slot0._tweenHurt = ZProj.TweenHelper.DOFillAmount(slot0._imgProgressHurt, slot9, slot9 * 2)
		slot0._tweenHeal = ZProj.TweenHelper.DOFillAmount(slot0._imgProgressHeal, slot10, slot10 * 2)
	else
		slot0._imgProgressHarm.fillAmount = slot8
		slot0._imgProgressHurt.fillAmount = slot9
		slot0._imgProgressHeal.fillAmount = slot10
	end

	slot0:_refreshInfoUI(slot0._statType)
end

function slot0._refreshInfoUI(slot0, slot1)
	if slot0._view.viewContainer.fightStatView:getStatType() and slot3 ~= slot1 then
		slot2 = slot3
	end

	slot0._scrollUseSkill.parentGameObject = slot0._view._csListScroll.gameObject
	slot0._statType = slot2 or slot0._statType

	gohelper.setActive(slot0._godata, slot2 == FightEnum.FightStatType.DataView)
	gohelper.setActive(slot0._goskill, slot2 == FightEnum.FightStatType.SkillView)
	gohelper.setActive(slot0._goscrolluseskill, GameUtil.getTabLen(slot0._mo.cards) > 0)
	gohelper.setActive(slot0._goskillempty, GameUtil.getTabLen(slot0._mo.cards) == 0)

	slot5 = GameUtil.getTabLen(slot0._skillItems)

	if GameUtil.getTabLen(slot0._mo.cards) > 0 and slot2 == FightEnum.FightStatType.SkillView then
		slot0:_sortCard()

		for slot9, slot10 in ipairs(slot0._mo.cards) do
			if not slot0._skillItems[slot9] then
				slot11 = slot0:getUserDataTb_()
				slot15 = "skillitem" .. slot9
				slot11.go = gohelper.clone(slot0._goskillItem, slot0._goskillContent, slot15)
				slot11.skillIconGo = slot0:getUserDataTb_()

				for slot15 = 1, 4 do
					slot16 = gohelper.findChild(slot11.go, "skillicon" .. slot15)
					slot17 = slot0:getUserDataTb_()
					slot17.go = slot16
					slot17.imgIcon = gohelper.findChildSingleImage(slot16, "imgIcon")
					slot17.tag = gohelper.findChildSingleImage(slot16, "tag/tagIcon")
					slot17.count = gohelper.findChildText(slot16, "count/txt_count")
					slot17.goStar = gohelper.findChildText(slot16, "star")
					slot11.skillIconGo[slot15] = slot17
				end

				table.insert(slot0._skillItems, slot11)
			end

			for slot15, slot16 in ipairs(slot11.skillIconGo) do
				slot16.isUniqueSkill = slot0.entityMO:isUniqueSkill(slot10.skillId)

				gohelper.setActive(slot16.goStar, true)
			end

			gohelper.setActive(slot11.go, true)
			slot0:_setSkillCardInfo(slot11, slot10)
		end
	end

	if slot4 < slot5 then
		for slot9 = slot4 + 1, slot5 do
			gohelper.setActive(slot0._skillItems[slot9] and slot10.go, false)
		end
	end
end

function slot0._sortCard(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._mo.cards) do
		for slot10, slot11 in ipairs(slot0.entityMO.skillGroup1) do
			if slot11 == slot6.skillId then
				slot1[slot11] = 1
			end
		end

		for slot10, slot11 in ipairs(slot0.entityMO.skillGroup2) do
			if slot11 == slot6.skillId then
				slot1[slot11] = 2
			end
		end

		if slot0.entityMO:isUniqueSkill(slot6.skillId) then
			slot1[slot6.skillId] = 0
		end
	end

	table.sort(slot0._mo.cards, function (slot0, slot1)
		if uv0[slot0.skillId] ~= uv0[slot1.skillId] then
			slot3 = uv0[slot1.skillId]

			if uv0[slot0.skillId] and slot3 then
				return slot2 < slot3
			else
				return slot2 and true or false
			end
		else
			return uv1.entityMO:getSkillLv(slot0.skillId) < uv1.entityMO:getSkillLv(slot1.skillId)
		end

		return false
	end)
end

function slot0._setSkillCardInfo(slot0, slot1, slot2)
	if FightHelper.isASFDSkill(slot2.skillId) then
		return slot0:refreshASFDSkill(slot1, slot2)
	end

	slot3 = slot0.entityMO:getSkillLv(slot2.skillId)
	slot4 = lua_skill.configDict[slot2.skillId]

	for slot8, slot9 in ipairs(slot1.skillIconGo) do
		gohelper.setActive(slot9.go, slot8 == slot3)

		if slot8 == slot3 then
			slot9.imgIcon:LoadImage(ResUrl.getSkillIcon(slot4.icon))

			if not slot9.isUniqueSkill then
				slot9.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot4.showTag))
			end

			slot9.count.text = slot2.useCount

			gohelper.setActive(slot1.goStar, false)
		end
	end
end

function slot0.refreshASFDSkill(slot0, slot1, slot2)
	slot3 = 1

	for slot7, slot8 in ipairs(slot1.skillIconGo) do
		gohelper.setActive(slot8.go, slot7 == slot3)

		if slot7 == slot3 then
			slot8.imgIcon:LoadImage(ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon))
			slot8.tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

			slot8.count.text = slot2.useCount
		end
	end
end

function slot0.refreshAssistBossInfo(slot0)
	if not TowerConfig.instance:getAssistBossConfig(slot0.entityMO.modelId) then
		return
	end

	slot0._txtName.text = slot1.name
	slot4, slot5 = HeroConfig.instance:getShowLevel(TowerModel.instance:getFightFinishParam() and slot2.teamLevel or 0)
	slot0._txtLv.text = string.format("<size=20>LV.</size>%d", slot4)

	gohelper.setActive(slot0._gorankobj, slot5 > 1)

	for slot9 = 1, 3 do
		gohelper.setActive(slot0._rankGOs[slot9], slot5 > 1 and slot9 == slot5 - 1 or false)
	end

	slot0._heroIcon:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(slot1.skinId).headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot1.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._rare, "bgequip" .. 6)
end

function slot0.refreshASFDInfo(slot0)
	slot0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightASFDConfig.instance.headIcon))

	slot0._txtName.text = FightASFDConfig.instance:getSkillCo().name

	gohelper.setActive(slot0.goLayout, false)
	gohelper.setActive(slot0.goRare, false)
	gohelper.setActive(slot0.goCareer, false)
end

function slot0.onDestroy(slot0)
	if slot0._tweenHarm then
		ZProj.TweenHelper.KillById(slot0._tweenHarm)
		ZProj.TweenHelper.KillById(slot0._tweenHurt)
		ZProj.TweenHelper.KillById(slot0._tweenHeal)
	end

	slot0._tweenHarm = nil
	slot0._tweenHurt = nil
	slot0._tweenHeal = nil

	for slot4, slot5 in pairs(slot0._skillItems) do
		if slot5 then
			for slot9, slot10 in pairs(slot5.skillIconGo) do
				slot10.imgIcon:UnLoadImage()

				if not slot10.isUniqueSkill then
					slot10.tag:UnLoadImage()
				end
			end
		end
	end

	slot0._heroIcon:UnLoadImage()
end

function slot0.refreshAct174Info(slot0)
	gohelper.setActive(slot0._txtLv.gameObject.transform.parent, false)
	recthelper.setAnchorY(slot0._txtName.gameObject.transform, 0)

	if slot0.entityMO.modelId then
		slot2 = Activity174Config.instance:getRoleCoByHeroId(slot1)

		UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot2.career))
		UISpriteSetMgr.instance:setCommonSprite(slot0._rare, "bgequip" .. CharacterEnum.Color[slot2.rare])
		slot0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot2.skinId))

		slot0._txtName.text = slot2.name
	end
end

return slot0
