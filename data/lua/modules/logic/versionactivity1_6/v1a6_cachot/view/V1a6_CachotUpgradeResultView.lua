module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeResultView", package.seeall)

local var_0_0 = class("V1a6_CachotUpgradeResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "top/#simage_title")
	arg_1_0._gohope = gohelper.findChild(arg_1_0.viewGO, "top/#go_hope")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "top/#go_hope/bg/#go_progress")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "top/#go_hope/#txt_num1")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "top/#go_hope/#txt_num2")
	arg_1_0._goshop = gohelper.findChild(arg_1_0.viewGO, "top/#go_shop")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "top/#go_shop/#simage_icon")
	arg_1_0._txtshopnum = gohelper.findChildText(arg_1_0.viewGO, "top/#go_shop/#txt_shopnum")
	arg_1_0._goteampresetitem = gohelper.findChild(arg_1_0.viewGO, "#go_teampresetitem")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal")
	arg_1_0._txtorder = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/#txt_order")
	arg_1_0._goqualityeffect1 = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect1")
	arg_1_0._imagequality1 = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality1")
	arg_1_0._goqualityeffect2 = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect2")
	arg_1_0._imagequality2 = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	arg_1_0._txtlevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1")
	arg_1_0._txtlevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level2")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch")
	arg_1_0._btnswitch2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch2")
	arg_1_0._godetails = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details")
	arg_1_0._godetailitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details/#go_detailitem")
	arg_1_0._txtbreaklevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel1")
	arg_1_0._txtbreaklevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel2")
	arg_1_0._txttalentlevel1 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel1")
	arg_1_0._txttalentlevel2 = gohelper.findChildText(arg_1_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel2")
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "right/#go_full")
	arg_1_0._goupgraded = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_upgraded")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnswitch2:AddClickListener(arg_2_0._btnswitch2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnswitch2:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_4_0)
	arg_4_0._detailAnimator:Play("close", 0, 0)
	arg_4_0:_showUpSwitch(false)
	TaskDispatcher.cancelTask(arg_4_0._hideDetail, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._hideDetail, arg_4_0, 0.16)
end

function var_0_0._hideDetail(arg_5_0)
	gohelper.setActive(arg_5_0._godetails, false)
end

function var_0_0._btnswitch2OnClick(arg_6_0)
	gohelper.setActive(arg_6_0._godetails, true)
	arg_6_0:_showUpSwitch(true)
	arg_6_0._detailAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(arg_6_0._hideDetail, arg_6_0)
end

function var_0_0._showUpSwitch(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._btnswitch, arg_7_1)
	gohelper.setActive(arg_7_0._btnswitch2, not arg_7_1)
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_initRoleLevelInfo()
	arg_9_0:_initDetailItemList()

	arg_9_0._detailAnimator = arg_9_0._godetails:GetComponent("Animator")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update)
end

