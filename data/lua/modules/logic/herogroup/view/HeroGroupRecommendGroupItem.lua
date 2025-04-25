module("modules.logic.herogroup.view.HeroGroupRecommendGroupItem", package.seeall)

slot0 = class("HeroGroupRecommendGroupItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._txtrank = gohelper.findChildText(slot1, "#go_info/rankhead/#txt_rank")
	slot0._txtnum = gohelper.findChildText(slot1, "#go_info/#txt_num")
	slot0._txtherogrouprate = gohelper.findChildText(slot1, "#go_info/#txt_herogrouprate")
	slot0._goheroitem = gohelper.findChild(slot1, "#go_info/herogrouplist/#go_heroitem")
	slot0._simagecloth = gohelper.findChildSingleImage(slot1, "#go_info/#simage_cloth")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot1, "#go_info/#btn_use")
	slot0._goinfo = gohelper.findChild(slot1, "#go_info")
	slot0._gonull = gohelper.findChild(slot1, "#go_null")
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagebg = gohelper.findChildSingleImage(slot1, "#simage_bg")
	slot0._gobossItem = gohelper.findChild(slot1, "#go_info/#go_bossitem")
	slot0._gobossEmpty = gohelper.findChild(slot1, "#go_info/#go_bossitem/go_empty")
	slot0._gobossContainer = gohelper.findChild(slot1, "#go_info/#go_bossitem/go_container")
	slot0._simageBossIcon = gohelper.findChildSingleImage(slot1, "#go_info/#go_bossitem/go_container/simage_bossicon")
	slot0._imageBossCareer = gohelper.findChildImage(slot1, "#go_info/#go_bossitem/go_container/image_career")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnuse:RemoveClickListener()
end

function slot0._btnuseOnClick(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroup)

	slot1 = slot0._mo.heroDataList
	slot2 = {}
	slot5 = {}

	if not string.nilorempty(lua_battle.configDict[HeroGroupModel.instance.battleId].aid) then
		slot5 = string.splitToNumber(slot4.aid, "#")
	end

	slot6 = {}

	if not string.nilorempty(slot4.trialHeros) then
		slot6 = GameUtil.splitString2(slot4.trialHeros, true)
	end

	slot7 = {
		[lua_hero_trial.configDict[slot12[1]][slot12[2]].heroId] = true
	}

	for slot11, slot12 in pairs(slot6) do
		if slot12[3] then
			-- Nothing
		end
	end

	for slot11 = 1, #slot1 do
		if slot1[slot11].heroId and slot12 > 0 then
			slot13 = HeroModel.instance:getByHeroId(slot12)

			if HeroGroupModel.instance:isAdventureOrWeekWalk() then
				if WeekWalkModel.instance:getCurMapHeroCd(slot12) > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					slot13 = nil
				end
			elseif slot13 and HeroGroupModel.instance:isRestrict(slot13.uid) then
				if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot14.restrictReason) then
					ToastController.instance:showToastWithString(slot15)
				end

				slot13 = nil
			end

			if slot7[slot12] then
				slot13 = nil
			end

			if slot13 then
				table.insert(slot2, slot13.uid)
			else
				table.insert(slot2, "0")
			end
		else
			table.insert(slot2, "0")
		end
	end

	slot8 = HeroGroupModel.instance:getCurGroupMO()
	slot9 = 0

	if slot0._mo.cloth and slot0._mo.cloth ~= 0 and PlayerClothModel.instance:canUse(slot0._mo.cloth) then
		slot9 = slot0._mo.cloth
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		for slot14, slot15 in ipairs(PlayerClothModel.instance:getList()) do
			if PlayerClothModel.instance:hasCloth(slot15.id) then
				slot9 = slot15.id

				break
			end
		end
	end

	slot10 = {
		groupId = slot8.id,
		name = slot8.name,
		clothId = slot9,
		heroList = slot2
	}

	if TowerModel.instance:isInTowerBattle() then
		slot0:onTowerUse(slot10, slot8, slot5, slot4.roleNum, slot4.playerMax, true, slot6)

		return
	end

	slot8:initWithBattle(slot10, slot5, slot4.roleNum, slot4.playerMax, true, slot6)
	HeroSingleGroupModel.instance:setSingleGroup(slot8, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function slot0.onTowerUse(slot0, slot1, slot2, ...)
	if TowerModel.instance:getRecordFightParam() and slot3.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	if slot0._mo.assistBossId and slot4 > 0 and slot3 and not slot3.isHeroGroupLock and not TowerModel.instance:isBossBan(slot4) and not TowerModel.instance:isLimitTowerBossBan(slot3.towerType, slot3.towerId, slot4) and TowerAssistBossModel.instance:getById(slot4) and TowerController.instance:isBossTowerOpen() then
		slot1.assistBossId = slot4
	end

	for slot8, slot9 in ipairs(slot1.heroList) do
		if HeroModel.instance:getById(slot9) and TowerModel.instance:isHeroBan(slot10.heroId) then
			slot1.heroList[slot8] = tostring(0)
		end
	end

	slot2:initWithBattle(slot1, ...)
	HeroSingleGroupModel.instance:setSingleGroup(slot2, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goheroitem, false)

	slot0._heroItemList = {}

	slot0._simagebg:LoadImage(ResUrl.getHeroGroupBg("biandui_youdi"))

	slot0._imagebg = slot0._simagebg:GetComponent(gohelper.Type_Image)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._gonull, slot0._mo.isEmpty)
	gohelper.setActive(slot0._goinfo, not slot0._mo.isEmpty)
	ZProj.UGUIHelper.SetColorAlpha(slot0._imagebg, slot0._mo.isEmpty and 0.5 or 1)

	if slot0._mo.isEmpty then
		return
	end

	slot0._txtrank.text = string.format("%d", slot0._index)
	slot0._txtherogrouprate.text = string.format("%s%%", math.floor(slot0._mo.rate * 10000) / 100)
	slot2 = slot0._mo.cloth and slot0._mo.cloth ~= 0 and lua_cloth.configDict[slot0._mo.cloth]

	gohelper.setActive(slot0._simagecloth.gameObject, slot2)

	if slot2 then
		slot0._simagecloth:LoadImage(ResUrl.getPlayerClothIcon(slot2.icon))
	end

	slot0:_refreshHeroItem()

	slot0._txtnum.text = GameUtil.getEnglishOrderNumber(slot0._index)

	slot0:refreshTowerBossUI()
