module("modules.logic.seasonver.act123.view1_9.Season123_1_9HeroGroupHeroItem", package.seeall)

local var_0_0 = class("Season123_1_9HeroGroupHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._seasonHeroGroupListView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goheroitem = gohelper.findChild(arg_2_1, "heroitemani")
	arg_2_0.anim = arg_2_0._goheroitem:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._tagTr = gohelper.findChildComponent(arg_2_1, "heroitemani/tags", typeof(UnityEngine.Transform))
	arg_2_0._subGO = gohelper.findChild(arg_2_1, "heroitemani/tags/aidtag")
	arg_2_0._aidGO = gohelper.findChild(arg_2_1, "heroitemani/tags/storytag")
	arg_2_0._trialTagGO = gohelper.findChild(arg_2_1, "heroitemani/tags/trialtag")
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
	arg_2_0._cardItem1 = Season123_1_9HeroGroupCardItem.New(arg_2_0._gocarditem1, arg_2_0, {
		slot = 1
	})
	arg_2_0._goherolvLayout = gohelper.findChild(arg_2_1, "heroitemani/equipcard/vertical/layout")
	arg_2_0._sliderhp = gohelper.findChildSlider(arg_2_1, "heroitemani/#go_hp/#slider_hp")
	arg_2_0._gohp = gohelper.findChild(arg_2_1, "heroitemani/#go_hp")
	arg_2_0._imagehp = gohelper.findChildImage(arg_2_1, "heroitemani/#go_hp/#slider_hp/Fill Area/Fill")
	arg_2_0._charactericon = gohelper.findChild(arg_2_1, "heroitemani/hero/charactericon")
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._seasonHeroGroupListView.viewName)

	arg_2_0:_initData()
	arg_2_0:_addEvents()
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.mo = arg_3_1
	arg_3_0.viewParam = arg_3_2
	arg_3_0._heroMO = Season123HeroUtils.getHeroMO(Season123HeroGroupModel.instance.activityId, arg_3_0.mo.heroUid, Season123HeroGroupModel.instance.stage)
	arg_3_0._monsterCo = arg_3_1:getMonsterCO()
	arg_3_0.trialCO = arg_3_1:getTrialCO()
	arg_3_0._posIndex = arg_3_0.mo.id - 1

	ZProj.UGUIHelper.SetGrayscale(arg_3_0._simagecharactericon.gameObject, false)

	local var_3_0 = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(arg_3_0._goreplayready, var_3_0.isReplay)

	local var_3_1 = false
	local var_3_2

	if arg_3_0._heroMO or arg_3_3 and arg_3_3.heroId and arg_3_3.heroId ~= 0 then
		local var_3_3 = var_3_0.isReplay and var_3_0.replay_hero_data[arg_3_0.mo.heroUid] or nil
		local var_3_4, var_3_5 = HeroConfig.instance:getShowLevel(var_3_3 and var_3_3.level or arg_3_0._heroMO.level)

		arg_3_0._txtlvnum.text = var_3_4
		var_3_2 = FightConfig.instance:getSkinCO(var_3_3 and var_3_3.skin or arg_3_0._heroMO.skin)

		local var_3_6 = arg_3_0._heroMO and arg_3_0._heroMO.config or HeroConfig.instance:getHeroCO(arg_3_3.heroId)

		arg_3_0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(var_3_2.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareericon, "lssx_" .. tostring(var_3_6.career))

		for iter_3_0 = 1, 3 do
			gohelper.setActive(arg_3_0._goranks[iter_3_0], iter_3_0 == var_3_5 - 1)
		end

		gohelper.setActive(arg_3_0._gostarroot, true)

		for iter_3_1 = 1, 6 do
			gohelper.setActive(arg_3_0._gostars[iter_3_1], iter_3_1 <= CharacterEnum.Star[var_3_6.rare])
		end
	elseif arg_3_0._monsterCo then
		var_3_2 = FightConfig.instance:getSkinCO(arg_3_0._monsterCo.skinId)

		arg_3_0._simagecharactericon:LoadImage(ResUrl.getHeadIconMiddle(var_3_2.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareericon, "lssx_" .. tostring(arg_3_0._monsterCo.career))

		local var_3_7, var_3_8 = HeroConfig.instance:getShowLevel(arg_3_0._monsterCo.level)

		arg_3_0._txtlvnum.text = var_3_7

		for iter_3_2 = 1, 3 do
			gohelper.setActive(arg_3_0._goranks[iter_3_2], iter_3_2 == var_3_8 - 1)
		end

		gohelper.setActive(arg_3_0._gostarroot, false)
	elseif arg_3_0.trialCO then
		local var_3_9 = HeroConfig.instance:getHeroCO(arg_3_0.trialCO.heroId)

		if arg_3_0.trialCO.skin > 0 then
			var_3_2 = SkinConfig.instance:getSkinCo(arg_3_0.trialCO.skin)
		else
			var_3_2 = SkinConfig.instance:getSkinCo(var_3_9.skinId)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareericon, "lssx_" .. tostring(var_3_9.career))

		local var_3_10, var_3_11 = HeroConfig.instance:getShowLevel(arg_3_0.trialCO.level)

		arg_3_0._txtlvnum.text = var_3_10

		for iter_3_3 = 1, 3 do
			gohelper.setActive(arg_3_0._goranks[iter_3_3], iter_3_3 == var_3_11 - 1)
		end

		for iter_3_4 = 1, 6 do
			gohelper.setActive(arg_3_0._gostars[iter_3_4], iter_3_4 <= CharacterEnum.Star[var_3_9.rare])
		end
	end

	if var_3_2 then
		arg_3_0._commonHeroCard:onUpdateMO(var_3_2)
	end

	arg_3_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_3_0.mo.id)
	arg_3_0.isAidLock = arg_3_0.mo.aid and arg_3_0.mo.aid == -1
	arg_3_0.isTrialLock = (arg_3_0.mo.trial and arg_3_0.mo.trialPos) ~= nil
	arg_3_0.isAid = arg_3_0.mo.aid ~= nil

	local var_3_12 = HeroGroupModel.instance:getBattleRoleNum()

	arg_3_0.isRoleNumLock = var_3_12 and var_3_12 < arg_3_0.mo.id
	arg_3_0.isEmpty = arg_3_1:isEmpty()

	local var_3_13 = (arg_3_0._heroMO or arg_3_0._monsterCo or arg_3_0.trialCO or arg_3_3 and arg_3_3.heroId and arg_3_3.heroId ~= 0) and not arg_3_0.isLock and not arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._gohero, var_3_13)
	gohelper.setActive(arg_3_0._gostarroot, var_3_13)
	gohelper.setActive(arg_3_0._goherolvLayout, var_3_13)

	local var_3_14 = not arg_3_0._heroMO and (arg_3_3 == nil or arg_3_3.heroId == nil or arg_3_3.heroId == 0) and not arg_3_0._monsterCo and not arg_3_0.trialCO
	local var_3_15 = var_3_14 or arg_3_0.isLock or arg_3_0.isAidLock or arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._gonone, var_3_15)

	local var_3_16 = var_3_14 and not arg_3_0.isLock and not arg_3_0.isAidLock and not arg_3_0.isRoleNumLock

	gohelper.setActive(arg_3_0._goadd, var_3_16)
	gohelper.setActive(arg_3_0._golock, arg_3_0.isLock or arg_3_0.isAidLock or arg_3_0.isRoleNumLock)
	gohelper.setActive(arg_3_0._aidGO, arg_3_0.mo.aid and arg_3_0.mo.aid ~= -1)
	gohelper.setActive(arg_3_0._trialTagGO, arg_3_0.trialCO ~= nil)
	recthelper.setAnchor(arg_3_0._tagTr, -62.5, arg_3_0._subGO.activeSelf and -98.9 or -51.3)

	if not HeroSingleGroupModel.instance:isTemp() and arg_3_0.isRoleNumLock and arg_3_0._heroMO ~= nil and arg_3_0._monsterCo == nil then
		HeroSingleGroupModel.instance:remove(arg_3_0._heroMO.id)
		Season123HeroGroupController.instance:saveCurrentHeroGroup()
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
	arg_6_0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipUpdate, arg_6_0._updateEquipCards, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, arg_6_0._updateSeasonEquips, arg_6_0)
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
	arg_7_0:_updateEquipCards()
	arg_7_0:_updateAct123Hp()
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
			fromView = EquipEnum.FromViewEnum.FromSeason123HeroGroupFightView
		}

		if arg_9_0.trialCO then
			var_9_0.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_9_0.trialCO)

			if arg_9_0.trialCO.equipId > 0 then
				var_9_0.equipMo = var_9_0.heroMo.trialEquipMo
			end
		end

		EquipController.instance:openEquipInfoTeamView(var_9_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._updateEquips(arg_10_0)
	arg_10_0._equipType = -1

	if arg_10_0.isLock or arg_10_0.isAid or arg_10_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_10_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
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

		local var_10_4

		if arg_10_0.trialCO and arg_10_0.trialCO.equipId > 0 then
			var_10_4 = EquipConfig.instance:getEquipCo(arg_10_0.trialCO.equipId)
		end

		if arg_10_0._equipMO then
			arg_10_0._equipType = arg_10_0._equipMO.config.rare - 2
		elseif var_10_4 then
			arg_10_0._equipType = var_10_4.rare - 2
		end

		gohelper.setActive(arg_10_0._equip.equipIcon.gameObject, arg_10_0._equipMO)
		gohelper.setActive(arg_10_0._equip.equipRare.gameObject, arg_10_0._equipMO)
		gohelper.setActive(arg_10_0._equip.equipGolv, arg_10_0._equipMO)

		local var_10_5

		var_10_5 = arg_10_0.mo.id - 1 == EquipTeamListModel.instance:getCurPosIndex()

		if arg_10_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._equip.equipIcon, arg_10_0._equipMO.config.icon)

			arg_10_0._equip.equiptxtlv.text = "LV." .. arg_10_0._equipMO.level

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._equip.equipRare, "bianduixingxian_" .. arg_10_0._equipMO.config.rare)
		elseif var_10_4 then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._equip.equipIcon, var_10_4.icon)

			arg_10_0._equip.equiptxtlv.text = "LV." .. arg_10_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._equip.equipRare, "bianduixingxian_" .. var_10_4.rare)
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