function var_0_0._initRoleLevelInfo(arg_10_0)
	arg_10_0._roleStarList = arg_10_0:getUserDataTb_()
	arg_10_0._roleStarNum = gohelper.findChildText(arg_10_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/#txt_num")

	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/rare")
	local var_10_1 = 1

	for iter_10_0 = 1, var_10_1 do
		local var_10_2 = gohelper.findChild(var_10_0, "go_rare" .. iter_10_0)

		arg_10_0._roleStarList[iter_10_0] = var_10_2
	end

	arg_10_0._rankList1 = arg_10_0:getUserDataTb_()
	arg_10_0._rankList2 = arg_10_0:getUserDataTb_()

	for iter_10_1 = 1, 3 do
		local var_10_3 = gohelper.findChild(arg_10_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1/rankobj/rank" .. iter_10_1)

		table.insert(arg_10_0._rankList1, var_10_3)

		local var_10_4 = gohelper.findChild(arg_10_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/rankobj/rank" .. iter_10_1)

		table.insert(arg_10_0._rankList2, var_10_4)
	end
end

function var_0_0._initPresetItem(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes[1]
	local var_11_1 = arg_11_0:getResInst(var_11_0, arg_11_0._goteampresetitem)

	arg_11_0._presetItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, V1a6_CachotTeamItem)
end

function var_0_0._initDetailItemList(arg_12_0)
	arg_12_0._detailItemList = arg_12_0:getUserDataTb_()

	local var_12_0 = {}

	for iter_12_0 = 6, 1, -1 do
		table.insert(var_12_0, iter_12_0)
	end

	gohelper.CreateObjList(arg_12_0, arg_12_0._initDetailItem, var_12_0, arg_12_0._godetails, arg_12_0._godetailitem)
end

function var_0_0._initDetailItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.starNum = arg_13_2
	var_13_0.lv1 = gohelper.findChildText(arg_13_1, "txt_level1")
	var_13_0.lv2 = gohelper.findChildText(arg_13_1, "txt_level2")
	var_13_0.lvnum = gohelper.findChildText(arg_13_1, "#txt_num")
	var_13_0.lvnum.text = tostring(arg_13_2)
	var_13_0._rankList1 = arg_13_0:getUserDataTb_()
	var_13_0._rankList2 = arg_13_0:getUserDataTb_()

	for iter_13_0 = 1, 3 do
		local var_13_1 = gohelper.findChild(arg_13_1, "txt_level1/rankobj/rank" .. iter_13_0)

		table.insert(var_13_0._rankList1, var_13_1)

		local var_13_2 = gohelper.findChild(arg_13_1, "rankobj/rank" .. iter_13_0)

		table.insert(var_13_0._rankList2, var_13_2)
	end

	local var_13_3 = 1

	for iter_13_1 = 1, var_13_3 do
		local var_13_4 = gohelper.findChild(arg_13_1, "rare/go_rare" .. iter_13_1)

		gohelper.setActive(var_13_4, iter_13_1 <= arg_13_2)
	end

	gohelper.setActive(arg_13_1, true)

	arg_13_0._detailItemList[arg_13_3] = var_13_0

	if arg_13_3 == 6 then
		gohelper.setActive(arg_13_1, false)
	end
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._teamItemMo = arg_15_0.viewParam and arg_15_0.viewParam.teamItemMo
	arg_15_0._seatIndex = arg_15_0.viewParam and arg_15_0.viewParam.seatIndex
	arg_15_0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(arg_15_0._seatIndex))
	arg_15_0._quality = gohelper.findChildImage(arg_15_0.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	arg_15_0._qualityEffectList = arg_15_0:getUserDataTb_()

	local var_15_0 = arg_15_0._goqualityeffect2.transform
	local var_15_1 = var_15_0.childCount

	for iter_15_0 = 1, var_15_1 do
		local var_15_2 = var_15_0:GetChild(iter_15_0 - 1)

		arg_15_0._qualityEffectList[var_15_2.name] = var_15_2

		local var_15_3 = var_15_2:GetComponentsInChildren(gohelper.Type_Image, true)

		for iter_15_1 = 0, var_15_3.Length - 1 do
			var_15_3[iter_15_1].maskable = true
		end
	end

	arg_15_0:_initPresetItem()
	arg_15_0._presetItem:onUpdateMO(arg_15_0._teamItemMo)
	arg_15_0:_showSeatInfo()
	arg_15_0:_showUpSwitch(false)
end

function var_0_0._showSeatInfo(arg_16_0)
	local var_16_0 = arg_16_0._seatIndex

	arg_16_0._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(arg_16_0._seatIndex))

	local var_16_1 = V1a6_CachotTeamModel.instance:getSeatLevel(var_16_0)
	local var_16_2 = lua_rogue_field.configDict[var_16_1]

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_16_0._imagequality2, "v1a6_cachot_quality_0" .. var_16_1)

	local var_16_3 = "effect_0" .. var_16_1

	for iter_16_0, iter_16_1 in pairs(arg_16_0._qualityEffectList) do
		gohelper.setActive(iter_16_1, iter_16_0 == var_16_3)
	end

	arg_16_0._txtbreaklevel2.text = "Lv." .. var_16_2.equipLevel
	arg_16_0._txttalentlevel2.text = "Lv." .. var_16_2.talentLevel

	local var_16_4 = arg_16_0._teamItemMo:getHeroMO()
	local var_16_5 = 6

	if var_16_4 then
		var_16_5 = CharacterEnum.Star[var_16_4.config.rare]
	end

	arg_16_0._roleStarNum.text = tostring(var_16_5)

	for iter_16_2, iter_16_3 in ipairs(arg_16_0._roleStarList) do
		gohelper.setActive(iter_16_3, iter_16_2 <= var_16_5)
	end

	local var_16_6 = arg_16_0:_getLevelKey(var_16_5)

	arg_16_0:_showDetailLevel(var_16_2[var_16_6], arg_16_0._txtlevel2, arg_16_0._rankList2)

	for iter_16_4, iter_16_5 in ipairs(arg_16_0._detailItemList) do
		local var_16_7 = arg_16_0:_getLevelKey(iter_16_5.starNum)

		arg_16_0:_updateDetailItem(iter_16_5, var_16_2, nil, var_16_7)
	end
end

function var_0_0._getLevelKey(arg_17_0, arg_17_1)
	if arg_17_1 >= 5 then
		return "level" .. arg_17_1
	else
		return "level4"
	end
end

function var_0_0._updateDetailItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_0:_showDetailLevel(arg_18_2[arg_18_4], arg_18_1.lv2, arg_18_1._rankList2)
end

function var_0_0._showDetailLevel(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0, var_19_1 = HeroConfig.instance:getShowLevel(arg_19_1)

	arg_19_2.text = "Lv." .. var_19_0

	for iter_19_0, iter_19_1 in ipairs(arg_19_3) do
		local var_19_2 = iter_19_0 == var_19_1 - 1

		gohelper.setActive(iter_19_1, var_19_2)
	end
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._hideDetail, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
