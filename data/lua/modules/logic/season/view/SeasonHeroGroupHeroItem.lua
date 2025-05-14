module("modules.logic.season.view.SeasonHeroGroupHeroItem", package.seeall)

local var_0_0 = class("SeasonHeroGroupHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._seasonHeroGroupListView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goheroitem = gohelper.findChild(arg_2_1, "heroitemani")
	arg_2_0.anim = arg_2_0._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._subGO = gohelper.findChild(arg_2_1, "heroitemani/aidtag")
	arg_2_0._gonone = gohelper.findChild(arg_2_1, "heroitemani/none")
	arg_2_0._goadd = gohelper.findChild(arg_2_1, "heroitemani/none/add")
	arg_2_0._golock = gohelper.findChild(arg_2_1, "heroitemani/none/lock")
	arg_2_0._gohero = gohelper.findChild(arg_2_1, "heroitemani/hero")
	arg_2_0._simagecharactericon = gohelper.findChildSingleImage(arg_2_1, "heroitemani/hero/charactericon")
	arg_2_0._imagecareericon = gohelper.findChildImage(arg_2_1, "heroitemani/hero/career")
	arg_2_0._goblackmask = gohelper.findChild(arg_2_1, "heroitemani/hero/blackmask")
	arg_2_0._gostarroot = gohelper.findChild(arg_2_1, "heroitemani/equipcard/#go_starList")
	arg_2_0._gostars = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 6 do
		arg_2_0._gostars[iter_2_0] = gohelper.findChild(arg_2_1, "heroitemani/equipcard/#go_starList/star" .. iter_2_0)
	end

	arg_2_0._txtlvnum = gohelper.findChildText(arg_2_1, "heroitemani/equipcard/vertical/layout/lv/lvnum")
	arg_2_0._goranks = arg_2_0:getUserDataTb_()

	for iter_2_1 = 1, 3 do
		arg_2_0._goranks[iter_2_1] = gohelper.findChild(arg_2_1, "heroitemani/equipcard/vertical/layout/rankobj/rank" .. iter_2_1)
	end

	arg_2_0._goequipcard = gohelper.findChild(arg_2_1, "heroitemani/equipcard")
	arg_2_0._goequip = gohelper.findChild(arg_2_1, "heroitemani/equipcard/vertical/equip")
	arg_2_0._btnclickequip = gohelper.getClick(arg_2_0._goequip)
	arg_2_0._gofakeequip = gohelper.findChild(arg_2_1, "heroitemani/equipcard/vertical/fakeequip")
	arg_2_0._goreplayready = gohelper.findChild(arg_2_1, "heroitemani/hero/replayready")
	arg_2_0._goclick = gohelper.findChild(arg_2_1, "heroitemani/click")
	arg_2_0._btnclickitem = gohelper.getClick(arg_2_0._goclick)
	arg_2_0._goselectdebuff = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect")
	arg_2_0._goselected = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/xuanzhong")
	arg_2_0._gofinished = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/wancheng")
	arg_2_0._goroleequip = gohelper.findChild(arg_2_1, "heroitemani/roleequip")
	arg_2_0._droproleequipleft = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/left")
	arg_2_0._droproleequipright = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/right")
	arg_2_0._goflags = gohelper.findChild(arg_2_1, "heroitemani/hero/go_flags")
	arg_2_0._gorecommended = gohelper.findChild(arg_2_1, "heroitemani/hero/go_flags/go_recommended")
	arg_2_0._gocounter = gohelper.findChild(arg_2_1, "heroitemani/hero/go_flags/go_counter")
	arg_2_0._goseason = gohelper.findChild(arg_2_1, "heroitemani/equipcard")
	arg_2_0._goboth = gohelper.findChild(arg_2_1, "heroitemani/equipcard/go_both")
	arg_2_0._gosingle = gohelper.findChild(arg_2_1, "heroitemani/equipcard/go_single")
	arg_2_0._gocardlist = gohelper.findChild(arg_2_1, "heroitemani/equipcard/cardlist")
	arg_2_0._gocarditem1 = gohelper.findChild(arg_2_1, "heroitemani/equipcard/cardlist/carditem1")
	arg_2_0._cardItem1 = SeasonHeroGroupCardItem.New(arg_2_0._gocarditem1, arg_2_0, {
		slot = 1
	})
	arg_2_0._gocarditem2 = gohelper.findChild(arg_2_1, "heroitemani/equipcard/cardlist/carditem2")
	arg_2_0._cardItem2 = SeasonHeroGroupCardItem.New(arg_2_0._gocarditem2, arg_2_0, {
		slot = 2
	})
	arg_2_0._goherolvLayout = gohelper.findChild(arg_2_1, "heroitemani/equipcard/vertical/layout")

	arg_2_0:_initData()
	arg_2_0:_addEvents()
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0.mo = arg_3_1
	arg_3_0._heroMO = arg_3_1:getHeroMO()
	arg_3_0._monsterCo = arg_3_1:getMonsterCO()
	arg_3_0._posIndex = arg_3_0.mo.id - 1

	ZProj.UGUIHelper.SetGrayscale(arg_3_0._simagecharactericon.gameObject, false)

	local var_3_0 = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(arg_3_0._goreplayready, var_3_0.isReplay)

	if arg_3_0._heroMO then
		local var_3_1 = var_3_0.isReplay and var_3_0.replay_hero_data[arg_3_0.mo.heroUid] or nil
		local var_3_2, var_3_3 = HeroConfig.instance:getShowLevel(var_3_1 and var_3_1.level or arg_3_0._heroMO.level)

		arg_3_0._txtlvnum.text = var_3_2

		local var_3_4 = FightConfig.instance:getSkinCO(var_3_1 and var_3_1.skin or arg_3_0._heroMO.skin)

		arg_3_0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(var_3_4.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareericon, "lssx_" .. tostring(arg_3_0._heroMO.config.career))

		for iter_3_0 = 1, 3 do
			gohelper.setActive(arg_3_0._goranks[iter_3_0], iter_3_0 == var_3_3 - 1)
		end

		gohelper.setActive(arg_3_0._gostarroot, true)

		for iter_3_1 = 1, 6 do
			gohelper.setActive(arg_3_0._gostars[iter_3_1], iter_3_1 <= CharacterEnum.Star[arg_3_0._heroMO.config.rare])
		end
	elseif arg_3_0._monsterCo then
		local var_3_5 = FightConfig.instance:getSkinCO(arg_3_0._monsterCo.skinId)

		arg_3_0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(var_3_5.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareericon, "lssx_" .. tostring(arg_3_0._monsterCo.career))

		local var_3_6, var_3_7 = HeroConfig.instance:getShowLevel(arg_3_0._monsterCo.level)

		arg_3_0._txtlvnum.text = var_3_6

		for iter_3_2 = 1, 3 do
			gohelper.setActive(arg_3_0._goranks[iter_3_2], iter_3_2 == var_3_7 - 1)
		end

		gohelper.setActive(arg_3_0._gostarroot, false)
	end

	arg_3_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_3_0.mo.id)
	arg_3_0.isAidLock = arg_3_0.mo.aid and arg_3_0.mo.aid == -1
	arg_3_0.isAid = arg_3_0.mo.aid ~= nil

	local var_3_8 = HeroGroupModel.instance:getBattleRoleNum()

	arg_3_0.isRoleNumLock = var_3_8 and var_3_8 < arg_3_0.mo.id
	arg_3_0.isEmpty = arg_3_1:isEmpty()

	local var_3_9 = (arg_3_0._heroMO or arg_3_0._monsterCo) and not arg_3_0.isLock and not arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._gohero, var_3_9)
	gohelper.setActive(arg_3_0._gostarroot, var_3_9)
	gohelper.setActive(arg_3_0._goherolvLayout, var_3_9)

	local var_3_10 = not arg_3_0._heroMO and not arg_3_0._monsterCo or arg_3_0.isLock or arg_3_0.isAidLock or arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._gonone, var_3_10)

	local var_3_11 = not arg_3_0._heroMO and not arg_3_0._monsterCo and not arg_3_0.isLock and not arg_3_0.isAidLock and not arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._goadd, var_3_11)
	gohelper.setActive(arg_3_0._golock, arg_3_0.isLock or arg_3_0.isAidLock or arg_3_0.isRoleNumLock)
	gohelper.setActive(arg_3_0._aidGO, arg_3_0.mo.aid and arg_3_0.mo.aid ~= -1)

	if arg_3_0.isRoleNumLock and arg_3_0._heroMO ~= nil and arg_3_0._monsterCo == nil then
		HeroSingleGroupModel.instance:remove(arg_3_0._heroMO.id)

		local var_3_12 = ActivityEnum.Activity.Season
		local var_3_13 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_3_12)
		local var_3_14 = Activity104Model.instance:getSnapshotHeroGroupBySubId(var_3_13)
		local var_3_15 = {
			groupIndex = var_3_13,
			heroGroup = var_3_14
		}

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_3_15)
	end

	gohelper.setActive(arg_3_0._subGO, arg_3_0:checkSubGoVisable())
	arg_3_0:_updateSeasonEquips()
	arg_3_0:showCounterSign()

	if arg_3_0._playDeathAnim then
		arg_3_0._playDeathAnim = nil

		arg_3_0.anim:Play("open", 0, 0)
	end