function var_0_0._updateEquipCards(arg_11_0)
	local var_11_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_11_1 = var_11_0:getAct104PosEquips(arg_11_0.mo.id - 1).equipUid
	local var_11_2 = Season123Model.instance:getBattleContext()

	if not var_11_2 then
		return
	end

	local var_11_3 = var_11_2.actId
	local var_11_4 = Season123Model.instance:getActInfo(var_11_3)

	if not var_11_4 then
		return
	end

	local var_11_5 = var_11_2.layer
	local var_11_6 = false
	local var_11_7
	local var_11_8

	if var_11_0.isReplay then
		local var_11_9 = var_11_0.replay_activity104Equip_data[arg_11_0.mo.heroUid]

		var_11_8 = var_11_9 and var_11_9[1] and var_11_9[1].equipId or 0
	else
		local var_11_10 = var_11_0:getAct104PosEquips(arg_11_0.mo.id - 1).equipUid or {}
		local var_11_11

		var_11_11 = arg_11_0.trialCO and (arg_11_0.trialCO.act104EquipId1 > 0 or arg_11_0.trialCO.act104EquipId2 > 0)

		if arg_11_0.trialCO and arg_11_0.trialCO.act104EquipId1 > 0 then
			var_11_8 = arg_11_0.trialCO.act104EquipId1
		else
			var_11_7 = var_11_10[1]
			var_11_8 = var_11_4:getItemIdByUid(var_11_7)
		end

		var_11_5 = nil
	end

	arg_11_0._cardItem1:setData(arg_11_0.mo, var_11_5, var_11_8, var_11_7)

	arg_11_0._hasUseSeasonEquipCard = arg_11_0._cardItem1:hasUseSeasonEquipCard()

	local var_11_12 = not arg_11_0.isAid and arg_11_0._cardItem1.slotUnlock
	local var_11_13 = var_11_12 and var_0_0.NonCardSlotBlackMaskHeight or var_0_0.HasCardSlotBlackMashHeight

	recthelper.setHeight(arg_11_0._goblackmask.transform, var_11_13)
	gohelper.setActive(arg_11_0._gocardlist, var_11_12)
	arg_11_0._cardItem1:setActive(var_11_12)

	local var_11_14 = var_0_0.SingleSlotCardItem1Pos

	recthelper.setAnchor(arg_11_0._cardItem1.transform, var_11_14.x, var_11_14.y)
