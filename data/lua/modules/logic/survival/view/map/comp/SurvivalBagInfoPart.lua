module("modules.logic.survival.view.map.comp.SurvivalBagInfoPart", package.seeall)

local var_0_0 = class("SurvivalBagInfoPart", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
	arg_1_0.go = arg_1_1
	arg_1_0.parent = arg_1_1.transform.parent
	arg_1_0._goinfo = gohelper.findChild(arg_1_1, "root/#go_info")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "root/#go_empty")
	arg_1_0._goquality5 = gohelper.findChild(arg_1_1, "root/#go_quality")
	arg_1_0._goprice = gohelper.findChild(arg_1_1, "root/#go_info/top/right/price")
	arg_1_0._txtprice = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/right/price/#txt_price")
	arg_1_0._goheavy = gohelper.findChild(arg_1_1, "root/#go_info/top/right/heavy")
	arg_1_0._txtheavy = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/right/heavy/#txt_heavy")
	arg_1_0._goequipTagItem = gohelper.findChild(arg_1_1, "root/#go_info/top/right/tag/go_item")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/middle/#txt_name")
	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/middle/#txt_num")
	arg_1_0._gonpc = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/npc")
	arg_1_0._imagenpc = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/npc/#simage_chess")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/collection")
	arg_1_0._imageitem = gohelper.findChildSingleImage(arg_1_1, "root/#go_info/top/middle/collection/#simage_icon")
	arg_1_0._imageitemrare = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/collection/#image_quailty2")
	arg_1_0._imageitemrare2 = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/npc/#image_quailty2")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/#btn_remove")
	arg_1_0._btnleave = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/#btn_leave")
	arg_1_0._goTips = gohelper.findChild(arg_1_1, "root/#go_info/top/left/go_tips")
	arg_1_0._btncloseTips = gohelper.findChildClick(arg_1_1, "root/#go_info/top/left/go_tips/#btn_close")
	arg_1_0._btntipremove = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#btn_remove")
	arg_1_0._btntipleave = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#btn_leave")
	arg_1_0._txthave = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/left/go_tips/#txt_currency")
	arg_1_0._txtremain = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/top/left/go_tips/#txt_after")
	arg_1_0._gotipsnum = gohelper.findChild(arg_1_1, "root/#go_info/top/left/go_tips/#go_num")
	arg_1_0._inputtipnum = gohelper.findChildTextMeshInputField(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/valuebg/#input_value")
	arg_1_0._btntipsaddnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/#btn_add")
	arg_1_0._btntipssubnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/top/left/go_tips/#go_num/#btn_sub")
	arg_1_0._btngoequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_goequip")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_use")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_equip")
	arg_1_0._btnunequip = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_unequip")
	arg_1_0._btnsearch = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_search")
	arg_1_0._btnsell = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_sell")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_buy")
	arg_1_0._btnplace = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_place")
	arg_1_0._btnunplace = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_unplace")
	arg_1_0._gonum = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num")
	arg_1_0._txtcount = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count")
	arg_1_0._goicon1 = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count/icon1")
	arg_1_0._goicon2 = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/#txt_count/icon2")
	arg_1_0._goinput = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_num/valuebg")
	arg_1_0._inputnum = gohelper.findChildTextMeshInputField(arg_1_1, "root/#go_info/bottom/#go_num/valuebg/#input_value")
	arg_1_0._btnaddnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_add")
	arg_1_0._btnsubnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_sub")
	arg_1_0._btnmaxnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_max")
	arg_1_0._btnminnum = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#go_num/#btn_min")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_1, "root/#go_info/bottom/#btn_select")
	arg_1_0._goscore = gohelper.findChild(arg_1_1, "root/#go_info/#go_score")
	arg_1_0._txtscore = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/#go_score/image_NumBG/#txt_Num")
	arg_1_0._imagescore = gohelper.findChildImage(arg_1_1, "root/#go_info/#go_score/image_NumBG/image_AssessIon")
	arg_1_0._goattritem = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base/Viewport/Content/#go_attrs/#go_baseitem")
	arg_1_0._goFrequency = gohelper.findChild(arg_1_1, "root/#go_info/Frequency")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num")
	arg_1_0._txtFrequencyName = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/txt_Frequency")
	arg_1_0._goscroll = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_close")

	gohelper.setActive(arg_1_0._btnClose, false)

	local var_1_0 = arg_1_1.transform.parent

	if var_1_0 then
		local var_1_1 = var_1_0.gameObject:GetComponentInParent(gohelper.Type_LimitedScrollRect)

		if var_1_1 then
			arg_1_0._goscroll:GetComponent(gohelper.Type_LimitedScrollRect).parentGameObject = var_1_1.gameObject
		end
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._openTips, arg_2_0)
	arg_2_0._btnleave:AddClickListener(arg_2_0._openTips, arg_2_0)
	arg_2_0._btncloseTips:AddClickListener(arg_2_0._closeTips, arg_2_0)
	arg_2_0._btntipremove:AddClickListener(arg_2_0._removeItem, arg_2_0)
	arg_2_0._btntipleave:AddClickListener(arg_2_0._removeItem, arg_2_0)
	arg_2_0._inputtipnum:AddOnEndEdit(arg_2_0._ontipnuminputChange, arg_2_0)
	arg_2_0._btntipsaddnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, 1)
	arg_2_0._btntipssubnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, -1)
	arg_2_0._btngoequip:AddClickListener(arg_2_0._onGoEquipClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._onUseClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onEquipClick, arg_2_0)
	arg_2_0._btnunequip:AddClickListener(arg_2_0._onUnEquipClick, arg_2_0)
	arg_2_0._btnsearch:AddClickListener(arg_2_0._onSearchClick, arg_2_0)
	arg_2_0._btnsell:AddClickListener(arg_2_0._onSellClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._onBuyClick, arg_2_0)
	arg_2_0._btnplace:AddClickListener(arg_2_0._onPlaceClick, arg_2_0)
	arg_2_0._btnunplace:AddClickListener(arg_2_0._onUnPlaceClick, arg_2_0)
	arg_2_0._inputnum:AddOnEndEdit(arg_2_0._ontnuminputChange, arg_2_0)
	arg_2_0._btnaddnum:AddClickListener(arg_2_0._onAddNumClick, arg_2_0, 1)
	arg_2_0._btnsubnum:AddClickListener(arg_2_0._onAddNumClick, arg_2_0, -1)
	arg_2_0._btnmaxnum:AddClickListener(arg_2_0._onMaxNumClick, arg_2_0)
	arg_2_0._btnminnum:AddClickListener(arg_2_0._onMinNumClick, arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._onSelectClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onClickCloseTips, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_2_0.updateCenterShow, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnremove:RemoveClickListener()
	arg_3_0._btnleave:RemoveClickListener()
	arg_3_0._btncloseTips:RemoveClickListener()
	arg_3_0._btntipremove:RemoveClickListener()
	arg_3_0._btntipleave:RemoveClickListener()
	arg_3_0._inputtipnum:RemoveOnEndEdit()
	arg_3_0._btntipsaddnum:RemoveClickListener()
	arg_3_0._btntipssubnum:RemoveClickListener()
	arg_3_0._btngoequip:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnunequip:RemoveClickListener()
	arg_3_0._btnsearch:RemoveClickListener()
	arg_3_0._btnsell:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnplace:RemoveClickListener()
	arg_3_0._btnunplace:RemoveClickListener()
	arg_3_0._inputnum:RemoveOnEndEdit()
	arg_3_0._btnaddnum:RemoveClickListener()
	arg_3_0._btnsubnum:RemoveClickListener()
	arg_3_0._btnmaxnum:RemoveClickListener()
	arg_3_0._btnminnum:RemoveClickListener()
	arg_3_0._btnselect:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_3_0.updateCenterShow, arg_3_0)
