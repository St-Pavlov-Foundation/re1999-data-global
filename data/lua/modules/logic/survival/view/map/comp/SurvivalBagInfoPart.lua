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
	arg_1_0._imagenpc = gohelper.findChildSingleImage(arg_1_1, "root/#go_info/top/middle/npc/#simage_chess")
	arg_1_0._goitem = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/collection")
	arg_1_0._imageitem = gohelper.findChildSingleImage(arg_1_1, "root/#go_info/top/middle/collection/#simage_icon")
	arg_1_0._imageitemrare = gohelper.findChildImage(arg_1_1, "root/#go_info/top/middle/collection/#image_quailty2")
	arg_1_0._effect6 = gohelper.findChild(arg_1_1, "root/#go_info/top/middle/collection/#go_deceffect")
	arg_1_0._effect6_2 = gohelper.findChild(arg_1_1, "root/#go_deceffect")
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
	arg_1_0._go_rewardinherit = gohelper.findChild(arg_1_1, "root/#go_info/bottom/#go_rewardinherit")
	arg_1_0._btn_rewardinherit_select = gohelper.findChildButtonWithAudio(arg_1_0._go_rewardinherit, "#btn_rewardinherit_select")
	arg_1_0._btn_rewardinherit_unselect = gohelper.findChildButtonWithAudio(arg_1_0._go_rewardinherit, "#btn_rewardinherit_unselect")
	arg_1_0._goscore = gohelper.findChild(arg_1_1, "root/#go_info/#go_score")
	arg_1_0._txtscore = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/#go_score/image_NumBG/#txt_Num")
	arg_1_0._imagescore = gohelper.findChildImage(arg_1_1, "root/#go_info/#go_score/image_NumBG/image_AssessIon")
	arg_1_0._goattritem = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base/Viewport/Content/#go_attrs/#go_baseitem")
	arg_1_0._goFrequency = gohelper.findChild(arg_1_1, "root/#go_info/Frequency")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/image_NumBG/#txt_Num")
	arg_1_0._txtFrequencyName = gohelper.findChildTextMesh(arg_1_1, "root/#go_info/Frequency/txt_Frequency")
	arg_1_0._goscroll = gohelper.findChild(arg_1_1, "root/#go_info/scroll_base")
	arg_1_0.itemSubType_npc = gohelper.findChild(arg_1_1, "root/#go_info/top/left/itemSubType_npc")
	arg_1_0.recommend = gohelper.findChild(arg_1_1, "root/#go_info/top/left/recommend")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_1, "root/#btn_close")

	gohelper.setActive(arg_1_0._btnClose, false)

	arg_1_0._showBtns = true

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
	arg_2_0._btn_rewardinherit_select:AddClickListener(arg_2_0._onRewardInheritSelectClick, arg_2_0)
	arg_2_0._btn_rewardinherit_unselect:AddClickListener(arg_2_0._onRewardInheritUnSelectClick, arg_2_0)
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
	arg_3_0._btn_rewardinherit_select:RemoveClickListener()
	arg_3_0._btn_rewardinherit_unselect:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipDescSimpleChange, arg_3_0.updateCenterShow, arg_3_0)
end

function var_0_0._onSelectClick(arg_4_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickBagItem, arg_4_0.mo)
end

function var_0_0._onRewardInheritSelectClick(arg_5_0)
	if arg_5_0._onClickSelectCallBack then
		arg_5_0._onClickSelectCallBack(arg_5_0._rewardInheritBtnContext, arg_5_0)
	end
end

function var_0_0._onRewardInheritUnSelectClick(arg_6_0)
	if arg_6_0._onClickUnSelectCallBack then
		arg_6_0._onClickUnSelectCallBack(arg_6_0._rewardInheritBtnContext, arg_6_0)
	end
end

function var_0_0._openTips(arg_7_0)
	gohelper.setActive(arg_7_0._goTips, true)
end

function var_0_0._closeTips(arg_8_0)
	gohelper.setActive(arg_8_0._goTips, false)
end

function var_0_0.setIsShowEmpty(arg_9_0, arg_9_1)
	arg_9_0._isShowEmpty = arg_9_1
end