end

function var_0_0.checkSubGoVisable(arg_4_0)
	if arg_4_0.isLock then
		return false
	end

	if arg_4_0.isAidLock then
		return false
	end

	if arg_4_0.isRoleNumLock then
		return false
	end

	local var_4_0 = HeroGroupModel.instance.battleId
	local var_4_1 = var_4_0 and lua_battle.configDict[var_4_0]

	if var_4_1 then
		return arg_4_0.mo.id > var_4_1.playerMax
	end

	return arg_4_0.mo.id == ModuleEnum.MaxHeroCountInGroup
end

function var_0_0._initData(arg_5_0)
	arg_5_0._firstEnter = true

	gohelper.setActive(arg_5_0._goselectdebuff, false)
end

function var_0_0._addEvents(arg_6_0)
	arg_6_0._btnclickitem:AddClickListener(arg_6_0._onClickHeroItem, arg_6_0)
	arg_6_0._btnclickequip:AddClickListener(arg_6_0._onClickEquip, arg_6_0)
	arg_6_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, arg_6_0._updateAct104Equips, arg_6_0)
	arg_6_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_6_0._updateAct104Equips, arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_6_0.setHeroGroupEquipEffect, arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_6_0.playHeroGroupHeroEffect, arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_6_0._updateSeasonEquips, arg_6_0)
	arg_6_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_6_0._updateSeasonEquips, arg_6_0)
	arg_6_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_6_0._updateSeasonEquips, arg_6_0)
	arg_6_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_6_0._updateSeasonEquips, arg_6_0)
	arg_6_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_6_0._updateSeasonEquips, arg_6_0)
	arg_6_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_6_0._updateSeasonEquips, arg_6_0)
