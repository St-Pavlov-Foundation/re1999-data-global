module("modules.logic.fight.view.FightStatItem", package.seeall)

local var_0_0 = class("FightStatItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroIcon = gohelper.findChildSingleImage(arg_1_1, "heroinfo/hero/icon")
	arg_1_0._career = gohelper.findChildImage(arg_1_1, "heroinfo/career")
	arg_1_0._rare = gohelper.findChildImage(arg_1_1, "heroinfo/rare")
	arg_1_0._front = gohelper.findChildImage(arg_1_1, "heroinfo/front")
	arg_1_0.goLayout = gohelper.findChild(arg_1_1, "heroinfo/layout")
	arg_1_0.goRare = gohelper.findChild(arg_1_1, "heroinfo/rare")
	arg_1_0.goCareer = gohelper.findChild(arg_1_1, "heroinfo/career")
	arg_1_0._gorankobj = gohelper.findChild(arg_1_1, "heroinfo/layout/rankobj")
	arg_1_0._rankGOs = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0._rankGOs[iter_1_0] = gohelper.findChildImage(arg_1_0._gorankobj, "rank" .. tostring(iter_1_0))
	end

	arg_1_0._txtLv = gohelper.findChildText(arg_1_1, "heroinfo/layout/txtLv")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "heroinfo/txtName")
	arg_1_0._txtHarm = gohelper.findChildText(arg_1_1, "data/txtHarm")
	arg_1_0._txtHurt = gohelper.findChildText(arg_1_1, "data/txtHurt")
	arg_1_0._txtHeal = gohelper.findChildText(arg_1_1, "data/txtHeal")
	arg_1_0._txtHarmRate = gohelper.findChildText(arg_1_1, "data/txtHarmRate")
	arg_1_0._txtHurtRate = gohelper.findChildText(arg_1_1, "data/txtHurtRate")
	arg_1_0._txtHealRate = gohelper.findChildText(arg_1_1, "data/txtHealRate")
	arg_1_0._imgProgressHarm = gohelper.findChildImage(arg_1_1, "data/progressHarm/progress")
	arg_1_0._imgProgressHurt = gohelper.findChildImage(arg_1_1, "data/progressHurt/progress")
	arg_1_0._imgProgressHeal = gohelper.findChildImage(arg_1_1, "data/progressHeal/progress")
	arg_1_0._godata = gohelper.findChild(arg_1_1, "data")
	arg_1_0._goskill = gohelper.findChild(arg_1_1, "skill")
	arg_1_0._scrollUseSkill = gohelper.findChild(arg_1_1, "skill/scroll_useskill"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._goskillContent = gohelper.findChild(arg_1_1, "skill/scroll_useskill/Viewport/Content")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_1, "skill/scroll_useskill/Viewport/Content/skillItem")
	arg_1_0._goscrolluseskill = gohelper.findChild(arg_1_1, "skill/scroll_useskill")
	arg_1_0._goskillempty = gohelper.findChild(arg_1_1, "skill/go_skillempty")
	arg_1_0._skillItems = arg_1_0:getUserDataTb_()

	gohelper.setActive(arg_1_0._goskillItem, false)

	arg_1_0._statType = FightEnum.FightStatType.DataView
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.SwitchInfoState, arg_2_0._refreshInfoUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.SwitchInfoState, arg_3_0._refreshInfoUI, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0.entityMO = arg_4_1.entityMO or FightDataHelper.entityMgr:getById(arg_4_1.entityId)

	if arg_4_1.entityId == FightASFDDataMgr.EmitterId then
		arg_4_0.entityMO = FightDataHelper.ASFDDataMgr:getEmitterEmitterMo()
	end

	local var_4_0 = ViewMgr.instance:isOpen(ViewName.Act174FightResultView)
	local var_4_1 = ViewMgr.instance:isOpen(ViewName.Act191FightSuccView)
	local var_4_2 = arg_4_0._mo.fromOtherFight
	local var_4_3 = lua_character.configDict[arg_4_0.entityMO.modelId]

	gohelper.setActive(arg_4_0.goLayout, true)
	gohelper.setActive(arg_4_0.goRare, true)
	gohelper.setActive(arg_4_0.goCareer, true)

	if arg_4_0.entityMO:isAssistBoss() then
		arg_4_0:refreshAssistBossInfo()
	elseif arg_4_0.entityMO:isASFDEmitter() then
		arg_4_0:refreshASFDInfo()
	elseif var_4_0 then
		arg_4_0:refreshAct174Info()
	elseif var_4_1 then
		arg_4_0:refreshAct191Info()
	elseif not var_4_3 then
		local var_4_4 = lua_monster.configDict[arg_4_0.entityMO.modelId]

		arg_4_0._txtName.text = FightConfig.instance:getNewMonsterConfig(var_4_4) and var_4_4.highPriorityName or var_4_4.name

		if var_4_4 then
			local var_4_5, var_4_6 = HeroConfig.instance:getShowLevel(var_4_4.level)

			arg_4_0._txtLv.text = string.format("<size=20>Lv.</size>%d", var_4_5)

			gohelper.setActive(arg_4_0._gorankobj, var_4_6 > 1)

			for iter_4_0 = 1, 3 do
				gohelper.setActive(arg_4_0._rankGOs[iter_4_0], var_4_6 > 1 and iter_4_0 == var_4_6 - 1 or false)
			end

			local var_4_7 = FightConfig.instance:getSkinCO(var_4_4.skinId)

			arg_4_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_4_7.retangleIcon))
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0._career, "lssx_" .. tostring(var_4_4.career))
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0._rare, "bgequip" .. 1)
		end
	else
		local var_4_8 = arg_4_0.entityMO:getTrialAttrCo()

		arg_4_0._txtName.text = var_4_3 and var_4_3.name or ""

		if var_4_8 then
			arg_4_0._txtName.text = var_4_8.name
		end

		if not var_4_2 and FightReplayModel.instance:isReplay() then
			local var_4_9, var_4_10 = HeroConfig.instance:getShowLevel(arg_4_0.entityMO.level)

			arg_4_0._txtLv.text = string.format("<size=20>Lv.</size>%d", var_4_9)

			gohelper.setActive(arg_4_0._gorankobj, var_4_10 > 1)

			for iter_4_1 = 1, 3 do
				gohelper.setActive(arg_4_0._rankGOs[iter_4_1], var_4_10 > 1 and iter_4_1 == var_4_10 - 1 or false)
			end

			local var_4_11 = FightConfig.instance:getSkinCO(arg_4_0.entityMO.skin)

			arg_4_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_4_11.retangleIcon))
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0._career, "lssx_" .. tostring(var_4_3.career))
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0._rare, "bgequip" .. CharacterEnum.Star[var_4_3.rare])
		else
			local var_4_12 = HeroModel.instance:getByHeroId(arg_4_0.entityMO.modelId)

			if not var_4_12 and var_4_3 or tonumber(arg_4_0.entityMO.uid) < 0 or var_4_2 then
				var_4_12 = HeroMo.New()

				var_4_12:initFromConfig(var_4_3)

				var_4_12.level = arg_4_0.entityMO.level
				var_4_12.skin = arg_4_0.entityMO.skin
			end

			if var_4_12 then
				local var_4_13 = HeroGroupBalanceHelper.getHeroBalanceLv(var_4_12.heroId)
				local var_4_14

				if var_4_13 and var_4_13 > var_4_12.level and not var_4_2 then
					var_4_14 = true

					for iter_4_2 = 1, 3 do
						SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._rankGOs[iter_4_2], "#547a99")
					end
				else
					for iter_4_3 = 1, 3 do
						SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._rankGOs[iter_4_3], "#342929")
					end
				end

				local var_4_15 = arg_4_0.entityMO and arg_4_0.entityMO.level or var_4_12.level
				local var_4_16, var_4_17 = HeroConfig.instance:getShowLevel(var_4_14 and var_4_13 or var_4_15)

				arg_4_0._txtLv.text = (var_4_14 and "<color=#547a99>" or "") .. string.format("<size=20>Lv.</size>%d", var_4_16)

				gohelper.setActive(arg_4_0._gorankobj, var_4_17 > 1)

				for iter_4_4 = 1, 3 do
					gohelper.setActive(arg_4_0._rankGOs[iter_4_4], var_4_17 > 1 and iter_4_4 == var_4_17 - 1 or false)
				end

				local var_4_18 = arg_4_0.entityMO and arg_4_0.entityMO.skin or var_4_12.skin
				local var_4_19 = FightConfig.instance:getSkinCO(var_4_18)

				arg_4_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_4_19.retangleIcon))
				UISpriteSetMgr.instance:setCommonSprite(arg_4_0._career, "lssx_" .. tostring(var_4_12.config.career))
				UISpriteSetMgr.instance:setCommonSprite(arg_4_0._rare, "bgequip" .. CharacterEnum.Star[var_4_12.config.rare])
			end
		end
	end

	arg_4_0._txtHarm.text = arg_4_1.harm
	arg_4_0._txtHurt.text = arg_4_1.hurt
	arg_4_0._txtHeal.text = arg_4_1.heal

	local var_4_20 = FightStatModel.instance:getTotalHarm()
	local var_4_21 = FightStatModel.instance:getTotalHurt()
	local var_4_22 = FightStatModel.instance:getTotalHeal()
	local var_4_23 = var_4_20 > 0 and arg_4_1.harm / var_4_20 or 0
	local var_4_24 = var_4_21 > 0 and arg_4_1.hurt / var_4_21 or 0
	local var_4_25 = var_4_22 > 0 and arg_4_1.heal / var_4_22 or 0

	arg_4_0._txtHarmRate.text = string.format("%.2f%%", var_4_23 * 100)
	arg_4_0._txtHurtRate.text = string.format("%.2f%%", var_4_24 * 100)
	arg_4_0._txtHealRate.text = string.format("%.2f%%", var_4_25 * 100)

	if not arg_4_0._tweenHarm then
		arg_4_0._tweenHarm = ZProj.TweenHelper.DOFillAmount(arg_4_0._imgProgressHarm, var_4_23, var_4_23 * 2)
		arg_4_0._tweenHurt = ZProj.TweenHelper.DOFillAmount(arg_4_0._imgProgressHurt, var_4_24, var_4_24 * 2)
		arg_4_0._tweenHeal = ZProj.TweenHelper.DOFillAmount(arg_4_0._imgProgressHeal, var_4_25, var_4_25 * 2)
	else
		arg_4_0._imgProgressHarm.fillAmount = var_4_23
		arg_4_0._imgProgressHurt.fillAmount = var_4_24
		arg_4_0._imgProgressHeal.fillAmount = var_4_25
	end

	arg_4_0:_refreshInfoUI(arg_4_0._statType)
