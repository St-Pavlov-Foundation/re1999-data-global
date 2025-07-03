module("modules.logic.herogroup.view.HeroGroupRecommendGroupItem", package.seeall)

local var_0_0 = class("HeroGroupRecommendGroupItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtrank = gohelper.findChildText(arg_1_1, "#go_info/rankhead/#txt_rank")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_1, "#go_info/#txt_num")
	arg_1_0._txtherogrouprate = gohelper.findChildText(arg_1_1, "#go_info/#txt_herogrouprate")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_1, "#go_info/herogrouplist/#go_heroitem")
	arg_1_0._simagecloth = gohelper.findChildSingleImage(arg_1_1, "#go_info/#simage_cloth")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_1, "#go_info/#btn_use")
	arg_1_0._goinfo = gohelper.findChild(arg_1_1, "#go_info")
	arg_1_0._gonull = gohelper.findChild(arg_1_1, "#go_null")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_1, "#simage_bg")
	arg_1_0._gobossItem = gohelper.findChild(arg_1_1, "#go_info/#go_bossitem")
	arg_1_0._gobossEmpty = gohelper.findChild(arg_1_1, "#go_info/#go_bossitem/go_empty")
	arg_1_0._gobossContainer = gohelper.findChild(arg_1_1, "#go_info/#go_bossitem/go_container")
	arg_1_0._simageBossIcon = gohelper.findChildSingleImage(arg_1_1, "#go_info/#go_bossitem/go_container/simage_bossicon")
	arg_1_0._imageBossCareer = gohelper.findChildImage(arg_1_1, "#go_info/#go_bossitem/go_container/image_career")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnuse:RemoveClickListener()
end

function var_0_0._btnuseOnClick(arg_4_0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroup)

	local var_4_0 = arg_4_0._mo.heroDataList
	local var_4_1 = {}
	local var_4_2 = HeroGroupModel.instance.battleId
	local var_4_3 = lua_battle.configDict[var_4_2]
	local var_4_4 = {}

	if not string.nilorempty(var_4_3.aid) then
		var_4_4 = string.splitToNumber(var_4_3.aid, "#")
	end

	local var_4_5 = {}
	local var_4_6 = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)

	if not string.nilorempty(var_4_6) then
		var_4_5 = GameUtil.splitString2(var_4_6, true)
	end

	local var_4_7 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_5) do
		if iter_4_1[3] then
			var_4_7[lua_hero_trial.configDict[iter_4_1[1]][iter_4_1[2]].heroId] = true
		end
	end

	for iter_4_2 = 1, #var_4_0 do
		local var_4_8 = var_4_0[iter_4_2].heroId

		if var_4_8 and var_4_8 > 0 then
			local var_4_9 = HeroModel.instance:getByHeroId(var_4_8)

			if HeroGroupModel.instance:isAdventureOrWeekWalk() then
				if WeekWalkModel.instance:getCurMapHeroCd(var_4_8) > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					var_4_9 = nil
				end
			elseif var_4_9 and HeroGroupModel.instance:isRestrict(var_4_9.uid) then
				local var_4_10 = HeroGroupModel.instance:getCurrentBattleConfig()
				local var_4_11 = var_4_10 and var_4_10.restrictReason

				if not string.nilorempty(var_4_11) then
					ToastController.instance:showToastWithString(var_4_11)
				end

				var_4_9 = nil
			end

			if var_4_7[var_4_8] then
				var_4_9 = nil
			end

			if var_4_9 then
				table.insert(var_4_1, var_4_9.uid)
			else
				table.insert(var_4_1, "0")
			end
		else
			table.insert(var_4_1, "0")
		end
	end

	local var_4_12 = HeroGroupModel.instance:getCurGroupMO()
	local var_4_13 = 0

	if arg_4_0._mo.cloth and arg_4_0._mo.cloth ~= 0 and PlayerClothModel.instance:canUse(arg_4_0._mo.cloth) then
		var_4_13 = arg_4_0._mo.cloth
	elseif OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		local var_4_14 = PlayerClothModel.instance:getList()

		for iter_4_3, iter_4_4 in ipairs(var_4_14) do
			if PlayerClothModel.instance:hasCloth(iter_4_4.id) then
				var_4_13 = iter_4_4.id

				break
			end
		end
	end

	local var_4_15 = {
		groupId = var_4_12.id,
		name = var_4_12.name,
		clothId = var_4_13,
		heroList = var_4_1
	}

	if TowerModel.instance:isInTowerBattle() then
		arg_4_0:onTowerUse(var_4_15, var_4_12, var_4_4, var_4_3.roleNum, var_4_3.playerMax, true, var_4_5)

		return
	end

	var_4_12:initWithBattle(var_4_15, var_4_4, var_4_3.roleNum, var_4_3.playerMax, true, var_4_5)
	HeroSingleGroupModel.instance:setSingleGroup(var_4_12, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnUseRecommendGroupFinish)
