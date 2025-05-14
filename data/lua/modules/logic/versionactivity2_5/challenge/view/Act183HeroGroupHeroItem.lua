module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupHeroItem", package.seeall)

local var_0_0 = class("Act183HeroGroupHeroItem", HeroGroupHeroItem)

function var_0_0.onUpdateMO(arg_1_0, arg_1_1)
	arg_1_0._commonHeroCard:setGrayScale(false)

	local var_1_0 = HeroGroupModel.instance.battleId
	local var_1_1 = var_1_0 and lua_battle.configDict[var_1_0]

	arg_1_0.mo = arg_1_1
	arg_1_0._posIndex = arg_1_0.mo.id - 1
	arg_1_0._heroMO = arg_1_1:getHeroMO()
	arg_1_0.monsterCO = arg_1_1:getMonsterCO()
	arg_1_0.trialCO = arg_1_1:getTrialCO()

	gohelper.setActive(arg_1_0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_1_2

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_1_2 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_1_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_1_0._lvnumen, "#E9E9E9")

	for iter_1_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_1_0._goRankList[iter_1_0], "#F6F3EC")
	end

	if arg_1_0._heroMO then
		local var_1_3 = HeroModel.instance:getByHeroId(arg_1_0._heroMO.heroId)
		local var_1_4 = FightConfig.instance:getSkinCO(var_1_2 and var_1_2.skin or var_1_3.skin)

		arg_1_0._commonHeroCard:onUpdateMO(var_1_4)

		if arg_1_0.isLock or arg_1_0.isAid or arg_1_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_1_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_1_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_1_0._careericon, "lssx_" .. tostring(arg_1_0._heroMO.config.career))

		local var_1_5 = var_1_2 and var_1_2.level or arg_1_0._heroMO.level
		local var_1_6 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_1_0._heroMO.heroId)
		local var_1_7

		if var_1_5 < var_1_6 then
			var_1_5 = var_1_6
			var_1_7 = true
		end

		local var_1_8, var_1_9 = HeroConfig.instance:getShowLevel(var_1_5)

		if var_1_7 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_1_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_1_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_1_8

			for iter_1_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_1_0._goRankList[iter_1_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_1_0._lvnum.text = var_1_8
		end

		for iter_1_2 = 1, 3 do
			local var_1_10 = arg_1_0._goRankList[iter_1_2]

			gohelper.setActive(var_1_10, iter_1_2 == var_1_9 - 1)
		end

		gohelper.setActive(arg_1_0._goStars, true)

		for iter_1_3 = 1, 6 do
			local var_1_11 = arg_1_0._goStarList[iter_1_3]

			gohelper.setActive(var_1_11, iter_1_3 <= CharacterEnum.Star[arg_1_0._heroMO.config.rare])
		end
	elseif arg_1_0.monsterCO then
		local var_1_12 = FightConfig.instance:getSkinCO(arg_1_0.monsterCO.skinId)

		arg_1_0._commonHeroCard:onUpdateMO(var_1_12)
		UISpriteSetMgr.instance:setCommonSprite(arg_1_0._careericon, "lssx_" .. tostring(arg_1_0.monsterCO.career))

		local var_1_13, var_1_14 = HeroConfig.instance:getShowLevel(arg_1_0.monsterCO.level)

		arg_1_0._lvnum.text = var_1_13

		for iter_1_4 = 1, 3 do
			local var_1_15 = arg_1_0._goRankList[iter_1_4]

			gohelper.setActive(var_1_15, iter_1_4 == var_1_14 - 1)
		end

		gohelper.setActive(arg_1_0._goStars, false)
	elseif arg_1_0.trialCO then
		local var_1_16 = HeroConfig.instance:getHeroCO(arg_1_0.trialCO.heroId)
		local var_1_17

		if arg_1_0.trialCO.skin > 0 then
			var_1_17 = SkinConfig.instance:getSkinCo(arg_1_0.trialCO.skin)
		else
			var_1_17 = SkinConfig.instance:getSkinCo(var_1_16.skinId)
		end

		if arg_1_0.isLock or arg_1_0.isAid or arg_1_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_1_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_1_0._goblackmask.transform, 300)
		end

		arg_1_0._commonHeroCard:onUpdateMO(var_1_17)
		UISpriteSetMgr.instance:setCommonSprite(arg_1_0._careericon, "lssx_" .. tostring(var_1_16.career))

		local var_1_18, var_1_19 = HeroConfig.instance:getShowLevel(arg_1_0.trialCO.level)

		arg_1_0._lvnum.text = var_1_18

		for iter_1_5 = 1, 3 do
			local var_1_20 = arg_1_0._goRankList[iter_1_5]

			gohelper.setActive(var_1_20, iter_1_5 == var_1_19 - 1)
		end

		gohelper.setActive(arg_1_0._goStars, true)

		for iter_1_6 = 1, 6 do
			local var_1_21 = arg_1_0._goStarList[iter_1_6]

			gohelper.setActive(var_1_21, iter_1_6 <= CharacterEnum.Star[var_1_16.rare])
		end
	end

	if arg_1_0._heroItemContainer then
		arg_1_0._heroItemContainer.compColor[arg_1_0._lvnumen] = arg_1_0._lvnumen.color

		for iter_1_7 = 1, 3 do
			arg_1_0._heroItemContainer.compColor[arg_1_0._goRankList[iter_1_7]] = arg_1_0._goRankList[iter_1_7].color
		end
	end

	arg_1_0.isLock = false
	arg_1_0.isAidLock = arg_1_0.mo.aid and arg_1_0.mo.aid == -1
	arg_1_0.isAid = arg_1_0.mo.aid ~= nil
	arg_1_0.isTrialLock = (arg_1_0.mo.trial and arg_1_0.mo.trialPos) ~= nil

	local var_1_22 = HeroGroupModel.instance:getBattleRoleNum()

	arg_1_0.isRoleNumLock = false
	arg_1_0.isEmpty = arg_1_1:isEmpty()

	gohelper.setActive(arg_1_0._heroGO, (arg_1_0._heroMO ~= nil or arg_1_0.monsterCO ~= nil or arg_1_0.trialCO ~= nil) and not arg_1_0.isLock and not arg_1_0.isRoleNumLock)
	gohelper.setActive(arg_1_0._noneGO, arg_1_0._heroMO == nil and arg_1_0.monsterCO == nil and arg_1_0.trialCO == nil or arg_1_0.isLock or arg_1_0.isAidLock or arg_1_0.isRoleNumLock)
	gohelper.setActive(arg_1_0._addGO, arg_1_0._heroMO == nil and arg_1_0.monsterCO == nil and arg_1_0.trialCO == nil and not arg_1_0.isLock and not arg_1_0.isAidLock and not arg_1_0.isRoleNumLock)
	gohelper.setActive(arg_1_0._lockGO, arg_1_0:selfIsLock())
	gohelper.setActive(arg_1_0._aidGO, arg_1_0.mo.aid and arg_1_0.mo.aid ~= -1)

	if var_1_1 then
		gohelper.setActive(arg_1_0._subGO, not arg_1_0.isLock and not arg_1_0.isAidLock and not arg_1_0.isRoleNumLock and arg_1_0.mo.id > var_1_1.playerMax)
	else
		gohelper.setActive(arg_1_0._subGO, not arg_1_0.isLock and not arg_1_0.isAidLock and not arg_1_0.isRoleNumLock and arg_1_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(arg_1_0._tagTr, 36.3, arg_1_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_1_0.trialCO then
		gohelper.setActive(arg_1_0._trialTagGO, true)

		arg_1_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_1_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_1_0.isRoleNumLock and arg_1_0._heroMO ~= nil and arg_1_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_1_0._heroMO.id)
	end

	arg_1_0:initEquips()
	arg_1_0:showCounterSign()

	if arg_1_0._playDeathAnim then
		arg_1_0._playDeathAnim = nil

		arg_1_0:playAnim(UIAnimationName.Open)
	end

	arg_1_0:_showMojingTip()
end

function var_0_0.selfIsLock(arg_2_0)
	return false
end

function var_0_0.setScale(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._scaleX = arg_3_1 or 1
	arg_3_0._scaleY = arg_3_2 or 1
	arg_3_0._scaleZ = arg_3_3 or 1

	transformhelper.setLocalScale(arg_3_0.go.transform, arg_3_0._scaleX, arg_3_0._scaleY, arg_3_0._scaleZ)
end

function var_0_0.onItemEndDrag(arg_4_0, arg_4_1, arg_4_2)
	ZProj.TweenHelper.DOScale(arg_4_0.go.transform, arg_4_0._scaleX, arg_4_0._scaleY, arg_4_0._scaleZ, 0.2, nil, nil, nil, EaseType.Linear)
	arg_4_0:_setHeroItemPressState(false)
end

return var_0_0