function var_0_0.setCloseShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.setActive(arg_10_0._btnClose, arg_10_1)

	arg_10_0._clickCloseCallback = arg_10_2
	arg_10_0._clickCloseCallobj = arg_10_3
end

function var_0_0._onClickCloseTips(arg_11_0)
	arg_11_0:updateMo()

	if arg_11_0._clickCloseCallback then
		arg_11_0._clickCloseCallback(arg_11_0._clickCloseCallobj)
	end
end

function var_0_0.setChangeSource(arg_12_0, arg_12_1)
	arg_12_0._changeSourceDict = arg_12_1
end

function var_0_0.getItemSource(arg_13_0)
	return arg_13_0._changeSourceDict and arg_13_0._changeSourceDict[arg_13_0.mo.source] or arg_13_0.mo.source
end

function var_0_0.setHideParent(arg_14_0, arg_14_1)
	arg_14_0.parent = arg_14_1
end

function var_0_0.setShopData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.shopId = arg_15_1
	arg_15_0.shopType = arg_15_2
end

function var_0_0.updateMo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.param = arg_16_2 or {}

	gohelper.setActive(arg_16_0._goTips, false)

	local var_16_0 = arg_16_1 and arg_16_0.mo and arg_16_1 ~= arg_16_0.mo

	arg_16_0.mo = arg_16_1

	if arg_16_0._isShowEmpty then
		gohelper.setActive(arg_16_0._goinfo, arg_16_1)
		gohelper.setActive(arg_16_0._goempty, not arg_16_1)
	else
		gohelper.setActive(arg_16_0.parent, arg_16_1)
	end

	if var_16_0 and not arg_16_0.param.jumpChangeAnim then
		arg_16_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_16_0._refreshAll, arg_16_0, 0.167)
	else
		arg_16_0:_refreshAll()
	end

	local var_16_1 = arg_16_0.mo and arg_16_0.mo.co and arg_16_0.mo.co.rare == 5 and (SurvivalEnum.ItemSource.Drop == arg_16_0.mo.source or SurvivalEnum.ItemSource.Search == arg_16_0.mo.source)

	gohelper.setActive(arg_16_0._goquality5, arg_16_0.mo and arg_16_0.mo.co and arg_16_0.mo.co.rare == 5)

	if var_16_1 then
		arg_16_0._anim:Play("opensp", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_explore_senior)
	end

	gohelper.setActive(arg_16_0.recommend, arg_16_0.shopType and arg_16_0.mo and arg_16_0:isShelterShop() and arg_16_0.mo:isDisasterRecommendItem(arg_16_0.param.mapId))
	gohelper.setActive(arg_16_0.itemSubType_npc, arg_16_0.shopType and arg_16_0.mo and arg_16_0:isSurvivalShop() and arg_16_0.mo:isNPCRecommendItem())
end

function var_0_0.isShelterShop(arg_17_0)
	return not SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0.isSurvivalShop(arg_18_0)
	return SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0._refreshAll(arg_19_0)
	if arg_19_0.mo then
		arg_19_0:updatePrice()
		arg_19_0:updateHeavy()
		arg_19_0:updateEquipTag()
		arg_19_0:updateBaseInfo()
	end
end

function var_0_0.updatePrice(arg_20_0)
	gohelper.setActive(arg_20_0._goprice, not arg_20_0.mo:isNPC() and not arg_20_0.mo:isCurrency())

	if arg_20_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem and arg_20_0.mo.getBuyPrice then
		arg_20_0._txtprice.text = arg_20_0.mo:getBuyPrice()
	elseif arg_20_0:getItemSource() == SurvivalEnum.ItemSource.ShopBag then
		arg_20_0._txtprice.text = arg_20_0.mo:getSellPrice(arg_20_0.shopId)
	else
		local var_20_0 = arg_20_0.mo.co.worth

		arg_20_0._txtprice.text = var_20_0
	end
end

function var_0_0.updateHeavy(arg_21_0)
	local var_21_0 = arg_21_0.mo.co.mass

	gohelper.setActive(arg_21_0._goheavy, var_21_0 > 0 and not arg_21_0.mo:isCurrency())

	arg_21_0._txtheavy.text = var_21_0
end