end

function var_0_0._onSelectClick(arg_4_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickBagItem, arg_4_0.mo)
end

function var_0_0._openTips(arg_5_0)
	gohelper.setActive(arg_5_0._goTips, true)
end

function var_0_0._closeTips(arg_6_0)
	gohelper.setActive(arg_6_0._goTips, false)
end

function var_0_0.setIsShowEmpty(arg_7_0, arg_7_1)
	arg_7_0._isShowEmpty = arg_7_1
end

function var_0_0.setCloseShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	gohelper.setActive(arg_8_0._btnClose, arg_8_1)

	arg_8_0._clickCloseCallback = arg_8_2
	arg_8_0._clickCloseCallobj = arg_8_3
end

function var_0_0._onClickCloseTips(arg_9_0)
	arg_9_0:updateMo()

	if arg_9_0._clickCloseCallback then
		arg_9_0._clickCloseCallback(arg_9_0._clickCloseCallobj)
	end
end

function var_0_0.setChangeSource(arg_10_0, arg_10_1)
	arg_10_0._changeSourceDict = arg_10_1
end

function var_0_0.getItemSource(arg_11_0)
	return arg_11_0._changeSourceDict and arg_11_0._changeSourceDict[arg_11_0.mo.source] or arg_11_0.mo.source
