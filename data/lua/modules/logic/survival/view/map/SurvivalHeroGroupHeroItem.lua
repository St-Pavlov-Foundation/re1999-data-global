module("modules.logic.survival.view.map.SurvivalHeroGroupHeroItem", package.seeall)

local var_0_0 = class("SurvivalHeroGroupHeroItem", HeroGroupHeroItem)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.findChild(arg_1_1, "heroitemani")

	arg_1_0._gohp = gohelper.findChild(arg_1_1, "heroitemani/#go_hp")
	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, SurvivalHeroHealthPart)

	var_0_0.super.init(arg_1_0, arg_1_1)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._commonHeroCard:setGrayScale(false)

	local var_2_0 = HeroGroupModel.instance.episodeId
	local var_2_1 = HeroGroupModel.instance.battleId
	local var_2_2 = var_2_1 and lua_battle.configDict[var_2_1]

	arg_2_0.mo = arg_2_1
	arg_2_0._posIndex = arg_2_0.mo.id - 1
	arg_2_0._heroMO = arg_2_1:getHeroMO()
	arg_2_0.monsterCO = arg_2_1:getMonsterCO()
	arg_2_0.trialCO = arg_2_1:getTrialCO()

	gohelper.setActive(arg_2_0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_2_3

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_2_3 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_2_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._lvnumen, "#E9E9E9")

	for iter_2_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._goRankList[iter_2_0], "#F6F3EC")
	end

	gohelper.setActive(arg_2_0._gohp, arg_2_0._heroMO)

	if arg_2_0._heroMO then
		arg_2_0._healthPart:setHeroId(arg_2_0._heroMO.heroId)
	end

	if arg_2_0._heroMO then
		local var_2_4 = arg_2_0._heroMO
		local var_2_5 = FightConfig.instance:getSkinCO(var_2_3 and var_2_3.skin or var_2_4.skin)

		arg_2_0._commonHeroCard:onUpdateMO(var_2_5)

		if arg_2_0.isLock or arg_2_0.isAid or arg_2_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_2_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_2_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_2_0._careericon, "lssx_" .. tostring(arg_2_0._heroMO.config.career))

		local var_2_6 = var_2_3 and var_2_3.level or arg_2_0._heroMO.level
		local var_2_7 = SurvivalBalanceHelper.getHeroBalanceLv(arg_2_0._heroMO.heroId)
		local var_2_8

		if var_2_6 < var_2_7 then
			var_2_6 = var_2_7
			var_2_8 = true
		end

		local var_2_9, var_2_10 = HeroConfig.instance:getShowLevel(var_2_6)

		if var_2_8 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._lvnumen, SurvivalBalanceHelper.BalanceColor)

			arg_2_0._lvnum.text = "<color=" .. SurvivalBalanceHelper.BalanceColor .. ">" .. var_2_9

			for iter_2_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._goRankList[iter_2_1], SurvivalBalanceHelper.BalanceIconColor)
			end
		else
			arg_2_0._lvnum.text = var_2_9
		end

		for iter_2_2 = 1, 3 do
			local var_2_11 = arg_2_0._goRankList[iter_2_2]

			gohelper.setActive(var_2_11, iter_2_2 == var_2_10 - 1)
		end

		gohelper.setActive(arg_2_0._goStars, true)

		for iter_2_3 = 1, 6 do
			local var_2_12 = arg_2_0._goStarList[iter_2_3]

			gohelper.setActive(var_2_12, iter_2_3 <= CharacterEnum.Star[arg_2_0._heroMO.config.rare])
		end
	elseif arg_2_0.monsterCO then
		local var_2_13 = FightConfig.instance:getSkinCO(arg_2_0.monsterCO.skinId)

		arg_2_0._commonHeroCard:onUpdateMO(var_2_13)
		UISpriteSetMgr.instance:setCommonSprite(arg_2_0._careericon, "lssx_" .. tostring(arg_2_0.monsterCO.career))

		local var_2_14, var_2_15 = HeroConfig.instance:getShowLevel(arg_2_0.monsterCO.level)

		arg_2_0._lvnum.text = var_2_14

		for iter_2_4 = 1, 3 do
			local var_2_16 = arg_2_0._goRankList[iter_2_4]

			gohelper.setActive(var_2_16, iter_2_4 == var_2_15 - 1)
		end

		gohelper.setActive(arg_2_0._goStars, false)
	elseif arg_2_0.trialCO then
		local var_2_17 = HeroConfig.instance:getHeroCO(arg_2_0.trialCO.heroId)
		local var_2_18

		if arg_2_0.trialCO.skin > 0 then
			var_2_18 = SkinConfig.instance:getSkinCo(arg_2_0.trialCO.skin)
		else
			var_2_18 = SkinConfig.instance:getSkinCo(var_2_17.skinId)
		end

		if arg_2_0.isLock or arg_2_0.isAid or arg_2_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_2_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_2_0._goblackmask.transform, 300)
		end

		arg_2_0._commonHeroCard:onUpdateMO(var_2_18)
		UISpriteSetMgr.instance:setCommonSprite(arg_2_0._careericon, "lssx_" .. tostring(var_2_17.career))

		local var_2_19, var_2_20 = HeroConfig.instance:getShowLevel(arg_2_0.trialCO.level)

		arg_2_0._lvnum.text = var_2_19

		for iter_2_5 = 1, 3 do
			local var_2_21 = arg_2_0._goRankList[iter_2_5]

			gohelper.setActive(var_2_21, iter_2_5 == var_2_20 - 1)
		end

		gohelper.setActive(arg_2_0._goStars, true)

		for iter_2_6 = 1, 6 do
			local var_2_22 = arg_2_0._goStarList[iter_2_6]

			gohelper.setActive(var_2_22, iter_2_6 <= CharacterEnum.Star[var_2_17.rare])
		end
	end

	if arg_2_0._heroItemContainer then
		arg_2_0._heroItemContainer.compColor[arg_2_0._lvnumen] = arg_2_0._lvnumen.color

		for iter_2_7 = 1, 3 do
			arg_2_0._heroItemContainer.compColor[arg_2_0._goRankList[iter_2_7]] = arg_2_0._goRankList[iter_2_7].color
		end
	end

	arg_2_0.isLock = false
	arg_2_0.isAidLock = arg_2_0.mo.aid and arg_2_0.mo.aid == -1
	arg_2_0.isAid = arg_2_0.mo.aid ~= nil
	arg_2_0.isTrialLock = (arg_2_0.mo.trial and arg_2_0.mo.trialPos) ~= nil

	local var_2_23 = HeroGroupModel.instance:getBattleRoleNum()

	arg_2_0.isRoleNumLock = false
	arg_2_0.isEmpty = arg_2_1:isEmpty()

	gohelper.setActive(arg_2_0._heroGO, (arg_2_0._heroMO ~= nil or arg_2_0.monsterCO ~= nil or arg_2_0.trialCO ~= nil) and not arg_2_0.isLock and not arg_2_0.isRoleNumLock)
	gohelper.setActive(arg_2_0._noneGO, arg_2_0._heroMO == nil and arg_2_0.monsterCO == nil and arg_2_0.trialCO == nil or arg_2_0.isLock or arg_2_0.isAidLock or arg_2_0.isRoleNumLock)
	gohelper.setActive(arg_2_0._addGO, arg_2_0._heroMO == nil and arg_2_0.monsterCO == nil and arg_2_0.trialCO == nil and not arg_2_0.isLock and not arg_2_0.isAidLock and not arg_2_0.isRoleNumLock)
	gohelper.setActive(arg_2_0._lockGO, arg_2_0:selfIsLock())
	gohelper.setActive(arg_2_0._aidGO, arg_2_0.mo.aid and arg_2_0.mo.aid ~= -1)

	if var_2_2 then
		gohelper.setActive(arg_2_0._subGO, not arg_2_0.isLock and not arg_2_0.isAidLock and not arg_2_0.isRoleNumLock and arg_2_0.mo.id > var_2_2.playerMax)
	else
		gohelper.setActive(arg_2_0._subGO, not arg_2_0.isLock and not arg_2_0.isAidLock and not arg_2_0.isRoleNumLock and arg_2_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(arg_2_0._tagTr, 36.3, arg_2_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_2_0.trialCO then
		gohelper.setActive(arg_2_0._trialTagGO, true)

		arg_2_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_2_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_2_0.isRoleNumLock and arg_2_0._heroMO ~= nil and arg_2_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_2_0._heroMO.id)
	end

	arg_2_0:initEquips()
	arg_2_0:showCounterSign()

	if arg_2_0._playDeathAnim then
		arg_2_0._playDeathAnim = nil

		arg_2_0:playAnim(UIAnimationName.Open)
	end

	arg_2_0:_showMojingTip()

	if arg_2_0._gorecommended.activeSelf or arg_2_0._gocounter.activeSelf then
		recthelper.setAnchorY(arg_2_0._gohp.transform, -288)
	else
		recthelper.setAnchorY(arg_2_0._gohp.transform, -275)
	end
end

function var_0_0.selfIsLock(arg_3_0)
	return false
end

function var_0_0.setScale(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._scaleX = arg_4_1 or 1
	arg_4_0._scaleY = arg_4_2 or 1
	arg_4_0._scaleZ = arg_4_3 or 1

	transformhelper.setLocalScale(arg_4_0.go.transform, arg_4_0._scaleX, arg_4_0._scaleY, arg_4_0._scaleZ)
end

function var_0_0.onItemEndDrag(arg_5_0, arg_5_1, arg_5_2)
	ZProj.TweenHelper.DOScale(arg_5_0.go.transform, arg_5_0._scaleX, arg_5_0._scaleY, arg_5_0._scaleZ, 0.2, nil, nil, nil, EaseType.Linear)
	arg_5_0:_setHeroItemPressState(false)
end

function var_0_0._onOpenEquipTeamView(arg_6_0)
	local var_6_0, var_6_1, var_6_2 = SurvivalBalanceHelper.getBalanceLv()

	arg_6_0._viewParam.isBalance = true
	arg_6_0._viewParam.balanceEquipLv = var_6_2

	EquipController.instance:openEquipInfoTeamView(arg_6_0._viewParam)
end

function var_0_0.initEquips(arg_7_0, arg_7_1)
	arg_7_0._equipType = -1

	if arg_7_0.isLock or arg_7_0.isAid or arg_7_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_7_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_7_0._equipGO, false)
		gohelper.setActive(arg_7_0._fakeEquipGO, false)
		gohelper.setActive(arg_7_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_7_0._equipGO, true)
		gohelper.setActive(arg_7_0._fakeEquipGO, true)
		gohelper.setActive(arg_7_0._emptyEquipGo, true)

		if not arg_7_0._equip then
			arg_7_0._equip = arg_7_0:getUserDataTb_()
			arg_7_0._equip.moveContainer = gohelper.findChild(arg_7_0._equipGO, "moveContainer")
			arg_7_0._equip.equipIcon = gohelper.findChildImage(arg_7_0._equipGO, "moveContainer/equipIcon")
			arg_7_0._equip.equipRare = gohelper.findChildImage(arg_7_0._equipGO, "moveContainer/equiprare")
			arg_7_0._equip.equiptxten = gohelper.findChildText(arg_7_0._equipGO, "equiptxten")
			arg_7_0._equip.equiptxtlv = gohelper.findChildText(arg_7_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_7_0._equip.equipGolv = gohelper.findChild(arg_7_0._equipGO, "moveContainer/equiplv")

			arg_7_0:_equipIconAddDrag(arg_7_0._equip.moveContainer, arg_7_0._equip.equipIcon)
		end

		local var_7_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_7_0.mo.id - 1).equipUid[1]

		arg_7_0._equipMO = EquipModel.instance:getEquip(var_7_0) or HeroGroupTrialModel.instance:getEquipMo(var_7_0)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			arg_7_0._equipMO = nil

			local var_7_1 = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[arg_7_0.mo.heroUid]

			if var_7_1 then
				local var_7_2 = EquipConfig.instance:getEquipCo(var_7_1.equipId)

				if var_7_2 then
					arg_7_0._equipMO = {}
					arg_7_0._equipMO.config = var_7_2
					arg_7_0._equipMO.refineLv = var_7_1.refineLv
					arg_7_0._equipMO.level = var_7_1.equipLv
				end
			end
		end

		local var_7_3

		if arg_7_0.trialCO and arg_7_0.trialCO.equipId > 0 then
			var_7_3 = EquipConfig.instance:getEquipCo(arg_7_0.trialCO.equipId)
		end

		if arg_7_0._equipMO then
			arg_7_0._equipType = arg_7_0._equipMO.config.rare - 2
		elseif var_7_3 then
			arg_7_0._equipType = var_7_3.rare - 2
		end

		gohelper.setActive(arg_7_0._equip.equipIcon.gameObject, arg_7_0._equipMO or var_7_3)
		gohelper.setActive(arg_7_0._equip.equipRare.gameObject, arg_7_0._equipMO or var_7_3)
		gohelper.setActive(arg_7_0._equip.equipAddGO, not arg_7_0._equipMO and not var_7_3)
		gohelper.setActive(arg_7_0._equip.equipGolv, arg_7_0._equipMO or var_7_3)
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._equip.equiptxten, (arg_7_0._equipMO or var_7_3) and 0.15 or 0.06)

		if arg_7_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_7_0._equip.equipIcon, arg_7_0._equipMO.config.icon)

			local var_7_4, var_7_5, var_7_6 = SurvivalBalanceHelper.getBalanceLv()

			if var_7_6 and var_7_6 > arg_7_0._equipMO.level and arg_7_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_7_0._equip.equiptxtlv.text = "<color=" .. SurvivalBalanceHelper.BalanceColor .. ">LV." .. var_7_6
			else
				arg_7_0._equip.equiptxtlv.text = "LV." .. arg_7_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_7_0._equip.equipRare, "bianduixingxian_" .. arg_7_0._equipMO.config.rare)
			arg_7_0:_showEquipParticleEffect(arg_7_1)
		elseif var_7_3 then
			local var_7_7 = EquipConfig.instance:getEquipCo(arg_7_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_7_0._equip.equipIcon, var_7_7.icon)

			arg_7_0._equip.equiptxtlv.text = "LV." .. arg_7_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_7_0._equip.equipRare, "bianduixingxian_" .. var_7_7.rare)
			arg_7_0:_showEquipParticleEffect(arg_7_1)
		end
	end

	arg_7_0.last_equip = arg_7_0._equipMO and arg_7_0._equipMO.uid
	arg_7_0.last_hero = arg_7_0._heroMO and arg_7_0._heroMO.heroId or 0
end

return var_0_0
