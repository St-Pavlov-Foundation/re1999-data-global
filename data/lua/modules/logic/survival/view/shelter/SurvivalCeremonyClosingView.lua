module("modules.logic.survival.view.shelter.SurvivalCeremonyClosingView", package.seeall)

local var_0_0 = class("SurvivalCeremonyClosingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG")
	arg_1_0._simagePanelBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG1")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG2")
	arg_1_0._scrollcontentlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._goEnding = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Ending")
	arg_1_0._simageending = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#simage_ending")
	arg_1_0._txtending = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#txt_ending")
	arg_1_0._goendingScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#go_endingScore")
	arg_1_0._txtendingScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Ending/#go_endingScore/#txt_endingScore")
	arg_1_0._goNpc = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc")
	arg_1_0._gonpcitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcitem")
	arg_1_0._imagenpc = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcitem/#image_npc")
	arg_1_0._gonpcline1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcline1")
	arg_1_0._gonpcline2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/layout/#go_npcline2")
	arg_1_0._gonpcScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#go_npcScore")
	arg_1_0._txtnpcScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#go_npcScore/#txt_npcScore")
	arg_1_0._goBoss = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss")
	arg_1_0._gobossitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossitem")
	arg_1_0._imageboss = gohelper.findChildImage(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossitem/#image_boss")
	arg_1_0._gobossline1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossline1")
	arg_1_0._gobossline2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/layout/#go_bossline2")
	arg_1_0._gobossScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/#go_bossScore")
	arg_1_0._txtbossScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Boss/#go_bossScore/#txt_bossScore")
	arg_1_0._gosurvivalTime = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime")
	arg_1_0._txtsurvivalTime = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#txt_survivalTime")
	arg_1_0._goscore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#go_score")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_survivalTime/#go_score/#txt_score")
	arg_1_0._goextraTarget = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget")
	arg_1_0._txtextraTarget = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#txt_extraTarget")
	arg_1_0._goextraScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#go_extraScore")
	arg_1_0._txtextraScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_extraTarget/#go_extraScore/#txt_extraScore")
	arg_1_0._goCollection = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Collection")
	arg_1_0._txtCollection = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#txt_Collection")
	arg_1_0._gocollectionScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#go_collectionScore")
	arg_1_0._txtcollectionScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/#go_collectionScore/#txt_collectionScore")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Item")
	arg_1_0._txtItem = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#txt_Item")
	arg_1_0._goItemScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#go_ItemScore")
	arg_1_0._txtItemScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_Item/#go_ItemScore/#txt_ItemScore")
	arg_1_0._goTotalScore = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore")
	arg_1_0._txtTotalScore = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_TotalScore/#txt_TotalScore")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

local var_0_1 = 50
local var_0_2 = {
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5
}
local var_0_3 = {
	boss = 3,
	extraTarget = 5,
	item = 7,
	npc = 2,
	survival = 4,
	collection = 1,
	winScore = 6
}
local var_0_4 = ZProj.TweenHelper

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._nextClick = gohelper.findChildClickWithAudio(arg_5_0.viewGO, "go_click")

	arg_5_0._nextClick:AddClickListener(arg_5_0.enterNext, arg_5_0)

	arg_5_0._canvasGroupEnding = arg_5_0._goEnding:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupNpc = arg_5_0._goNpc:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupBoss = arg_5_0._goBoss:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupSurvivalTime = arg_5_0._gosurvivalTime:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupExtraTarget = arg_5_0._goextraTarget:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupCollection = arg_5_0._goCollection:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupItem = arg_5_0._goItem:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._canvasGroupTotalScore = arg_5_0._goTotalScore:GetComponent(gohelper.Type_CanvasGroup)
	arg_5_0._animationEnding = arg_5_0._goEnding:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationNpc = arg_5_0._goNpc:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationBoss = arg_5_0._goBoss:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationSurvivalTime = arg_5_0._gosurvivalTime:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationExtraTarget = arg_5_0._goextraTarget:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationCollection = arg_5_0._goCollection:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationExtraItem = arg_5_0._goItem:GetComponent(gohelper.Type_Animation)
	arg_5_0._animationTotalScore = arg_5_0._goTotalScore:GetComponent(gohelper.Type_Animation)
	arg_5_0._contentRect = gohelper.findChild(arg_5_0.viewGO, "#scroll_contentlist/viewport/content").transform:GetComponent(gohelper.Type_RectTransform)

	local var_5_0 = arg_5_0._scrollcontentlist.transform:GetComponent(gohelper.Type_RectTransform)

	arg_5_0._scrollHeight = recthelper.getHeight(var_5_0)
	arg_5_0._goCollectionLayout = gohelper.findChild(arg_5_0.viewGO, "#scroll_contentlist/viewport/content/#go_Collection/layout")
	arg_5_0._goItemLayout = gohelper.findChild(arg_5_0.viewGO, "#scroll_contentlist/viewport/content/#go_Item/layout")
	arg_5_0._txtTips = gohelper.findChildText(arg_5_0.viewGO, "txt_tips")

	gohelper.setActive(arg_5_0._btnclose.gameObject, false)
	gohelper.setActive(arg_5_0._txtTips.gameObject, false)
	gohelper.setActive(arg_5_0._gonpcitem, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._isWin = arg_7_0.viewParam.isWin or false

	local var_7_0 = arg_7_0.viewParam.report

	if not string.nilorempty(var_7_0) then
		arg_7_0._report = cjson.decode(var_7_0)
	end

	arg_7_0._totalScore = arg_7_0._report.totalCount

	SurvivalShelterChooseNpcListModel.instance:clearSelectList()
	SurvivalShelterChooseEquipListModel.instance:clearSelectList()

	local var_7_1 = arg_7_0._report.extraData

	if not string.nilorempty(var_7_1) then
		local var_7_2 = string.split(var_7_1, "|")
		local var_7_3 = var_7_2[1]
		local var_7_4 = var_7_2[2]

		if not string.nilorempty(var_7_3) then
			local var_7_5 = string.splitToNumber(var_7_3, "#")

			SurvivalShelterChooseNpcListModel.instance:setNeedSelectNpcList(var_7_5)
		end

		if not string.nilorempty(var_7_4) then
			local var_7_6 = string.splitToNumber(var_7_4, "#")

			SurvivalShelterChooseEquipListModel.instance:setNeedSelectEquipList(var_7_6)
		end
	end

	arg_7_0:_initView()
end

function var_0_0._initView(arg_8_0)
	arg_8_0._allShowGO = arg_8_0:getUserDataTb_()
	arg_8_0._allShowAnimation = arg_8_0:getUserDataTb_()
	arg_8_0._showTime = {}
	arg_8_0._maxStep = 0

	arg_8_0:_initEnding()
	arg_8_0:_initNpc()
	arg_8_0:_initBoss()
	arg_8_0:_initSurvivalTime()
	arg_8_0:_initExtraTarget()
	arg_8_0:_initCollection()
	arg_8_0:_initItem()
	arg_8_0:_initTotalScore()

	arg_8_0._progress = 1

	arg_8_0:_refreshCurProgress()
end

function var_0_0._initEnding(arg_9_0)
	local var_9_0 = arg_9_0:getScoreByType(var_0_3.winScore)

	arg_9_0._txtendingScore.text = var_9_0

	gohelper.setActive(arg_9_0._goendingScore, var_9_0 > 0)

	local var_9_1 = arg_9_0._report.endId
	local var_9_2 = lua_survival_end.configDict[var_9_1]
	local var_9_3 = var_9_2.endImg

	arg_9_0._simageending:LoadImage(var_9_3)

	arg_9_0._txtending.text = var_9_2.endDesc

	arg_9_0:addShowStep(arg_9_0._animationEnding, var_0_2[1], arg_9_0._canvasGroupEnding)
end

local var_0_5 = 9
local var_0_6 = 0

function var_0_0._initNpc(arg_10_0)
	local var_10_0 = arg_10_0:getScoreByType(var_0_3.npc)

	var_0_6 = 0

	gohelper.setActive(arg_10_0._goNpc, var_10_0 > 0)

	if var_10_0 <= 0 then
		return
	end

	arg_10_0._txtnpcScore.text = var_10_0

	if arg_10_0._npcItems == nil then
		arg_10_0._npcItems = arg_10_0:getUserDataTb_()
	end

	local var_10_1 = arg_10_0._report.gainNpcSet
	local var_10_2 = #var_10_1

	for iter_10_0 = 1, var_10_2 do
		local var_10_3 = var_10_1[iter_10_0]
		local var_10_4 = SurvivalConfig.instance:getNpcConfig(var_10_3)
		local var_10_5 = arg_10_0._npcItems[iter_10_0]

		if var_10_5 == nil then
			local var_10_6 = arg_10_0:getNpcLine()

			var_10_5 = gohelper.clone(arg_10_0._gonpcitem, var_10_6, var_10_3)

			gohelper.setActive(var_10_5, true)
			table.insert(arg_10_0._npcItems, var_10_5)

			if not var_10_6.activeSelf then
				gohelper.setActive(var_10_6, true)
			end
		end

		local var_10_7 = gohelper.findChildSingleImage(var_10_5, "#image_npc")

		if var_10_4 and not string.nilorempty(var_10_4.smallIcon) then
			local var_10_8 = ResUrl.getSurvivalNpcIcon(var_10_4.smallIcon)

			var_10_7:LoadImage(var_10_8)
		end
	end

	arg_10_0:addShowStep(arg_10_0._animationNpc, var_0_2[2], arg_10_0._canvasGroupNpc)
end

function var_0_0.getNpcLine(arg_11_0)
	var_0_6 = var_0_6 + 1

	local var_11_0 = math.ceil(var_0_6 / var_0_5)

	if arg_11_0._npcLines == nil then
		arg_11_0._npcLines = arg_11_0:getUserDataTb_()
	end

	if arg_11_0._npcLines[var_11_0] ~= nil then
		return arg_11_0._npcLines[var_11_0]
	end

	local var_11_1 = arg_11_0._gonpcline1

	if var_11_0 % 2 == 0 then
		var_11_1 = arg_11_0._gonpcline2
	end

	local var_11_2 = gohelper.cloneInPlace(var_11_1, var_11_0)

	arg_11_0._npcLines[var_11_0] = var_11_2

	return var_11_2
end

function var_0_0._initBoss(arg_12_0)
	local var_12_0 = arg_12_0:getScoreByType(var_0_3.boss)

	gohelper.setActive(arg_12_0._goBoss, var_12_0 > 0)

	if var_12_0 <= 0 then
		return
	end

	arg_12_0._txtbossScore.text = var_12_0

	if arg_12_0._bossItems == nil then
		arg_12_0._bossItems = arg_12_0:getUserDataTb_()
	end

	local var_12_1 = arg_12_0._report.fightIds
	local var_12_2 = 9
	local var_12_3 = #var_12_1

	for iter_12_0 = 1, var_12_3 do
		local var_12_4 = tonumber(var_12_1[iter_12_0])
		local var_12_5 = lua_survival_shelter_intrude_fight.configDict[var_12_4]
		local var_12_6 = arg_12_0._bossItems[iter_12_0]

		if var_12_6 == nil then
			local var_12_7 = arg_12_0._gobossline1

			if var_12_2 < iter_12_0 then
				var_12_7 = arg_12_0._gobossline2
			end

			var_12_6 = gohelper.clone(arg_12_0._gobossitem, var_12_7, var_12_4)

			gohelper.setActive(var_12_6, true)
			table.insert(arg_12_0._bossItems, var_12_6)
		end

		local var_12_8 = gohelper.findChildSingleImage(var_12_6, "#image_boss")

		if not string.nilorempty(var_12_5.smallheadicon) then
			local var_12_9 = ResUrl.monsterHeadIcon(var_12_5.smallheadicon)

			var_12_8:LoadImage(var_12_9)
		end
	end

	gohelper.setActive(arg_12_0._gobossline2, var_12_2 < var_12_3)
	arg_12_0:addShowStep(arg_12_0._animationBoss, var_0_2[3], arg_12_0._canvasGroupBoss)
end

function var_0_0._initSurvivalTime(arg_13_0)
	local var_13_0 = arg_13_0:getScoreByType(var_0_3.survival)

	gohelper.setActive(arg_13_0._gosurvivalTime, var_13_0 > 0)

	if var_13_0 <= 0 then
		return
	end

	arg_13_0._txtscore.text = var_13_0

	local var_13_1 = arg_13_0._report.day

	arg_13_0._txtsurvivalTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_survivalTime"), var_13_1)

	arg_13_0:addShowStep(arg_13_0._animationSurvivalTime, var_0_2[4], arg_13_0._canvasGroupSurvivalTime)
end

function var_0_0._initExtraTarget(arg_14_0)
	local var_14_0 = arg_14_0:getScoreByType(var_0_3.extraTarget)

	gohelper.setActive(arg_14_0._goextraTarget, var_14_0 > 0)

	if var_14_0 <= 0 then
		return
	end

	arg_14_0._txtextraScore.text = var_14_0

	local var_14_1 = arg_14_0._report.normalTaskCount

	arg_14_0._txtextraTarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_extraTarget"), var_14_1)

	arg_14_0:addShowStep(arg_14_0._animationExtraTarget, var_0_2[5], arg_14_0._canvasGroupExtraTarget)
end

function var_0_0._initCollection(arg_15_0)
	local var_15_0 = arg_15_0:getScoreByType(var_0_3.collection)

	gohelper.setActive(arg_15_0._goCollection, var_15_0 > 0)

	if var_15_0 <= 0 then
		return
	end

	arg_15_0._txtcollectionScore.text = var_15_0

	if arg_15_0._collectionItems == nil then
		arg_15_0._collectionItems = arg_15_0:getUserDataTb_()
	end

	local var_15_1 = arg_15_0._report.itemId2Count
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		table.insert(var_15_2, iter_15_0)
	end

	table.sort(var_15_2, function(arg_16_0, arg_16_1)
		return var_15_1[arg_16_0] > var_15_1[arg_16_1]
	end)
	gohelper.setActive(arg_15_0._item, false)

	for iter_15_2 = 1, #var_15_2 do
		local var_15_3 = var_15_1[var_15_2[iter_15_2]]
		local var_15_4 = tonumber(var_15_2[iter_15_2])
		local var_15_5 = SurvivalBagItemMo.New()

		var_15_5:init({
			id = var_15_4,
			count = var_15_3
		})

		if var_15_5.equipCo ~= nil then
			local var_15_6 = arg_15_0.viewContainer:getSetting().otherRes.itemRes
			local var_15_7 = arg_15_0:getResInst(var_15_6, arg_15_0._goCollectionLayout)
			local var_15_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_7, SurvivalBagItem)

			var_15_8:updateMo(var_15_5)
			var_15_8:setShowNum(true)
			var_15_8:setItemSize(150, 150)
			gohelper.setActive(var_15_7, true)
			table.insert(arg_15_0._collectionItems, var_15_8)
		end
	end

	local var_15_9 = arg_15_0._report.equipCount

	if var_15_9 > 0 then
		arg_15_0._txtCollection.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_collection"), var_15_9)
	end

	gohelper.setActive(arg_15_0._txtCollection.gameObject, var_15_9 > 0)
	arg_15_0:addShowStep(arg_15_0._animationCollection, var_0_2[6], arg_15_0._canvasGroupCollection)
end

function var_0_0._initItem(arg_17_0)
	local var_17_0 = arg_17_0:getScoreByType(var_0_3.item)

	gohelper.setActive(arg_17_0._goItem, var_17_0 > 0)

	if var_17_0 <= 0 then
		return
	end

	if arg_17_0._collectionItems == nil then
		arg_17_0._collectionItems = arg_17_0:getUserDataTb_()
	end

	arg_17_0._txtItemScore.text = var_17_0

	local var_17_1 = arg_17_0._report.itemId2Count
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		table.insert(var_17_2, iter_17_0)
	end

	table.sort(var_17_2, function(arg_18_0, arg_18_1)
		return var_17_1[arg_18_0] > var_17_1[arg_18_1]
	end)

	local var_17_3 = 0

	gohelper.setActive(arg_17_0._item, false)

	for iter_17_2 = 1, #var_17_2 do
		local var_17_4 = var_17_1[var_17_2[iter_17_2]]
		local var_17_5 = tonumber(var_17_2[iter_17_2])
		local var_17_6 = SurvivalBagItemMo.New()

		var_17_6:init({
			id = var_17_5,
			count = var_17_4
		})

		if var_17_6.equipCo == nil and (not var_17_6:isCurrency() or var_17_6.co.subType ~= SurvivalEnum.CurrencyType.Enthusiastic) then
			var_17_3 = var_17_3 + var_17_4

			local var_17_7 = arg_17_0.viewContainer:getSetting().otherRes.itemRes
			local var_17_8 = arg_17_0:getResInst(var_17_7, arg_17_0._goItemLayout)
			local var_17_9 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_8, SurvivalBagItem)

			var_17_9:updateMo(var_17_6)
			var_17_9:setShowNum(true)
			var_17_9:setItemSize(150, 150)
			gohelper.setActive(var_17_8, true)
			table.insert(arg_17_0._collectionItems, var_17_9)
		end
	end

	arg_17_0._txtItem.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyclosingview_item"), var_17_3)

	arg_17_0:addShowStep(arg_17_0._animationExtraItem, var_0_2[7], arg_17_0._canvasGroupItem)