end

function var_0_0.setHideParent(arg_12_0, arg_12_1)
	arg_12_0.parent = arg_12_1
end

function var_0_0.updateMo(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goTips, false)

	local var_13_0 = arg_13_1 and arg_13_0.mo and arg_13_1 ~= arg_13_0.mo

	arg_13_0.mo = arg_13_1

	if arg_13_0._isShowEmpty then
		gohelper.setActive(arg_13_0._goinfo, arg_13_1)
		gohelper.setActive(arg_13_0._goempty, not arg_13_1)
	else
		gohelper.setActive(arg_13_0.parent, arg_13_1)
	end

	if var_13_0 then
		arg_13_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_13_0._refreshAll, arg_13_0, 0.167)
	else
		arg_13_0:_refreshAll()
	end

	local var_13_1 = arg_13_0.mo and arg_13_0.mo.co and arg_13_0.mo.co.rare == 5 and (SurvivalEnum.ItemSource.Drop == arg_13_0.mo.source or SurvivalEnum.ItemSource.Search == arg_13_0.mo.source)

	gohelper.setActive(arg_13_0._goquality5, arg_13_0.mo and arg_13_0.mo.co and arg_13_0.mo.co.rare == 5)

	if var_13_1 then
		arg_13_0._anim:Play("opensp", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_explore_senior)
	end
end

function var_0_0._refreshAll(arg_14_0)
	if arg_14_0.mo then
		arg_14_0:updatePrice()
		arg_14_0:updateHeavy()
		arg_14_0:updateEquipTag()
		arg_14_0:updateBaseInfo()
	end
end

function var_0_0.updatePrice(arg_15_0)
	local var_15_0 = arg_15_0.mo.co.worth

	gohelper.setActive(arg_15_0._goprice, not arg_15_0.mo:isNPC() and not arg_15_0.mo:isCurrency())

	arg_15_0._txtprice.text = var_15_0
end

function var_0_0.updateHeavy(arg_16_0)
	local var_16_0 = arg_16_0.mo.co.mass

	gohelper.setActive(arg_16_0._goheavy, var_16_0 > 0 and not arg_16_0.mo:isCurrency())

	arg_16_0._txtheavy.text = var_16_0
end

function var_0_0.updateEquipTag(arg_17_0)
	local var_17_0 = {}

	if arg_17_0.mo.equipCo then
		var_17_0 = string.splitToNumber(arg_17_0.mo.equipCo.tag, "#") or {}
	end

	gohelper.CreateObjList(arg_17_0, arg_17_0._createEquipTag, var_17_0, nil, arg_17_0._goequipTagItem)
end

function var_0_0._createEquipTag(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChildButtonWithAudio(arg_18_1, "")
	local var_18_1 = gohelper.findChildImage(arg_18_1, "#image_tag")
	local var_18_2 = lua_survival_equip_found.configDict[arg_18_2]

	if not var_18_2 then
		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(var_18_1, var_18_2.icon4)
	arg_18_0:removeClickCb(var_18_0)
	arg_18_0:addClickCb(var_18_0, arg_18_0._onClickTag, arg_18_0, {
		co = var_18_2,
		btn = var_18_0
	})
end

function var_0_0._onClickTag(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.btn.transform
	local var_19_1 = var_19_0.lossyScale
	local var_19_2 = var_19_0.position
	local var_19_3 = recthelper.getWidth(var_19_0)
	local var_19_4 = recthelper.getHeight(var_19_0)

	var_19_2.x = var_19_2.x - var_19_3 / 2 * var_19_1.x
	var_19_2.y = var_19_2.y + var_19_4 / 2 * var_19_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		txt = arg_19_1.co.name,
		pos = var_19_2
	})
