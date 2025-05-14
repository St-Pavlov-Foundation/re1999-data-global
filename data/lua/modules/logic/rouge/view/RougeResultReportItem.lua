module("modules.logic.rouge.view.RougeResultReportItem", package.seeall)

local var_0_0 = class("RougeResultReportItem", ListScrollCellExtend)

var_0_0.DefaultTitleImageUrl = "singlebg_lang/txt_rouge/enter/rouge_enter_titlebg.png"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageredbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_redbg")
	arg_1_0._simagegreenbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_greenbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_time")
	arg_1_0._godifficulty = gohelper.findChild(arg_1_0.viewGO, "#go_difficulty")
	arg_1_0._txtdifficulty = gohelper.findChildText(arg_1_0.viewGO, "#go_difficulty/#txt_difficulty")
	arg_1_0._gofaction = gohelper.findChild(arg_1_0.viewGO, "#go_faction")
	arg_1_0._imageTypeIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_faction/#image_TypeIcon")
	arg_1_0._txtTypeName = gohelper.findChildText(arg_1_0.viewGO, "#go_faction/image_NameBG/#txt_TypeName")
	arg_1_0._txtLv = gohelper.findChildText(arg_1_0.viewGO, "#go_faction/#txt_Lv")
	arg_1_0._imagePointIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_faction/layout/#image_PointIcon")
	arg_1_0._goherogroup = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item2")
	arg_1_0._goitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item3")
	arg_1_0._goitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item4")
	arg_1_0._goitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item5")
	arg_1_0._goitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item6")
	arg_1_0._goitem7 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item7")
	arg_1_0._goitem8 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item8")
	arg_1_0._godec = gohelper.findChild(arg_1_0.viewGO, "#go_dec")
	arg_1_0._godecred = gohelper.findChild(arg_1_0.viewGO, "#go_dec/#go_dec_red")
	arg_1_0._godecgreen = gohelper.findChild(arg_1_0.viewGO, "#go_dec/#go_dec_green")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_dec/#txt_dec")
	arg_1_0._btndetails = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_details")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetails:RemoveClickListener()
end