end

function slot0._refreshHeroItem(slot0)
	for slot5 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot6 = slot0._mo.heroDataList[slot5]

		if not slot0._heroItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goheroitem, "item" .. slot5)
			slot7.gocontainer = gohelper.findChild(slot7.go, "go_container")
			slot7.simageheroicon = gohelper.findChildSingleImage(slot7.go, "go_container/simage_heroicon")
			slot7.imagecareer = gohelper.findChildImage(slot7.go, "go_container/image_career")
			slot7.goaidtag = gohelper.findChild(slot7.go, "go_container/go_aidtag")
			slot7.gostorytag = gohelper.findChild(slot7.go, "go_container/go_storytag")
			slot7.imageinsight = gohelper.findChildImage(slot7.go, "go_container/level/layout/image_insight")
			slot7.txtlevel = gohelper.findChildText(slot7.go, "go_container/level/layout/txt_level")
			slot7.goempty = gohelper.findChild(slot7.go, "go_empty")

			table.insert(slot0._heroItemList, slot7)
		end

		gohelper.setActive(slot7.gocontainer, slot6)
		gohelper.setActive(slot7.goempty, not slot6)

		if slot6 then
			gohelper.setActive(slot7.gostorytag, false)
			gohelper.setActive(slot7.goaidtag, false)

			slot8 = slot6.heroId
			slot9, slot10 = HeroConfig.instance:getShowLevel(slot1[slot5].level)
			slot7.txtlevel.text = slot0:getShowLevelText(slot9)

			if slot10 > 1 then
				UISpriteSetMgr.instance:setHeroGroupSprite(slot7.imageinsight, "biandui_dongxi_" .. tostring(slot10 - 1))
				gohelper.setActive(slot7.imageinsight.gameObject, true)
			else
				gohelper.setActive(slot7.imageinsight.gameObject, false)
			end

			slot11 = HeroConfig.instance:getHeroCO(slot8)

			slot7.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot11.skinId).headIcon))
			UISpriteSetMgr.instance:setCommonSprite(slot7.imagecareer, "lssx_" .. tostring(slot11.career))

			slot13 = HeroModel.instance:getByHeroId(slot8)

			ZProj.UGUIHelper.SetGrayscale(slot7.simageheroicon.gameObject, not slot13)
			ZProj.UGUIHelper.SetGrayscale(slot7.imagecareer.gameObject, not slot13)
		end

		gohelper.setActive(slot7.go, true)
	end
end

function slot0.refreshTowerBossUI(slot0)
	slot1 = slot0._mo.cloth and slot0._mo.cloth ~= 0 and lua_cloth.configDict[slot0._mo.cloth]
	slot2 = slot1 ~= nil
	slot3 = TowerModel.instance:isInTowerBattle()
	slot5 = slot0._mo.assistBossId and slot4 > 0

	gohelper.setActive(slot0._simagecloth.gameObject, slot1 and not slot3)
	gohelper.setActive(slot0._gobossItem, slot3)
	gohelper.setActive(slot0._gobossEmpty, slot3 and not slot5)
	gohelper.setActive(slot0._gobossContainer, slot3 and slot5)

	if slot3 and slot5 then
		slot6 = TowerConfig.instance:getAssistBossConfig(slot4)

		UISpriteSetMgr.instance:setCommonSprite(slot0._imageBossCareer, string.format("lssx_%s", slot6.career))
		slot0._simageBossIcon:LoadImage(ResUrl.monsterHeadIcon(FightConfig.instance:getSkinCO(slot6.skinId) and slot7.headIcon))
	end
end

function slot0.getShowLevelText(slot0, slot1)
	return "<size=12>Lv.</size>" .. tostring(slot1)
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onDestroy(slot0)
	slot0._simagecloth:UnLoadImage()
	slot0._simagebg:UnLoadImage()
	slot0._simageBossIcon:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._heroItemList) do
		slot5.simageheroicon:UnLoadImage()
	end
end

return slot0
