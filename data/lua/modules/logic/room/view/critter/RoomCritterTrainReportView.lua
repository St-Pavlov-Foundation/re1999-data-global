module("modules.logic.room.view.critter.RoomCritterTrainReportView", package.seeall)

local var_0_0 = class("RoomCritterTrainReportView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagepage = gohelper.findChildSingleImage(arg_1_0.viewGO, "page1/#simage_page")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "page1/top/#simage_title")
	arg_1_0._goqualityhigh = gohelper.findChild(arg_1_0.viewGO, "page1/top/#go_qualityhigh")
	arg_1_0._goqualitylow = gohelper.findChild(arg_1_0.viewGO, "page1/top/#go_qualitylow")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "page1/top/#txt_name")
	arg_1_0._btnnameedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "page1/top/#txt_name/#btn_nameedit")
	arg_1_0._gocrittericon = gohelper.findChild(arg_1_0.viewGO, "page1/top/critter/#go_crittericon")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "page1/top/#go_starList")
	arg_1_0._scrolldes = gohelper.findChildScrollRect(arg_1_0.viewGO, "page1/top/#scroll_des")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "page1/top/#scroll_des/viewport/content/#txt_Desc")
	arg_1_0._txttag1 = gohelper.findChildText(arg_1_0.viewGO, "page1/top/tag/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildText(arg_1_0.viewGO, "page1/top/tag/#txt_tag2")
	arg_1_0._txtwork = gohelper.findChildText(arg_1_0.viewGO, "page1/middle/work/#txt_work")
	arg_1_0._imagelvwork = gohelper.findChildImage(arg_1_0.viewGO, "page1/middle/work/#image_lv_work")
	arg_1_0._txtheart = gohelper.findChildText(arg_1_0.viewGO, "page1/middle/heart/#txt_heart")
	arg_1_0._imagelvheart = gohelper.findChildImage(arg_1_0.viewGO, "page1/middle/heart/#image_lv_heart")
	arg_1_0._txtlucky = gohelper.findChildText(arg_1_0.viewGO, "page1/middle/lucky/#txt_lucky")
	arg_1_0._imagelvlucky = gohelper.findChildImage(arg_1_0.viewGO, "page1/middle/lucky/#image_lv_lucky")
	arg_1_0._scrollskill = gohelper.findChildScrollRect(arg_1_0.viewGO, "page1/bottom/1/#scroll_skill")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem")
	arg_1_0._txtskillname = gohelper.findChildText(arg_1_0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	arg_1_0._txtskilldec = gohelper.findChildText(arg_1_0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	arg_1_0._btnsubtag1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "page1/bottom/#btn_subtag1")
	arg_1_0._btnsubtag2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "page1/bottom/#btn_subtag2")
	arg_1_0._btnsubtag3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "page1/bottom/#btn_subtag3")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "page1/bottom/#go_empty")
	arg_1_0._simagesmallpage = gohelper.findChildSingleImage(arg_1_0.viewGO, "page2/#simage_smallpage")
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.viewGO, "page2/heroinfo/#image_quality")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "page2/heroinfo/#image_quality/#simage_heroicon")
	arg_1_0._txtheroname = gohelper.findChildText(arg_1_0.viewGO, "page2/heroinfo/#txt_heroname")
	arg_1_0._txtherolevel = gohelper.findChildText(arg_1_0.viewGO, "page2/heroinfo/#txt_herolevel")
	arg_1_0._scrollcomments = gohelper.findChildScrollRect(arg_1_0.viewGO, "page2/#scroll_comments")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "page2/#scroll_comments/viewport/content/#txt_dec")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "page2/#simage_signature")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnnameedit:AddClickListener(arg_2_0._btnnameeditOnClick, arg_2_0)
	arg_2_0._btnsubtag1:AddClickListener(arg_2_0._btnsubtag1OnClick, arg_2_0)
	arg_2_0._btnsubtag2:AddClickListener(arg_2_0._btnsubtag2OnClick, arg_2_0)
	arg_2_0._btnsubtag3:AddClickListener(arg_2_0._btnsubtag3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnnameedit:RemoveClickListener()
	arg_3_0._btnsubtag1:RemoveClickListener()
	arg_3_0._btnsubtag2:RemoveClickListener()
	arg_3_0._btnsubtag3:RemoveClickListener()
end

function var_0_0._btnnameeditOnClick(arg_4_0)
	RoomCritterController.instance:openRenameView(arg_4_0._critterUid)
end

function var_0_0._btnsubtag1OnClick(arg_5_0)
	arg_5_0:_selectSubTag(CritterEnum.SkilTagType.Common)
end

function var_0_0._btnsubtag2OnClick(arg_6_0)
	arg_6_0:_selectSubTag(CritterEnum.SkilTagType.Base)
end

function var_0_0._btnsubtag3OnClick(arg_7_0)
	arg_7_0:_selectSubTag(CritterEnum.SkilTagType.Race)
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._starTbList = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, 6 do
		local var_9_0 = gohelper.findChild(arg_9_0._gostarList, "star" .. iter_9_0)

		table.insert(arg_9_0._starTbList, var_9_0)
	end

	arg_9_0._tagsTbListDict = {}
	arg_9_0._tagType2IdxDict = {}
	arg_9_0._goskillItemDict = arg_9_0:getUserDataTb_()
	arg_9_0._goSubTagList = arg_9_0:getUserDataTb_()
	arg_9_0._tagTypeList = {
		CritterEnum.SkilTagType.Common,
		CritterEnum.SkilTagType.Base,
		CritterEnum.SkilTagType.Race
	}
	arg_9_0._tagsCfgMap = {}

	for iter_9_1 = 1, #arg_9_0._tagTypeList do
		local var_9_1 = gohelper.findChild(arg_9_0.viewGO, "page1/bottom/" .. iter_9_1)

		arg_9_0._goSubTagList[iter_9_1] = var_9_1

		local var_9_2 = gohelper.findChild(var_9_1, "#scroll_skill/viewport/content/#go_skillItem")
		local var_9_3 = arg_9_0._tagTypeList[iter_9_1]

		arg_9_0._tagType2IdxDict[var_9_3] = iter_9_1
		arg_9_0._goskillItemDict[var_9_3] = var_9_2
		arg_9_0._tagsTbListDict[var_9_3] = {}

		table.insert(arg_9_0._tagsTbListDict[var_9_3], arg_9_0:_createTagTB(var_9_2))
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, arg_11_0._onCritterRenameReply, arg_11_0)

	arg_11_0._critterUid = arg_11_0.viewParam and arg_11_0.viewParam.critterUid
	arg_11_0._heroId = arg_11_0.viewParam and arg_11_0.viewParam.heroId
	arg_11_0._trainNum = arg_11_0.viewParam and arg_11_0.viewParam.tranNum or 1
	arg_11_0._critterMO = CritterModel.instance:getCritterMOByUid(arg_11_0._critterUid)
	arg_11_0._heroMO = HeroModel.instance:getByHeroId(arg_11_0._heroId)
	arg_11_0._tagsCfgMap = {}

	if arg_11_0._critterMO and arg_11_0._critterMO.skillInfo then
		local var_11_0 = arg_11_0._critterMO.skillInfo.tags or {}

		for iter_11_0 = 1, #var_11_0 do
			local var_11_1 = CritterConfig.instance:getCritterTagCfg(var_11_0[iter_11_0])

			if var_11_1 then
				arg_11_0._tagsCfgMap[var_11_1.type] = arg_11_0._tagsCfgMap[var_11_1.type] or {}

				table.insert(arg_11_0._tagsCfgMap[var_11_1.type], var_11_1)
			end
		end
	end

	arg_11_0:refreshUI()

	local var_11_2

	for iter_11_1, iter_11_2 in ipairs(arg_11_0._tagTypeList) do
		local var_11_3 = arg_11_0._tagsCfgMap[iter_11_2]

		if var_11_3 and #var_11_3 > 0 then
			var_11_2 = iter_11_2

			break
		end
	end

	arg_11_0:_selectSubTag(var_11_2 or CritterEnum.SkilTagType.Base)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_dabiao)
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._simageheroicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