end

function var_0_0._updateSeasonEquips(arg_7_0)
	arg_7_0:_updateEquips()
	arg_7_0:_updateAct104Equips()
end

function var_0_0._onClickHeroItem(arg_8_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_8_0.mo.aid or arg_8_0.isRoleNumLock then
		if arg_8_0.mo.aid == -1 or arg_8_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_8_0.isLock then
		local var_8_0, var_8_1 = HeroGroupModel.instance:getPositionLockDesc(arg_8_0.mo.id)

		GameFacade.showToast(var_8_0, var_8_1)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_8_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickEquip(arg_9_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		local var_9_0 = {
			heroMo = arg_9_0._heroMO,
			equipMo = arg_9_0._equipMO,
			posIndex = arg_9_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeasonFightView
		}

		EquipController.instance:openEquipInfoTeamView(var_9_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._updateEquips(arg_10_0)
	arg_10_0._equipType = -1

	if arg_10_0.isLock or arg_10_0.isAid or arg_10_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		gohelper.setActive(arg_10_0._gofakeequip, false)
		gohelper.setActive(arg_10_0._goemptyequip, false)
	else
		gohelper.setActive(arg_10_0._gofakeequip, true)
		gohelper.setActive(arg_10_0._goemptyequip, true)

		if not arg_10_0._equip then
			arg_10_0._equip = arg_10_0:getUserDataTb_()
			arg_10_0._equip.moveContainer = gohelper.findChild(arg_10_0._goequip, "moveContainer")
			arg_10_0._equip.moveContainerTrs = arg_10_0._equip.moveContainer.transform
			arg_10_0._equip.equipIcon = gohelper.findChildImage(arg_10_0._goequip, "moveContainer/equipIcon")
			arg_10_0._equip.equipRare = gohelper.findChildImage(arg_10_0._goequip, "moveContainer/equiprare")
			arg_10_0._equip.equiptxtlv = gohelper.findChildText(arg_10_0._goequip, "moveContainer/equiplv/txtequiplv")
			arg_10_0._equip.equipGolv = gohelper.findChild(arg_10_0._goequip, "moveContainer/equiplv")

			arg_10_0:_equipIconAddDrag(arg_10_0._equip.equipIcon.gameObject)
		end

		local var_10_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_10_1 = var_10_0:getPosEquips(arg_10_0.mo.id - 1).equipUid[1]

		arg_10_0._equipMO = EquipModel.instance:getEquip(var_10_1)

		if var_10_0.isReplay then
			arg_10_0._equipMO = nil

			local var_10_2 = var_10_0.replay_equip_data[arg_10_0.mo.heroUid]

			if var_10_2 then
				local var_10_3 = EquipConfig.instance:getEquipCo(var_10_2.equipId)

				if var_10_3 then
					arg_10_0._equipMO = {}
					arg_10_0._equipMO.config = var_10_3
					arg_10_0._equipMO.refineLv = var_10_2.refineLv
					arg_10_0._equipMO.level = var_10_2.equipLv
				end
			end
		end

		if arg_10_0._equipMO then
			arg_10_0._equipType = arg_10_0._equipMO.config.rare - 2
		end

		gohelper.setActive(arg_10_0._equip.equipIcon.gameObject, arg_10_0._equipMO)
		gohelper.setActive(arg_10_0._equip.equipRare.gameObject, arg_10_0._equipMO)
		gohelper.setActive(arg_10_0._equip.equipGolv, arg_10_0._equipMO)

		local var_10_4

		var_10_4 = arg_10_0.mo.id - 1 == EquipTeamListModel.instance:getCurPosIndex()

		if arg_10_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._equip.equipIcon, arg_10_0._equipMO.config.icon)

			arg_10_0._equip.equiptxtlv.text = luaLang("level") .. arg_10_0._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._equip.equipRare, "bianduixingxian_" .. arg_10_0._equipMO.config.rare)
		end
	end

	arg_10_0.last_equip = arg_10_0._equipMO and arg_10_0._equipMO.uid
	arg_10_0.last_hero = arg_10_0._heroMO and arg_10_0._heroMO.heroId or 0
	arg_10_0._firstEnter = false
end

var_0_0.NonCardSlotBlackMaskHeight = 362
var_0_0.HasCardSlotBlackMashHeight = 200
var_0_0.SingleSlotCardItem1Pos = Vector2.New(-3.8, 24.9)
var_0_0.TwoSlotCardItem1Pos = Vector2.New(-51.6, 28.2)

function var_0_0._updateAct104Equips(arg_11_0)
	local var_11_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_11_1 = var_11_0:getAct104PosEquips(arg_11_0.mo.id - 1).equipUid
	local var_11_2 = Activity104Model.instance:getAct104CurLayer()

	if DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season then
		var_11_2 = Activity104Model.instance:getBattleFinishLayer()
	end

	local var_11_3 = not var_11_0.isReplay and var_11_1[1]
	local var_11_4 = not var_11_0.isReplay and var_11_1[2]
	local var_11_5 = Activity104Model.instance:getItemIdByUid(var_11_1[1])
	local var_11_6 = Activity104Model.instance:getItemIdByUid(var_11_1[2])

	if var_11_0.isReplay then
		var_11_5 = var_11_0.replay_activity104Equip_data[arg_11_0.mo.heroUid] and var_11_0.replay_activity104Equip_data[arg_11_0.mo.heroUid][1].equipId or 0
		var_11_6 = var_11_0.replay_activity104Equip_data[arg_11_0.mo.heroUid] and var_11_0.replay_activity104Equip_data[arg_11_0.mo.heroUid][2].equipId or 0
	else
		var_11_2 = nil
	end

	arg_11_0._cardItem1:setData(arg_11_0.mo, var_11_2, var_11_5, var_11_3)
	arg_11_0._cardItem2:setData(arg_11_0.mo, var_11_2, var_11_6, var_11_4)

	arg_11_0._hasUseSeasonEquipCard = arg_11_0._cardItem1:hasUseSeasonEquipCard() or arg_11_0._cardItem2:hasUseSeasonEquipCard()

	local var_11_7 = arg_11_0._cardItem1.slotUnlock or arg_11_0._cardItem2.slotUnlock
	local var_11_8 = var_11_7 and var_0_0.NonCardSlotBlackMaskHeight or var_0_0.HasCardSlotBlackMashHeight

	recthelper.setHeight(arg_11_0._goblackmask.transform, var_11_8)
	gohelper.setActive(arg_11_0._gocardlist, var_11_7)

	local var_11_9 = arg_11_0._cardItem1.slotUnlock and arg_11_0._cardItem2.slotUnlock and var_0_0.TwoSlotCardItem1Pos or var_0_0.SingleSlotCardItem1Pos

	recthelper.setAnchor(arg_11_0._cardItem1.transform, var_11_9.x, var_11_9.y)
end

function var_0_0._equipIconAddDrag(arg_12_0, arg_12_1)
	if arg_12_0._drag then
		return
	end

	arg_12_1:GetComponent(gohelper.Type_Image).raycastTarget = true
	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_1)

	arg_12_0._drag:AddDragBeginListener(arg_12_0._onBeginDrag, arg_12_0, arg_12_1.transform)
	arg_12_0._drag:AddDragListener(arg_12_0._onDrag, arg_12_0)
	arg_12_0._drag:AddDragEndListener(arg_12_0._onEndDrag, arg_12_0, arg_12_1.transform)
