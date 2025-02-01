module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupHeroItem", package.seeall)

slot0 = class("Season123_2_0HeroGroupHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._seasonHeroGroupListView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goheroitem = gohelper.findChild(slot1, "heroitemani")
	slot0.anim = slot0._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	slot5 = typeof
	slot0._tagTr = gohelper.findChildComponent(slot1, "heroitemani/tags", slot5(UnityEngine.Transform))
	slot0._subGO = gohelper.findChild(slot1, "heroitemani/tags/aidtag")
	slot0._aidGO = gohelper.findChild(slot1, "heroitemani/tags/storytag")
	slot0._trialTagGO = gohelper.findChild(slot1, "heroitemani/tags/trialtag")
	slot0._subGO = gohelper.findChild(slot1, "heroitemani/aidtag")
	slot0._gonone = gohelper.findChild(slot1, "heroitemani/none")
	slot0._goadd = gohelper.findChild(slot1, "heroitemani/none/add")
	slot0._golock = gohelper.findChild(slot1, "heroitemani/none/lock")
	slot0._gohero = gohelper.findChild(slot1, "heroitemani/hero")
	slot0._imagecareericon = gohelper.findChildImage(slot1, "heroitemani/hero/career")
	slot0._goblackmask = gohelper.findChild(slot1, "heroitemani/hero/blackmask")
	slot0._gostarroot = gohelper.findChild(slot1, "heroitemani/equipcard/#go_starList")
	slot0._gostars = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		slot0._gostars[slot5] = gohelper.findChild(slot1, "heroitemani/equipcard/#go_starList/star" .. slot5)
	end

	slot0._txtlvnum = gohelper.findChildText(slot1, "heroitemani/equipcard/vertical/layout/lv/lvnum")
	slot0._goranks = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0._goranks[slot5] = gohelper.findChild(slot1, "heroitemani/equipcard/vertical/layout/rankobj/rank" .. slot5)
	end

	slot0._goequipcard = gohelper.findChild(slot1, "heroitemani/equipcard")
	slot0._goequip = gohelper.findChild(slot1, "heroitemani/equipcard/vertical/equip")
	slot0._btnclickequip = gohelper.getClick(slot0._goequip)
	slot0._gofakeequip = gohelper.findChild(slot1, "heroitemani/equipcard/vertical/fakeequip")
	slot0._goreplayready = gohelper.findChild(slot1, "heroitemani/hero/replayready")
	slot0._goclick = gohelper.findChild(slot1, "heroitemani/click")
	slot0._btnclickitem = gohelper.getClick(slot0._goclick)
	slot0._goselectdebuff = gohelper.findChild(slot1, "heroitemani/selectedeffect")
	slot0._goselected = gohelper.findChild(slot1, "heroitemani/selectedeffect/xuanzhong")
	slot0._gofinished = gohelper.findChild(slot1, "heroitemani/selectedeffect/wancheng")
	slot0._goroleequip = gohelper.findChild(slot1, "heroitemani/roleequip")
	slot0._droproleequipleft = gohelper.findChildDropdown(slot1, "heroitemani/roleequip/left")
	slot0._droproleequipright = gohelper.findChildDropdown(slot1, "heroitemani/roleequip/right")
	slot0._goflags = gohelper.findChild(slot1, "heroitemani/hero/go_flags")
	slot0._gorecommended = gohelper.findChild(slot1, "heroitemani/hero/go_flags/go_recommended")
	slot0._gocounter = gohelper.findChild(slot1, "heroitemani/hero/go_flags/go_counter")
	slot0._goseason = gohelper.findChild(slot1, "heroitemani/equipcard")
	slot0._goboth = gohelper.findChild(slot1, "heroitemani/equipcard/go_both")
	slot0._gosingle = gohelper.findChild(slot1, "heroitemani/equipcard/go_single")
	slot0._gocardlist = gohelper.findChild(slot1, "heroitemani/equipcard/cardlist")
	slot0._gocarditem1 = gohelper.findChild(slot1, "heroitemani/equipcard/cardlist/carditem1")
	slot0._cardItem1 = Season123_2_0HeroGroupCardItem.New(slot0._gocarditem1, slot0, {
		slot = 1
	})
	slot0._goherolvLayout = gohelper.findChild(slot1, "heroitemani/equipcard/vertical/layout")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "heroitemani/#go_hp/#slider_hp")
	slot0._gohp = gohelper.findChild(slot1, "heroitemani/#go_hp")
	slot0._imagehp = gohelper.findChildImage(slot1, "heroitemani/#go_hp/#slider_hp/Fill Area/Fill")
	slot0._charactericon = gohelper.findChild(slot1, "heroitemani/hero/charactericon")
	slot0._commonHeroCard = CommonHeroCard.create(slot0._charactericon, slot0._seasonHeroGroupListView.viewName)

	slot0:_initData()
	slot0:_addEvents()
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0.mo = slot1
	slot0.viewParam = slot2
	slot0._heroMO = Season123HeroUtils.getHeroMO(Season123HeroGroupModel.instance.activityId, slot0.mo.heroUid, Season123HeroGroupModel.instance.stage)
	slot0._monsterCo = slot1:getMonsterCO()
	slot0.trialCO = slot1:getTrialCO()
	slot0._posIndex = slot0.mo.id - 1

	gohelper.setActive(slot0._goreplayready, HeroGroupModel.instance:getCurGroupMO().isReplay)

	slot5 = false
	slot6 = nil

	if slot0._heroMO or slot3 and slot3.heroId and slot3.heroId ~= 0 then
		slot7 = slot4.isReplay and slot4.replay_hero_data[slot0.mo.heroUid] or nil
		slot0._txtlvnum.text, slot9 = HeroConfig.instance:getShowLevel(slot7 and slot7.level or slot0._heroMO.level)
		slot6 = FightConfig.instance:getSkinCO(slot7 and slot7.skin or slot0._heroMO.skin)

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. tostring((slot0._heroMO and slot0._heroMO.config or HeroConfig.instance:getHeroCO(slot3.heroId)).career))

		for slot14 = 1, 3 do
			gohelper.setActive(slot0._goranks[slot14], slot14 == slot9 - 1)
		end

		gohelper.setActive(slot0._gostarroot, true)

		for slot14 = 1, 6 do
			gohelper.setActive(slot0._gostars[slot14], slot14 <= CharacterEnum.Star[slot10.rare])
		end
	elseif slot0._monsterCo then
		slot6 = FightConfig.instance:getSkinCO(slot0._monsterCo.skinId)
		slot12 = slot0._monsterCo.career

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. tostring(slot12))

		slot0._txtlvnum.text, slot8 = HeroConfig.instance:getShowLevel(slot0._monsterCo.level)

		for slot12 = 1, 3 do
			gohelper.setActive(slot0._goranks[slot12], slot12 == slot8 - 1)
		end

		gohelper.setActive(slot0._gostarroot, false)
	elseif slot0.trialCO then
		slot7 = HeroConfig.instance:getHeroCO(slot0.trialCO.heroId)
		slot6 = (slot0.trialCO.skin <= 0 or SkinConfig.instance:getSkinCo(slot0.trialCO.skin)) and SkinConfig.instance:getSkinCo(slot7.skinId)

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. tostring(slot7.career))

		slot0._txtlvnum.text, slot9 = HeroConfig.instance:getShowLevel(slot0.trialCO.level)

		for slot13 = 1, 3 do
			gohelper.setActive(slot0._goranks[slot13], slot13 == slot9 - 1)
		end

		for slot13 = 1, 6 do
			gohelper.setActive(slot0._gostars[slot13], slot13 <= CharacterEnum.Star[slot7.rare])
		end
	end

	if slot6 then
		slot0._commonHeroCard:onUpdateMO(slot6)
	end

	slot0.isLock = not HeroGroupModel.instance:isPositionOpen(slot0.mo.id)
	slot0.isAidLock = slot0.mo.aid and slot0.mo.aid == -1
	slot0.isTrialLock = (slot0.mo.trial and slot0.mo.trialPos) ~= nil
	slot0.isAid = slot0.mo.aid ~= nil
	slot0.isRoleNumLock = HeroGroupModel.instance:getBattleRoleNum() and slot7 < slot0.mo.id
	slot0.isEmpty = slot1:isEmpty()
	slot8 = (slot0._heroMO or slot0._monsterCo or slot0.trialCO or slot3 and slot3.heroId and slot3.heroId ~= 0) and not slot0.isLock and not slot0.isRoleNumLock

	gohelper.setActive(slot0._gohero, slot8)
	gohelper.setActive(slot0._gostarroot, slot8)
	gohelper.setActive(slot0._goherolvLayout, slot8)

	slot9 = not slot0._heroMO and (slot3 == nil or slot3.heroId == nil or slot3.heroId == 0) and not slot0._monsterCo and not slot0.trialCO

	gohelper.setActive(slot0._gonone, slot9 or slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._goadd, slot9 and not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._golock, slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._aidGO, slot0.mo.aid and slot0.mo.aid ~= -1)
	gohelper.setActive(slot0._trialTagGO, slot0.trialCO ~= nil)
	recthelper.setAnchor(slot0._tagTr, -62.5, slot0._subGO.activeSelf and -98.9 or -51.3)

	if not HeroSingleGroupModel.instance:isTemp() and slot0.isRoleNumLock and slot0._heroMO ~= nil and slot0._monsterCo == nil then
		HeroSingleGroupModel.instance:remove(slot0._heroMO.id)
		Season123HeroGroupController.instance:saveCurrentHeroGroup()
	end

	gohelper.setActive(slot0._subGO, slot0:checkSubGoVisable())
	slot0:_updateSeasonEquips()
	slot0:showCounterSign()

	if slot0._playDeathAnim then
		slot0._playDeathAnim = nil

		slot0.anim:Play("open", 0, 0)
	end