end

function var_0_0._refreshInfoUI(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_0._view.viewContainer.fightStatView:getStatType()

	if var_5_1 and var_5_1 ~= var_5_0 then
		var_5_0 = var_5_1
	end

	arg_5_0._scrollUseSkill.parentGameObject = arg_5_0._view._csListScroll.gameObject
	arg_5_0._statType = var_5_0 or arg_5_0._statType

	gohelper.setActive(arg_5_0._godata, var_5_0 == FightEnum.FightStatType.DataView)
	gohelper.setActive(arg_5_0._goskill, var_5_0 == FightEnum.FightStatType.SkillView)
	gohelper.setActive(arg_5_0._goscrolluseskill, GameUtil.getTabLen(arg_5_0._mo.cards) > 0)
	gohelper.setActive(arg_5_0._goskillempty, GameUtil.getTabLen(arg_5_0._mo.cards) == 0)

	local var_5_2 = GameUtil.getTabLen(arg_5_0._mo.cards)
	local var_5_3 = GameUtil.getTabLen(arg_5_0._skillItems)

	if var_5_2 > 0 and var_5_0 == FightEnum.FightStatType.SkillView then
		arg_5_0:_sortCard()

		for iter_5_0, iter_5_1 in ipairs(arg_5_0._mo.cards) do
			local var_5_4 = arg_5_0._skillItems[iter_5_0]

			if not var_5_4 then
				var_5_4 = arg_5_0:getUserDataTb_()
				var_5_4.go = gohelper.clone(arg_5_0._goskillItem, arg_5_0._goskillContent, "skillitem" .. iter_5_0)
				var_5_4.skillIconGo = arg_5_0:getUserDataTb_()

				for iter_5_2 = 0, 4 do
					local var_5_5 = gohelper.findChild(var_5_4.go, "skillicon" .. iter_5_2)
					local var_5_6 = arg_5_0:getUserDataTb_()

					var_5_6.go = var_5_5
					var_5_6.imgIcon = gohelper.findChildSingleImage(var_5_5, "imgIcon")
					var_5_6.tag = gohelper.findChildSingleImage(var_5_5, "tag/tagIcon")
					var_5_6.count = gohelper.findChildText(var_5_5, "count/txt_count")
					var_5_6.goStar = gohelper.findChildText(var_5_5, "star")
					var_5_4.skillIconGo[iter_5_2 + 1] = var_5_6
				end

				table.insert(arg_5_0._skillItems, var_5_4)
			end

			for iter_5_3, iter_5_4 in ipairs(var_5_4.skillIconGo) do
				iter_5_4.isBigSkill = FightCardDataHelper.isBigSkill(iter_5_1.skillId)

				if lua_skill_next.configDict[iter_5_1.skillId] then
					iter_5_4.isBigSkill = false
				end

				gohelper.setActive(iter_5_4.goStar, true)
			end

			gohelper.setActive(var_5_4.go, true)
			arg_5_0:_setSkillCardInfo(var_5_4, iter_5_1)
		end
	end

	if var_5_2 < var_5_3 then
		for iter_5_5 = var_5_2 + 1, var_5_3 do
			local var_5_7 = arg_5_0._skillItems[iter_5_5]

			gohelper.setActive(var_5_7 and var_5_7.go, false)
		end
	end
end

function var_0_0._sortCard(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._mo.cards) do
		for iter_6_2, iter_6_3 in ipairs(arg_6_0.entityMO.skillGroup1) do
			if iter_6_3 == iter_6_1.skillId then
				var_6_0[iter_6_3] = 1
			end
		end

		for iter_6_4, iter_6_5 in ipairs(arg_6_0.entityMO.skillGroup2) do
			if iter_6_5 == iter_6_1.skillId then
				var_6_0[iter_6_5] = 2
			end
		end

		if FightCardDataHelper.isBigSkill(iter_6_1.skillId) then
			var_6_0[iter_6_1.skillId] = 0
		end
	end

	table.sort(arg_6_0._mo.cards, function(arg_7_0, arg_7_1)
		if var_6_0[arg_7_0.skillId] ~= var_6_0[arg_7_1.skillId] then
			local var_7_0 = var_6_0[arg_7_0.skillId]
			local var_7_1 = var_6_0[arg_7_1.skillId]

			if var_7_0 and var_7_1 then
				return var_7_0 < var_7_1
			else
				return var_7_0 and true or false
			end
		else
			return arg_6_0.entityMO:getSkillLv(arg_7_0.skillId) < arg_6_0.entityMO:getSkillLv(arg_7_1.skillId)
		end

		return false
	end)
end

function var_0_0._setSkillCardInfo(arg_8_0, arg_8_1, arg_8_2)
	if FightHelper.isASFDSkill(arg_8_2.skillId) then
		return arg_8_0:refreshASFDSkill(arg_8_1, arg_8_2)
	end

	local var_8_0 = arg_8_0.entityMO:getSkillLv(arg_8_2.skillId)
	local var_8_1 = lua_skill.configDict[arg_8_2.skillId]

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.skillIconGo) do
		local var_8_2 = iter_8_0 - 1

		gohelper.setActive(iter_8_1.go, var_8_2 == var_8_0)

		if var_8_2 == var_8_0 then
			local var_8_3 = ResUrl.getSkillIcon(var_8_1.icon)

			iter_8_1.imgIcon:LoadImage(var_8_3)

			if not iter_8_1.isBigSkill then
				iter_8_1.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_8_1.showTag))
			end

			iter_8_1.count.text = arg_8_2.useCount

			gohelper.setActive(arg_8_1.goStar, false)
		end
	end