end

function var_0_0._onBeginDrag(arg_13_0, arg_13_1, arg_13_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	gohelper.setAsLastSibling(arg_13_0.go)

	local var_13_0 = arg_13_0:getDragTransform()

	arg_13_0:topDragTransformOrder()

	local var_13_1 = arg_13_2.position
	local var_13_2 = HeroGroupHeroItem.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_13_2 = HeroGroupHeroItem.EquipDragMobileScale
		var_13_1 = var_13_1 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_13_3 = recthelper.screenPosToAnchorPos(var_13_1, var_13_0.parent)

	arg_13_0:_tweenToPos(var_13_0, var_13_3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_13_0._equip.equipGolv, false)
	arg_13_0:killEquipTweenId()

	arg_13_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_13_1.parent, var_13_2, var_13_2, var_13_2, HeroGroupHeroItem.EquipTweenDuration)
end

function var_0_0._onDrag(arg_14_0, arg_14_1, arg_14_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_14_0 = arg_14_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_14_0 = var_14_0 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_14_1 = arg_14_0:getDragTransform()
	local var_14_2 = recthelper.screenPosToAnchorPos(var_14_0, var_14_1.parent)

	arg_14_0:_tweenToPos(var_14_1, var_14_2)
end

function var_0_0._onEndDrag(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:killEquipTweenId()

	arg_15_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_15_1.parent, 1, 1, 1, HeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_15_0 = arg_15_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_15_0 = var_15_0 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_15_1 = arg_15_0:_moveToTarget(var_15_0)

	arg_15_0:_setEquipDragEnabled(false)

	local var_15_2 = arg_15_0:getDragTransform()
	local var_15_3 = arg_15_0:getOrignDragPos()

	if not var_15_1 or var_15_1 == arg_15_0 or var_15_1.mo.aid then
		local var_15_4 = recthelper.rectToRelativeAnchorPos(var_15_3, var_15_2.parent)

		arg_15_0:_setToPos(var_15_2, var_15_4, true, arg_15_0.onDragEndFail, arg_15_0)

		return
	end

	arg_15_0:_playDragEndAudio(var_15_1)

	local var_15_5 = var_15_1:getDragTransform()

	var_15_1:topDragTransformOrder()

	local var_15_6 = var_15_1:getOrignDragPos()
	local var_15_7 = recthelper.rectToRelativeAnchorPos(var_15_3, var_15_5.parent)

	arg_15_0._tweenId = arg_15_0:_setToPos(var_15_5, var_15_7, true)

	local var_15_8 = recthelper.rectToRelativeAnchorPos(var_15_6, var_15_2.parent)

	arg_15_0:_setToPos(var_15_2, var_15_8, true, arg_15_0.onDragEndSuccess, arg_15_0, var_15_1)
end

function var_0_0.topDragTransformOrder(arg_16_0)
	local var_16_0 = arg_16_0:getDragTransform()

	gohelper.addChildPosStay(arg_16_0.currentParent, var_16_0.gameObject)
end

function var_0_0.resetDragTransformOrder(arg_17_0)
	local var_17_0 = arg_17_0:getDragTransform()

	gohelper.addChildPosStay(arg_17_0._goequip, var_17_0.gameObject)
end

function var_0_0.getDragTransform(arg_18_0)
	return arg_18_0._equip.moveContainerTrs
end

function var_0_0.getOrignDragPos(arg_19_0)
	return arg_19_0._goequip.transform.position
end

function var_0_0.onDragEndFail(arg_20_0)
	arg_20_0:resetDragTransformOrder()
	gohelper.setActive(arg_20_0._gorootequipeffect1, false)
	gohelper.setActive(arg_20_0._equip.equipGolv, true)
	arg_20_0:_setEquipDragEnabled(true)
end

function var_0_0.onDragEndSuccess(arg_21_0, arg_21_1)
	EquipTeamListModel.instance:openTeamEquip(arg_21_0.mo.id - 1, arg_21_0._heroMO)

	if arg_21_0._tweenId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenId)

		arg_21_0._tweenId = nil
	end

	arg_21_0:resetDragTransformOrder()
	arg_21_1:resetDragTransformOrder()

	local var_21_0 = arg_21_0:getDragTransform()
	local var_21_1 = arg_21_1:getDragTransform()

	arg_21_0:_setToPos(var_21_0, Vector2())
	arg_21_0:_setToPos(var_21_1, Vector2())
	gohelper.setActive(arg_21_0._gorootequipeffect1, false)
	gohelper.setActive(arg_21_0._equip.equipGolv, true)
	arg_21_0:_setEquipDragEnabled(true)

	local var_21_2 = arg_21_0.mo.id - 1
	local var_21_3 = arg_21_1.mo.id - 1
	local var_21_4 = EquipTeamListModel.instance:getTeamEquip(var_21_2)[1]

	var_21_4 = EquipModel.instance:getEquip(var_21_4) and var_21_4 or nil

	if var_21_4 then
		EquipTeamShowItem.removeEquip(var_21_2, true)
	end

	local var_21_5 = EquipTeamListModel.instance:getTeamEquip(var_21_3)[1]

	var_21_5 = EquipModel.instance:getEquip(var_21_5) and var_21_5 or nil

	if var_21_5 then
		EquipTeamShowItem.removeEquip(var_21_3, true)
	end

	if var_21_4 then
		EquipTeamShowItem.replaceEquip(var_21_3, var_21_4, true)
	end

	if var_21_5 then
		EquipTeamShowItem.replaceEquip(var_21_2, var_21_5, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)

	if not HeroSingleGroupModel.instance:isTemp() then
		local var_21_6 = HeroGroupModel.instance:getCurGroupMO()
		local var_21_7 = ActivityEnum.Activity.Season
		local var_21_8 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_21_7)
		local var_21_9 = Activity104Model.instance:getSnapshotHeroGroupBySubId(var_21_8)
		local var_21_10 = {
			groupIndex = var_21_8,
			heroGroup = var_21_9
		}

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_21_10)
	end