end

function slot0.checkSubGoVisable(slot0)
	if slot0.isLock then
		return false
	end

	if slot0.isAidLock then
		return false
	end

	if slot0.isRoleNumLock then
		return false
	end

	if HeroGroupModel.instance.battleId and lua_battle.configDict[slot1] then
		return slot2.playerMax < slot0.mo.id
	end

	return slot0.mo.id == ModuleEnum.MaxHeroCountInGroup
end

function slot0._initData(slot0)
	slot0._firstEnter = true

	gohelper.setActive(slot0._goselectdebuff, false)
end

function slot0._addEvents(slot0)
	slot0._btnclickitem:AddClickListener(slot0._onClickHeroItem, slot0)
	slot0._btnclickequip:AddClickListener(slot0._onClickEquip, slot0)
	slot0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipUpdate, slot0._updateEquipCards, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, slot0.setHeroGroupEquipEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, slot0.playHeroGroupHeroEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, slot0._updateSeasonEquips, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0._updateSeasonEquips, slot0)
end

function slot0._updateSeasonEquips(slot0)
	slot0:_updateEquips()
	slot0:_updateEquipCards()
	slot0:_updateAct123Hp()
end

function slot0._onClickHeroItem(slot0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if slot0.mo.aid or slot0.isRoleNumLock then
		if slot0.mo.aid == -1 or slot0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if slot0.isLock then
		slot1, slot2 = HeroGroupModel.instance:getPositionLockDesc(slot0.mo.id)

		GameFacade.showToast(slot1, slot2)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, slot0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function slot0._onClickEquip(slot0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		slot1 = {
			heroMo = slot0._heroMO,
			equipMo = slot0._equipMO,
			posIndex = slot0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView,
			heroMo = HeroGroupTrialModel.instance:getHeroMo(slot0.trialCO.heroId)
		}

		if slot0.trialCO then
			if slot0.trialCO.equipId > 0 then
				slot1.equipMo = slot1.heroMo.trialEquipMo
			end
		end

		EquipController.instance:openEquipInfoTeamView(slot1)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function slot0._updateEquips(slot0)
	slot0._equipType = -1

	if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not slot0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(slot0._gofakeequip, false)
		gohelper.setActive(slot0._goemptyequip, false)
	else
		gohelper.setActive(slot0._gofakeequip, true)
		gohelper.setActive(slot0._goemptyequip, true)

		if not slot0._equip then
			slot0._equip = slot0:getUserDataTb_()
			slot0._equip.moveContainer = gohelper.findChild(slot0._goequip, "moveContainer")
			slot0._equip.moveContainerTrs = slot0._equip.moveContainer.transform
			slot0._equip.equipIcon = gohelper.findChildImage(slot0._goequip, "moveContainer/equipIcon")
			slot0._equip.equipRare = gohelper.findChildImage(slot0._goequip, "moveContainer/equiprare")
			slot0._equip.equiptxtlv = gohelper.findChildText(slot0._goequip, "moveContainer/equiplv/txtequiplv")
			slot0._equip.equipGolv = gohelper.findChild(slot0._goequip, "moveContainer/equiplv")

			slot0:_equipIconAddDrag(slot0._equip.equipIcon.gameObject)
		end

		slot1 = HeroGroupModel.instance:getCurGroupMO()
		slot0._equipMO = EquipModel.instance:getEquip(slot1:getPosEquips(slot0.mo.id - 1).equipUid[1])

		if slot1.isReplay then
			slot0._equipMO = nil

			if slot1.replay_equip_data[slot0.mo.heroUid] and EquipConfig.instance:getEquipCo(slot4.equipId) then
				slot0._equipMO = {
					config = slot5,
					refineLv = slot4.refineLv,
					level = slot4.equipLv
				}
			end
		end

		slot4 = nil

		if slot0.trialCO and slot0.trialCO.equipId > 0 then
			slot4 = EquipConfig.instance:getEquipCo(slot0.trialCO.equipId)
		end

		if slot0._equipMO then
			slot0._equipType = slot0._equipMO.config.rare - 2
		elseif slot4 then
			slot0._equipType = slot4.rare - 2
		end

		gohelper.setActive(slot0._equip.equipIcon.gameObject, slot0._equipMO)
		gohelper.setActive(slot0._equip.equipRare.gameObject, slot0._equipMO)
		gohelper.setActive(slot0._equip.equipGolv, slot0._equipMO)

		slot5 = slot0.mo.id - 1 == EquipTeamListModel.instance:getCurPosIndex()

		if slot0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._equip.equipIcon, slot0._equipMO.config.icon)

			slot0._equip.equiptxtlv.text = "LV." .. slot0._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(slot0._equip.equipRare, "bianduixingxian_" .. slot0._equipMO.config.rare)
		elseif slot4 then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._equip.equipIcon, slot4.icon)

			slot0._equip.equiptxtlv.text = "LV." .. slot0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(slot0._equip.equipRare, "bianduixingxian_" .. slot4.rare)
		end
	end

	slot0.last_equip = slot0._equipMO and slot0._equipMO.uid
	slot0.last_hero = slot0._heroMO and slot0._heroMO.heroId or 0
	slot0._firstEnter = false