end

function var_0_0._updateAct123Hp(arg_12_0)
	local var_12_0 = Season123Model.instance:getBattleContext()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.actId
	local var_12_2 = var_12_0.stage
	local var_12_3 = var_12_0.layer

	if not var_12_2 then
		gohelper.setActive(arg_12_0._gohp, false)

		return
	end

	local var_12_4 = Season123Model.instance:getSeasonHeroMO(var_12_1, var_12_2, var_12_3, arg_12_0.mo.heroUid)

	if var_12_4 ~= nil then
		gohelper.setActive(arg_12_0._gohp, true)
		arg_12_0:setHp(var_12_4.hpRate)
	else
		gohelper.setActive(arg_12_0._gohp, false)
	end
end

function var_0_0.setHp(arg_13_0, arg_13_1)
	local var_13_0 = math.floor(arg_13_1 / 10)
	local var_13_1 = Mathf.Clamp(var_13_0 / 100, 0, 1)

	arg_13_0._sliderhp:SetValue(var_13_1)
	Season123HeroGroupUtils.setHpBar(arg_13_0._imagehp, var_13_1)
end

function var_0_0._equipIconAddDrag(arg_14_0, arg_14_1)
	if arg_14_0._drag then
		return
	end

	arg_14_1:GetComponent(gohelper.Type_Image).raycastTarget = true
	arg_14_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_14_1)

	arg_14_0._drag:AddDragBeginListener(arg_14_0._onBeginDrag, arg_14_0, arg_14_1.transform)
	arg_14_0._drag:AddDragListener(arg_14_0._onDrag, arg_14_0)
	arg_14_0._drag:AddDragEndListener(arg_14_0._onEndDrag, arg_14_0, arg_14_1.transform)