end

function var_0_0.onTowerUse(arg_5_0, arg_5_1, arg_5_2, ...)
	local var_5_0 = TowerModel.instance:getRecordFightParam()

	if var_5_0 and var_5_0.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)
		ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)

		return
	end

	local var_5_1 = arg_5_0._mo.assistBossId

	if var_5_1 and var_5_1 > 0 and var_5_0 and not var_5_0.isHeroGroupLock and not TowerModel.instance:isBossBan(var_5_1) and not TowerModel.instance:isLimitTowerBossBan(var_5_0.towerType, var_5_0.towerId, var_5_1) and TowerAssistBossModel.instance:getById(var_5_1) and TowerController.instance:isBossTowerOpen() then
		arg_5_1.assistBossId = var_5_1
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.heroList) do
		local var_5_2 = HeroModel.instance:getById(iter_5_1)

		if var_5_2 and TowerModel.instance:isHeroBan(var_5_2.heroId) then
			arg_5_1.heroList[iter_5_0] = tostring(0)
		end
	end

	arg_5_2:initWithBattle(arg_5_1, ...)
	HeroSingleGroupModel.instance:setSingleGroup(arg_5_2, true)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
	ViewMgr.instance:closeView(ViewName.HeroGroupRecommendView)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goheroitem, false)

	arg_6_0._heroItemList = {}

	arg_6_0._simagebg:LoadImage(ResUrl.getHeroGroupBg("biandui_youdi"))

	arg_6_0._imagebg = arg_6_0._simagebg:GetComponent(gohelper.Type_Image)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	gohelper.setActive(arg_7_0._gonull, arg_7_0._mo.isEmpty)
	gohelper.setActive(arg_7_0._goinfo, not arg_7_0._mo.isEmpty)
	ZProj.UGUIHelper.SetColorAlpha(arg_7_0._imagebg, arg_7_0._mo.isEmpty and 0.5 or 1)

	if arg_7_0._mo.isEmpty then
		return
	end

	arg_7_0._txtrank.text = string.format("%d", arg_7_0._index)
	arg_7_0._txtherogrouprate.text = string.format("%s%%", math.floor(arg_7_0._mo.rate * 10000) / 100)

	local var_7_0 = arg_7_0._mo.cloth and arg_7_0._mo.cloth ~= 0 and lua_cloth.configDict[arg_7_0._mo.cloth]

	gohelper.setActive(arg_7_0._simagecloth.gameObject, var_7_0)

	if var_7_0 then
		arg_7_0._simagecloth:LoadImage(ResUrl.getPlayerClothIcon(var_7_0.icon))
	end

	arg_7_0:_refreshHeroItem()

	arg_7_0._txtnum.text = GameUtil.getEnglishOrderNumber(arg_7_0._index)

	arg_7_0:refreshTowerBossUI()
end