end

slot0.NonCardSlotBlackMaskHeight = 362
slot0.HasCardSlotBlackMashHeight = 200
slot0.SingleSlotCardItem1Pos = Vector2.New(-3.8, 24.9)
slot0.TwoSlotCardItem1Pos = Vector2.New(-51.6, 28.2)

function slot0._updateEquipCards(slot0)
	slot2 = HeroGroupModel.instance:getCurGroupMO():getAct104PosEquips(slot0.mo.id - 1).equipUid

	if not Season123Model.instance:getBattleContext() then
		return
	end

	if not Season123Model.instance:getActInfo(slot3.actId) then
		return
	end

	slot6 = slot3.layer
	slot7 = false

	slot0._cardItem1:setData(slot0.mo, slot1.isReplay and (slot1.replay_activity104Equip_data[slot0.mo.heroUid] and slot10[1] and slot10[1].equipId or 0) or nil, nil, )

	slot0._hasUseSeasonEquipCard = slot0._cardItem1:hasUseSeasonEquipCard()
	slot10 = not slot0.isAid and slot0._cardItem1.slotUnlock

	recthelper.setHeight(slot0._goblackmask.transform, slot10 and uv0.NonCardSlotBlackMaskHeight or uv0.HasCardSlotBlackMashHeight)
	gohelper.setActive(slot0._gocardlist, slot10)
	slot0._cardItem1:setActive(slot10)

	slot12 = uv0.SingleSlotCardItem1Pos

	recthelper.setAnchor(slot0._cardItem1.transform, slot12.x, slot12.y)