end

function var_0_0._playDragEndAudio(arg_22_0, arg_22_1)
	if not arg_22_0._equipMO or arg_22_0._equipMO.config.id <= 0 then
		return
	end

	local var_22_0, var_22_1, var_22_2 = EquipHelper.getSkillBaseDescAndIcon(arg_22_0._equipMO.config.id, arg_22_0._equipMO.refineLv)

	if #var_22_0 > 0 and EquipHelper.detectEquipSkillSuited(arg_22_1._heroMO and arg_22_1._heroMO.heroId, arg_22_0._equipMO.config.skillType, arg_22_0._equipMO.refineLv) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._tweenToPos(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0, var_23_1 = recthelper.getAnchor(arg_23_1)

	if math.abs(var_23_0 - arg_23_2.x) > 10 or math.abs(var_23_1 - arg_23_2.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(arg_23_1, arg_23_2.x, arg_23_2.y, 0.2)
	else
		recthelper.setAnchor(arg_23_1, arg_23_2.x, arg_23_2.y)
	end
end

function var_0_0._setToPos(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5, arg_24_6)
	local var_24_0, var_24_1 = recthelper.getAnchor(arg_24_1)

	if arg_24_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_24_1, arg_24_2.x, arg_24_2.y, 0.2, arg_24_4, arg_24_5, arg_24_6)
	else
		recthelper.setAnchor(arg_24_1, arg_24_2.x, arg_24_2.y)

		if arg_24_4 then
			arg_24_4(arg_24_5)
		end
	end