function var_0_0.updateEquipTag(arg_22_0)
	local var_22_0 = {}

	if arg_22_0.mo.equipCo then
		if arg_22_0.mo.equipCo.equipType == 0 then
			local var_22_1 = string.splitToNumber(arg_22_0.mo.equipCo.tag, "#") or {}

			for iter_22_0, iter_22_1 in ipairs(var_22_1) do
				local var_22_2 = lua_survival_equip_found.configDict[iter_22_1]

				if var_22_2 then
					table.insert(var_22_0, {
						icon = var_22_2.icon4,
						desc = var_22_2.name
					})
				end
			end
		else
			var_22_0 = {
				{
					icon = "100",
					desc = luaLang("survival_spequip_tag")
				}
			}
		end
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0._createEquipTag, var_22_0, nil, arg_22_0._goequipTagItem)
end

function var_0_0._createEquipTag(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = gohelper.findChildButtonWithAudio(arg_23_1, "")
	local var_23_1 = gohelper.findChildImage(arg_23_1, "#image_tag")

	UISpriteSetMgr.instance:setSurvivalSprite(var_23_1, arg_23_2.icon)
	arg_23_0:removeClickCb(var_23_0)

	if arg_23_2.desc then
		arg_23_0:addClickCb(var_23_0, arg_23_0._onClickTag, arg_23_0, {
			desc = arg_23_2.desc,
			btn = var_23_0
		})
	end
end

function var_0_0._onClickTag(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.btn.transform
	local var_24_1 = var_24_0.lossyScale
	local var_24_2 = var_24_0.position
	local var_24_3 = recthelper.getWidth(var_24_0)
	local var_24_4 = recthelper.getHeight(var_24_0)

	var_24_2.x = var_24_2.x - var_24_3 / 2 * var_24_1.x
	var_24_2.y = var_24_2.y + var_24_4 / 2 * var_24_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		txt = arg_24_1.desc,
		pos = var_24_2
	})
end

function var_0_0.updateBaseInfo(arg_25_0)
	local var_25_0 = luaLang("multiple")

	arg_25_0._txtname.text = arg_25_0.mo.co.name

	if arg_25_0.mo.count > 1 then
		arg_25_0._txtnum.text = var_25_0 .. arg_25_0.mo.count
	else
		arg_25_0._txtnum.text = ""
	end

	local var_25_1 = arg_25_0:getItemSource()
	local var_25_2 = var_25_1 == SurvivalEnum.ItemSource.Search or arg_25_0.mo.co.disposable == 0 and not arg_25_0.mo:isCurrency() and (var_25_1 == SurvivalEnum.ItemSource.Map or var_25_1 == SurvivalEnum.ItemSource.Shelter)

	gohelper.setActive(arg_25_0._btnleave, var_25_2 and arg_25_0.mo.npcCo)
	gohelper.setActive(arg_25_0._btntipleave, arg_25_0.mo.npcCo)
	gohelper.setActive(arg_25_0._btnremove, var_25_2 and not arg_25_0.mo.npcCo)
	gohelper.setActive(arg_25_0._btntipremove, not arg_25_0.mo.npcCo)
	gohelper.setActive(arg_25_0._gonpc, arg_25_0.mo.npcCo)
	gohelper.setActive(arg_25_0._goitem, not arg_25_0.mo.npcCo)

	if arg_25_0.mo.npcCo then
		SurvivalUnitIconHelper.instance:setNpcIcon(arg_25_0._imagenpc, arg_25_0.mo.npcCo.headIcon)
		UISpriteSetMgr.instance:setSurvivalSprite(arg_25_0._imageitemrare2, "survival_bag_itemquality2_" .. arg_25_0.mo.npcCo.rare, false)
		gohelper.setActive(arg_25_0._effect6, false)
		gohelper.setActive(arg_25_0._effect6_2, false)
	else
		UISpriteSetMgr.instance:setSurvivalSprite(arg_25_0._imageitemrare, "survival_bag_itemquality2_" .. arg_25_0.mo.co.rare, false)
		arg_25_0._imageitem:LoadImage(ResUrl.getSurvivalItemIcon(arg_25_0.mo.co.icon))
		gohelper.setActive(arg_25_0._effect6, arg_25_0.mo.co.rare == 6)
		gohelper.setActive(arg_25_0._effect6_2, arg_25_0.mo.co.rare == 6)
	end

	arg_25_0:updateTipCountShow()
	arg_25_0:updateBtnsShow()
	arg_25_0:updateCenterShow()