end

function slot0._updateAct123Hp(slot0)
	if not Season123Model.instance:getBattleContext() then
		return
	end

	slot2 = slot1.actId
	slot4 = slot1.layer

	if not slot1.stage then
		gohelper.setActive(slot0._gohp, false)

		return
	end

	if Season123Model.instance:getSeasonHeroMO(slot2, slot3, slot4, slot0.mo.heroUid) ~= nil then
		gohelper.setActive(slot0._gohp, true)
		slot0:setHp(slot5.hpRate)
	else
		gohelper.setActive(slot0._gohp, false)
	end
end

function slot0.setHp(slot0, slot1)
	slot3 = Mathf.Clamp(math.floor(slot1 / 10) / 100, 0, 1)

	slot0._sliderhp:SetValue(slot3)
	Season123HeroGroupUtils.setHpBar(slot0._imagehp, slot3)
end

function slot0._equipIconAddDrag(slot0, slot1)
	if slot0._drag then
		return
	end

	slot1:GetComponent(gohelper.Type_Image).raycastTarget = true
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if slot0.trialCO and slot0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return
	end

	gohelper.setAsLastSibling(slot0.go)

	slot3 = slot0:getDragTransform()

	slot0:topDragTransformOrder()

	slot5 = HeroGroupHeroItem.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot5 = HeroGroupHeroItem.EquipDragMobileScale
		slot4 = slot2.position + HeroGroupHeroItem.EquipDragOffset
	end

	slot0:_tweenToPos(slot3, recthelper.screenPosToAnchorPos(slot4, slot3.parent))
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(slot0._equip.equipGolv, false)
	slot0:killEquipTweenId()

	slot0.equipTweenId = ZProj.TweenHelper.DOScale(slot1.parent, slot5, slot5, slot5, HeroGroupHeroItem.EquipTweenDuration)