end

function var_0_0._moveToTarget(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._seasonHeroGroupListView.heroPosTrList) do
		if arg_25_0._seasonHeroGroupListView._heroItemList[iter_25_0] ~= arg_25_0 then
			local var_25_0 = iter_25_1.parent
			local var_25_1 = recthelper.screenPosToAnchorPos(arg_25_1, var_25_0)

			if math.abs(var_25_1.x) * 2 < recthelper.getWidth(var_25_0) and math.abs(var_25_1.y) * 2 < recthelper.getHeight(var_25_0) then
				return arg_25_0._seasonHeroGroupListView._heroItemList[iter_25_0]
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._seasonHeroGroupListView._heroItemList) do
		if iter_26_1._drag then
			iter_26_1._drag.enabled = arg_26_1
		end
	end
end

function var_0_0.playHeroGroupHeroEffect(arg_27_0, arg_27_1)
	arg_27_0.anim:Play(arg_27_1, 0, 0)

	arg_27_0.last_equip = nil
	arg_27_0.last_hero = nil
	arg_27_0._firstEnter = true
end

function var_0_0.playRestrictAnimation(arg_28_0, arg_28_1)
	if arg_28_0._heroMO and arg_28_1[arg_28_0._heroMO.uid] then
		arg_28_0._playDeathAnim = true

		arg_28_0.anim:Play("herogroup_hero_deal", 0, 0)

		arg_28_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_28_0.setGrayFactor, nil, arg_28_0)
	end