end

function var_0_0._initTotalScore(arg_19_0)
	local var_19_0 = arg_19_0._totalScore

	arg_19_0._txtTotalScore.text = var_19_0

	arg_19_0:addShowStep(arg_19_0._animationTotalScore, var_0_2[8], arg_19_0._canvasGroupTotalScore)
end

function var_0_0.addShowStep(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	table.insert(arg_20_0._allShowAnimation, arg_20_1)
	table.insert(arg_20_0._allShowGO, arg_20_1.gameObject)
	table.insert(arg_20_0._showTime, arg_20_2)

	arg_20_0._maxStep = arg_20_0._maxStep + 1

	arg_20_0:_initCanvasAlpha(arg_20_3)
end

function var_0_0.getScoreByType(arg_21_0, arg_21_1)
	if arg_21_0._report then
		local var_21_0 = arg_21_0._report.module2Score

		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			if tonumber(iter_21_0) == arg_21_1 then
				return iter_21_1
			end
		end
	end

	return 0
end

function var_0_0._initCanvasAlpha(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_1.alpha = 0
	end
end

function var_0_0.enterNext(arg_23_0)
	if not arg_23_0._canEnterNext then
		return
	end

	if arg_23_0._progress == arg_23_0._maxStep then
		return
	end

	arg_23_0._progress = arg_23_0._progress + 1

	arg_23_0:_refreshCurProgress()
end

function var_0_0.getContentY(arg_24_0)
	if arg_24_0._allContentY == nil or #arg_24_0._allContentY <= 0 then
		arg_24_0._allContentY = {}

		local var_24_0 = tabletool.len(arg_24_0._allShowGO)

		for iter_24_0 = 1, var_24_0 do
			local var_24_1 = arg_24_0._allShowGO[iter_24_0].transform

			ZProj.UGUIHelper.RebuildLayout(var_24_1)

			local var_24_2 = var_24_1:GetComponent(gohelper.Type_RectTransform)
			local var_24_3 = recthelper.getHeight(var_24_2)

			if var_24_3 ~= 0 then
				arg_24_0._allContentY[iter_24_0] = var_24_3 + var_0_1
			end
		end
	end

	local var_24_4 = 0
	local var_24_5 = math.min(arg_24_0._progress, #arg_24_0._allContentY)

	for iter_24_1 = 1, var_24_5 do
		var_24_4 = var_24_4 + arg_24_0._allContentY[iter_24_1]
	end

	return var_24_4 - arg_24_0._scrollHeight
end

function var_0_0._refreshCurProgress(arg_25_0)
	arg_25_0._canEnterNext = false

	local var_25_0 = arg_25_0._allShowGO[arg_25_0._progress]
	local var_25_1 = arg_25_0._showTime[arg_25_0._progress]
	local var_25_2 = arg_25_0._allShowAnimation[arg_25_0._progress]
	local var_25_3 = arg_25_0:getContentY()

	if var_25_3 > 0 then
		arg_25_0._moveTweenId = var_0_4.DOAnchorPosY(arg_25_0._contentRect, var_25_3, var_25_1)
	end

	if var_25_0 ~= nil then
		arg_25_0._tweenId = var_0_4.DOFadeCanvasGroup(var_25_0, 0, 1, var_25_1, arg_25_0._progressFinish, arg_25_0)
	end

	if var_25_2 then
		var_25_2:Play()
	end
end

function var_0_0._progressFinish(arg_26_0)
	arg_26_0._canEnterNext = true

	local var_26_0 = arg_26_0._progress == arg_26_0._maxStep

	gohelper.setActive(arg_26_0._nextClick.gameObject, not var_26_0)
	gohelper.setActive(arg_26_0._txtTips.gameObject, var_26_0)
	gohelper.setActive(arg_26_0._btnclose.gameObject, var_26_0)
end

function var_0_0.onClose(arg_27_0)
	local var_27_0 = GameSceneMgr.instance:getCurSceneType()

	if var_27_0 == SceneType.SurvivalShelter or var_27_0 == SceneType.Fight then
		SurvivalController.instance:exitMap()
	end

	local var_27_1 = SurvivalModel.instance:getOutSideInfo()

	if var_27_1 then
		var_27_1.inWeek = false
	end
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._progressFinish, arg_28_0)

	if arg_28_0._nextClick then
		arg_28_0._nextClick:RemoveClickListener()

		arg_28_0._nextClick = nil
	end

	if arg_28_0._tweenId then
		var_0_4.KillById(arg_28_0._tweenId)

		arg_28_0._tweenId = nil
	end
end

return var_0_0