end

function slot0._onDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if slot0.trialCO and slot0.trialCO.equipId > 0 then
		return
	end

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot3 = slot2.position + HeroGroupHeroItem.EquipDragOffset
	end

	slot4 = slot0:getDragTransform()

	slot0:_tweenToPos(slot4, recthelper.screenPosToAnchorPos(slot3, slot4.parent))
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0:killEquipTweenId()

	slot0.equipTweenId = ZProj.TweenHelper.DOScale(slot1.parent, 1, 1, 1, HeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if slot0.trialCO and slot0.trialCO.equipId > 0 then
		return
	end

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot3 = slot2.position + HeroGroupHeroItem.EquipDragOffset
	end

	slot0:_setEquipDragEnabled(false)

	slot5 = slot0:getDragTransform()
	slot6 = slot0:getOrignDragPos()
	slot7 = slot0:_moveToTarget(slot3) and slot4.trialCO and slot4.trialCO.equipId > 0

	if not slot4 or slot4 == slot0 or slot4.mo.aid or slot7 then
		if slot7 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		slot0:_setToPos(slot5, recthelper.rectToRelativeAnchorPos(slot6, slot5.parent), true, slot0.onDragEndFail, slot0)

		return
	end

	slot0:_playDragEndAudio(slot4)

	slot8 = slot4:getDragTransform()

	slot4:topDragTransformOrder()

	slot0._tweenId = slot0:_setToPos(slot8, recthelper.rectToRelativeAnchorPos(slot6, slot8.parent), true)

	slot0:_setToPos(slot5, recthelper.rectToRelativeAnchorPos(slot4:getOrignDragPos(), slot5.parent), true, slot0.onDragEndSuccess, slot0, slot4)
end

function slot0.canMoveCardToPos(slot0, slot1)
	if slot0._cardItem1 then
		return slot0._cardItem1:canMoveToPos(slot1)
	else
		return true
	end
end

function slot0.topDragTransformOrder(slot0)
	gohelper.addChildPosStay(slot0.currentParent, slot0:getDragTransform().gameObject)
end

function slot0.resetDragTransformOrder(slot0)
	gohelper.addChildPosStay(slot0._goequip, slot0:getDragTransform().gameObject)
end

function slot0.getDragTransform(slot0)
	return slot0._equip.moveContainerTrs
end

function slot0.getOrignDragPos(slot0)
	return slot0._goequip.transform.position
end

function slot0.onDragEndFail(slot0)
	slot0:resetDragTransformOrder()
	gohelper.setActive(slot0._gorootequipeffect1, false)
	gohelper.setActive(slot0._equip.equipGolv, true)
	slot0:_setEquipDragEnabled(true)
end

function slot0.onDragEndSuccess(slot0, slot1)
	EquipTeamListModel.instance:openTeamEquip(slot0.mo.id - 1, slot0._heroMO)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0:resetDragTransformOrder()
	slot1:resetDragTransformOrder()
	slot0:_setToPos(slot0:getDragTransform(), Vector2())
	slot0:_setToPos(slot1:getDragTransform(), Vector2())
	gohelper.setActive(slot0._gorootequipeffect1, false)
	gohelper.setActive(slot0._equip.equipGolv, true)
	slot0:_setEquipDragEnabled(true)

	slot5 = slot1.mo.id - 1

	if EquipModel.instance:getEquip(EquipTeamListModel.instance:getTeamEquip(slot0.mo.id - 1)[1]) and slot6 or nil then
		EquipTeamShowItem.removeEquip(slot4, true)
	end

	if EquipModel.instance:getEquip(EquipTeamListModel.instance:getTeamEquip(slot5)[1]) and slot7 or nil then
		EquipTeamShowItem.removeEquip(slot5, true)
	end

	if slot6 then
		EquipTeamShowItem.replaceEquip(slot5, slot6, true)
	end

	if slot7 then
		EquipTeamShowItem.replaceEquip(slot4, slot7, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)

	if not HeroSingleGroupModel.instance:isTemp() then
		slot8 = HeroGroupModel.instance:getCurGroupMO()

		if not Season123Model.instance:getActInfo(slot0.viewParam.actId) then
			return
		end

		if Season123HeroGroupModel.instance:isEpisodeSeason123() then
			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, {
				groupIndex = slot10.heroGroupSnapshotSubId,
				heroGroup = slot10:getCurHeroGroup()
			})
		elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, {
				heroGroup = slot8
			})
		else
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
			HeroGroupModel.instance:saveCurGroupData()
		end
	end
