module("modules.logic.seasonver.act123.view1_9.Season123_1_9SettlementHeroItem", package.seeall)

local var_0_0 = class("Season123_1_9SettlementHeroItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_hero")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_hero/#simage_heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_hero/#image_career")
	arg_1_0._gocard1 = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout/#go_cards/#go_card1")
	arg_1_0._gocard2 = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout/#go_cards/#go_card2")
	arg_1_0._gosingle = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout/#go_cards/#go_single")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout/#go_equip")
	arg_1_0._imageequipicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_hero/layout/#go_equip/#image_equipicon")
	arg_1_0._imageequiprare = gohelper.findChildImage(arg_1_0.viewGO, "#go_hero/layout/#go_equip/#image_equiprare")
	arg_1_0._gocards = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout/#go_cards")
	arg_1_0._equipPart = gohelper.findChild(arg_1_0.viewGO, "#go_hero/layout")
	arg_1_0._commonHeroCard = CommonHeroCard.create(arg_1_0._simageheroicon.gameObject, arg_1_0.viewName)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onRefreshViewParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._is_replay = arg_4_1
	arg_4_0._hero = arg_4_2
	arg_4_0._equip = arg_4_3
	arg_4_0._equip_123 = arg_4_4
	arg_4_0._replay_data = arg_4_5
	arg_4_0._trail = arg_4_6
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = Season123Model.instance:getCurSeasonId()

	arg_5_0:setViewVisibleInternal(false)

	if arg_5_0._is_replay then
		arg_5_0:_showReplayData()
	else
		arg_5_0:_showNormalData()
	end

	if arg_5_0._no123Equip and arg_5_0._noEquip then
		gohelper.setActive(arg_5_0._equipPart, false)
	end

	gohelper.setActive(arg_5_0._gocards, not arg_5_0._no123Equip)
end

function var_0_0._showNormalData(arg_6_0)
	if arg_6_0._trail then
		arg_6_0:_showTrailHeroIcon(arg_6_0._trail)
	else
		arg_6_0:_showHeroIcon(arg_6_0._hero)
	end

	local var_6_0 = arg_6_0._equip and EquipModel.instance:getEquip(arg_6_0._equip[1])
	local var_6_1 = var_6_0 and var_6_0.equipId

	arg_6_0:_showEquipIcon(var_6_1)

	if arg_6_0._equip_123 then
		local var_6_2 = Season123Model.instance:getAllItemMo(arg_6_0.actId)
		local var_6_3 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0._equip_123) do
			if var_6_2[iter_6_1] then
				table.insert(var_6_3, var_6_2[iter_6_1].uid)
			end
		end

		local var_6_4 = #var_6_3

		arg_6_0._no123Equip = var_6_4 == 0

		for iter_6_2, iter_6_3 in ipairs(var_6_3) do
			arg_6_0:_showEquip123(iter_6_2, iter_6_3, var_6_4)
		end
	end
end

function var_0_0._showTrailHeroIcon(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = lua_hero_trial.configDict[arg_7_1.trialId][0]
	local var_7_1 = HeroConfig.instance:getHeroCO(var_7_0.heroId)
	local var_7_2

	if var_7_0.skin > 0 then
		var_7_2 = SkinConfig.instance:getSkinCo(var_7_0.skin)
	else
		var_7_2 = SkinConfig.instance:getSkinCo(var_7_1.skinId)
	end

	local var_7_3 = var_7_1.career

	if var_7_2 then
		arg_7_0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(var_7_2.retangleIcon))
	else
		gohelper.setActive(arg_7_0.viewGO.transform.parent.gameObject, false)
	end

	if var_7_3 then
		UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. tostring(var_7_3))
	end

	if var_7_2 then
		arg_7_0._commonHeroCard:onUpdateMO(var_7_2)
	end
end

function var_0_0._showHeroIcon(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = HeroModel.instance:getById(arg_8_1)
	local var_8_1 = arg_8_0:checkAssist(arg_8_1, var_8_0)
	local var_8_2
	local var_8_3

	if var_8_1 then
		arg_8_2 = arg_8_2 or var_8_1.skin
		var_8_2 = var_8_1.config.career
	else
		local var_8_4 = FightDataHelper.entityMgr:getById(arg_8_1)

		if var_8_4 then
			local var_8_5 = lua_monster.configDict[var_8_4.modelId]

			if var_8_5 then
				arg_8_2 = arg_8_2 or var_8_5.skinId
				var_8_3 = FightConfig.instance:getSkinCO(arg_8_2)
				var_8_2 = var_8_5.career
			end
		end
	end

	if arg_8_2 then
		var_8_3 = FightConfig.instance:getSkinCO(arg_8_2)

		if var_8_3 then
			arg_8_0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(var_8_3.retangleIcon))
		end
	else
		gohelper.setActive(arg_8_0.viewGO.transform.parent.gameObject, false)
	end

	if var_8_2 then
		UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer, "lssx_" .. tostring(var_8_2))
	end

	if var_8_3 then
		arg_8_0._commonHeroCard:onUpdateMO(var_8_3)
	end
end

function var_0_0.checkAssist(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		local var_9_0 = Season123Model.instance:getBattleContext()

		if var_9_0.stage ~= nil then
			arg_9_2 = Season123HeroUtils.getHeroMO(var_9_0.actId, arg_9_1, var_9_0.stage)
		end
	end

	return arg_9_2
end

function var_0_0._showEquipIcon(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_1 ~= 0 then
		local var_10_0 = EquipConfig.instance:getEquipCo(arg_10_1)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._imageequipicon, var_10_0.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._imageequiprare, "bianduixingxian_" .. var_10_0.rare)
	else
		gohelper.setActive(arg_10_0._goequip, false)

		arg_10_0._noEquip = true
	end
end

function var_0_0._showEquip123(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if arg_11_4 == 0 then
		return
	end

	local var_11_0 = arg_11_3 <= 1 and arg_11_0._gosingle or arg_11_0["_gocard" .. arg_11_1]

	arg_11_0:openSubView(Season123_1_9CelebrityCardGetItem, Season123_1_9CelebrityCardItem.AssetPath, var_11_0, arg_11_2, nil, arg_11_4)
end

function var_0_0._showReplayData(arg_12_0)
	local var_12_0 = arg_12_0._hero

	arg_12_0:_showHeroIcon(var_12_0, arg_12_0._replay_data and arg_12_0._replay_data.skin)
	arg_12_0:_showEquipIcon(arg_12_0._equip and arg_12_0._equip.equipId)

	if var_12_0 ~= "0" and var_12_0 ~= "-100000" and arg_12_0._equip_123 then
		local var_12_1 = #arg_12_0._equip_123

		arg_12_0._no123Equip = var_12_1 == 0

		for iter_12_0 = 1, var_12_1 do
			arg_12_0:_showEquip123(iter_12_0, arg_12_0._equip_123[iter_12_0].equipUid, var_12_1, arg_12_0._equip_123[iter_12_0].equipId)
		end
	end
end

local var_0_1 = {}

function var_0_0._refreshEquipPos(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simageheroicon:UnLoadImage()
end

return var_0_0
