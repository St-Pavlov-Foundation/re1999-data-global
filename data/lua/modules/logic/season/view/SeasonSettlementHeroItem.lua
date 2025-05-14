module("modules.logic.season.view.SeasonSettlementHeroItem", package.seeall)

local var_0_0 = class("SeasonSettlementHeroItem", BaseViewExtended)

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

function var_0_0.onRefreshViewParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._is_replay = arg_4_1
	arg_4_0._hero = arg_4_2
	arg_4_0._equip = arg_4_3
	arg_4_0._equip_104 = arg_4_4
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:setViewVisibleInternal(false)

	if arg_5_0._is_replay then
		arg_5_0:_showReplayData()
	else
		arg_5_0:_showNormalData()
	end

	if arg_5_0._no104Equip and arg_5_0._noEquip then
		gohelper.setActive(arg_5_0._equipPart, false)
	end

	gohelper.setActive(arg_5_0._gocards, not arg_5_0._no104Equip)
end

function var_0_0._showNormalData(arg_6_0)
	arg_6_0:_showHeroIcon(arg_6_0._hero)

	local var_6_0 = arg_6_0._equip and EquipModel.instance:getEquip(arg_6_0._equip[1])
	local var_6_1 = var_6_0 and var_6_0.equipId

	arg_6_0:_showEquipIcon(var_6_1)

	if arg_6_0._equip_104 then
		local var_6_2 = Activity104Model.instance:getAllItemMo()
		local var_6_3 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_0._equip_104) do
			if var_6_2[iter_6_1] then
				table.insert(var_6_3, var_6_2[iter_6_1].uid)
			end
		end

		local var_6_4 = #var_6_3

		arg_6_0._no104Equip = var_6_4 == 0

		for iter_6_2, iter_6_3 in ipairs(var_6_3) do
			arg_6_0:_showEquip104(iter_6_2, iter_6_3, var_6_4)
		end
	end
end

function var_0_0._showHeroIcon(arg_7_0, arg_7_1)
	local var_7_0 = HeroModel.instance:getById(arg_7_1)

	if var_7_0 then
		local var_7_1 = FightConfig.instance:getSkinCO(var_7_0.skin)

		arg_7_0._simageheroicon:LoadImage(ResUrl.getHeadIconMiddle(var_7_1.retangleIcon))
		UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. tostring(var_7_0.config.career))
	else
		gohelper.setActive(arg_7_0.viewGO.transform.parent.gameObject, false)
	end
end

function var_0_0._showEquipIcon(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1 ~= 0 then
		local var_8_0 = EquipConfig.instance:getEquipCo(arg_8_1)

		UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_8_0._imageequipicon, var_8_0.icon)
		UISpriteSetMgr.instance:setHeroGroupSprite(arg_8_0._imageequiprare, "bianduixingxian_" .. var_8_0.rare)
	else
		gohelper.setActive(arg_8_0._goequip, false)

		arg_8_0._noEquip = true
	end
end

function var_0_0._showEquip104(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4 == 0 then
		return
	end

	local var_9_0 = arg_9_3 <= 1 and arg_9_0._gosingle or arg_9_0["_gocard" .. arg_9_1]

	arg_9_0:openSubView(SeasonCelebrityCardGetItem, "ui/viewres/season/seasoncelebritycarditem.prefab", var_9_0, arg_9_2, nil, arg_9_4)
end

function var_0_0._showReplayData(arg_10_0)
	local var_10_0 = arg_10_0._hero

	arg_10_0:_showHeroIcon(var_10_0)
	arg_10_0:_showEquipIcon(arg_10_0._equip and arg_10_0._equip.equipId)

	if var_10_0 ~= "0" and var_10_0 ~= "-100000" and arg_10_0._equip_104 then
		local var_10_1 = #arg_10_0._equip_104

		arg_10_0._no104Equip = var_10_1 == 0

		for iter_10_0 = 1, var_10_1 do
			arg_10_0:_showEquip104(iter_10_0, arg_10_0._equip_104[iter_10_0].equipUid, var_10_1, arg_10_0._equip_104[iter_10_0].equipId)
		end
	end
end

local var_0_1 = {}

function var_0_0._refreshEquipPos(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageheroicon:UnLoadImage()
end

return var_0_0