function var_0_0._onCritterRenameReply(arg_14_0, arg_14_1)
	if arg_14_0._critterMO and arg_14_0._critterUid == arg_14_1 then
		arg_14_0._txtname.text = arg_14_0._critterMO:getName()
	end
end

function var_0_0._createTagTB(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = arg_15_1
	var_15_0._txtskillname = gohelper.findChildText(arg_15_1, "title/#txt_skillname")
	var_15_0._imageicon = gohelper.findChildImage(arg_15_1, "title/#txt_skillname/#image_icon")
	var_15_0._txtskilldec = gohelper.findChildText(arg_15_1, "#txt_skilldec")

	return var_15_0
end

function var_0_0._selectSubTag(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._tagType2IdxDict and arg_16_0._tagType2IdxDict[arg_16_1] or 1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._goSubTagList) do
		gohelper.setActive(iter_16_1, iter_16_0 == var_16_0)
	end

	local var_16_1 = arg_16_0._tagsCfgMap[arg_16_1]

	gohelper.setActive(arg_16_0._goempty, not var_16_1 or #var_16_1 < 1)
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:_refreshCritterTagUI()
	arg_17_0:_refreshHeroUI()
	arg_17_0:_refreshCritterUI()
end

function var_0_0._refreshCritterTagUI(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._tagTypeList) do
		arg_18_0:_refreshTagTBByTyp(iter_18_1, arg_18_0._tagsCfgMap[iter_18_1])
	end
end

function var_0_0._refreshTagTBByTyp(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 0
	local var_19_1 = arg_19_0._tagsTbListDict[arg_19_1]

	if not var_19_1 then
		return
	end

	if arg_19_2 and #arg_19_2 > 0 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_2) do
			var_19_0 = var_19_0 + 1

			local var_19_2 = var_19_1[iter_19_0]

			if not var_19_2 then
				local var_19_3 = gohelper.cloneInPlace(arg_19_0._goskillItemDict[arg_19_1])

				var_19_2 = arg_19_0:_createTagTB(var_19_3)

				table.insert(var_19_1, var_19_2)
			end

			var_19_2._txtskillname.text = iter_19_1.name
			var_19_2._txtskilldec.text = iter_19_1.desc

			UISpriteSetMgr.instance:setCritterSprite(var_19_2._imageicon, iter_19_1.skillIcon)
		end
	end

	for iter_19_2 = 1, #var_19_1 do
		gohelper.setActive(var_19_1[iter_19_2].go, iter_19_2 <= var_19_0)
	end
end

function var_0_0._refreshCritterUI(arg_20_0)
	if not arg_20_0._critterMO then
		return
	end

	local var_20_0 = arg_20_0._critterMO:getDefineCfg()
	local var_20_1 = arg_20_0._critterMO.isHighQuality
	local var_20_2 = arg_20_0._critterMO.efficiency
	local var_20_3 = arg_20_0._critterMO.patience
	local var_20_4 = arg_20_0._critterMO.lucky

	arg_20_0._txtwork.text = var_20_2
	arg_20_0._txtheart.text = var_20_3
	arg_20_0._txtlucky.text = var_20_4

	UISpriteSetMgr.instance:setCritterSprite(arg_20_0._imagelvwork, arg_20_0:_getLevelIconName(var_20_2))
	UISpriteSetMgr.instance:setCritterSprite(arg_20_0._imagelvheart, arg_20_0:_getLevelIconName(var_20_3))
	UISpriteSetMgr.instance:setCritterSprite(arg_20_0._imagelvlucky, arg_20_0:_getLevelIconName(var_20_4))

	arg_20_0._txtname.text = arg_20_0._critterMO:getName()
	arg_20_0._txtDesc.text = var_20_0 and var_20_0.desc or ""

	gohelper.setActive(arg_20_0._txttag2, arg_20_0._critterMO.specialSkin)
	gohelper.setActive(arg_20_0._goqualityhigh, var_20_1)
	gohelper.setActive(arg_20_0._goqualitylow, not var_20_1)

	if not arg_20_0.critterIcon then
		arg_20_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_20_0._gocrittericon)
	end

	arg_20_0.critterIcon:setMOValue(arg_20_0._critterMO:getId(), arg_20_0._critterMO:getDefineId())

	local var_20_5 = var_20_0 and var_20_0.rare or 3

	for iter_20_0 = 1, #arg_20_0._starTbList do
		gohelper.setActive(arg_20_0._starTbList[iter_20_0], iter_20_0 <= var_20_5 + 1)
	end

	local var_20_6 = arg_20_0._critterMO:isMaturity() and "room_critter_adult" or "room_critter_child"

	arg_20_0._txttag1.text = luaLang(var_20_6)

	local var_20_7 = arg_20_0._tagsCfgMap[CritterEnum.SkilTagType.Common]
	local var_20_8 = arg_20_0._trainNum
	local var_20_9 = arg_20_0:_getMaxAttrName()
	local var_20_10 = var_20_7 and #var_20_7 or 0

	arg_20_0._txtdec.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("critter_report_comment_txt"), var_20_8, var_20_9, var_20_10)
end

function var_0_0._getLevelIconName(arg_21_0, arg_21_1)
	local var_21_0 = CritterConfig.instance:getCritterAttributeLevelCfgByValue(arg_21_1)

	return var_21_0 and var_21_0.icon or ""
end

function var_0_0._refreshHeroUI(arg_22_0)
	if arg_22_0._heroMO then
		local var_22_0 = arg_22_0._heroMO.config
		local var_22_1 = SkinConfig.instance:getSkinCo(arg_22_0._heroMO.skin)

		arg_22_0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(var_22_1.headIcon))

		arg_22_0._txtheroname.text = var_22_0.name

		arg_22_0._simagesignature:LoadImage(ResUrl.getSignature(var_22_0.signature))
		UISpriteSetMgr.instance:setCritterSprite(arg_22_0._imagequality, CritterEnum.QualityImageNameMap[var_22_0.rare])

		arg_22_0._txtherolevel.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	end
end

function var_0_0._getMaxAttrName(arg_23_0)
	if not arg_23_0._critterMO then
		return ""
	end

	local var_23_0 = arg_23_0._critterMO:getAttributeInfos()
	local var_23_1

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if var_23_1 == nil or var_23_1.value < iter_23_1.value then
			var_23_1 = iter_23_1
		end
	end

	local var_23_2 = var_23_1 and CritterConfig.instance:getCritterAttributeCfg(var_23_1.attributeId)

	return var_23_2 and var_23_2.name or ""
end

return var_0_0
