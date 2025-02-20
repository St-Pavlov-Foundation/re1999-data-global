module("modules.logic.season.view.SeasonHeroGroupHeroItem", package.seeall)

slot0 = class("SeasonHeroGroupHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._seasonHeroGroupListView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goheroitem = gohelper.findChild(slot1, "heroitemani")
	slot0.anim = slot0._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	slot0._subGO = gohelper.findChild(slot1, "heroitemani/aidtag")
	slot0._gonone = gohelper.findChild(slot1, "heroitemani/none")
	slot0._goadd = gohelper.findChild(slot1, "heroitemani/none/add")
	slot0._golock = gohelper.findChild(slot1, "heroitemani/none/lock")
	slot0._gohero = gohelper.findChild(slot1, "heroitemani/hero")
	slot0._simagecharactericon = gohelper.findChildSingleImage(slot1, "heroitemani/hero/charactericon")
	slot0._imagecareericon = gohelper.findChildImage(slot1, "heroitemani/hero/career")
	slot0._goblackmask = gohelper.findChild(slot1, "heroitemani/hero/blackmask")
	slot5 = "heroitemani/equipcard/#go_starList"
	slot0._gostarroot = gohelper.findChild(slot1, slot5)
	slot0._gostars = slot0:getUserDataTb_()

	for slot5 = 1, 6 do
		slot0._gostars[slot5] = gohelper.findChild(slot1, "heroitemani/equipcard/#go_starList/star" .. slot5)
	end

	slot5 = "heroitemani/equipcard/vertical/layout/lv/lvnum"
	slot0._txtlvnum = gohelper.findChildText(slot1, slot5)
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
	slot0._cardItem1 = SeasonHeroGroupCardItem.New(slot0._gocarditem1, slot0, {
		slot = 1
	})
	slot0._gocarditem2 = gohelper.findChild(slot1, "heroitemani/equipcard/cardlist/carditem2")
	slot0._cardItem2 = SeasonHeroGroupCardItem.New(slot0._gocarditem2, slot0, {
		slot = 2
	})
	slot0._goherolvLayout = gohelper.findChild(slot1, "heroitemani/equipcard/vertical/layout")

	slot0:_initData()
	slot0:_addEvents()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._heroMO = slot1:getHeroMO()
	slot0._monsterCo = slot1:getMonsterCO()
	slot0._posIndex = slot0.mo.id - 1

	ZProj.UGUIHelper.SetGrayscale(slot0._simagecharactericon.gameObject, false)
	gohelper.setActive(slot0._goreplayready, HeroGroupModel.instance:getCurGroupMO().isReplay)

	if slot0._heroMO then
		slot3 = slot2.isReplay and slot2.replay_hero_data[slot0.mo.heroUid] or nil
		slot0._txtlvnum.text, slot5 = HeroConfig.instance:getShowLevel(slot3 and slot3.level or slot0._heroMO.level)

		slot0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(FightConfig.instance:getSkinCO(slot3 and slot3.skin or slot0._heroMO.skin).retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. tostring(slot0._heroMO.config.career))

		for slot10 = 1, 3 do
			gohelper.setActive(slot0._goranks[slot10], slot10 == slot5 - 1)
		end

		slot10 = true

		gohelper.setActive(slot0._gostarroot, slot10)

		for slot10 = 1, 6 do
			gohelper.setActive(slot0._gostars[slot10], slot10 <= CharacterEnum.Star[slot0._heroMO.config.rare])
		end
	elseif slot0._monsterCo then
		slot0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(FightConfig.instance:getSkinCO(slot0._monsterCo.skinId).retangleIcon))

		slot9 = tostring(slot0._monsterCo.career)

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. slot9)

		slot0._txtlvnum.text, slot5 = HeroConfig.instance:getShowLevel(slot0._monsterCo.level)

		for slot9 = 1, 3 do
			gohelper.setActive(slot0._goranks[slot9], slot9 == slot5 - 1)
		end

		gohelper.setActive(slot0._gostarroot, false)
	end

	slot0.isLock = not HeroGroupModel.instance:isPositionOpen(slot0.mo.id)
	slot0.isAidLock = slot0.mo.aid and slot0.mo.aid == -1
	slot0.isAid = slot0.mo.aid ~= nil
	slot0.isRoleNumLock = HeroGroupModel.instance:getBattleRoleNum() and slot3 < slot0.mo.id
	slot0.isEmpty = slot1:isEmpty()
	slot4 = (slot0._heroMO or slot0._monsterCo) and not slot0.isLock and not slot0.isRoleNumLock

	gohelper.setActive(slot0._gohero, slot4)
	gohelper.setActive(slot0._gostarroot, slot4)
	gohelper.setActive(slot0._goherolvLayout, slot4)
	gohelper.setActive(slot0._gonone, not slot0._heroMO and not slot0._monsterCo or slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._goadd, not slot0._heroMO and not slot0._monsterCo and not slot0.isLock and not slot0.isAidLock and not slot0.isRoleNumLock)
	gohelper.setActive(slot0._golock, slot0.isLock or slot0.isAidLock or slot0.isRoleNumLock)
	gohelper.setActive(slot0._aidGO, slot0.mo.aid and slot0.mo.aid ~= -1)

	if slot0.isRoleNumLock and slot0._heroMO ~= nil and slot0._monsterCo == nil then
		HeroSingleGroupModel.instance:remove(slot0._heroMO.id)

		slot8 = Activity104Model.instance:getSeasonCurSnapshotSubId(ActivityEnum.Activity.Season)

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, {
			groupIndex = slot8,
			heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(slot8)
		})
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
	slot0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, slot0._updateAct104Equips, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, slot0._updateAct104Equips, slot0)
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
	slot0:_updateAct104Equips()
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
		EquipController.instance:openEquipInfoTeamView({
			heroMo = slot0._heroMO,
			equipMo = slot0._equipMO,
			posIndex = slot0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeasonFightView
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function slot0._updateEquips(slot0)
	slot0._equipType = -1

	if slot0.isLock or slot0.isAid or slot0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
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

		if slot0._equipMO then
			slot0._equipType = slot0._equipMO.config.rare - 2
		end

		gohelper.setActive(slot0._equip.equipIcon.gameObject, slot0._equipMO)
		gohelper.setActive(slot0._equip.equipRare.gameObject, slot0._equipMO)
		gohelper.setActive(slot0._equip.equipGolv, slot0._equipMO)

		slot4 = slot0.mo.id - 1 == EquipTeamListModel.instance:getCurPosIndex()

		if slot0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(slot0._equip.equipIcon, slot0._equipMO.config.icon)

			slot0._equip.equiptxtlv.text = luaLang("level") .. slot0._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(slot0._equip.equipRare, "bianduixingxian_" .. slot0._equipMO.config.rare)
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

function slot0._updateAct104Equips(slot0)
	slot2 = HeroGroupModel.instance:getCurGroupMO():getAct104PosEquips(slot0.mo.id - 1).equipUid
	slot3 = Activity104Model.instance:getAct104CurLayer()

	if DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season then
		slot3 = Activity104Model.instance:getBattleFinishLayer()
	end

	slot3 = slot1.isReplay and (slot1.replay_activity104Equip_data[slot0.mo.heroUid] and slot1.replay_activity104Equip_data[slot0.mo.heroUid][2].equipId or 0) or nil

	slot0._cardItem1:setData(slot0.mo, slot3, Activity104Model.instance:getItemIdByUid(slot2[1]), not slot1.isReplay and slot2[1])
	slot0._cardItem2:setData(slot0.mo, slot3, Activity104Model.instance:getItemIdByUid(slot2[2]), not slot1.isReplay and slot2[2])

	slot0._hasUseSeasonEquipCard = slot0._cardItem1:hasUseSeasonEquipCard() or slot0._cardItem2:hasUseSeasonEquipCard()
	slot8 = slot0._cardItem1.slotUnlock or slot0._cardItem2.slotUnlock

	recthelper.setHeight(slot0._goblackmask.transform, slot8 and uv0.NonCardSlotBlackMaskHeight or uv0.HasCardSlotBlackMashHeight)
	gohelper.setActive(slot0._gocardlist, slot8)

	slot11 = slot0._cardItem1.slotUnlock and slot0._cardItem2.slotUnlock and uv0.TwoSlotCardItem1Pos or uv0.SingleSlotCardItem1Pos

	recthelper.setAnchor(slot0._cardItem1.transform, slot11.x, slot11.y)
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

	if GameUtil.isMobilePlayerAndNotEmulator() then
		slot3 = slot2.position + HeroGroupHeroItem.EquipDragOffset
	end

	slot0:_setEquipDragEnabled(false)

	slot5 = slot0:getDragTransform()
	slot6 = slot0:getOrignDragPos()

	if not slot0:_moveToTarget(slot3) or slot4 == slot0 or slot4.mo.aid then
		slot0:_setToPos(slot5, recthelper.rectToRelativeAnchorPos(slot6, slot5.parent), true, slot0.onDragEndFail, slot0)

		return
	end

	slot0:_playDragEndAudio(slot4)

	slot7 = slot4:getDragTransform()

	slot4:topDragTransformOrder()

	slot0._tweenId = slot0:_setToPos(slot7, recthelper.rectToRelativeAnchorPos(slot6, slot7.parent), true)

	slot0:_setToPos(slot5, recthelper.rectToRelativeAnchorPos(slot4:getOrignDragPos(), slot5.parent), true, slot0.onDragEndSuccess, slot0, slot4)
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
		slot10 = Activity104Model.instance:getSeasonCurSnapshotSubId(ActivityEnum.Activity.Season)

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, {
			groupIndex = slot10,
			heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(slot10)
		})
	end
end

function slot0._playDragEndAudio(slot0, slot1)
	if not slot0._equipMO or slot0._equipMO.config.id <= 0 then
		return
	end

	slot2, slot3, slot4 = EquipHelper.getSkillBaseDescAndIcon(slot0._equipMO.config.id, slot0._equipMO.refineLv)

	if #slot2 > 0 and EquipHelper.detectEquipSkillSuited(slot1._heroMO and slot1._heroMO.heroId, slot0._equipMO.config.skillType, slot0._equipMO.refineLv) then
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

function slot0.playRestrictAnimation(slot0, slot1)
	if slot0._heroMO and slot1[slot0._heroMO.uid] then
		slot0._playDeathAnim = true

		slot0.anim:Play("herogroup_hero_deal", 0, 0)

		slot0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0.setGrayFactor, nil, slot0)
	end