function var_0_0._refreshHeroItem(arg_8_0)
	local var_8_0 = arg_8_0._mo.heroDataList

	for iter_8_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_8_1 = var_8_0[iter_8_0]
		local var_8_2 = arg_8_0._heroItemList[iter_8_0]

		if not var_8_2 then
			var_8_2 = arg_8_0:getUserDataTb_()
			var_8_2.go = gohelper.cloneInPlace(arg_8_0._goheroitem, "item" .. iter_8_0)
			var_8_2.gocontainer = gohelper.findChild(var_8_2.go, "go_container")
			var_8_2.simageheroicon = gohelper.findChildSingleImage(var_8_2.go, "go_container/simage_heroicon")
			var_8_2.imagecareer = gohelper.findChildImage(var_8_2.go, "go_container/image_career")
			var_8_2.goaidtag = gohelper.findChild(var_8_2.go, "go_container/go_aidtag")
			var_8_2.gostorytag = gohelper.findChild(var_8_2.go, "go_container/go_storytag")
			var_8_2.imageinsight = gohelper.findChildImage(var_8_2.go, "go_container/level/layout/image_insight")
			var_8_2.txtlevel = gohelper.findChildText(var_8_2.go, "go_container/level/layout/txt_level")
			var_8_2.goempty = gohelper.findChild(var_8_2.go, "go_empty")

			table.insert(arg_8_0._heroItemList, var_8_2)
		end

		gohelper.setActive(var_8_2.gocontainer, var_8_1)
		gohelper.setActive(var_8_2.goempty, not var_8_1)

		if var_8_1 then
			gohelper.setActive(var_8_2.gostorytag, false)
			gohelper.setActive(var_8_2.goaidtag, false)

			local var_8_3 = var_8_1.heroId
			local var_8_4, var_8_5 = HeroConfig.instance:getShowLevel(var_8_0[iter_8_0].level)

			var_8_2.txtlevel.text = arg_8_0:getShowLevelText(var_8_4)

			if var_8_5 > 1 then
				UISpriteSetMgr.instance:setHeroGroupSprite(var_8_2.imageinsight, "biandui_dongxi_" .. tostring(var_8_5 - 1))
				gohelper.setActive(var_8_2.imageinsight.gameObject, true)
			else
				gohelper.setActive(var_8_2.imageinsight.gameObject, false)
			end

			local var_8_6 = HeroConfig.instance:getHeroCO(var_8_3)
			local var_8_7 = SkinConfig.instance:getSkinCo(var_8_6.skinId)

			var_8_2.simageheroicon:LoadImage(ResUrl.getHeadIconSmall(var_8_7.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(var_8_2.imagecareer, "lssx_" .. tostring(var_8_6.career))

			local var_8_8 = HeroModel.instance:getByHeroId(var_8_3)

			ZProj.UGUIHelper.SetGrayscale(var_8_2.simageheroicon.gameObject, not var_8_8)
			ZProj.UGUIHelper.SetGrayscale(var_8_2.imagecareer.gameObject, not var_8_8)
		end

		gohelper.setActive(var_8_2.go, true)
	end
end

function var_0_0.refreshTowerBossUI(arg_9_0)
	local var_9_0 = arg_9_0._mo.cloth and arg_9_0._mo.cloth ~= 0 and lua_cloth.configDict[arg_9_0._mo.cloth]
	local var_9_1

	var_9_1 = var_9_0 ~= nil

	local var_9_2 = TowerModel.instance:isInTowerBattle()
	local var_9_3 = arg_9_0._mo.assistBossId
	local var_9_4 = var_9_3 and var_9_3 > 0

	gohelper.setActive(arg_9_0._simagecloth.gameObject, var_9_0 and not var_9_2)
	gohelper.setActive(arg_9_0._gobossItem, var_9_2)
	gohelper.setActive(arg_9_0._gobossEmpty, var_9_2 and not var_9_4)
	gohelper.setActive(arg_9_0._gobossContainer, var_9_2 and var_9_4)

	if var_9_2 and var_9_4 then
		local var_9_5 = TowerConfig.instance:getAssistBossConfig(var_9_3)

		UISpriteSetMgr.instance:setCommonSprite(arg_9_0._imageBossCareer, string.format("lssx_%s", var_9_5.career))

		local var_9_6 = FightConfig.instance:getSkinCO(var_9_5.skinId)

		arg_9_0._simageBossIcon:LoadImage(ResUrl.monsterHeadIcon(var_9_6 and var_9_6.headIcon))
	end
end

function var_0_0.getShowLevelText(arg_10_0, arg_10_1)
	return "<size=12>Lv.</size>" .. tostring(arg_10_1)
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._anim
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._simagecloth:UnLoadImage()
	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simageBossIcon:UnLoadImage()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._heroItemList) do
		iter_12_1.simageheroicon:UnLoadImage()
	end
end

return var_0_0
