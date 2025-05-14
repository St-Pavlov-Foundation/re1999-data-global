module("modules.logic.rouge.view.RougeResultReView", package.seeall)

local var_0_0 = class("RougeResultReView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fail/#simage_mask")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._simagerightmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_rightmask")
	arg_1_0._simageleftmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "img_dec/#simage_leftmask")
	arg_1_0._godlctitles = gohelper.findChild(arg_1_0.viewGO, "Left/title/#go_dlctitles")
	arg_1_0._godifficulty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_difficulty")
	arg_1_0._txtdifficulty = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_difficulty/#txt_difficulty")
	arg_1_0._txtend = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_end")
	arg_1_0._gofaction = gohelper.findChild(arg_1_0.viewGO, "Left/#go_faction")
	arg_1_0._imageTypeIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_faction/#image_TypeIcon")
	arg_1_0._txtTypeName = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_faction/image_NameBG/#txt_TypeName")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_faction/#txt_Lv")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "Left/#go_collection")
	arg_1_0._txtcollectionnum = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_collection/#txt_collectionnum")
	arg_1_0._gocoin = gohelper.findChild(arg_1_0.viewGO, "Left/#go_coin")
	arg_1_0._txtcoinnum = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_coin/#txt_coinnum")
	arg_1_0._scrollherogroup = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_herogroup")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_herogroup/Viewport/Content/#go_line2")
	arg_1_0._goplayinfo = gohelper.findChild(arg_1_0.viewGO, "Right/#go_playinfo")
	arg_1_0._txtplayername = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_playinfo/#txt_playername")
	arg_1_0._txtplayerlv = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_playinfo/#txt_playerlv")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_playinfo/#txt_time")
	arg_1_0._simageplayericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#go_playinfo/#simage_playericon")
	arg_1_0._gochessboard = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard/#go_dragContainer/#go_chessitem")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard/#go_cellModel")
	arg_1_0._godragarea = gohelper.findChild(arg_1_0.viewGO, "Right/#go_chessboard/#go_dragarea")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gohide = gohelper.findChild(arg_1_0.viewGO, "#go_hide")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_hide/#btn_hide")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnhideOnClick(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._heroLineTab = arg_6_0:getUserDataTb_()
	arg_6_0._gonormaltitle = gohelper.findChild(arg_6_0.viewGO, "Left/title/normal")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.PurdahPull)

	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.reviewInfo

	arg_8_0:refreshUI(var_8_0)
	gohelper.setActive(arg_8_0._gotopleft, arg_8_0.viewParam and arg_8_0.viewParam.showNavigate)
end