end

function slot0.setGrayFactor(slot0, slot1)
	ZProj.UGUIHelper.SetGrayFactor(slot0._simagecharactericon.gameObject, slot1)
end

slot1 = Vector2.New(0, -4)
slot2 = Vector2.New(0, -30)

function slot0.showCounterSign(slot0)
	slot1 = nil

	if slot0._heroMO then
		slot1 = lua_character.configDict[slot0._heroMO.heroId].career
	elseif slot0.monsterCO then
		slot1 = slot0.monsterCO.career
	end

	slot2, slot3 = FightHelper.detectAttributeCounter()
	slot4 = tabletool.indexOf(slot2, slot1)

	gohelper.setActive(slot0._gorecommended, slot4)
	gohelper.setActive(slot0._gocounter, tabletool.indexOf(slot3, slot1))

	if slot4 or slot5 then
		slot6 = slot0._hasUseSeasonEquipCard and uv0 or uv1

		recthelper.setAnchor(slot0._goflags.transform, slot6.x, slot6.y)
	end
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
	slot0._simagecharactericon:UnLoadImage()

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

	if slot0._cardItem2 then
		slot0._cardItem2:destory()

		slot0._cardItem2 = nil
	end

	TaskDispatcher.cancelTask(slot0.hideDragEffect, slot0)
end

return slot0
