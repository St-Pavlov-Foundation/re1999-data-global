module("modules.logic.playercard.view.comp.PlayerCardCardItem", package.seeall)

local var_0_0 = class("PlayerCardCardItem", ListScrollCell)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.compType = arg_1_1 and arg_1_1.compType
	arg_1_0.cardIndex = arg_1_1 and arg_1_1.index
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.imageBg = gohelper.findChildImage(arg_2_0.viewGO, "#image_bg")
	arg_2_0.goEmpty = gohelper.findChild(arg_2_0.viewGO, "empty")
	arg_2_0.goEmptyAdd = gohelper.findChild(arg_2_0.goEmpty, "#btn_add")
	arg_2_0.goEmptyImg = gohelper.findChild(arg_2_0.goEmpty, "img_empty")
	arg_2_0.goNormal = gohelper.findChild(arg_2_0.viewGO, "normal")
	arg_2_0.txtCardName = gohelper.findChildTextMesh(arg_2_0.goNormal, "#txt_cardname")
	arg_2_0.txtEnName = gohelper.findChildTextMesh(arg_2_0.goNormal, "#txt_en")
	arg_2_0.txtDesc = gohelper.findChildTextMesh(arg_2_0.goNormal, "#txt_dec")
	arg_2_0.goNormalChange = gohelper.findChild(arg_2_0.goNormal, "#btn_change")
	arg_2_0.goSelect = gohelper.findChild(arg_2_0.viewGO, "select")
	arg_2_0.txtIndex = gohelper.findChildTextMesh(arg_2_0.goSelect, "#txt_order")
	arg_2_0.btnChange = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_change")
	arg_2_0.goSelectedEff = gohelper.findChild(arg_2_0.viewGO, "selected_eff")

	arg_2_0:initCard()
	arg_2_0:setVisible(true)
end

function var_0_0.setVisible(arg_3_0, arg_3_1)
	if arg_3_0.isVisible == arg_3_1 then
		return
	end

	arg_3_0.isVisible = arg_3_1

	gohelper.setActive(arg_3_0.viewGO, arg_3_1)
end