end

function var_0_0.updateBaseInfo(arg_20_0)
	local var_20_0 = luaLang("multiple")

	arg_20_0._txtname.text = arg_20_0.mo.co.name

	if arg_20_0.mo.count > 1 then
		arg_20_0._txtnum.text = var_20_0 .. arg_20_0.mo.count
	else
		arg_20_0._txtnum.text = ""
	end

	local var_20_1 = arg_20_0:getItemSource()
	local var_20_2 = var_20_1 == SurvivalEnum.ItemSource.Search or arg_20_0.mo.co.disposable == 0 and not arg_20_0.mo:isCurrency() and (var_20_1 == SurvivalEnum.ItemSource.Map or var_20_1 == SurvivalEnum.ItemSource.Shelter)

	gohelper.setActive(arg_20_0._btnleave, var_20_2 and arg_20_0.mo.npcCo)
	gohelper.setActive(arg_20_0._btntipleave, arg_20_0.mo.npcCo)
	gohelper.setActive(arg_20_0._btnremove, var_20_2 and not arg_20_0.mo.npcCo)
	gohelper.setActive(arg_20_0._btntipremove, not arg_20_0.mo.npcCo)
	gohelper.setActive(arg_20_0._gonpc, arg_20_0.mo.npcCo)
	gohelper.setActive(arg_20_0._goitem, not arg_20_0.mo.npcCo)

	if arg_20_0.mo.npcCo then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_20_0._imagenpc, arg_20_0.mo.npcCo.headIcon, false)
		UISpriteSetMgr.instance:setSurvivalSprite(arg_20_0._imageitemrare2, "survival_bag_itemquality2_" .. arg_20_0.mo.npcCo.rare, false)
	else
		UISpriteSetMgr.instance:setSurvivalSprite(arg_20_0._imageitemrare, "survival_bag_itemquality2_" .. arg_20_0.mo.co.rare, false)
		arg_20_0._imageitem:LoadImage(ResUrl.getSurvivalItemIcon(arg_20_0.mo.co.icon))
	end

	arg_20_0:updateTipCountShow()
	arg_20_0:updateBtnsShow()
	arg_20_0:updateCenterShow()
end

function var_0_0.updateTipCountShow(arg_21_0)
	arg_21_0._inputtipnum:SetText(arg_21_0.mo.count)

	if arg_21_0.mo.count <= 1 then
		gohelper.setActive(arg_21_0._gotipsnum, false)
		gohelper.setActive(arg_21_0._txthave, false)
		gohelper.setActive(arg_21_0._txtremain, false)
	else
		gohelper.setActive(arg_21_0._gotipsnum, true)

		if arg_21_0:getItemSource() ~= SurvivalEnum.ItemSource.Search then
			gohelper.setActive(arg_21_0._txthave, true)
			gohelper.setActive(arg_21_0._txtremain, true)
			arg_21_0:updateTipCount()
		else
			gohelper.setActive(arg_21_0._txthave, false)
			gohelper.setActive(arg_21_0._txtremain, false)
		end
	end
end

local var_0_1 = {
	490,
	346,
	313,
	284.9,
	317.9
}