end

function var_0_0.updateTipCountShow(arg_26_0)
	arg_26_0._inputtipnum:SetText(arg_26_0.mo.count)

	if arg_26_0.mo.count <= 1 then
		gohelper.setActive(arg_26_0._gotipsnum, false)
		gohelper.setActive(arg_26_0._txthave, false)
		gohelper.setActive(arg_26_0._txtremain, false)
	else
		gohelper.setActive(arg_26_0._gotipsnum, true)

		if arg_26_0:getItemSource() ~= SurvivalEnum.ItemSource.Search then
			gohelper.setActive(arg_26_0._txthave, true)
			gohelper.setActive(arg_26_0._txtremain, true)
			arg_26_0:updateTipCount()
		else
			gohelper.setActive(arg_26_0._txthave, false)
			gohelper.setActive(arg_26_0._txtremain, false)
		end
	end
end

function var_0_0.setShowBtns(arg_27_0, arg_27_1)
	arg_27_0._showBtns = arg_27_1
end

local var_0_1 = {
	490,
	346,
	313,
	284.9,
	317.9
}

function var_0_0.updateBtnsShow(arg_28_0)
	local var_28_0 = 1

	arg_28_0._inputnum:SetText(arg_28_0.mo.count)
	gohelper.setActive(arg_28_0._btngoequip, false)
	gohelper.setActive(arg_28_0._btnuse, false)
	gohelper.setActive(arg_28_0._btnequip, false)
	gohelper.setActive(arg_28_0._btnunequip, false)
	gohelper.setActive(arg_28_0._btnsearch, false)
	gohelper.setActive(arg_28_0._btnsell, false)
	gohelper.setActive(arg_28_0._btnbuy, false)
	gohelper.setActive(arg_28_0._btnplace, false)
	gohelper.setActive(arg_28_0._btnunplace, false)
	gohelper.setActive(arg_28_0._gonum, false)
	gohelper.setActive(arg_28_0._txtcount, false)
	gohelper.setActive(arg_28_0._goicon1, false)
	gohelper.setActive(arg_28_0._goicon2, false)
	gohelper.setActive(arg_28_0._btnselect, false)

	if arg_28_0._showBtns then
		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Search then
			gohelper.setActive(arg_28_0._btnsearch, true)
			gohelper.setActive(arg_28_0._gonum, arg_28_0.mo.count > 1)

			var_28_0 = arg_28_0.mo.count > 1 and 3 or 2
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Map and not SurvivalMapModel.instance:getSceneMo().panel then
			if arg_28_0.mo.equipCo then
				var_28_0 = 2

				gohelper.setActive(arg_28_0._btngoequip, true)
			elseif arg_28_0.mo.co.type == SurvivalEnum.ItemType.Quick then
				var_28_0 = 2

				gohelper.setActive(arg_28_0._btnuse, true)
			end
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Equip then
			var_28_0 = 2

			gohelper.setActive(arg_28_0._btnunequip, true)
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
			var_28_0 = 2

			gohelper.setActive(arg_28_0._btnequip, true)
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Commit then
			gohelper.setActive(arg_28_0._txtcount, true)
			gohelper.setActive(arg_28_0._goicon1, true)
			gohelper.setActive(arg_28_0._gonum, arg_28_0.mo.count > 1)
			gohelper.setActive(arg_28_0._btnplace, true)

			var_28_0 = arg_28_0.mo.count > 1 and 4 or 5

			arg_28_0._inputnum:SetText("1")
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Commited then
			gohelper.setActive(arg_28_0._txtcount, true)
			gohelper.setActive(arg_28_0._goicon1, true)
			gohelper.setActive(arg_28_0._gonum, arg_28_0.mo.count > 1)
			gohelper.setActive(arg_28_0._btnunplace, true)

			var_28_0 = arg_28_0.mo.count > 1 and 4 or 5
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.Composite then
			var_28_0 = 2

			gohelper.setActive(arg_28_0._btnselect, true)
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.ShopBag and arg_28_0.mo.sellPrice > 0 then
			var_28_0 = 4

			gohelper.setActive(arg_28_0._txtcount, true)
			gohelper.setActive(arg_28_0._goicon2, true)
			gohelper.setActive(arg_28_0._gonum, true)
			gohelper.setActive(arg_28_0._btnsell, true)
		end

		if arg_28_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem and not arg_28_0.param.hideBuy then
			var_28_0 = 4

			gohelper.setActive(arg_28_0._txtcount, true)
			gohelper.setActive(arg_28_0._goicon2, true)
			gohelper.setActive(arg_28_0._gonum, true)
			gohelper.setActive(arg_28_0._btnbuy, true)
			arg_28_0._inputnum:SetText("1")
		end
	end

	recthelper.setHeight(arg_28_0._goscroll.transform, var_0_1[var_28_0])
	arg_28_0:onInputValueChange()