end

function var_0_0._onBeginDrag(arg_15_0, arg_15_1, arg_15_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_15_0.trialCO and arg_15_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return
	end

	gohelper.setAsLastSibling(arg_15_0.go)

	local var_15_0 = arg_15_0:getDragTransform()

	arg_15_0:topDragTransformOrder()

	local var_15_1 = arg_15_2.position
	local var_15_2 = HeroGroupHeroItem.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_15_2 = HeroGroupHeroItem.EquipDragMobileScale
		var_15_1 = var_15_1 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_15_3 = recthelper.screenPosToAnchorPos(var_15_1, var_15_0.parent)

	arg_15_0:_tweenToPos(var_15_0, var_15_3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_15_0._equip.equipGolv, false)
	arg_15_0:killEquipTweenId()

	arg_15_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_15_1.parent, var_15_2, var_15_2, var_15_2, HeroGroupHeroItem.EquipTweenDuration)
end

function var_0_0._onDrag(arg_16_0, arg_16_1, arg_16_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_16_0.trialCO and arg_16_0.trialCO.equipId > 0 then
		return
	end

	local var_16_0 = arg_16_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_16_0 = var_16_0 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_16_1 = arg_16_0:getDragTransform()
	local var_16_2 = recthelper.screenPosToAnchorPos(var_16_0, var_16_1.parent)

	arg_16_0:_tweenToPos(var_16_1, var_16_2)
end

function var_0_0._onEndDrag(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:killEquipTweenId()

	arg_17_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_17_1.parent, 1, 1, 1, HeroGroupHeroItem.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_17_0.trialCO and arg_17_0.trialCO.equipId > 0 then
		return
	end

	local var_17_0 = arg_17_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_17_0 = var_17_0 + HeroGroupHeroItem.EquipDragOffset
	end

	local var_17_1 = arg_17_0:_moveToTarget(var_17_0)

	arg_17_0:_setEquipDragEnabled(false)

	local var_17_2 = arg_17_0:getDragTransform()
	local var_17_3 = arg_17_0:getOrignDragPos()
	local var_17_4 = var_17_1 and var_17_1.trialCO and var_17_1.trialCO.equipId > 0

	if not var_17_1 or var_17_1 == arg_17_0 or var_17_1.mo.aid or var_17_4 then
		if var_17_4 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		local var_17_5 = recthelper.rectToRelativeAnchorPos(var_17_3, var_17_2.parent)

		arg_17_0:_setToPos(var_17_2, var_17_5, true, arg_17_0.onDragEndFail, arg_17_0)

		return
	end

	arg_17_0:_playDragEndAudio(var_17_1)

	local var_17_6 = var_17_1:getDragTransform()

	var_17_1:topDragTransformOrder()

	local var_17_7 = var_17_1:getOrignDragPos()
	local var_17_8 = recthelper.rectToRelativeAnchorPos(var_17_3, var_17_6.parent)

	arg_17_0._tweenId = arg_17_0:_setToPos(var_17_6, var_17_8, true)

	local var_17_9 = recthelper.rectToRelativeAnchorPos(var_17_7, var_17_2.parent)

	arg_17_0:_setToPos(var_17_2, var_17_9, true, arg_17_0.onDragEndSuccess, arg_17_0, var_17_1)
end

function var_0_0.canMoveCardToPos(arg_18_0, arg_18_1)
	if arg_18_0._cardItem1 then
		return arg_18_0._cardItem1:canMoveToPos(arg_18_1)
	else
		return true
	end
end

function var_0_0.topDragTransformOrder(arg_19_0)
	local var_19_0 = arg_19_0:getDragTransform()

	gohelper.addChildPosStay(arg_19_0.currentParent, var_19_0.gameObject)
end

function var_0_0.resetDragTransformOrder(arg_20_0)
	local var_20_0 = arg_20_0:getDragTransform()

	gohelper.addChildPosStay(arg_20_0._goequip, var_20_0.gameObject)
end

function var_0_0.getDragTransform(arg_21_0)
	return arg_21_0._equip.moveContainerTrs
end

function var_0_0.getOrignDragPos(arg_22_0)
	return arg_22_0._goequip.transform.position
end

function var_0_0.onDragEndFail(arg_23_0)
	arg_23_0:resetDragTransformOrder()
	gohelper.setActive(arg_23_0._gorootequipeffect1, false)
	gohelper.setActive(arg_23_0._equip.equipGolv, true)
	arg_23_0:_setEquipDragEnabled(true)
end

function var_0_0.onDragEndSuccess(arg_24_0, arg_24_1)
	EquipTeamListModel.instance:openTeamEquip(arg_24_0.mo.id - 1, arg_24_0._heroMO)

	if arg_24_0._tweenId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenId)

		arg_24_0._tweenId = nil
	end

	arg_24_0:resetDragTransformOrder()
	arg_24_1:resetDragTransformOrder()

	local var_24_0 = arg_24_0:getDragTransform()
	local var_24_1 = arg_24_1:getDragTransform()

	arg_24_0:_setToPos(var_24_0, Vector2())
	arg_24_0:_setToPos(var_24_1, Vector2())
	gohelper.setActive(arg_24_0._gorootequipeffect1, false)
	gohelper.setActive(arg_24_0._equip.equipGolv, true)
	arg_24_0:_setEquipDragEnabled(true)

	local var_24_2 = arg_24_0.mo.id - 1
	local var_24_3 = arg_24_1.mo.id - 1
	local var_24_4 = EquipTeamListModel.instance:getTeamEquip(var_24_2)[1]

	var_24_4 = EquipModel.instance:getEquip(var_24_4) and var_24_4 or nil

	if var_24_4 then
		EquipTeamShowItem.removeEquip(var_24_2, true)
	end

	local var_24_5 = EquipTeamListModel.instance:getTeamEquip(var_24_3)[1]

	var_24_5 = EquipModel.instance:getEquip(var_24_5) and var_24_5 or nil

	if var_24_5 then
		EquipTeamShowItem.removeEquip(var_24_3, true)
	end

	if var_24_4 then
		EquipTeamShowItem.replaceEquip(var_24_3, var_24_4, true)
	end

	if var_24_5 then
		EquipTeamShowItem.replaceEquip(var_24_2, var_24_5, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)

	if not HeroSingleGroupModel.instance:isTemp() then
		local var_24_6 = HeroGroupModel.instance:getCurGroupMO()
		local var_24_7 = arg_24_0.viewParam.actId
		local var_24_8 = Season123Model.instance:getActInfo(var_24_7)

		if not var_24_8 then
			return
		end

		if Season123HeroGroupModel.instance:isEpisodeSeason123() then
			local var_24_9 = var_24_8.heroGroupSnapshotSubId
			local var_24_10 = var_24_8:getCurHeroGroup()
			local var_24_11 = {
				groupIndex = var_24_9,
				heroGroup = var_24_10
			}

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, var_24_11)
		elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			local var_24_12 = {
				heroGroup = var_24_6
			}

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, var_24_12)
		else
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
			HeroGroupModel.instance:saveCurGroupData()
		end
	end