function var_0_0.updateBtnsShow(arg_22_0)
	local var_22_0 = 1

	arg_22_0._inputnum:SetText(arg_22_0.mo.count)
	gohelper.setActive(arg_22_0._btngoequip, false)
	gohelper.setActive(arg_22_0._btnuse, false)
	gohelper.setActive(arg_22_0._btnequip, false)
	gohelper.setActive(arg_22_0._btnunequip, false)
	gohelper.setActive(arg_22_0._btnsearch, false)
	gohelper.setActive(arg_22_0._btnsell, false)
	gohelper.setActive(arg_22_0._btnbuy, false)
	gohelper.setActive(arg_22_0._btnplace, false)
	gohelper.setActive(arg_22_0._btnunplace, false)
	gohelper.setActive(arg_22_0._gonum, false)
	gohelper.setActive(arg_22_0._txtcount, false)
	gohelper.setActive(arg_22_0._goicon1, false)
	gohelper.setActive(arg_22_0._goicon2, false)
	gohelper.setActive(arg_22_0._btnselect, false)

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		gohelper.setActive(arg_22_0._btnsearch, true)
		gohelper.setActive(arg_22_0._gonum, arg_22_0.mo.count > 1)

		var_22_0 = arg_22_0.mo.count > 1 and 3 or 2
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Map and not SurvivalMapModel.instance:getSceneMo().panel then
		if arg_22_0.mo.equipCo then
			var_22_0 = 2

			gohelper.setActive(arg_22_0._btngoequip, true)
		elseif arg_22_0.mo.co.type == SurvivalEnum.ItemType.Quick then
			var_22_0 = 2

			gohelper.setActive(arg_22_0._btnuse, true)
		end
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Equip then
		var_22_0 = 2

		gohelper.setActive(arg_22_0._btnunequip, true)
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		var_22_0 = 2

		gohelper.setActive(arg_22_0._btnequip, true)
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Commit then
		gohelper.setActive(arg_22_0._txtcount, true)
		gohelper.setActive(arg_22_0._goicon1, true)
		gohelper.setActive(arg_22_0._gonum, arg_22_0.mo.count > 1)
		gohelper.setActive(arg_22_0._btnplace, true)

		var_22_0 = arg_22_0.mo.count > 1 and 4 or 5

		arg_22_0._inputnum:SetText("1")
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Commited then
		gohelper.setActive(arg_22_0._txtcount, true)
		gohelper.setActive(arg_22_0._goicon1, true)
		gohelper.setActive(arg_22_0._gonum, arg_22_0.mo.count > 1)
		gohelper.setActive(arg_22_0._btnunplace, true)

		var_22_0 = arg_22_0.mo.count > 1 and 4 or 5
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.Composite then
		var_22_0 = 2

		gohelper.setActive(arg_22_0._btnselect, true)
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.ShopBag then
		var_22_0 = 4

		gohelper.setActive(arg_22_0._txtcount, true)
		gohelper.setActive(arg_22_0._goicon2, true)
		gohelper.setActive(arg_22_0._gonum, true)
		gohelper.setActive(arg_22_0._btnsell, true)
	end

	if arg_22_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem then
		var_22_0 = 4

		gohelper.setActive(arg_22_0._txtcount, true)
		gohelper.setActive(arg_22_0._goicon2, true)
		gohelper.setActive(arg_22_0._gonum, true)
		gohelper.setActive(arg_22_0._btnbuy, true)
		arg_22_0._inputnum:SetText("1")
	end

	recthelper.setHeight(arg_22_0._goscroll.transform, var_0_1[var_22_0])
	arg_22_0:onInputValueChange()
end