end

function var_0_0.updateCenterShow(arg_29_0)
	if not arg_29_0.mo then
		return
	end

	gohelper.setActive(arg_29_0._goscore, arg_29_0.mo.co.type == SurvivalEnum.ItemType.Equip)

	local var_29_0 = {}

	gohelper.setActive(arg_29_0._goFrequency, false)

	if arg_29_0.mo.equipCo then
		local var_29_1, var_29_2 = arg_29_0.mo:getEquipScoreLevel()

		UISpriteSetMgr.instance:setSurvivalSprite(arg_29_0._imagescore, "survivalequip_scoreicon_" .. var_29_1)

		arg_29_0._txtscore.text = string.format("<color=%s>%s</color>", var_29_2, arg_29_0.mo.equipCo.score + arg_29_0.mo.exScore)

		if arg_29_0.mo.slotMo then
			local var_29_3 = arg_29_0.mo.slotMo.parent.maxTagId
			local var_29_4 = lua_survival_equip_found.configDict[var_29_3]

			if var_29_4 then
				gohelper.setActive(arg_29_0._goFrequency, true)
				UISpriteSetMgr.instance:setSurvivalSprite(arg_29_0._imageFrequency, var_29_4.value)

				arg_29_0._txtFrequency.text = arg_29_0.mo.equipValues and arg_29_0.mo.equipValues[var_29_4.value] or 0

				local var_29_5 = lua_survival_attr.configDict[var_29_4.value]

				arg_29_0._txtFrequencyName.text = var_29_5 and var_29_5.name or ""
			end
		end

		local var_29_6 = arg_29_0.mo:getEquipEffectDesc()

		var_29_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list2 = var_29_6
		}
		var_29_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_29_0.mo.equipCo.desc
			}
		}
	elseif arg_29_0.mo.npcCo then
		local var_29_7, var_29_8 = SurvivalConfig.instance:getNpcConfigTag(arg_29_0.mo.npcCo.id)

		if var_29_8 then
			for iter_29_0, iter_29_1 in ipairs(var_29_8) do
				local var_29_9 = lua_survival_tag.configDict[iter_29_1]

				table.insert(var_29_0, {
					icon = "survival_bag_title0" .. var_29_9.color,
					desc = var_29_9.name,
					list = {
						var_29_9.desc
					}
				})
			end
		end
	else
		var_29_0[1] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_effect"),
			list = {
				arg_29_0.mo.co.desc1
			}
		}
		var_29_0[2] = {
			icon = "survival_bag_title01",
			desc = luaLang("survival_baginfo_info"),
			list = {
				arg_29_0.mo.co.desc2
			}
		}
	end

	gohelper.CreateObjList(arg_29_0, arg_29_0._createDescItems, var_29_0, nil, arg_29_0._goattritem)
end