end

function var_0_0.refreshASFDSkill(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = 1

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.skillIconGo) do
		gohelper.setActive(iter_9_1.go, iter_9_0 == var_9_0)

		if iter_9_0 == var_9_0 then
			local var_9_1 = ResUrl.getSkillIcon(FightASFDConfig.instance.normalSkillIcon)

			iter_9_1.imgIcon:LoadImage(var_9_1)
			iter_9_1.tag:LoadImage(ResUrl.getAttributeIcon("attribute_asfd"))

			iter_9_1.count.text = arg_9_2.useCount
		end
	end
end

function var_0_0.refreshAssistBossInfo(arg_10_0)
	local var_10_0 = TowerConfig.instance:getAssistBossConfig(arg_10_0.entityMO.modelId)

	if not var_10_0 then
		return
	end

	arg_10_0._txtName.text = var_10_0.name

	local var_10_1 = TowerModel.instance:getFightFinishParam()
	local var_10_2 = var_10_1 and var_10_1.teamLevel or 0
	local var_10_3, var_10_4 = HeroConfig.instance:getShowLevel(var_10_2)

	arg_10_0._txtLv.text = string.format("<size=20>LV.</size>%d", var_10_3)

	gohelper.setActive(arg_10_0._gorankobj, var_10_4 > 1)

	for iter_10_0 = 1, 3 do
		gohelper.setActive(arg_10_0._rankGOs[iter_10_0], var_10_4 > 1 and iter_10_0 == var_10_4 - 1 or false)
	end

	local var_10_5 = FightConfig.instance:getSkinCO(var_10_0.skinId)

	arg_10_0._heroIcon:LoadImage(ResUrl.monsterHeadIcon(var_10_5.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._career, "lssx_" .. tostring(var_10_0.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._rare, "bgequip" .. 6)
end

function var_0_0.refreshASFDInfo(arg_11_0)
	arg_11_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(FightASFDConfig.instance.headIcon))

	local var_11_0 = FightASFDConfig.instance:getSkillCo()

	arg_11_0._txtName.text = var_11_0.name

	gohelper.setActive(arg_11_0.goLayout, false)
	gohelper.setActive(arg_11_0.goRare, false)
	gohelper.setActive(arg_11_0.goCareer, false)
end

function var_0_0.onDestroy(arg_12_0)
	if arg_12_0._tweenHarm then
		ZProj.TweenHelper.KillById(arg_12_0._tweenHarm)
		ZProj.TweenHelper.KillById(arg_12_0._tweenHurt)
		ZProj.TweenHelper.KillById(arg_12_0._tweenHeal)
	end

	arg_12_0._tweenHarm = nil
	arg_12_0._tweenHurt = nil
	arg_12_0._tweenHeal = nil

	for iter_12_0, iter_12_1 in pairs(arg_12_0._skillItems) do
		if iter_12_1 then
			for iter_12_2, iter_12_3 in pairs(iter_12_1.skillIconGo) do
				iter_12_3.imgIcon:UnLoadImage()

				if not iter_12_3.isBigSkill then
					iter_12_3.tag:UnLoadImage()
				end
			end
		end
	end

	arg_12_0._heroIcon:UnLoadImage()
end

function var_0_0.refreshAct174Info(arg_13_0)
	gohelper.setActive(arg_13_0.goLayout, false)
	recthelper.setAnchorY(arg_13_0._txtName.gameObject.transform, 0)

	local var_13_0 = arg_13_0.entityMO.modelId

	if var_13_0 then
		local var_13_1 = Activity174Config.instance:getRoleCoByHeroId(var_13_0)

		UISpriteSetMgr.instance:setCommonSprite(arg_13_0._career, "lssx_" .. tostring(var_13_1.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_13_0._rare, "bgequip" .. CharacterEnum.Color[var_13_1.rare])
		arg_13_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_13_1.skinId))

		arg_13_0._txtName.text = var_13_1.name
	end
end

function var_0_0.refreshAct191Info(arg_14_0)
	gohelper.setActive(arg_14_0.goLayout, false)
	recthelper.setAnchorY(arg_14_0._txtName.gameObject.transform, 0)

	local var_14_0 = arg_14_0.entityMO.modelId

	if var_14_0 then
		local var_14_1 = Activity191Config.instance:getRoleCoByNativeId(var_14_0, 1)

		UISpriteSetMgr.instance:setCommonSprite(arg_14_0._career, "lssx_" .. tostring(var_14_1.career))
		UISpriteSetMgr.instance:setAct174Sprite(arg_14_0._rare, "act191_collection_rolebg")
		transformhelper.setLocalScale(arg_14_0._rare.gameObject.transform, 0.8, 0.8, 1)
		UISpriteSetMgr.instance:setAct174Sprite(arg_14_0._front, "act174_roleframe_" .. var_14_1.quality)
		gohelper.setActive(arg_14_0._front, true)
		arg_14_0._heroIcon:LoadImage(ResUrl.getHeadIconSmall(var_14_1.skinId))

		arg_14_0._txtName.text = var_14_1.name
	end
end

return var_0_0
