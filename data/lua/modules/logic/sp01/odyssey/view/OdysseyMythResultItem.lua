module("modules.logic.sp01.odyssey.view.OdysseyMythResultItem", package.seeall)

local var_0_0 = class("OdysseyMythResultItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gohero = gohelper.findChild(arg_1_1, "heroitemani")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_1, "heroitemani/hero/charactericon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_1, "heroitemani/hero/career")
	arg_1_0._gorank1 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/layout/rankobj/rank1")
	arg_1_0._gorank2 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/layout/rankobj/rank2")
	arg_1_0._gorank3 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/layout/rankobj/rank3")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_1, "heroitemani/hero/vertical/layout/lv/lvnum")
	arg_1_0._gostar1 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star1")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star2")
	arg_1_0._gostar3 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star3")
	arg_1_0._gostar4 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star4")
	arg_1_0._gostar5 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star5")
	arg_1_0._gostar6 = gohelper.findChild(arg_1_1, "heroitemani/hero/vertical/#go_starList/star6")
	arg_1_0._goequip = gohelper.findChild(arg_1_1, "heroitemani/equip")
	arg_1_0._imageequiprare = gohelper.findChildImage(arg_1_1, "heroitemani/equip/moveContainer/equiprare")
	arg_1_0._imageequipicon = gohelper.findChildImage(arg_1_1, "heroitemani/equip/moveContainer/equipIcon")
	arg_1_0._txtequiplvl = gohelper.findChildText(arg_1_1, "heroitemani/equip/moveContainer/equiplv/txtequiplv")
	arg_1_0._gotag = gohelper.findChild(arg_1_1, "heroitemani/tags")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_1, "empty")
	arg_1_0._goBottomEquip = gohelper.findChild(arg_1_1, "go_Equip")
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.heroMo = arg_2_1
	arg_2_0.equipMo = arg_2_2
	arg_2_0._index = arg_2_3

	arg_2_0:_refreshHero()
	arg_2_0:_refreshEquip()
	arg_2_0:_refreshBottomEquip()
	gohelper.setActive(arg_2_0._gohero, true)
	gohelper.setActive(arg_2_0._goEmpty, false)
end

function var_0_0._refreshHero(arg_3_0)
	local var_3_0 = arg_3_0.heroMo

	if not var_3_0 then
		logError("heroMo is nil")

		return
	end

	local var_3_1 = FightConfig.instance:getSkinCO(var_3_0.skin)
	local var_3_2 = ResUrl.getHeadIconMiddle(var_3_1.retangleIcon)

	arg_3_0._simageheroicon:LoadImage(var_3_2)

	local var_3_3 = "lssx_" .. tostring(var_3_0.config.career)

	UISpriteSetMgr.instance:setCommonSprite(arg_3_0._imagecareer, var_3_3)

	local var_3_4 = var_3_0.level or 0
	local var_3_5, var_3_6 = HeroConfig.instance:getShowLevel(var_3_4)

	arg_3_0._txtlv.text = var_3_5

	arg_3_0:_refreshLevelList()
	arg_3_0:_refreshStarList()
end

function var_0_0._refreshEquip(arg_4_0)
	local var_4_0 = arg_4_0.equipMo

	if not var_4_0 then
		gohelper.setActive(arg_4_0._goequip, false)

		return
	end

	local var_4_1 = var_4_0.config
	local var_4_2 = var_4_1.icon

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_4_0._imageequipicon, var_4_2)

	local var_4_3 = "bianduixingxian_" .. tostring(var_4_1.rare)

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_4_0._imageequiprare, var_4_3)

	local var_4_4 = var_4_0.level

	arg_4_0._txtequiplvl.text = "LV." .. var_4_4
end

function var_0_0._refreshLevelList(arg_5_0)
	local var_5_0 = arg_5_0.heroMo
	local var_5_1 = var_5_0 and var_5_0.level or 0
	local var_5_2, var_5_3 = HeroConfig.instance:getShowLevel(var_5_1)

	for iter_5_0 = 1, 3 do
		local var_5_4 = "_gorank" .. iter_5_0

		gohelper.setActive(arg_5_0[var_5_4], iter_5_0 == var_5_3 - 1)
	end
end

function var_0_0._refreshStarList(arg_6_0)
	local var_6_0 = arg_6_0.heroMo
	local var_6_1 = var_6_0.config and var_6_0.config.rare or -1

	for iter_6_0 = 1, 6 do
		local var_6_2 = "_gostar" .. iter_6_0

		gohelper.setActive(arg_6_0[var_6_2], iter_6_0 <= var_6_1 + 1)
	end
end

function var_0_0.setResFunc(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._getResFunc = arg_7_1
	arg_7_0._getResObj = arg_7_2
end

function var_0_0._refreshBottomEquip(arg_8_0)
	arg_8_0._gobottomequipList = {}

	local var_8_0 = arg_8_0._goBottomEquip.transform
	local var_8_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local var_8_2 = tonumber(var_8_1.value)

	for iter_8_0 = 1, var_8_2 do
		local var_8_3 = arg_8_0._getResFunc(arg_8_0._getResObj, var_8_0.gameObject)
		local var_8_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_3.gameObject, OdysseyHeroGroupEquipItem)

		table.insert(arg_8_0._gobottomequipList, var_8_4)
	end

	local var_8_5 = HeroGroupModel.instance:getCurGroupMO()
	local var_8_6 = arg_8_0._index
	local var_8_7 = var_8_5:getOdysseyEquips(var_8_6 - 1)

	for iter_8_1, iter_8_2 in ipairs(var_8_7.equipUid) do
		local var_8_8 = arg_8_0._gobottomequipList[iter_8_1]

		if not var_8_8 then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(iter_8_1))
		else
			local var_8_9 = tonumber(iter_8_2)

			var_8_8:setActive(true)
			var_8_8:setInfo(var_8_6, iter_8_1, var_8_9, OdysseyEnum.BagType.OnlyDisplay)
			var_8_8:refreshUI()
		end
	end

	local var_8_10 = #arg_8_0._gobottomequipList
	local var_8_11 = #var_8_7.equipUid

	if var_8_11 < var_8_10 then
		for iter_8_3 = var_8_11 + 1, var_8_10 do
			local var_8_12 = arg_8_0._gobottomequipList[iter_8_3]

			var_8_12:clear()
			var_8_12:setActive(false)
		end
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._simageheroicon:UnLoadImage()
end

return var_0_0