function var_0_0.onOpenFinish(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
end

function var_0_0.refreshUI(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_1:isSucceed()

	gohelper.setActive(arg_10_0._gosuccess, var_10_0)
	gohelper.setActive(arg_10_0._gofail, not var_10_0)

	arg_10_0._txtend.text = var_0_0.refreshEndingDesc(arg_10_1)

	arg_10_0:refreshBaseInfo(arg_10_1)
	arg_10_0:refreshTitle(arg_10_1)
	arg_10_0:refreshStyleInfo(arg_10_1)
	arg_10_0:refreshInitHeroUI(arg_10_1)
	arg_10_0:refreshPlayerInfo(arg_10_1)
	arg_10_0:refreshCollectionSlotArea(arg_10_1)
end

function var_0_0.refreshEndingDesc(arg_11_0)
	local var_11_0 = arg_11_0:isSucceed()
	local var_11_1 = ""

	if var_11_0 then
		local var_11_2 = arg_11_0.endId
		local var_11_3 = RougeConfig.instance:getEndingCO(var_11_2)

		var_11_1 = var_11_3 and var_11_3.desc
	else
		local var_11_4 = arg_11_0.layerId
		local var_11_5 = arg_11_0.middleLayerId
		local var_11_6 = arg_11_0:isInMiddleLayer()
		local var_11_7 = ""

		if var_11_6 then
			local var_11_8 = lua_rouge_middle_layer.configDict[var_11_5]

			var_11_7 = var_11_8 and var_11_8.name
		else
			local var_11_9 = lua_rouge_layer.configDict[var_11_4]

			var_11_7 = var_11_9 and var_11_9.name
		end

		var_11_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_rougeresultreportview_txt_dec5"), var_11_7)
	end

	return var_11_1
end

function var_0_0.refreshBaseInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.collectionNum

	arg_12_0._txtcollectionnum.text = var_12_0

	local var_12_1 = arg_12_1.gainCoin

	arg_12_0._txtcoinnum.text = var_12_1

	local var_12_2 = arg_12_1.season
	local var_12_3 = arg_12_1.difficulty
	local var_12_4 = lua_rouge_difficulty.configDict[var_12_2][var_12_3]

	arg_12_0._txtdifficulty.text = var_12_4 and var_12_4.title
	arg_12_0._txtLv.text = string.format("Lv.%s", arg_12_1.teamLevel)
end

function var_0_0.refreshTitle(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1:getVersions()
	local var_13_1 = RougeDLCHelper.versionListToString(var_13_0)
	local var_13_2 = arg_13_0._godlctitles.transform.childCount

	for iter_13_0 = 1, var_13_2 do
		local var_13_3 = arg_13_0._godlctitles.transform:GetChild(iter_13_0 - 1).gameObject
		local var_13_4 = var_13_3.name

		gohelper.setActive(var_13_3, var_13_4 == var_13_1)
	end

	local var_13_5 = var_13_0 and #var_13_0 > 0

	gohelper.setActive(arg_13_0._gonormaltitle, not var_13_5)
end

function var_0_0.refreshStyleInfo(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.season
	local var_14_1 = arg_14_1.style
	local var_14_2 = lua_rouge_style.configDict[var_14_0][var_14_1]

	arg_14_0._txtTypeName.text = var_14_2 and var_14_2.name

	local var_14_3 = var_14_2 and var_14_2.icon
	local var_14_4 = string.format("%s_light", var_14_3)

	UISpriteSetMgr.instance:setRouge2Sprite(arg_14_0._imageTypeIcon, var_14_4)
end

function var_0_0.refreshInitHeroUI(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getTeamInfo()
	local var_15_1, var_15_2 = arg_15_0:buildHeroPlaceMap(var_15_0)
	local var_15_3 = 0
	local var_15_4 = 0
	local var_15_5 = 1

	while var_15_5 <= 4 or var_15_4 <= var_15_2 do
		local var_15_6 = arg_15_0:getOrCreateHeroIconLine(var_15_5)
		local var_15_7 = arg_15_0:getLineHeroCount(var_15_5)

		var_15_3 = var_15_3 + 1
		var_15_4 = var_15_3 + var_15_7 - 1

		arg_15_0:refreshLineItem(var_15_6, var_15_5, var_15_1, var_15_3, var_15_4)

		var_15_3 = var_15_4
		var_15_5 = var_15_5 + 1
	end
end

function var_0_0.buildHeroPlaceMap(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1, var_16_2, var_16_3 = arg_16_0:splitAllHeros(arg_16_1)
	local var_16_4 = var_0_0.SingleHeroCountPerLine

	for iter_16_0 = 1, RougeEnum.FightTeamNormalHeroNum do
		var_16_0[iter_16_0 + var_16_4] = var_16_1[iter_16_0] or 0
	end

	local var_16_5 = var_0_0.SingleHeroCountPerLine + var_0_0.DoubleHeroCountPerLine + 1
	local var_16_6 = RougeEnum.FightTeamHeroNum - RougeEnum.FightTeamNormalHeroNum

	for iter_16_1 = 1, var_16_6 do
		var_16_0[iter_16_1 + var_16_5] = var_16_2[iter_16_1] or 0
	end

	local var_16_7 = #var_16_3
	local var_16_8 = 0

	for iter_16_2 = 1, var_16_7 do
		local var_16_9 = var_16_3[iter_16_2]
		local var_16_10 = iter_16_2

		if iter_16_2 <= var_0_0.SingleHeroCountPerLine then
			var_16_10 = iter_16_2
		elseif iter_16_2 == var_0_0.SingleHeroCountPerLine + 1 then
			var_16_10 = var_0_0.SingleHeroCountPerLine + var_0_0.DoubleHeroCountPerLine + 1
		else
			var_16_10 = var_0_0.DoubleHeroCountPerLine * 2 + iter_16_2
		end

		var_16_0[var_16_10] = var_16_9

		if var_16_8 < var_16_10 then
			var_16_8 = var_16_10
		end
	end

	return var_16_0, var_16_8
end

function var_0_0.splitAllHeros(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 and arg_17_1:getAllHeroId()
	local var_17_1 = {}
	local var_17_2 = {}
	local var_17_3 = {}
	local var_17_4 = {}

	arg_17_0._needFrameHeroIdMap = {}

	local var_17_5 = arg_17_1 and arg_17_1:getBattleHeroList()

	if var_17_5 then
		for iter_17_0, iter_17_1 in ipairs(var_17_5) do
			local var_17_6 = iter_17_1.heroId
			local var_17_7 = iter_17_1.supportHeroId

			table.insert(var_17_2, var_17_6)
			table.insert(var_17_1, var_17_7)

			var_17_4[var_17_6] = true
			var_17_4[var_17_7] = true
			arg_17_0._needFrameHeroIdMap[var_17_6] = true
			arg_17_0._needFrameHeroIdMap[var_17_7] = true
		end
	end

	if var_17_0 then
		for iter_17_2, iter_17_3 in ipairs(var_17_0) do
			if not var_17_4[iter_17_3] then
				table.insert(var_17_3, iter_17_3)
			end
		end
	end

	return var_17_2, var_17_1, var_17_3
end

function var_0_0.getOrCreateHeroIconLine(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._heroLineTab[arg_18_1]

	if not var_18_0 then
		local var_18_1 = arg_18_1 % 2 == 1 and arg_18_0._goline1 or arg_18_0._goline2

		var_18_0 = arg_18_0:getUserDataTb_()
		var_18_0.parent = gohelper.cloneInPlace(var_18_1, "line_" .. arg_18_1)
		var_18_0.heroItems = arg_18_0:getUserDataTb_()

		local var_18_2 = gohelper.findChild(var_18_0.parent, "go_item")
		local var_18_3 = arg_18_0.viewContainer._viewSetting.otherRes[1]
		local var_18_4 = arg_18_0:getLineHeroCount(arg_18_1)

		for iter_18_0 = 1, var_18_4 do
			local var_18_5 = gohelper.cloneInPlace(var_18_2, "heroitem_" .. iter_18_0)

			arg_18_0:getResInst(var_18_3, var_18_5, "icon")

			var_18_0.heroItems[iter_18_0] = var_18_5

			if iter_18_0 ~= 1 and arg_18_1 ~= 2 and arg_18_1 ~= 3 and iter_18_0 % 2 == 0 then
				var_18_5.transform:SetAsFirstSibling()
			end
		end

		arg_18_0._heroLineTab[arg_18_1] = var_18_0
	end

	return var_18_0
end

var_0_0.DoubleHeroCountPerLine = 4
var_0_0.SingleHeroCountPerLine = 5

function var_0_0.getLineHeroCount(arg_19_0, arg_19_1)
	return arg_19_1 % 2 == 1 and var_0_0.SingleHeroCountPerLine or var_0_0.DoubleHeroCountPerLine
end

function var_0_0.refreshLineItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if not arg_20_1 then
		return
	end

	for iter_20_0 = arg_20_4, arg_20_5 do
		local var_20_0 = arg_20_1.heroItems[iter_20_0 - arg_20_4 + 1]
		local var_20_1 = arg_20_3 and arg_20_3[iter_20_0]

		arg_20_0:refreshHeroUI(var_20_0, var_20_1)
	end

	gohelper.setActive(arg_20_1.parent, true)
end

function var_0_0.refreshHeroUI(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_2 and arg_21_2 > 0
	local var_21_1 = gohelper.findChild(arg_21_1, "icon/#go_heroitem/empty")
	local var_21_2 = gohelper.findChild(arg_21_1, "icon/#go_heroitem/frame")
	local var_21_3 = gohelper.findChildSingleImage(arg_21_1, "icon/#go_heroitem/#image_rolehead")

	gohelper.setActive(arg_21_1, true)
	gohelper.setActive(var_21_1, not var_21_0)
	gohelper.setActive(var_21_2, false)
	gohelper.setActive(var_21_3.gameObject, var_21_0)

	if var_21_0 then
		local var_21_4 = HeroConfig.instance:getHeroCO(arg_21_2)
		local var_21_5

		if HeroModel.instance:getByHeroId(arg_21_2) then
			var_21_5 = HeroModel.instance:getCurrentSkinConfig(arg_21_2)
		else
			local var_21_6 = var_21_4 and var_21_4.skinId

			var_21_5 = SkinConfig.instance:getSkinCo(var_21_6)
		end

		local var_21_7 = var_21_5 and var_21_5.headIcon

		var_21_3:LoadImage(ResUrl.getHeadIconSmall(var_21_7))

		local var_21_8 = arg_21_0._needFrameHeroIdMap[arg_21_2]

		gohelper.setActive(var_21_2, var_21_8)
	end
end

function var_0_0.refreshPlayerInfo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.playerName

	arg_22_0._txtplayername.text = var_22_0

	local var_22_1 = arg_22_1.playerLevel

	arg_22_0._txtplayerlv.text = string.format("Lv.%s", var_22_1)

	local var_22_2 = arg_22_1.finishTime / 1000

	arg_22_0._txttime.text = TimeUtil.localTime2ServerTimeString(var_22_2, "%Y.%m.%d %H:%M")

	if not arg_22_0._liveHeadIcon then
		arg_22_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_22_0._simageplayericon)
	end

	arg_22_0._liveHeadIcon:setLiveHead(arg_22_1.portrait)
end

function var_0_0.refreshCollectionSlotArea(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.style
	local var_23_1 = arg_23_1.season
	local var_23_2 = arg_23_1:getSlotCollections()

	if not arg_23_0._slotComp then
		arg_23_0._slotComp = RougeCollectionSlotComp.Get(arg_23_0._gochessboard, RougeCollectionHelper.ResultReViewCollectionSlotParam)
	end

	local var_23_3 = RougeCollectionConfig.instance:getStyleCollectionBagSize(var_23_1, var_23_0)

	arg_23_0._slotComp:onUpdateMO(var_23_3.col, var_23_3.row, var_23_2)
end

function var_0_0.onClose(arg_24_0)
	return
end

function var_0_0.onDestroyView(arg_25_0)
	if arg_25_0._slotComp then
		arg_25_0._slotComp:destroy()
	end
end

return var_0_0