end

function var_0_0._playDragEndAudio(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._equipMO.config.skillType == 0 and {} or EquipHelper.getSkillBaseDescAndIcon(arg_25_0._equipMO.config.id, arg_25_0._equipMO.refineLv)
	local var_25_1
	local var_25_2

	if #var_25_0 > 0 and EquipHelper.detectEquipSkillSuited(arg_25_1._heroMO and arg_25_1._heroMO.heroId, arg_25_0._equipMO.config.skillType, arg_25_0._equipMO.refineLv) then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._tweenToPos(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1 = recthelper.getAnchor(arg_26_1)

	if math.abs(var_26_0 - arg_26_2.x) > 10 or math.abs(var_26_1 - arg_26_2.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(arg_26_1, arg_26_2.x, arg_26_2.y, 0.2)
	else
		recthelper.setAnchor(arg_26_1, arg_26_2.x, arg_26_2.y)
	end
end

function var_0_0._setToPos(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	local var_27_0, var_27_1 = recthelper.getAnchor(arg_27_1)

	if arg_27_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_27_1, arg_27_2.x, arg_27_2.y, 0.2, arg_27_4, arg_27_5, arg_27_6)
	else
		recthelper.setAnchor(arg_27_1, arg_27_2.x, arg_27_2.y)

		if arg_27_4 then
			arg_27_4(arg_27_5)
		end
	end
end

function var_0_0._moveToTarget(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._seasonHeroGroupListView.heroPosTrList) do
		if arg_28_0._seasonHeroGroupListView._heroItemList[iter_28_0] ~= arg_28_0 then
			local var_28_0 = iter_28_1.parent
			local var_28_1 = recthelper.screenPosToAnchorPos(arg_28_1, var_28_0)

			if math.abs(var_28_1.x) * 2 < recthelper.getWidth(var_28_0) and math.abs(var_28_1.y) * 2 < recthelper.getHeight(var_28_0) then
				return arg_28_0._seasonHeroGroupListView._heroItemList[iter_28_0]
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0._seasonHeroGroupListView._heroItemList) do
		if iter_29_1._drag then
			iter_29_1._drag.enabled = arg_29_1
		end
	end
end

function var_0_0.playHeroGroupHeroEffect(arg_30_0, arg_30_1)
	arg_30_0.anim:Play(arg_30_1, 0, 0)

	arg_30_0.last_equip = nil
	arg_30_0.last_hero = nil
	arg_30_0._firstEnter = true
end

function var_0_0.playRestrictAnimation(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0._heroMO and (arg_31_1[arg_31_0._heroMO.uid] or arg_31_2 and arg_31_2[arg_31_0._heroMO.uid]) then
		arg_31_0._playDeathAnim = true

		arg_31_0.anim:Play("herogroup_hero_deal", 0, 0)

		arg_31_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_31_0.setGrayFactor, nil, arg_31_0)
	end
end

function var_0_0.setGrayFactor(arg_32_0, arg_32_1)
	ZProj.UGUIHelper.SetGrayFactor(arg_32_0._simagecharactericon.gameObject, arg_32_1)
end

local var_0_1 = Vector2.New(0, -4)
local var_0_2 = Vector2.New(0, -50)
local var_0_3 = var_0_2 - var_0_1
local var_0_4 = Vector2.New(0, -270)
local var_0_5 = Vector2.New(0, -30)

function var_0_0.showCounterSign(arg_33_0)
	local var_33_0

	if arg_33_0._heroMO then
		var_33_0 = lua_character.configDict[arg_33_0._heroMO.heroId].career
	elseif arg_33_0.monsterCO then
		var_33_0 = arg_33_0.monsterCO.career
	elseif arg_33_0.trialCO then
		local var_33_1 = lua_character.configDict[arg_33_0.trialCO.heroId]

		var_33_0 = var_33_1 and var_33_1.career
	end

	local var_33_2, var_33_3 = FightHelper.detectAttributeCounter()
	local var_33_4 = tabletool.indexOf(var_33_2, var_33_0)
	local var_33_5 = tabletool.indexOf(var_33_3, var_33_0)

	gohelper.setActive(arg_33_0._gorecommended, var_33_4)
	gohelper.setActive(arg_33_0._gocounter, var_33_5)

	local var_33_6 = var_0_4.x
	local var_33_7 = var_0_4.y

	if var_33_4 or var_33_5 then
		local var_33_8 = arg_33_0._hasUseSeasonEquipCard and var_0_2 or var_0_1

		recthelper.setAnchor(arg_33_0._goflags.transform, var_33_8.x, var_33_8.y)

		var_33_6 = var_33_6 + var_0_5.x
		var_33_7 = var_33_7 + var_0_5.y
	end

	if arg_33_0._hasUseSeasonEquipCard then
		var_33_6 = var_33_6 + var_0_3.x
		var_33_7 = var_33_7 + var_0_3.y
	end

	recthelper.setAnchor(arg_33_0._gohp.transform, var_33_6, var_33_7)
end

function var_0_0.onItemBeginDrag(arg_34_0, arg_34_1)
	if arg_34_1 == arg_34_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_34_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_34_0._goselectdebuff, true)
		gohelper.setActive(arg_34_0._goselected, true)
		gohelper.setActive(arg_34_0._gofinished, false)
	end

	gohelper.setActive(arg_34_0._goclick, false)