function var_0_0._createDescItems(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = gohelper.findChildImage(arg_30_1, "#image_title")
	local var_30_1 = gohelper.findChildTextMesh(arg_30_1, "#image_title/#txt_title")
	local var_30_2 = gohelper.findChildButtonWithAudio(arg_30_1, "#image_title/#txt_title/#btn_switch")
	local var_30_3 = gohelper.findChild(arg_30_1, "layout/#go_decitem")
	local var_30_4 = gohelper.findChild(arg_30_1, "layout/#go_decitem2")
	local var_30_5 = gohelper.findChild(arg_30_1, "layout/#go_decitem/#txt_desc")
	local var_30_6 = gohelper.findChild(arg_30_1, "layout/#go_decitem2/#txt_desc")

	UISpriteSetMgr.instance:setSurvivalSprite(var_30_0, arg_30_2.icon)

	var_30_1.text = arg_30_2.desc

	gohelper.setActive(var_30_3, arg_30_2.list)
	gohelper.setActive(var_30_4, arg_30_2.list2)
	gohelper.setActive(var_30_2, arg_30_2.list2)
	arg_30_0:addClickCb(var_30_2, arg_30_0._onClickSwitch, arg_30_0)

	if arg_30_2.list then
		gohelper.CreateObjList(arg_30_0, arg_30_0._createSubDescItems, arg_30_2.list, nil, var_30_5)
	end

	if arg_30_2.list2 then
		gohelper.CreateObjList(arg_30_0, arg_30_0._createSubDescItems2, arg_30_2.list2, nil, var_30_6)
	end
end

function var_0_0._onClickSwitch(arg_31_0)
	SurvivalModel.instance:changeDescSimple()
end

function var_0_0._createSubDescItems(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	gohelper.findChildTextMesh(arg_32_1, "").text = arg_32_2
end

function var_0_0._createSubDescItems2(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = gohelper.getClick(arg_33_1)
	local var_33_1 = gohelper.findChildTextMesh(arg_33_1, "")
	local var_33_2 = gohelper.findChildImage(arg_33_1, "point")

	MonoHelper.addNoUpdateLuaComOnceToGo(var_33_1.gameObject, SurvivalSkillDescComp):updateInfo(var_33_1, arg_33_2[1], 3028)
	arg_33_0:addClickCb(var_33_0, arg_33_0._onClickDesc, arg_33_0)

	local var_33_3 = arg_33_2[2]

	if arg_33_0:getItemSource() == SurvivalEnum.ItemSource.EquipBag then
		var_33_3 = false
	elseif arg_33_0:getItemSource() ~= SurvivalEnum.ItemSource.Equip then
		var_33_3 = true
	end

	ZProj.UGUIHelper.SetColorAlpha(var_33_1, var_33_3 and 1 or 0.5)

	if var_33_3 then
		var_33_2.color = GameUtil.parseColor("#000000")
	else
		var_33_2.color = GameUtil.parseColor("#808080")
	end
end

function var_0_0.setClickDescCallback(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0._clickDescCallback, arg_34_0._clickDescCallobj, arg_34_0._clickDescParam = arg_34_1, arg_34_2, arg_34_3
end

function var_0_0._onClickDesc(arg_35_0)
	if arg_35_0._clickDescCallback then
		arg_35_0._clickDescCallback(arg_35_0._clickDescCallobj, arg_35_0._clickDescParam)
	end
end

function var_0_0._removeItem(arg_36_0)
	local var_36_0 = tonumber(arg_36_0._inputtipnum:GetText()) or 0
	local var_36_1 = Mathf.Clamp(var_36_0, 1, arg_36_0.mo.count)

	if arg_36_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		SurvivalMapModel.instance.isSearchRemove = true

		SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "2#" .. arg_36_0.mo.uid .. "#" .. var_36_1)
	else
		SurvivalWeekRpc.instance:sendSurvivalRemoveBagItem(arg_36_0.mo.source, arg_36_0.mo.uid, var_36_1)
	end

	gohelper.setActive(arg_36_0._goTips, false)
end

function var_0_0._ontipnuminputChange(arg_37_0)
	local var_37_0 = tonumber(arg_37_0._inputtipnum:GetText()) or 0
	local var_37_1 = Mathf.Clamp(var_37_0, 1, arg_37_0.mo.count)

	if tostring(var_37_1) ~= arg_37_0._inputtipnum:GetText() then
		arg_37_0._inputtipnum:SetText(tostring(var_37_1))
		arg_37_0:updateTipCount()
	end
end

function var_0_0._addtipnum(arg_38_0, arg_38_1)
	local var_38_0 = (tonumber(arg_38_0._inputtipnum:GetText()) or 0) + arg_38_1
	local var_38_1 = Mathf.Clamp(var_38_0, 1, arg_38_0.mo.count)

	arg_38_0._inputtipnum:SetText(tostring(var_38_1))
	arg_38_0:updateTipCount()
end

function var_0_0.updateTipCount(arg_39_0)
	if arg_39_0:getItemSource() == SurvivalEnum.ItemSource.Search then
		return
	end

	local var_39_0 = tonumber(arg_39_0._inputtipnum:GetText()) or 0

	arg_39_0._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), arg_39_0.mo.count)
	arg_39_0._txtremain.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_remain"), arg_39_0.mo.count - var_39_0)
end

function var_0_0._onEquipClick(arg_40_0)
	if not arg_40_0.mo.equipCo then
		return
	end

	local var_40_0 = SurvivalShelterModel.instance:getWeekInfo().equipBox

	if arg_40_0.mo.equipCo.equipType == 0 then
		local var_40_1 = var_40_0.slots

		for iter_40_0, iter_40_1 in ipairs(var_40_1) do
			if iter_40_1.unlock and iter_40_1.item:isEmpty() then
				SurvivalWeekRpc.instance:sendSurvivalEquipWear(iter_40_0, arg_40_0.mo.uid)

				return
			end
		end
	else
		local var_40_2 = var_40_0.jewelrySlots

		for iter_40_2, iter_40_3 in ipairs(var_40_2) do
			if iter_40_3.unlock and iter_40_3.item:isEmpty() then
				SurvivalWeekRpc.instance:sendSurvivalJewelryEquipWear(iter_40_2, arg_40_0.mo.uid)

				return
			end
		end
	end

	GameFacade.showToast(ToastEnum.SurvivalCantEquip)
end

function var_0_0._onUnEquipClick(arg_41_0)
	if not arg_41_0.mo.equipCo then
		return
	end

	if arg_41_0.mo.equipCo.equipType == 0 then
		SurvivalWeekRpc.instance:sendSurvivalEquipDemount(arg_41_0.mo.index or 1)
	else
		SurvivalWeekRpc.instance:sendSurvivalJewelryEquipDemount(arg_41_0.mo.index or 1)
	end
end

function var_0_0._onSearchClick(arg_42_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#" .. arg_42_0.mo.uid .. "#" .. arg_42_0._inputnum:GetText())
end

function var_0_0._onSellClick(arg_43_0)
	SurvivalWeekRpc.instance:sendSurvivalShopSellRequest(arg_43_0.mo.uid, arg_43_0.shopType, arg_43_0.shopId, tonumber(arg_43_0._inputnum:GetText()))
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "SellItem", arg_43_0.mo)
end

function var_0_0._onBuyClick(arg_44_0)
	if not arg_44_0._canBuy then
		GameFacade.showToast(ToastEnum.SurvivalNoMoney)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalShopBuyRequest(arg_44_0.mo.uid, tonumber(arg_44_0._inputnum:GetText()), arg_44_0.shopType, arg_44_0.shopId)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "BuyItem", arg_44_0.mo)