end

function var_0_0.setGrayFactor(arg_29_0, arg_29_1)
	ZProj.UGUIHelper.SetGrayFactor(arg_29_0._simagecharactericon.gameObject, arg_29_1)
end

local var_0_1 = Vector2.New(0, -4)
local var_0_2 = Vector2.New(0, -30)

function var_0_0.showCounterSign(arg_30_0)
	local var_30_0

	if arg_30_0._heroMO then
		var_30_0 = lua_character.configDict[arg_30_0._heroMO.heroId].career
	elseif arg_30_0.monsterCO then
		var_30_0 = arg_30_0.monsterCO.career
	end

	local var_30_1, var_30_2 = FightHelper.detectAttributeCounter()
	local var_30_3 = tabletool.indexOf(var_30_1, var_30_0)
	local var_30_4 = tabletool.indexOf(var_30_2, var_30_0)

	gohelper.setActive(arg_30_0._gorecommended, var_30_3)
	gohelper.setActive(arg_30_0._gocounter, var_30_4)

	if var_30_3 or var_30_4 then
		local var_30_5 = arg_30_0._hasUseSeasonEquipCard and var_0_2 or var_0_1

		recthelper.setAnchor(arg_30_0._goflags.transform, var_30_5.x, var_30_5.y)
	end