function var_0_0._btndetailsOnClick(arg_4_0)
	local var_4_0 = {
		showNavigate = true,
		reviewInfo = arg_4_0._mo
	}

	RougeController.instance:openRougeResultReView(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:refreshEnding(arg_8_1)
	arg_8_0:refreshStyleInfo(arg_8_1)
	arg_8_0:refreshPlayerInfo(arg_8_1)
	arg_8_0:refreshBaseInfo(arg_8_1)
	arg_8_0:refreshHeroGroup(arg_8_1)
	arg_8_0:refreshTitle(arg_8_1)

	arg_8_0._txtdec.text = RougeResultReView.refreshEndingDesc(arg_8_1)

	local var_8_0 = arg_8_1:isSucceed()

	gohelper.setActive(arg_8_0._godecgreen, var_8_0)
	gohelper.setActive(arg_8_0._godecred, not var_8_0)
	gohelper.setActive(arg_8_0._simagegreenbg, var_8_0)
	gohelper.setActive(arg_8_0._simageredbg, not var_8_0)

	if UnityEngine.Time.frameCount - RougeResultReportListModel.instance.startFrameCount < 10 then
		arg_8_0._aniamtor = gohelper.onceAddComponent(arg_8_0.viewGO, gohelper.Type_Animator)

		arg_8_0._aniamtor:Play("open")
	end
end

function var_0_0.refreshHeroGroup(arg_9_0, arg_9_1)
	if not arg_9_0._heroItemList then
		arg_9_0._heroItemList = arg_9_0:getUserDataTb_()

		for iter_9_0 = 1, 8 do
			local var_9_0 = arg_9_0["_goitem" .. iter_9_0]
			local var_9_1 = arg_9_0._view.viewContainer._viewSetting.otherRes[2]
			local var_9_2 = arg_9_0._view:getResInst(var_9_1, var_9_0)
			local var_9_3 = {
				simagerolehead = gohelper.findChildSingleImage(var_9_2, "#go_heroitem/#image_rolehead"),
				frame = gohelper.findChild(var_9_2, "#go_heroitem/frame"),
				empty = gohelper.findChild(var_9_2, "#go_heroitem/empty")
			}

			arg_9_0._heroItemList[iter_9_0] = var_9_3
		end
	end

	for iter_9_1, iter_9_2 in ipairs(arg_9_0._heroItemList) do
		local var_9_4 = arg_9_0._mo.teamInfo.heroLifeList[iter_9_1]
		local var_9_5 = var_9_4 ~= nil

		gohelper.setActive(iter_9_2.simagerolehead, var_9_5)
		gohelper.setActive(iter_9_2.frame, var_9_5)
		gohelper.setActive(iter_9_2.empty, not var_9_5)

		if var_9_5 then
			local var_9_6 = var_9_4 and var_9_4.heroId
			local var_9_7

			if HeroModel.instance:getByHeroId(var_9_6) then
				var_9_7 = HeroModel.instance:getCurrentSkinConfig(var_9_6)
			else
				local var_9_8 = HeroConfig.instance:getHeroCO(var_9_6)
				local var_9_9 = var_9_8 and var_9_8.skinId

				var_9_7 = SkinConfig.instance:getSkinCo(var_9_9)
			end

			local var_9_10 = var_9_7 and var_9_7.headIcon

			iter_9_2.simagerolehead:LoadImage(ResUrl.getHeadIconSmall(var_9_10))
		end
	end
end

function var_0_0.refreshEnding(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.endId > 0

	gohelper.setActive(arg_10_0._godecgreen, var_10_0)
	gohelper.setActive(arg_10_0._godecred, not var_10_0)
	gohelper.setActive(arg_10_0._simagegreenbg, var_10_0)
	gohelper.setActive(arg_10_0._simageredbg, not var_10_0)
end

function var_0_0.refreshBaseInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.collectionNum
	local var_11_1 = arg_11_1.gainCoin
	local var_11_2 = arg_11_1.season
	local var_11_3 = arg_11_1.difficulty
	local var_11_4 = lua_rouge_difficulty.configDict[var_11_2][var_11_3]

	arg_11_0._txtdifficulty.text = var_11_4 and var_11_4.title
	arg_11_0._txtLv.text = string.format("Lv.%s", arg_11_1.teamLevel)
end

function var_0_0.refreshPlayerInfo(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.playerName
	local var_12_1 = arg_12_1.playerLevel
	local var_12_2 = arg_12_1.finishTime / 1000

	arg_12_0._txttime.text = TimeUtil.localTime2ServerTimeString(var_12_2, "%Y.%m.%d %H:%M")

	local var_12_3 = ItemConfig.instance:getItemIconById(arg_12_1.portrait)
end

function var_0_0.refreshStyleInfo(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.season
	local var_13_1 = arg_13_1.style
	local var_13_2 = lua_rouge_style.configDict[var_13_0][var_13_1]

	arg_13_0._txtTypeName.text = var_13_2 and var_13_2.name

	local var_13_3 = var_13_2 and var_13_2.icon

	if var_13_2 then
		UISpriteSetMgr.instance:setRouge2Sprite(arg_13_0._imageTypeIcon, string.format("%s_light", var_13_3))
		UISpriteSetMgr.instance:setRouge2Sprite(arg_13_0._imagePointIcon, string.format("rouge_faction_smallicon_%s", var_13_2.id))
	end

	gohelper.setActive(arg_13_0._gofaction, var_13_2 ~= nil)
end

function var_0_0.refreshTitle(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getVersions()
	local var_14_1 = RougeDLCHelper.versionListToString(var_14_0)
	local var_14_2 = ""

	if string.nilorempty(var_14_1) then
		var_14_2 = var_0_0.DefaultTitleImageUrl
	else
		var_14_2 = ResUrl.getRougeDLCLangImage("logo_dlc_" .. var_14_1)
	end

	arg_14_0._simagetitle:LoadImage(var_14_2)
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagetitle:UnLoadImage()
end

return var_0_0