end

function slot0._playDragEndAudio(slot0, slot1)
	slot3, slot4 = nil

	if #(slot0._equipMO.config.skillType == 0 and {} or EquipHelper.getSkillBaseDescAndIcon(slot0._equipMO.config.id, slot0._equipMO.refineLv)) > 0 and EquipHelper.detectEquipSkillSuited(slot1._heroMO and slot1._heroMO.heroId, slot0._equipMO.config.skillType, slot0._equipMO.refineLv) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function slot0._tweenToPos(slot0, slot1, slot2)
	slot3, slot4 = recthelper.getAnchor(slot1)

	if math.abs(slot3 - slot2.x) > 10 or math.abs(slot4 - slot2.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)
	end
end

function slot0._setToPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7, slot8 = recthelper.getAnchor(slot1)

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2, slot4, slot5, slot6)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0._moveToTarget(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._seasonHeroGroupListView.heroPosTrList) do
		if slot0._seasonHeroGroupListView._heroItemList[slot5] ~= slot0 then
			slot7 = slot6.parent

			if math.abs(recthelper.screenPosToAnchorPos(slot1, slot7).x) * 2 < recthelper.getWidth(slot7) and math.abs(slot8.y) * 2 < recthelper.getHeight(slot7) then
				return slot0._seasonHeroGroupListView._heroItemList[slot5]
			end
		end
	end

	return nil
end

function slot0._setEquipDragEnabled(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._seasonHeroGroupListView._heroItemList) do
		if slot6._drag then
			slot6._drag.enabled = slot1
		end
	end
end

function slot0.playHeroGroupHeroEffect(slot0, slot1)
	slot0.anim:Play(slot1, 0, 0)

	slot0.last_equip = nil
	slot0.last_hero = nil
	slot0._firstEnter = true
end

function slot0.playRestrictAnimation(slot0, slot1, slot2)
	if slot0._heroMO and (slot1[slot0._heroMO.uid] or slot2 and slot2[slot0._heroMO.uid]) then
		slot0._playDeathAnim = true

		slot0.anim:Play("herogroup_hero_deal", 0, 0)

		slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0.setGrayFactor, nil, slot0)
	end
end

function slot0.setGrayFactor(slot0, slot1)
	ZProj.UGUIHelper.SetGrayFactor(slot0._charactericon.gameObject, slot1)
end

slot3 = Vector2.New(0, -50) - Vector2.New(0, -4)
slot4 = Vector2.New(0, -270)
slot5 = Vector2.New(0, -30)