end

function var_0_0._onGoEquipClick(arg_45_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function var_0_0._onUseClick(arg_46_0)
	if SurvivalMapHelper.instance:isInFlow() then
		GameFacade.showToast(ToastEnum.SurvivalCantUseItem)

		return
	end

	if SurvivalEnum.CustomUseItemSubType[arg_46_0.mo.co.subType] then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnUseQuickItem, arg_46_0.mo)
		ViewMgr.instance:closeAllPopupViews()
	elseif arg_46_0.mo.co.subType == SurvivalEnum.ItemSubType.Quick_Exit then
		arg_46_0._exitItemMo = arg_46_0.mo

		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalItemAbort, MsgBoxEnum.BoxType.Yes_No, arg_46_0._sendUseItem, nil, nil, arg_46_0, nil, nil)
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_46_0.mo.uid, "")
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Use", arg_46_0.mo)
end

function var_0_0._sendUseItem(arg_47_0)
	SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_47_0._exitItemMo.uid, "")
end

function var_0_0._onPlaceClick(arg_48_0)
	local var_48_0 = tonumber(arg_48_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "Place", arg_48_0.mo, var_48_0)
end

function var_0_0._onUnPlaceClick(arg_49_0)
	local var_49_0 = tonumber(arg_49_0._inputnum:GetText()) or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnClickTipsBtn, "UnPlace", arg_49_0.mo, var_49_0)
