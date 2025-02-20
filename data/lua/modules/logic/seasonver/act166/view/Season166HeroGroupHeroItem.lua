module("modules.logic.seasonver.act166.view.Season166HeroGroupHeroItem", package.seeall)

slot0 = class("Season166HeroGroupHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._heroGroupListView = slot1
end

slot0.EquipTweenDuration = 0.16
slot0.EquipDragOffset = Vector2(0, 150)
slot0.EquipDragMobileScale = 1.7
slot0.EquipDragOtherScale = 1.4
slot0.PressColor = GameUtil.parseColor("#C8C8C8")

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._noneGO = gohelper.findChild(slot1, "heroitemani/none")
	slot0._addGO = gohelper.findChild(slot1, "heroitemani/none/add")
	slot0._lockGO = gohelper.findChild(slot1, "heroitemani/none/lock")
	slot0._heroGO = gohelper.findChild(slot1, "heroitemani/hero")
	slot0._tagTr = gohelper.findChildComponent(slot1, "heroitemani/tags", typeof(UnityEngine.Transform))
	slot0._subGO = gohelper.findChild(slot1, "heroitemani/tags/aidtag")
	slot0._aidGO = gohelper.findChild(slot1, "heroitemani/tags/storytag")
	slot0._trialTagGO = gohelper.findChild(slot1, "heroitemani/tags/trialtag")
	slot0._trialTagTxt = gohelper.findChildTextMesh(slot1, "heroitemani/tags/trialtag/#txt_trial_tag")
	slot0._clickGO = gohelper.findChild(slot1, "heroitemani/click")
	slot0._clickThis = gohelper.getClick(slot0._clickGO)
	slot0._equipGO = gohelper.findChild(slot1, "heroitemani/equip")
	slot0._clickEquip = gohelper.getClick(slot0._equipGO)
	slot0._charactericon = gohelper.findChild(slot1, "heroitemani/hero/charactericon")
	slot0._careericon = gohelper.findChildImage(slot1, "heroitemani/hero/career")
	slot0._goblackmask = gohelper.findChild(slot1, "heroitemani/hero/blackmask")
	slot0.level_part = gohelper.findChild(slot1, "heroitemani/hero/vertical/layout")
	slot0._lvnum = gohelper.findChildText(slot1, "heroitemani/hero/vertical/layout/lv/lvnum")
	slot5 = "heroitemani/hero/vertical/layout/lv/lvnum/lv"
	slot0._lvnumen = gohelper.findChildText(slot1, slot5)
	slot0._goRankList = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		table.insert(slot0._goRankList, gohelper.findChildImage(slot1, "heroitemani/hero/vertical/layout/rankobj/rank" .. slot5))
	end

	slot0._goStarList = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		table.insert(slot0._goStarList, gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList/star" .. slot5))
	end

	slot0._goStars = gohelper.findChild(slot1, "heroitemani/hero/vertical/#go_starList")
	slot0._fakeEquipGO = gohelper.findChild(slot1, "heroitemani/hero/vertical/fakeequip")
	slot0._dragFrameGO = gohelper.findChild(slot1, "heroitemani/selectedeffect")
	slot0._dragFrameSelectGO = gohelper.findChild(slot1, "heroitemani/selectedeffect/xuanzhong")
	slot0._dragFrameCompleteGO = gohelper.findChild(slot1, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(slot0._dragFrameGO, false)

	slot0._emptyEquipGo = gohelper.findChild(slot1, "heroitemani/emptyequip")
	slot0._animGO = gohelper.findChild(slot1, "heroitemani")
	slot0.anim = slot0._animGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._replayReady = gohelper.findChild(slot1, "heroitemani/hero/replayready")
	slot0._gorecommended = gohelper.findChild(slot1, "heroitemani/hero/#go_recommended")
	slot0._gocounter = gohelper.findChild(slot1, "heroitemani/hero/#go_counter")
	slot0._herocardGo = gohelper.findChild(slot1, "heroitemani/roleequip")
	slot0._leftDrop = gohelper.findChildDropdown(slot1, "heroitemani/roleequip/left")
	slot0._rightDrop = gohelper.findChildDropdown(slot1, "heroitemani/roleequip/right")
	slot0._imageAdd = gohelper.findChildImage(slot1, "heroitemani/none/add")
	slot0._commonHeroCard = CommonHeroCard.create(slot0._charactericon, slot0._heroGroupListView.viewName)
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.setParent(slot0, slot1)
	slot0.currentParent = slot1

	slot0._subGO.transform:SetParent(slot1, true)
	slot0._equipGO.transform:SetParent(slot1, true)
end

function slot0.flowOriginParent(slot0)
	slot0._equipGO.transform:SetParent(slot0._animGO.transform, false)
end

function slot0.flowCurrentParent(slot0)
	slot0._equipGO.transform:SetParent(slot0.currentParent, false)
end

function slot0.initEquips(slot0, slot1)
	slot0._equipType = -1

	if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not slot0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(slot0._equipGO, false)
		gohelper.setActive(slot0._fakeEquipGO, false)
		gohelper.setActive(slot0._emptyEquipGo, false)
	else
		gohelper.setActive(slot0._equipGO, true)
		gohelper.setActive(slot0._fakeEquipGO, true)
		gohelper.setActive(slot0._emptyEquipGo, true)

		if not slot0._equip then
			slot0._equip = slot0:getUserDataTb_()
			slot0._equip.moveContainer = gohelper.findChild(slot0._equipGO, "moveContainer")
			slot0._equip.equipIcon = gohelper.findChildImage(slot0._equipGO, "moveContainer/equipIcon")
			slot0._equip.equipRare = gohelper.findChildImage(slot0._equipGO, "moveContainer/equiprare")
			slot0._equip.equiptxten = gohelper.findChildText(slot0._equipGO, "equiptxten")
			slot0._equip.equiptxtlv = gohelper.findChildText(slot0._equipGO, "moveContainer/equiplv/txtequiplv")
			slot0._equip.equipGolv = gohelper.findChild(slot0._equipGO, "moveContainer/equiplv")

			slot0:_equipIconAddDrag(slot0._equip.moveContainer, slot0._equip.equipIcon)
		end

		slot0._equipMO = EquipModel.instance:getEquip(Season166HeroGroupModel.instance:getCurGroupMO():getPosEquips(slot0.mo.id - 1).equipUid[1]) or HeroGroupTrialModel.instance:getEquipMo(slot4)
		slot5 = nil

		if slot0.trialCO and slot0.trialCO.equipId > 0 then
			slot5 = EquipConfig.instance:getEquipCo(slot0.trialCO.equipId)
		end

		if slot0._equipMO then
			slot0._equipType = slot0._equipMO.config.rare - 2
		elseif slot5 then
			slot0._equipType = slot5.rare - 2
		end

		gohelper.setActive(slot0._equip.equipIcon.gameObject, slot0._equipMO or slot5)
		gohelper.setActive(slot0._equip.equipRare.gameObject, slot0._equipMO or slot5)
		gohelper.setActive(slot0._equip.equipAddGO, not slot0._equipMO and not slot5)
		gohelper.setActive(slot0._equip.equipGolv, slot0._equipMO or slot5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._equip.equiptxten, (slot0._equipMO or slot5) and 0.15 or 0.06)

		if slot0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._equip.equipIcon, slot0._equipMO.config.icon)

			slot6, slot7, slot8 = HeroGroupBalanceHelper.getBalanceLv()

			if slot8 and slot0._equipMO.level < slot8 and slot0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				slot0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. slot8
			else
				slot0._equip.equiptxtlv.text = "LV." .. slot0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(slot0._equip.equipRare, "bianduixingxian_" .. slot0._equipMO.config.rare)
			slot0:_showEquipParticleEffect(slot1)
		elseif slot5 then
			slot6 = EquipConfig.instance:getEquipCo(slot0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._equip.equipIcon, slot6.icon)

			slot0._equip.equiptxtlv.text = "LV." .. slot0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(slot0._equip.equipRare, "bianduixingxian_" .. slot6.rare)
			slot0:_showEquipParticleEffect(slot1)
		end
	end

	slot0.last_equip = slot0._equipMO and slot0._equipMO.uid
	slot0.last_hero = slot0._heroMO and slot0._heroMO.heroId or 0
end

function slot0._showEquipParticleEffect(slot0, slot1)
	if slot1 == slot0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function slot0._equipIconAddDrag(slot0, slot1, slot2)
	slot2:GetComponent(gohelper.Type_Image).raycastTarget = true
	slot4 = uv0.EquipDragOtherScale
	slot5 = nil

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot5 = uv0.EquipDragOffset
		slot4 = uv0.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(slot1, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkDrag, slot0, slot1.transform, nil, slot5, slot4)
end

function slot0._checkDrag(slot0)
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	if slot0.trialCO and slot0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function slot0._onBeginDrag(slot0)
	gohelper.setAsLastSibling(slot0._heroGroupListView.heroPosTrList[slot0.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(slot0._equip.equipGolv, false)
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot3 = slot2.position + uv0.EquipDragOffset
	end

	slot0:_setEquipDragEnabled(false)

	slot5 = slot0:_moveToTarget(slot3) and slot4.trialCO and slot4.trialCO.equipId > 0

	if not slot4 or slot4 == slot0 or slot4.mo.aid or slot5 or not slot4._equipGO.activeSelf then
		if slot5 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		slot0:_setToPos(slot0._equip.moveContainer.transform, Vector2(), true, function ()
			gohelper.setActive(uv0._equip.equipGolv, true)
			uv0:_setEquipDragEnabled(true)
		end, slot0)
		slot0:_showEquipParticleEffect()

		return
	end

	slot0:_playDragEndAudio(slot4)
	gohelper.setAsLastSibling(slot0._heroGroupListView.heroPosTrList[slot4.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(slot0._heroGroupListView.heroPosTrList[slot0.mo.id].parent.gameObject)

	slot0._tweenId = slot0:_setToPos(slot4._equip.moveContainer.transform, recthelper.rectToRelativeAnchorPos(slot0._equipGO.transform.position, slot4._equipGO.transform), true)

	slot0:_setToPos(slot0._equip.moveContainer.transform, recthelper.rectToRelativeAnchorPos(slot4._equipGO.transform.position, slot0._equipGO.transform), true, function ()
		EquipTeamListModel.instance:openTeamEquip(uv0.mo.id - 1, uv0._heroMO, Season166HeroGroupModel.instance:getCurGroupMO())

		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		uv0:_setToPos(uv0._equip.moveContainer.transform, Vector2())
		uv0:_setToPos(uv1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(uv0._equip.equipGolv, true)
		uv0:_setEquipDragEnabled(true)

		slot2 = uv1.mo.id - 1

		if (EquipModel.instance:getEquip(EquipTeamListModel.instance:getTeamEquip(uv0.mo.id - 1)[1]) or HeroGroupTrialModel.instance:getEquipMo(slot3)) and slot3 or nil then
			EquipTeamShowItem.removeEquip(slot1, true)
		end

		if (EquipModel.instance:getEquip(EquipTeamListModel.instance:getTeamEquip(slot2)[1]) or HeroGroupTrialModel.instance:getEquipMo(slot4)) and slot4 or nil then
			EquipTeamShowItem.removeEquip(slot2, true)
		end

		if slot3 then
			EquipTeamShowItem.replaceEquip(slot2, slot3, true)
		end

		if slot4 then
			EquipTeamShowItem.replaceEquip(slot1, slot4, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		Season166HeroGroupModel.instance:saveCurGroupData()
	end, slot0)
end

function slot0.resetEquipPos(slot0)
	if not slot0._equip then
		return
	end

	slot1 = slot0._equip.moveContainer.transform

	recthelper.setAnchor(slot1, 0, 0)
	transformhelper.setLocalScale(slot1, 1, 1, 1)
end

function slot0._playDragEndAudio(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function slot0._setToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = recthelper.getAnchor(slot1)

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0._moveToTarget(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._heroGroupListView.heroPosTrList) do
		if slot0._heroGroupListView._heroItemList[slot5] ~= slot0 then
			slot7 = slot6.parent

			if math.abs(recthelper.screenPosToAnchorPos(slot1, slot7).x) * 2 < recthelper.getWidth(slot7) and math.abs(slot8.y) * 2 < recthelper.getHeight(slot7) then
				return not slot0._heroGroupListView._heroItemList[slot5]:selfIsLock() and slot9 or nil
			end
		end
	end

	return nil
end

function slot0._setEquipDragEnabled(slot0, slot1)
	CommonDragHelper.instance:setGlobalEnabled(slot1)
end

function slot0.addEventListeners(slot0)
	slot0._clickThis:AddClickListener(slot0._onClickThis, slot0)
	slot0._clickThis:AddClickDownListener(slot0._onClickThisDown, slot0)
	slot0._clickThis:AddClickUpListener(slot0._onClickThisUp, slot0)
	slot0._clickEquip:AddClickListener(slot0._onClickEquip, slot0)
	slot0._clickEquip:AddClickDownListener(slot0._onClickEquipDown, slot0)
	slot0._clickEquip:AddClickUpListener(slot0._onClickEquipUp, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, slot0.setHeroGroupEquipEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, slot0.playHeroGroupHeroEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, slot0.initEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0.initEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, slot0.initEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, slot0.initEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, slot0.initEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.initEquips, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickThis:RemoveClickListener()
	slot0._clickThis:RemoveClickUpListener()
	slot0._clickThis:RemoveClickDownListener()
	slot0._clickEquip:RemoveClickListener()
	slot0._clickEquip:RemoveClickUpListener()
	slot0._clickEquip:RemoveClickDownListener()
end

function slot0.playHeroGroupHeroEffect(slot0, slot1)
	slot0:playAnim(slot1)

	slot0.last_equip = nil
	slot0.last_hero = nil
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._commonHeroCard:setGrayScale(false)

	slot3 = Season166HeroGroupModel.instance.battleId and lua_battle.configDict[slot2]
	slot0.mo = slot1
	slot0._posIndex = slot0.mo.id - 1
	slot0._heroMO = slot1:getHeroMO()
	slot0.monsterCO = not slot1.isAssist and slot1:getMonsterCO()
	slot0.trialCO = not slot1.isAssist and slot1:getTrialCO()

	gohelper.setActive(slot0._replayReady, Season166HeroGroupModel.instance:getCurGroupMO().isReplay)

	slot4 = nil

	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		slot4 = Season166HeroGroupModel.instance:getCurGroupMO().replay_hero_data[slot0.mo.heroUid]
	end

	slot8 = "#E9E9E9"

	SLFramework.UGUI.GuiHelper.SetColor(slot0._lvnumen, slot8)

	for slot8 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(slot0._goRankList[slot8], "#F6F3EC")
	end

	if slot0._heroMO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot4 and slot4.skin or (slot0.mo.isAssist and slot0._heroMO or HeroModel.instance:getByHeroId(slot0._heroMO.heroId)).skin))

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

		slot15 = true

		gohelper.setActive(slot0._goStars, slot15)

		for slot15 = 1, 6 do
			gohelper.setActive(slot0._goStarList[slot15], slot15 <= CharacterEnum.Star[slot0._heroMO.config.rare])
		end
	elseif slot0.monsterCO then
		slot0._commonHeroCard:onUpdateMO(FightConfig.instance:getSkinCO(slot0.monsterCO.skinId))

		slot11 = tostring(slot0.monsterCO.career)

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. slot11)

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

		slot12 = tostring(slot5.career)

		UISpriteSetMgr.instance:setCommonSprite(slot0._careericon, "lssx_" .. slot12)

		slot0._lvnum.text, slot8 = HeroConfig.instance:getShowLevel(slot0.trialCO.level)

		for slot12 = 1, 3 do
			gohelper.setActive(slot0._goRankList[slot12], slot12 == slot8 - 1)
		end

		slot12 = true

		gohelper.setActive(slot0._goStars, slot12)

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

	slot0.isLock = not Season166HeroGroupModel.instance:isPositionOpen(slot0.mo.id)
	slot0.isAidLock = slot0.isTeachItem and not slot0.mo.trial
	slot0.isAid = not slot0.mo.trial and slot0.isTeachItem
	slot0.isTrialLock = (slot0.mo.trial and slot0.mo.trialPos) ~= nil
	slot0.roleNum = Season166HeroGroupModel.instance:getBattleRoleNum()
	slot0.isRoleNumLock = slot0.roleNum and slot0.roleNum < slot0.mo.id
	slot0.isEmpty = slot1:isEmpty()

	gohelper.setActive(slot0._heroGO, (slot0._heroMO ~= nil or slot0.monsterCO ~= nil or slot0.trialCO ~= nil) and not slot0.isLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._noneGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil or slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._addGO, slot0._heroMO == nil and slot0.monsterCO == nil and slot0.trialCO == nil and not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._lockGO, slot0:selfIsLock())
	gohelper.setActive(slot0._aidGO, slot0.mo.trial and slot0.isTeachItem)
	gohelper.setActive(slot0._subGO, false)
	transformhelper.setLocalPosXY(slot0._tagTr, 36.3, slot0._subGO.activeSelf and 144.1 or 212.1)

	if (slot0.trialCO or slot0.mo.isAssist) and not slot0.isTeachItem then
		gohelper.setActive(slot0._trialTagGO, true)

		slot0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(slot0._trialTagGO, false)
	end

	if not Season166HeroSingleGroupModel.instance:isTemp() and slot0.isRoleNumLock and slot0._heroMO ~= nil and slot0.monsterCO == nil then
		Season166HeroSingleGroupModel.instance:remove(slot0._heroMO.id)
	end

	slot0:initEquips()
	slot0:showCounterSign()

	if slot0._playDeathAnim then
		slot0._playDeathAnim = nil

		slot0:playAnim(UIAnimationName.Open)
	end
end

function slot0.selfIsLock(slot0)
	return slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock
end

function slot0.setIsTeachItem(slot0, slot1)
	slot0.isTeachItem = slot1
end

function slot0.playRestrictAnimation(slot0, slot1)
	if slot0._heroMO and slot1[slot0._heroMO.uid] then
		slot0._playDeathAnim = true

		slot0:playAnim("herogroup_hero_deal")

		slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0.setGrayFactor, nil, slot0)
	end
end

function slot0.setGrayFactor(slot0, slot1)
	slot0._commonHeroCard:setGrayFactor(slot1)
end

function slot0.showCounterSign(slot0)
	slot1 = nil

	if slot0._heroMO then
		slot1 = lua_character.configDict[slot0._heroMO.heroId].career
	elseif slot0.trialCO then
		slot1 = HeroConfig.instance:getHeroCO(slot0.trialCO.heroId).career
	elseif slot0.monsterCO then
		slot1 = slot0.monsterCO.career
	end

	slot2, slot3 = FightHelper.detectAttributeCounter()

	gohelper.setActive(slot0._gorecommended, tabletool.indexOf(slot2, slot1))
	gohelper.setActive(slot0._gocounter, tabletool.indexOf(slot3, slot1))
end

function slot0._setUIPressState(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot4 = slot1:GetEnumerator()

	while slot4:MoveNext() do
		slot5 = nil

		if slot2 then
			(slot3 and slot3[slot4.Current] * 0.7 or uv0.PressColor).a = slot4.Current.color.a
		else
			slot5 = slot3 and slot3[slot4.Current] or Color.white
		end

		slot4.Current.color = slot5
	end
end

function slot0._onClickThis(slot0)
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if slot0.isTeachItem or slot0.isRoleNumLock then
		if not slot0.mo.trial or slot0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if slot0.isLock then
		logError(slot0.mo.id .. " is lock, check Error")
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, slot0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function slot0._onClickThisDown(slot0)
	slot0:_setHeroItemPressState(true)
end

function slot0._onClickThisUp(slot0)
	slot0:_setHeroItemPressState(false)
end

function slot0._setHeroItemPressState(slot0, slot1)
	if not slot0._heroItemContainer then
		slot0._heroItemContainer = slot0:getUserDataTb_()
		slot2 = slot0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._heroItemContainer.images = slot2
		slot0._heroItemContainer.tmps = slot0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
		slot0._heroItemContainer.compColor = {}
		slot4 = slot2:GetEnumerator()

		while slot4:MoveNext() do
			slot0._heroItemContainer.compColor[slot4.Current] = slot4.Current.color
		end

		slot4 = slot3:GetEnumerator()

		while slot4:MoveNext() do
			slot0._heroItemContainer.compColor[slot4.Current] = slot4.Current.color
		end
	end

	slot0._heroItemContainer.spines = slot0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	if slot0._heroItemContainer then
		slot0:_setUIPressState(slot0._heroItemContainer.images, slot1, slot0._heroItemContainer.compColor)
		slot0:_setUIPressState(slot0._heroItemContainer.tmps, slot1, slot0._heroItemContainer.compColor)
		slot0:_setUIPressState(slot0._heroItemContainer.spines, slot1)
	end

	if slot0._imageAdd then
		slot0._imageAdd.color = slot1 and uv0.PressColor or Color.white
	end
end

function slot0._onClickEquip(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or slot0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		slot0._viewParam = {
			heroGroupMo = Season166HeroGroupModel.instance:getCurGroupMO(),
			heroMo = slot0._heroMO,
			equipMo = slot0._equipMO,
			posIndex = slot0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView,
			maxHeroNum = slot0.roleNum
		}

		if slot0.trialCO then
			slot0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(slot0.trialCO.heroId)

			if slot0.trialCO.equipId > 0 then
				slot0._viewParam.equipMo = slot0._viewParam.heroMo.trialEquipMo
			end
		end

		slot0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function slot0._onClickEquipDown(slot0)
	slot0:_setEquipItemPressState(true)
end

function slot0._onClickEquipUp(slot0)
	slot0:_setEquipItemPressState(false)
end

function slot0._setEquipItemPressState(slot0, slot1)
	if not slot0._equipItemContainer then
		slot0._equipItemContainer = slot0:getUserDataTb_()
		slot0._equipEmtpyContainer = slot0:getUserDataTb_()
		slot2 = slot0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._equipItemContainer.images = slot2
		slot0._equipItemContainer.tmps = slot0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)
		slot0._equipItemContainer.compColor = {}
		slot0._equipEmtpyContainer.images = slot0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._equipEmtpyContainer.tmps = slot0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)
		slot0._equipEmtpyContainer.compColor = {}
		slot6 = slot2:GetEnumerator()

		while slot6:MoveNext() do
			slot0._equipItemContainer.compColor[slot6.Current] = slot6.Current.color
		end

		slot6 = slot3:GetEnumerator()

		while slot6:MoveNext() do
			slot0._equipItemContainer.compColor[slot6.Current] = slot6.Current.color
		end

		slot6 = slot4:GetEnumerator()

		while slot6:MoveNext() do
			slot0._equipEmtpyContainer.compColor[slot6.Current] = slot6.Current.color
		end

		slot6 = slot5:GetEnumerator()

		while slot6:MoveNext() do
			slot0._equipEmtpyContainer.compColor[slot6.Current] = slot6.Current.color
		end
	end

	if slot0._equipItemContainer then
		slot0:_setUIPressState(slot0._equipItemContainer.images, slot1, slot0._equipItemContainer.compColor)
		slot0:_setUIPressState(slot0._equipItemContainer.tmps, slot1, slot0._equipItemContainer.compColor)
	end

	if slot0._equipEmtpyContainer then
		slot0:_setUIPressState(slot0._equipEmtpyContainer.images, slot1, slot0._equipEmtpyContainer.compColor)
		slot0:_setUIPressState(slot0._equipEmtpyContainer.tmps, slot1, slot0._equipEmtpyContainer.compColor)
	end
end

function slot0._onOpenEquipTeamView(slot0)
	EquipController.instance:openEquipInfoTeamView(slot0._viewParam)
end

function slot0.onItemBeginDrag(slot0, slot1)
	if slot1 == slot0.mo.id then
		ZProj.TweenHelper.DOScale(slot0.go.transform, 1.1, 1.1, 1, 0.2, nil, , , EaseType.Linear)
		gohelper.setActive(slot0._dragFrameGO, true)
		gohelper.setActive(slot0._dragFrameSelectGO, true)
		gohelper.setActive(slot0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(slot0._clickGO, false)
end

function slot0.onItemEndDrag(slot0, slot1, slot2)
	ZProj.TweenHelper.DOScale(slot0.go.transform, 1, 1, 1, 0.2, nil, , , EaseType.Linear)
	slot0:_setHeroItemPressState(false)
end

function slot0.onItemCompleteDrag(slot0, slot1, slot2, slot3)
	if slot2 == slot0.mo.id and slot1 ~= slot2 then
		if slot3 then
			gohelper.setActive(slot0._dragFrameGO, true)
			gohelper.setActive(slot0._dragFrameSelectGO, false)
			gohelper.setActive(slot0._dragFrameCompleteGO, false)
			gohelper.setActive(slot0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(slot0.hideDragEffect, slot0)
			TaskDispatcher.runDelay(slot0.hideDragEffect, slot0, 0.833)
		end
	else
		gohelper.setActive(slot0._dragFrameGO, false)
	end

	gohelper.setActive(slot0._clickGO, true)
end

function slot0.hideDragEffect(slot0)
	gohelper.setActive(slot0._dragFrameGO, false)
end

function slot0.setHeroGroupEquipEffect(slot0, slot1)
	slot0._canPlayEffect = slot1
end

function slot0.getAnimStateLength(slot0, slot1)
	slot0.clipLengthDict = slot0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	if not slot0.clipLengthDict[slot1] then
		logError("not get animation state name :  " .. tostring(slot1))
	end

	return slot2 or 0
end

function slot0.playAnim(slot0, slot1)
	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, slot0:getAnimStateLength(slot1))
	slot0.anim:Play(slot1, 0, 0)
end

function slot0.onDestroy(slot0)
	if slot0._equip then
		CommonDragHelper.instance:unregisterDragObj(slot0._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(slot0._onOpenEquipTeamView, slot0)
	TaskDispatcher.cancelTask(slot0.hideDragEffect, slot0)
end

return slot0