function var_0_0.playSelelctEffect(arg_4_0)
	gohelper.setActive(arg_4_0.goSelectedEff, false)
	gohelper.setActive(arg_4_0.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function var_0_0.initCard(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(PlayerCardEnum.CardKey) do
		local var_5_0 = arg_5_0[string.format("_initCard" .. iter_5_1)]

		if var_5_0 then
			var_5_0(arg_5_0)
		end
	end
end

function var_0_0._initCard3(arg_6_0)
	arg_6_0.goRole = gohelper.findChild(arg_6_0.goNormal, "#go_role")
	arg_6_0._collectionFulls = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 5 do
		arg_6_0._collectionFulls[iter_6_0] = gohelper.findChildImage(arg_6_0.goRole, string.format("collection/collection%s/#image_full", iter_6_0))
	end
end

function var_0_0._initCard4(arg_7_0)
	arg_7_0.goRoom = gohelper.findChild(arg_7_0.goNormal, "#go_room")
	arg_7_0.txtLand = gohelper.findChildTextMesh(arg_7_0.goRoom, "#txt_num1")
	arg_7_0.txtBuilding = gohelper.findChildTextMesh(arg_7_0.goRoom, "#txt_num2")
end

function var_0_0._initCard6(arg_8_0)
	arg_8_0.goExplore = gohelper.findChild(arg_8_0.goNormal, "#go_explore")
	arg_8_0.exportItem = {}

	for iter_8_0 = 1, 3 do
		local var_8_0 = arg_8_0:getUserDataTb_()

		var_8_0.txtExplore = gohelper.findChildTextMesh(arg_8_0.goExplore, "#txt_num" .. tostring(iter_8_0))
		var_8_0.image = gohelper.findChildImage(arg_8_0.goExplore, string.format("#txt_num%s/icon", iter_8_0))
		arg_8_0.exportItem[iter_8_0] = var_8_0
	end
end

function var_0_0.refreshView(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.notIsFirst and arg_9_0.cardConfig ~= arg_9_2 then
		arg_9_0:playSelelctEffect()
	end

	arg_9_0.notIsFirst = true
	arg_9_0.cardInfo = arg_9_1
	arg_9_0.cardConfig = arg_9_2

	if arg_9_0.cardConfig then
		UISpriteSetMgr.instance:setPlayerInfoSprite(arg_9_0.imageBg, "player_card_" .. arg_9_2.id, true)
		gohelper.setActive(arg_9_0.goEmpty, false)
		gohelper.setActive(arg_9_0.goNormal, true)

		local var_9_0 = arg_9_0:isPlayerSelf() and arg_9_0.compType == PlayerCardEnum.CompType.Normal and arg_9_0.cardIndex == 4

		gohelper.setActive(arg_9_0.goNormalChange, var_9_0)

		arg_9_0.txtCardName.text = arg_9_2.name
		arg_9_0.txtEnName.text = arg_9_2.nameEn

		arg_9_0:refreshCard()
	else
		gohelper.setActive(arg_9_0.goEmpty, true)
		gohelper.setActive(arg_9_0.goNormal, false)

		local var_9_1 = arg_9_0:isPlayerSelf() and arg_9_0.compType == PlayerCardEnum.CompType.Normal

		gohelper.setActive(arg_9_0.goEmptyAdd, var_9_1)
		gohelper.setActive(arg_9_0.goEmptyImg, not var_9_1)
		UISpriteSetMgr.instance:setPlayerInfoSprite(arg_9_0.imageBg, "player_card_0", true)
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0:refreshView(arg_10_1.info, arg_10_1.config)

	local var_10_0 = PlayerCardProgressModel.instance:getSelectIndex(arg_10_1.id)

	if var_10_0 then
		gohelper.setActive(arg_10_0.goSelect, true)

		arg_10_0.txtIndex.text = tostring(var_10_0)
	else
		gohelper.setActive(arg_10_0.goSelect, false)
	end
end

function var_0_0.getConfig(arg_11_0)
	return arg_11_0.cardConfig
end

function var_0_0.isPlayerSelf(arg_12_0)
	return arg_12_0.cardInfo and arg_12_0.cardInfo:isSelf()
end

function var_0_0.getPlayerInfo(arg_13_0)
	return arg_13_0.cardInfo and arg_13_0.cardInfo:getPlayerInfo()
end

function var_0_0.refreshCard(arg_14_0)
	arg_14_0:resetCard()

	local var_14_0 = arg_14_0[string.format("_refreshCard" .. arg_14_0.cardConfig.id)]

	if var_14_0 then
		var_14_0(arg_14_0)
	end
end

function var_0_0.resetCard(arg_15_0)
	gohelper.setActive(arg_15_0.goRole, false)
	gohelper.setActive(arg_15_0.goRoom, false)
	gohelper.setActive(arg_15_0.goExplore, false)

	arg_15_0.txtDesc.text = ""
end

function var_0_0._refreshCard1(arg_16_0)
	local var_16_0 = arg_16_0:getPlayerInfo()

	arg_16_0.txtDesc.text = TimeUtil.timestampToString3(ServerTime.timeInLocal(var_16_0.registerTime / 1000))
end

function var_0_0._refreshCard2(arg_17_0)
	local var_17_0 = arg_17_0:getPlayerInfo()

	arg_17_0.txtDesc.text = formatLuaLang("cachotprogressview_remainDay", var_17_0.totalLoginDays)
end

function var_0_0._refreshCard3(arg_18_0)
	gohelper.setActive(arg_18_0.goRole, true)

	local var_18_0 = arg_18_0:getPlayerInfo()
	local var_18_1 = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local var_18_2 = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local var_18_3 = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local var_18_4 = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local var_18_5 = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)
	local var_18_6 = math.min(var_18_1 > 0 and var_18_0.heroRareNNCount / var_18_1 or 1, 1)
	local var_18_7 = math.min(var_18_2 > 0 and var_18_0.heroRareNCount / var_18_2 or 1, 1)
	local var_18_8 = math.min(var_18_3 > 0 and var_18_0.heroRareRCount / var_18_3 or 1, 1)
	local var_18_9 = math.min(var_18_4 > 0 and var_18_0.heroRareSRCount / var_18_4 or 1, 1)
	local var_18_10 = math.min(var_18_5 > 0 and var_18_0.heroRareSSRCount / var_18_5 or 1, 1)

	arg_18_0._collectionFulls[1].fillAmount = var_18_6
	arg_18_0._collectionFulls[2].fillAmount = var_18_7
	arg_18_0._collectionFulls[3].fillAmount = var_18_8
	arg_18_0._collectionFulls[4].fillAmount = var_18_9
	arg_18_0._collectionFulls[5].fillAmount = var_18_10
end

function var_0_0._refreshCard4(arg_19_0)
	gohelper.setActive(arg_19_0.goRoom, true)

	local var_19_0 = arg_19_0.cardInfo.roomCollection
	local var_19_1 = string.splitToNumber(var_19_0, "#")
	local var_19_2 = var_19_1 and var_19_1[1]

	if var_19_2 then
		arg_19_0.txtLand.text = var_19_2
	else
		arg_19_0.txtLand.text = PlayerCardEnum.EmptyString
	end

	local var_19_3 = var_19_1 and var_19_1[2]

	if var_19_3 then
		arg_19_0.txtBuilding.text = var_19_3
	else
		arg_19_0.txtBuilding.text = PlayerCardEnum.EmptyString
	end
end

function var_0_0._refreshCard5(arg_20_0)
	local var_20_0 = arg_20_0.cardInfo.weekwalkDeepLayerId

	if var_20_0 == -1 then
		arg_20_0.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		local var_20_1 = WeekWalkConfig.instance:getMapConfig(var_20_0)
		local var_20_2 = lua_weekwalk_scene.configDict[var_20_1 and var_20_1.sceneId]

		if var_20_2 then
			arg_20_0.txtDesc.text = var_20_2.battleName
		else
			arg_20_0.txtDesc.text = PlayerCardEnum.EmptyString2
		end
	end
end

function var_0_0._refreshCard6(arg_21_0)
	gohelper.setActive(arg_21_0.goExplore, true)

	local var_21_0 = arg_21_0.cardInfo.exploreCollection
	local var_21_1 = GameUtil.splitString2(var_21_0, true) or {}

	arg_21_0:_refreshExportItem(1, var_21_1[3], "dungeon_secretroom_btn_triangle")
	arg_21_0:_refreshExportItem(2, var_21_1[2], "dungeon_secretroom_btn_sandglass")
	arg_21_0:_refreshExportItem(3, var_21_1[1], "dungeon_secretroom_btn_box")
end

function var_0_0._refreshCard7(arg_22_0)
	local var_22_0 = arg_22_0.cardInfo.rougeDifficulty

	if var_22_0 == -1 then
		arg_22_0.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		arg_22_0.txtDesc.text = formatLuaLang("playercard_rougedesc", var_22_0)
	end
end

function var_0_0._refreshCard8(arg_23_0)
	local var_23_0 = arg_23_0.cardInfo.act128SSSCount

	if var_23_0 == -1 then
		arg_23_0.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		arg_23_0.txtDesc.text = formatLuaLang("times2", var_23_0)
	end
end

function var_0_0._refreshExportItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2 and arg_24_2[1]
	local var_24_1 = arg_24_2 and arg_24_2[2]
	local var_24_2 = arg_24_0.exportItem[arg_24_1]

	if var_24_0 then
		var_24_2.txtExplore.text = var_24_0
	else
		var_24_2.txtExplore.text = PlayerCardEnum.EmptyString
	end

	if var_24_0 and var_24_1 and var_24_1 <= var_24_0 then
		UISpriteSetMgr.instance:setExploreSprite(var_24_2.image, arg_24_3 .. "1", true)
	else
		UISpriteSetMgr.instance:setExploreSprite(var_24_2.image, arg_24_3 .. "2", true)
	end
end

function var_0_0.addEventListeners(arg_25_0)
	arg_25_0.btnChange:AddClickListener(arg_25_0.btnChangeOnClick, arg_25_0)
end

function var_0_0.removeEventListeners(arg_26_0)
	arg_26_0.btnChange:RemoveClickListener()
end

function var_0_0.btnChangeOnClick(arg_27_0)
	if not arg_27_0:isPlayerSelf() then
		return
	end

	if arg_27_0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.PlayerCardShowView)
	elseif arg_27_0.cardConfig then
		PlayerCardProgressModel.instance:clickItem(arg_27_0.cardConfig.id)
	end
end

function var_0_0.onDestroy(arg_28_0)
	return
end

return var_0_0