end

function var_0_0._ontnuminputChange(arg_50_0)
	local var_50_0 = tonumber(arg_50_0._inputnum:GetText()) or 0
	local var_50_1 = Mathf.Clamp(var_50_0, 1, arg_50_0.mo.count)

	if tostring(var_50_1) ~= arg_50_0._inputnum:GetText() then
		arg_50_0._inputnum:SetText(tostring(var_50_1))
	end

	arg_50_0:onInputValueChange()
end

function var_0_0._onAddNumClick(arg_51_0, arg_51_1)
	local var_51_0 = (tonumber(arg_51_0._inputnum:GetText()) or 0) + arg_51_1
	local var_51_1 = Mathf.Clamp(var_51_0, 1, arg_51_0.mo.count)

	arg_51_0._inputnum:SetText(tostring(var_51_1))
	arg_51_0:onInputValueChange()
end

function var_0_0.onInputValueChange(arg_52_0)
	local var_52_0 = tonumber(arg_52_0._inputnum:GetText()) or 0
	local var_52_1 = arg_52_0:getItemSource()

	if var_52_1 == SurvivalEnum.ItemSource.Commit or var_52_1 == SurvivalEnum.ItemSource.Commited then
		local var_52_2 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.NpcRecruitment, arg_52_0.mo.co.worth)

		arg_52_0._txtcount.text = var_52_0 * var_52_2
	end

	if var_52_1 == SurvivalEnum.ItemSource.ShopBag then
		arg_52_0._txtcount.text = var_52_0 * arg_52_0.mo:getSellPrice(arg_52_0.shopId)
	end

	if var_52_1 == SurvivalEnum.ItemSource.ShopItem then
		local var_52_3 = SurvivalMapHelper.instance:getBagMo():getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local var_52_4 = var_52_0 * arg_52_0.mo:getBuyPrice()

		arg_52_0._canBuy = var_52_4 <= var_52_3

		if var_52_4 <= var_52_3 then
			arg_52_0._txtcount.text = string.format("%d/%d", var_52_3, var_52_4)
		else
			arg_52_0._txtcount.text = string.format("<color=#ec4747>%d</color>/%d", var_52_3, var_52_4)
		end
	end
end

function var_0_0._onMaxNumClick(arg_53_0)
	local var_53_0 = arg_53_0.mo.count

	if arg_53_0:getItemSource() == SurvivalEnum.ItemSource.ShopItem then
		local var_53_1 = SurvivalMapHelper.instance:getBagMo():getCurrencyNum(SurvivalEnum.CurrencyType.Gold)
		local var_53_2 = math.floor(var_53_1 / arg_53_0.mo:getBuyPrice())

		if var_53_2 <= 0 then
			var_53_2 = 1
		end

		var_53_0 = Mathf.Clamp(var_53_0, 1, var_53_2)
	end

	arg_53_0._inputnum:SetText(var_53_0)
	arg_53_0:onInputValueChange()
end

function var_0_0._onMinNumClick(arg_54_0)
	arg_54_0._inputnum:SetText(1)
	arg_54_0:onInputValueChange()
end

function var_0_0.showRewardInheritBtn(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	gohelper.setActive(arg_55_0._go_rewardinherit, true)
	gohelper.setActive(arg_55_0._btn_rewardinherit_select, arg_55_2)
	gohelper.setActive(arg_55_0._btn_rewardinherit_unselect, not arg_55_2)

	arg_55_0._rewardInheritBtnContext = arg_55_1
	arg_55_0._onClickSelectCallBack = arg_55_3
	arg_55_0._onClickUnSelectCallBack = arg_55_4

	recthelper.setHeight(arg_55_0._goscroll.transform, var_0_1[2])
end

function var_0_0.playAnim(arg_56_0, arg_56_1)
	arg_56_0._anim:Play(arg_56_1, 0, 0)
end

function var_0_0.onDestroy(arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._refreshAll, arg_57_0)
end

return var_0_0