end

function var_0_0.onItemEndDrag(arg_35_0, arg_35_1, arg_35_2)
	ZProj.TweenHelper.DOScale(arg_35_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
end

function var_0_0.onItemCompleteDrag(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if arg_36_2 == arg_36_0.mo.id and arg_36_1 ~= arg_36_2 then
		if arg_36_3 then
			gohelper.setActive(arg_36_0._goselectdebuff, true)
			gohelper.setActive(arg_36_0._goselected, false)
			gohelper.setActive(arg_36_0._gofinished, false)
			gohelper.setActive(arg_36_0._gofinished, true)
			TaskDispatcher.cancelTask(arg_36_0.hideDragEffect, arg_36_0)
			TaskDispatcher.runDelay(arg_36_0.hideDragEffect, arg_36_0, 0.833)
		end
	else
		gohelper.setActive(arg_36_0._goselectdebuff, false)
	end

	gohelper.setActive(arg_36_0._gorootequipeffect2, false)
	gohelper.setActive(arg_36_0._goclick, true)
end

function var_0_0.hideDragEffect(arg_37_0)
	gohelper.setActive(arg_37_0._goselectdebuff, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_38_0, arg_38_1)
	arg_38_0._canPlayEffect = arg_38_1
end

function var_0_0.setParent(arg_39_0, arg_39_1)
	arg_39_0.currentParent = arg_39_1

	gohelper.addChildPosStay(arg_39_1.gameObject, arg_39_0._subGO)
end

function var_0_0.flowOriginParent(arg_40_0)
	return
end

function var_0_0.flowCurrentParent(arg_41_0)
	return
end

function var_0_0.getHeroItemList(arg_42_0)
	return arg_42_0._seasonHeroGroupListView:getHeroItemList()
end

function var_0_0.killEquipTweenId(arg_43_0)
	if arg_43_0.equipTweenId then
		ZProj.TweenHelper.KillById(arg_43_0.equipTweenId)

		arg_43_0.equipTweenId = nil
	end
end

function var_0_0._removeEvents(arg_44_0)
	arg_44_0._btnclickitem:RemoveClickListener()
	arg_44_0._btnclickequip:RemoveClickListener()
end

function var_0_0.onDestroy(arg_45_0)
	arg_45_0:_removeEvents()
	arg_45_0:killEquipTweenId()
	arg_45_0._simagecharactericon:UnLoadImage()

	if arg_45_0._leftSeasonCardItem then
		arg_45_0._leftSeasonCardItem:destroy()

		arg_45_0._leftSeasonCardItem = nil
	end

	if arg_45_0._rightSeasonCardItem then
		arg_45_0._rightSeasonCardItem:destroy()

		arg_45_0._rightSeasonCardItem = nil
	end

	if arg_45_0._drag then
		arg_45_0._drag:RemoveDragBeginListener()
		arg_45_0._drag:RemoveDragListener()
		arg_45_0._drag:RemoveDragEndListener()
	end

	if arg_45_0._cardItem1 then
		arg_45_0._cardItem1:destory()

		arg_45_0._cardItem1 = nil
	end

	TaskDispatcher.cancelTask(arg_45_0.hideDragEffect, arg_45_0)
end

return var_0_0