function var_0_0.updateCenterShow(arg_23_0)
	if not arg_23_0.mo then
		return
	end

	gohelper.setActive(arg_23_0._goscore, arg_23_0.mo.co.type == SurvivalEnum.ItemType.Equip)

	local var_23_0 = {}

	gohelper.setActive(arg_23_0._goFrequency, false)

	if arg_23_0.mo.equipCo then
		local var_23_1, var_23_2 = arg_23_0.mo:getEquipScoreLevel()

		UISpriteSetMgr.instance:setSurvivalSprite(arg_23_0._imagescore, "survivalequip_scoreicon_" .. var_23_1)

		arg_23_0._txtscore.text = string.format("<color=%s>%s</color>", var_23_2, arg_23_0.mo.equipCo.score + arg_23_0.mo.exScore)

		if arg_23_0.mo.slotMo then
			local var_23_3 = arg_23_0.mo.slotMo.parent.maxTagId
			local var_23_4 = lua_survival_equip_found.configDict[var_23_3]

			if var_23_4 then
				gohelper.setActive(arg_23_0._goFrequency, true)
				UISpriteSetMgr.instance:setSurvivalSprite(arg_23_0._imageFrequency, var_23_4.value)

				arg_23_0._txtFrequency.text = arg_23_0.mo.equipValues and arg_23_0.mo.equipValues[var_23_4.value] or 0

				local var_23_5 = lua_survival_attr.configDict[var_23_4.value]

				arg_23_0._txtFrequencyName.text = var_23_5 and var_23_5.name or ""
			end
		end

		local var_23_6 = arg_23_0.mo:getEquipEffectDesc()

		var_23_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list2 = var_23_6
		}
		var_23_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_23_0.mo.equipCo.desc
			}
		}
	elseif arg_23_0.mo.npcCo then
		local var_23_7, var_23_8 = SurvivalConfig.instance:getNpcConfigTag(arg_23_0.mo.npcCo.id)

		if var_23_8 then
			for iter_23_0, iter_23_1 in ipairs(var_23_8) do
				local var_23_9 = lua_survival_tag.configDict[iter_23_1]

				table.insert(var_23_0, {
					icon = "survival_bag_title0" .. var_23_9.color,
					desc = var_23_9.name,
					list = {
						var_23_9.desc
					}
				})
			end
		end
	else
		var_23_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list = {
				arg_23_0.mo.co.desc1
			}
		}
		var_23_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_23_0.mo.co.desc2
			}
		}
	end

	gohelper.CreateObjList(arg_23_0, arg_23_0._createDescItems, var_23_0, nil, arg_23_0._goattritem)
end