function slot0.showCounterSign(slot0)
	slot1 = nil

	if slot0._heroMO then
		slot1 = lua_character.configDict[slot0._heroMO.heroId].career
	elseif slot0.monsterCO then
		slot1 = slot0.monsterCO.career
	elseif slot0.trialCO then
		slot1 = lua_character.configDict[slot0.trialCO.heroId] and slot2.career
	end

	slot2, slot3 = FightHelper.detectAttributeCounter()
	slot4 = tabletool.indexOf(slot2, slot1)

	gohelper.setActive(slot0._gorecommended, slot4)
	gohelper.setActive(slot0._gocounter, tabletool.indexOf(slot3, slot1))

	if slot4 or slot5 then
		slot8 = slot0._hasUseSeasonEquipCard and uv1 or uv2

		recthelper.setAnchor(slot0._goflags.transform, slot8.x, slot8.y)

		slot6 = uv0.x + uv3.x
		slot7 = uv0.y + uv3.y
	end

	if slot0._hasUseSeasonEquipCard then
		slot6 = slot6 + uv4.x
		slot7 = slot7 + uv4.y
	end

	recthelper.setAnchor(slot0._gohp.transform, slot6, slot7)
end

function slot0.onItemBeginDrag(slot0, slot1)
	if slot1 == slot0.mo.id then
		ZProj.TweenHelper.DOScale(slot0.go.transform, 1.1, 1.1, 1, 0.2, nil, , , EaseType.Linear)
		gohelper.setActive(slot0._goselectdebuff, true)
		gohelper.setActive(slot0._goselected, true)
		gohelper.setActive(slot0._gofinished, false)
	end

	gohelper.setActive(slot0._goclick, false)
end

function slot0.onItemEndDrag(slot0, slot1, slot2)
	ZProj.TweenHelper.DOScale(slot0.go.transform, 1, 1, 1, 0.2, nil, , , EaseType.Linear)
end

function slot0.onItemCompleteDrag(slot0, slot1, slot2, slot3)
	if slot2 == slot0.mo.id and slot1 ~= slot2 then
		if slot3 then
			gohelper.setActive(slot0._goselectdebuff, true)
			gohelper.setActive(slot0._goselected, false)
			gohelper.setActive(slot0._gofinished, false)
			gohelper.setActive(slot0._gofinished, true)
			TaskDispatcher.cancelTask(slot0.hideDragEffect, slot0)
			TaskDispatcher.runDelay(slot0.hideDragEffect, slot0, 0.833)
		end
	else
		gohelper.setActive(slot0._goselectdebuff, false)
	end

	gohelper.setActive(slot0._gorootequipeffect2, false)
	gohelper.setActive(slot0._goclick, true)
end

function slot0.hideDragEffect(slot0)
	gohelper.setActive(slot0._goselectdebuff, false)
end

function slot0.setHeroGroupEquipEffect(slot0, slot1)
	slot0._canPlayEffect = slot1
end

function slot0.setParent(slot0, slot1)
	slot0.currentParent = slot1

	gohelper.addChildPosStay(slot1.gameObject, slot0._subGO)
end

function slot0.flowOriginParent(slot0)
end

function slot0.flowCurrentParent(slot0)
end

function slot0.getHeroItemList(slot0)
	return slot0._seasonHeroGroupListView:getHeroItemList()
end

function slot0.killEquipTweenId(slot0)
	if slot0.equipTweenId then
		ZProj.TweenHelper.KillById(slot0.equipTweenId)

		slot0.equipTweenId = nil
	end
end

function slot0._removeEvents(slot0)
	slot0._btnclickitem:RemoveClickListener()
	slot0._btnclickequip:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0:_removeEvents()
	slot0:killEquipTweenId()

	if slot0._leftSeasonCardItem then
		slot0._leftSeasonCardItem:destroy()

		slot0._leftSeasonCardItem = nil
	end

	if slot0._rightSeasonCardItem then
		slot0._rightSeasonCardItem:destroy()

		slot0._rightSeasonCardItem = nil
	end

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	if slot0._cardItem1 then
		slot0._cardItem1:destory()

		slot0._cardItem1 = nil
	end

	TaskDispatcher.cancelTask(slot0.hideDragEffect, slot0)
end

return slot0