end

function var_0_0.onItemBeginDrag(arg_31_0, arg_31_1)
	if arg_31_1 == arg_31_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_31_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_31_0._goselectdebuff, true)
		gohelper.setActive(arg_31_0._goselected, true)
		gohelper.setActive(arg_31_0._gofinished, false)
	end

	gohelper.setActive(arg_31_0._goclick, false)
end

function var_0_0.onItemEndDrag(arg_32_0, arg_32_1, arg_32_2)
	ZProj.TweenHelper.DOScale(arg_32_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
end

function var_0_0.onItemCompleteDrag(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if arg_33_2 == arg_33_0.mo.id and arg_33_1 ~= arg_33_2 then
		if arg_33_3 then
			gohelper.setActive(arg_33_0._goselectdebuff, true)
			gohelper.setActive(arg_33_0._goselected, false)
			gohelper.setActive(arg_33_0._gofinished, false)
			gohelper.setActive(arg_33_0._gofinished, true)
			TaskDispatcher.cancelTask(arg_33_0.hideDragEffect, arg_33_0)
			TaskDispatcher.runDelay(arg_33_0.hideDragEffect, arg_33_0, 0.833)
		end
	else
		gohelper.setActive(arg_33_0._goselectdebuff, false)
	end

	gohelper.setActive(arg_33_0._gorootequipeffect2, false)
	gohelper.setActive(arg_33_0._goclick, true)
end

function var_0_0.hideDragEffect(arg_34_0)
	gohelper.setActive(arg_34_0._goselectdebuff, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_35_0, arg_35_1)
	arg_35_0._canPlayEffect = arg_35_1
end

function var_0_0.setParent(arg_36_0, arg_36_1)
	arg_36_0.currentParent = arg_36_1

	gohelper.addChildPosStay(arg_36_1.gameObject, arg_36_0._subGO)
end

function var_0_0.flowOriginParent(arg_37_0)
	return
end

function var_0_0.flowCurrentParent(arg_38_0)
	return
end

function var_0_0.getHeroItemList(arg_39_0)
	return arg_39_0._seasonHeroGroupListView:getHeroItemList()
end

function var_0_0.killEquipTweenId(arg_40_0)
	if arg_40_0.equipTweenId then
		ZProj.TweenHelper.KillById(arg_40_0.equipTweenId)

		arg_40_0.equipTweenId = nil
	end
end

function var_0_0._removeEvents(arg_41_0)
	arg_41_0._btnclickitem:RemoveClickListener()
	arg_41_0._btnclickequip:RemoveClickListener()
end

function var_0_0.onDestroy(arg_42_0)
	arg_42_0:_removeEvents()
	arg_42_0:killEquipTweenId()
	arg_42_0._simagecharactericon:UnLoadImage()

	if arg_42_0._leftSeasonCardItem then
		arg_42_0._leftSeasonCardItem:destroy()

		arg_42_0._leftSeasonCardItem = nil
	end

	if arg_42_0._rightSeasonCardItem then
		arg_42_0._rightSeasonCardItem:destroy()

		arg_42_0._rightSeasonCardItem = nil
	end

	if arg_42_0._drag then
		arg_42_0._drag:RemoveDragBeginListener()
		arg_42_0._drag:RemoveDragListener()
		arg_42_0._drag:RemoveDragEndListener()
	end

	if arg_42_0._cardItem1 then
		arg_42_0._cardItem1:destory()

		arg_42_0._cardItem1 = nil
	end

	if arg_42_0._cardItem2 then
		arg_42_0._cardItem2:destory()

		arg_42_0._cardItem2 = nil
	end

	TaskDispatcher.cancelTask(arg_42_0.hideDragEffect, arg_42_0)
end

return var_0_0