function var_0_0._createDescItems(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = gohelper.findChildImage(arg_24_1, "#image_title")
	local var_24_1 = gohelper.findChildTextMesh(arg_24_1, "#image_title/#txt_title")
	local var_24_2 = gohelper.findChildButtonWithAudio(arg_24_1, "#image_title/#txt_title/#btn_switch")
	local var_24_3 = gohelper.findChild(arg_24_1, "layout/#go_decitem")
	local var_24_4 = gohelper.findChild(arg_24_1, "layout/#go_decitem2")
	local var_24_5 = gohelper.findChild(arg_24_1, "layout/#go_decitem/#txt_desc")
	local var_24_6 = gohelper.findChild(arg_24_1, "layout/#go_decitem2/#txt_desc")

	UISpriteSetMgr.instance:setSurvivalSprite(var_24_0, arg_24_2.icon)

	var_24_1.text = arg_24_2.desc

	gohelper.setActive(var_24_3, arg_24_2.list)
	gohelper.setActive(var_24_4, arg_24_2.list2)
	gohelper.setActive(var_24_2, arg_24_2.list2)
	arg_24_0:addClickCb(var_24_2, arg_24_0._onClickSwitch, arg_24_0)

	if arg_24_2.list then
		gohelper.CreateObjList(arg_24_0, arg_24_0._createSubDescItems, arg_24_2.list, nil, var_24_5)
	end

	if arg_24_2.list2 then
		gohelper.CreateObjList(arg_24_0, arg_24_0._createSubDescItems2, arg_24_2.list2, nil, var_24_6)
	end
end

function var_0_0._onClickSwitch(arg_25_0)
	SurvivalModel.instance:changeDescSimple()
end

function var_0_0._createSubDescItems(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	gohelper.findChildTextMesh(arg_26_1, "").text = arg_26_2
end

function var_0_0._createSubDescItems2(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = gohelper.getClick(arg_27_1)
	local var_27_1 = gohelper.findChildTextMesh(arg_27_1, "")
	local var_27_2 = gohelper.findChildImage(arg_27_1, "point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_27_1.gameObject, SurvivalSkillDescComp):updateInfo(var_27_1, arg_27_2[1], 3028)
	arg_27_0:addClickCb(var_27_0, arg_27_0._onClickDesc, arg_27_0)

	local var_27_3 = arg_27_2[2]

	if arg_27_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		var_27_3 = false
	elseif arg_27_0:getItemSource() ~= SurvivalEnum.ItemSource.Equip then
		var_27_3 = true
	end

	ZProj.UGUIHelper.SetColorAlpha(var_27_1, var_27_3 and 1 or 0.5)

	if var_27_3 then
		var_27_2.color = GameUtil.parseColor("#000000")
	else
		var_27_2.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0.setClickDescCallback(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0._clickDescCallback, arg_28_0._clickDescCallobj, arg_28_0._clickDescParam = arg_28_1, arg_28_2, arg_28_3
end

function var_0_0._onClickDesc(arg_29_0)
	if arg_29_0._clickDescCallback then
		arg_29_0._clickDescCallback(arg_29_0._clickDescCallobj, arg_29_0._clickDescParam)
	end
end

function var_0_0._removeItem(arg_30_0)
	local var_30_0 = tonumber(arg_30_0._inputtipnum:GetText()) or 0
	local var_30_1 = Mathf.Clamp(var_30_0, 1, arg_30_0.mo.count)

	if arg_30_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		SurvivalMapModel.instance.isSearchRemove = true

		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "2#" .. arg_30_0.mo.uid .. "#" .. var_30_1)
	else
		SurvivalWeekRpc.instance:sendSurvivalRemoveBagItem(arg_30_0.mo.source, arg_30_0.mo.uid, var_30_1)
	end

	gohelper.setActive(arg_30_0._goTips, false)
end

function var_0_0._ontipnuminputChange(arg_31_0)
	local var_31_0 = tonumber(arg_31_0._inputtipnum:GetText()) or 0
	local var_31_1 = Mathf.Clamp(var_31_0, 1, arg_31_0.mo.count)

	if tostring(var_31_1) ~= arg_31_0._inputtipnum:GetText() then
		arg_31_0._inputtipnum:SetText(tostring(var_31_1))
		arg_31_0:updateTipCount()
	end
end

function var_0_0._addtipnum(arg_32_0, arg_32_1)
	local var_32_0 = (tonumber(arg_32_0._inputtipnum:GetText()) or 0) + arg_32_1
	local var_32_1 = Mathf.Clamp(var_32_0, 1, arg_32_0.mo.count)

	arg_32_0._inputtipnum:SetText(tostring(var_32_1))
	arg_32_0:updateTipCount()
end

function var_0_0.updateTipCount(arg_33_0)
	if arg_33_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		return
	end

	local var_33_0 = tonumber(arg_33_0._inputtipnum:GetText()) or 0

	arg_33_0._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), arg_33_0.mo.count)
	arg_33_0._txtremain.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_remain"), arg_33_0.mo.count - var_33_0)
end

function var_0_0.setCurEquipSlot(arg_34_0, arg_34_1)
	arg_34_0._slotId = arg_34_1
end

function var_0_0._onEquipClick(arg_35_0)
	if SurvivalShelterModel.instance:getWeekInfo().equipBox.slots[arg_35_0._slotId].level < arg_35_0.mo.equipLevel then
		GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalEquipWear(arg_35_0._slotId or 1, arg_35_0.mo.uid)
end

function var_0_0._onUnEquipClick(arg_36_0)
	SurvivalWeekRpc.instance:sendSurvivalEquipDemount(arg_36_0._slotId or 1)
end

function var_0_0._onSearchClick(arg_37_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#" .. arg_37_0.mo.uid .. "#" .. arg_37_0._inputnum:GetText())
end

function var_0_0._onSellClick(arg_38_0)
	SurvivalWeekRpc.instance:sendSurvivalShopSellRequest(arg_38_0.mo.uid, tonumber(arg_38_0._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "SellItem", arg_38_0.mo)
end

function var_0_0._onBuyClick(arg_39_0)
	if not arg_39_0._canBuy then
		GameFacade.showToast(ToastEnum.SurvivalNoMoney)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalShopBuyRequest(arg_39_0.mo.uid, tonumber(arg_39_0._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "BuyItem", arg_39_0.mo)
end

function var_0_0._onGoEquipClick(arg_40_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0._onUseClick(arg_41_0)
	if SurvivalMapHelper.instance:isInFlow() then
		GameFacade.showToast(ToastEnum.SurvivalCantUseItem)

		return
	end

	if SurvivalEnum.CustomUseItemSubType[arg_41_0.mo.co.subType] then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUseQuickItem, arg_41_0.mo)
		ViewMgr.instance:closeAllPopupViews()
	elseif arg_41_0.mo.co.subType == SurvivalEnum.ItemSubType.Quick_Exit then
		arg_41_0._exitItemMo = arg_41_0.mo

		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalItemAbort, MsgBoxEnum.BoxType.Yes_No, arg_41_0._sendUseItem, nil, nil, arg_41_0, nil, nil)
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_41_0.mo.uid, "")
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Use", arg_41_0.mo)
end

function var_0_0._sendUseItem(arg_42_0)
	SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_42_0._exitItemMo.uid, "")
end

function var_0_0._onPlaceClick(arg_43_0)
	local var_43_0 = tonumber(arg_43_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Place", arg_43_0.mo, var_43_0)
end

function var_0_0._onUnPlaceClick(arg_44_0)
	local var_44_0 = tonumber(arg_44_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "UnPlace", arg_44_0.mo, var_44_0)
end

function var_0_0._ontnuminputChange(arg_45_0)
	local var_45_0 = tonumber(arg_45_0._inputnum:GetText()) or 0
	local var_45_1 = Mathf.Clamp(var_45_0, 1, arg_45_0.mo.count)

	if tostring(var_45_1) ~= arg_45_0._inputnum:GetText() then
		arg_45_0._inputnum:SetText(tostring(var_45_1))
	end

	arg_45_0:onInputValueChange()
end

function var_0_0._onAddNumClick(arg_46_0, arg_46_1)
	local var_46_0 = (tonumber(arg_46_0._inputnum:GetText()) or 0) + arg_46_1
	local var_46_1 = Mathf.Clamp(var_46_0, 1, arg_46_0.mo.count)

	arg_46_0._inputnum:SetText(tostring(var_46_1))
	arg_46_0:onInputValueChange()
end

function var_0_0.onInputValueChange(arg_47_0)
	local var_47_0 = tonumber(arg_47_0._inputnum:GetText()) or 0
	local var_47_1 = arg_47_0:getItemSource()

	if var_47_1 == SurvivalEnum.ItemSource.Commit or var_47_1 == SurvivalEnum.ItemSource.Commited then
		local var_47_2 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.NpcRecruitment, arg_47_0.mo.co.worth)

		arg_47_0._txtcount.text = var_47_0 * var_47_2
	end

	if var_47_1 == SurvivalEnum.ItemSource.ShopBag then
		arg_47_0._txtcount.text = var_47_0 * arg_47_0.mo:getSellPrice()
	end

	if var_47_1 == SurvivalEnum.ItemSource.ShopItem then
		local var_47_3 = SurvivalShelterModel.instance:getWeekInfo()
		local var_47_4 = var_47_3.bag

		if var_47_3.inSurvival then
			var_47_4 = SurvivalMapModel.instance:getSceneMo().bag
		end

		local var_47_5 = var_47_4:getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local var_47_6 = var_47_0 * arg_47_0.mo:getBuyPrice()

		arg_47_0._canBuy = var_47_6 <= var_47_5

		if var_47_6 <= var_47_5 then
			arg_47_0._txtcount.text = string.format("%d/%d", var_47_5, var_47_6)
		else
			arg_47_0._txtcount.text = string.format("<color=#ec4747>%d</color>/%d", var_47_5, var_47_6)
		end
	end
end

function var_0_0._onMaxNumClick(arg_48_0)
	local var_48_0 = arg_48_0.mo.count

	if arg_48_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem then
		local var_48_1 = SurvivalMapHelper.instance:getBagMo():getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local var_48_2 = math.floor(var_48_1 / arg_48_0.mo:getBuyPrice())

		if var_48_2 <= 0 then
			var_48_2 = 1
		end

		var_48_0 = Mathf.Clamp(var_48_0, 1, var_48_2)
	end

	arg_48_0._inputnum:SetText(var_48_0)
	arg_48_0:onInputValueChange()
end

function var_0_0._onMinNumClick(arg_49_0)
	arg_49_0._inputnum:SetText(1)
	arg_49_0:onInputValueChange()
end

function var_0_0.onDestroy(arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._refreshAll, arg_50_0)
end

return var_0_0
