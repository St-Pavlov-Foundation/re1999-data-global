module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupHeroItem", package.seeall)

local var_0_0 = class("Act183HeroGroupHeroItem", HeroGroupHeroItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goleader = gohelper.findChild(arg_1_0.go, "heroitemani/hero/go_leader")
	arg_1_0._goleaderframe = gohelper.findChild(arg_1_0.go, "heroitemani/hero/go_leader/go_leaderframe")
	arg_1_0._goleadereffect = gohelper.findChild(arg_1_0.go, "heroitemani/hero/go_leader/go_leaderframe/#fit")
	arg_1_0._leaderTran = arg_1_0._goleader.transform
	arg_1_0._leaderFrameTran = arg_1_0._goleaderframe.transform
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

	if arg_2_0._heroMO then
		local var_2_4 = HeroModel.instance:getByHeroId(arg_2_0._heroMO.heroId)
		local var_2_5 = FightConfig.instance:getSkinCO(var_2_3 and var_2_3.skin or var_2_4.skin)

		arg_2_0._commonHeroCard:onUpdateMO(var_2_5)

		if arg_2_0.isLock or arg_2_0.isAid or arg_2_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_2_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_2_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_2_0._careericon, "lssx_" .. tostring(arg_2_0._heroMO.config.career))

		local var_2_6 = var_2_3 and var_2_3.level or arg_2_0._heroMO.level
		local var_2_7 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_2_0._heroMO.heroId)
		local var_2_8

		if var_2_6 < var_2_7 then
			var_2_6 = var_2_7
			var_2_8 = true
		end

		local var_2_9, var_2_10 = HeroConfig.instance:getShowLevel(var_2_6)

		if var_2_8 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_2_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_2_9

			for iter_2_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_2_0._goRankList[iter_2_1], HeroGroupBalanceHelper.BalanceIconColor)
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

	local var_2_24 = Act183Helper.isTeamLeader(var_2_0, arg_2_0._index)
	local var_2_25 = arg_2_0:hasHero()

	gohelper.setActive(arg_2_0._goleaderframe, var_2_24)
	gohelper.setActive(arg_2_0._goleadereffect, var_2_24 and var_2_25)
	arg_2_0:_setLeaderParent(var_2_25 and arg_2_0._leaderTran or arg_2_0._bgLeaderTran)
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

function var_0_0.onItemBeginDrag(arg_5_0, arg_5_1)
	var_0_0.super.onItemBeginDrag(arg_5_0, arg_5_1)

	if arg_5_1 == arg_5_0._index then
		arg_5_0:_setLeaderParent(arg_5_0._bgLeaderTran)
	end
end

function var_0_0.onItemEndDrag(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == arg_6_0.index or arg_6_2 == arg_6_0._index then
		arg_6_0:_setLeaderParent(arg_6_0._bgLeaderTran)
	end

	ZProj.TweenHelper.DOScale(arg_6_0.go.transform, arg_6_0._scaleX, arg_6_0._scaleY, arg_6_0._scaleZ, 0.2, function()
		arg_6_0:_setLeaderParent(arg_6_0:hasHero() and arg_6_0._leaderTran or arg_6_0._bgLeaderTran)
	end, nil, nil, EaseType.Linear)
	arg_6_0:_setHeroItemPressState(false)
end

function var_0_0.hasHero(arg_8_0)
	return arg_8_0._heroMO ~= nil or arg_8_0.monsterCO ~= nil or arg_8_0.trialCO ~= nil
end

function var_0_0.setBgLeaderTran(arg_9_0, arg_9_1)
	arg_9_0._bgLeaderTran = arg_9_1
end

function var_0_0._setLeaderParent(arg_10_0, arg_10_1)
	if gohelper.isNil(arg_10_1) then
		return
	end

	arg_10_0._leaderFrameTran:SetParent(arg_10_1, false)
end

return var_0_0
