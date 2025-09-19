module("modules.logic.survival.view.map.SurvivalMapBagView", package.seeall)

local var_0_0 = class("SurvivalMapBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "root/Right/scroll_collection")
	arg_1_0._toggleBagBg = gohelper.findChild(arg_1_0.viewGO, "root/toggleGroup/toggleBag/Background")
	arg_1_0._toggleBagLabel = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/toggleGroup/toggleBag/Label")
	arg_1_0._toggleNpcBg = gohelper.findChild(arg_1_0.viewGO, "root/toggleGroup/toggleNPC/Background")
	arg_1_0._toggleNpcLabel = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/toggleGroup/toggleNPC/Label")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "root/#go_infoview")
	arg_1_0._goheavy = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_heavy")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_sort")

	for iter_1_0 = 1, 3 do
		arg_1_0["_txtcurrency" .. iter_1_0] = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_tag/tag" .. iter_1_0 .. "/#txt_tag" .. iter_1_0)
		arg_1_0["_btnCurrency" .. iter_1_0] = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_tag/tag" .. iter_1_0)
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0.viewContainer:registerCallback(ViewEvent.ToSwitchTab, arg_2_0.onTabChange, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBag, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, arg_2_0._refreshBag, arg_2_0)

	for iter_2_0 = 1, 3 do
		arg_2_0["_btnCurrency" .. iter_2_0]:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
			id = iter_2_0,
			btn = arg_2_0["_btnCurrency" .. iter_2_0]
		})
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0.onTabChange, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBag, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, arg_3_0._refreshBag, arg_3_0)

	for iter_3_0 = 1, 3 do
		arg_3_0["_btnCurrency" .. iter_3_0]:RemoveClickListener()
	end
end

function var_0_0.onTabChange(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._curShowBag then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open_1)
	end

	arg_4_2 = arg_4_2 - 1

	if arg_4_0._curShowBag == arg_4_2 then
		return
	end

	arg_4_0._curShowBag = arg_4_2

	local var_4_0 = arg_4_0._curShowBag == 1

	gohelper.setActive(arg_4_0._toggleBagBg, var_4_0)
	gohelper.setActive(arg_4_0._toggleNpcBg, not var_4_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._toggleBagLabel, var_4_0 and "#F5F1EB" or "#AEAEAE")
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._toggleNpcLabel, var_4_0 and "#AEAEAE" or "#F5F1EB")
	gohelper.setActive(arg_4_0._gosort, arg_4_0._curShowBag == 1)
	arg_4_0:_refreshBag()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_bag_open)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goheavy, SurvivalWeightPart, arg_5_0:getBag())

	local var_5_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._gosort, SurvivalSortAndFilterPart)
	local var_5_1 = {
		{
			desc = luaLang("survival_sort_time"),
			type = SurvivalEnum.ItemSortType.Time
		},
		{
			desc = luaLang("survival_sort_mass"),
			type = SurvivalEnum.ItemSortType.Mass
		},
		{
			desc = luaLang("survival_sort_worth"),
			type = SurvivalEnum.ItemSortType.Worth
		},
		{
			desc = luaLang("survival_sort_type"),
			type = SurvivalEnum.ItemSortType.Type
		}
	}
	local var_5_2 = {
		{
			desc = luaLang("survival_filter_material"),
			type = SurvivalEnum.ItemFilterType.Material
		},
		{
			desc = luaLang("survival_filter_equip"),
			type = SurvivalEnum.ItemFilterType.Equip
		},
		{
			desc = luaLang("survival_filter_consume"),
			type = SurvivalEnum.ItemFilterType.Consume
		}
	}

	arg_5_0._curSort = var_5_1[1]
	arg_5_0._isDec = true
	arg_5_0._filterList = {}

	var_5_0:setOptions(var_5_1, var_5_2, arg_5_0._curSort, arg_5_0._isDec)
	var_5_0:setOptionChangeCallback(arg_5_0._onSortChange, arg_5_0)

	local var_5_3 = arg_5_0.viewContainer._viewSetting.otherRes.infoView
	local var_5_4 = arg_5_0:getResInst(var_5_3, arg_5_0._goinfoview)

	arg_5_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_4, SurvivalBagInfoPart)

	arg_5_0._infoPanel:setIsShowEmpty(true)

	local var_5_5 = arg_5_0.viewContainer._viewSetting.otherRes.itemRes

	arg_5_0._item = arg_5_0:getResInst(var_5_5, arg_5_0.viewGO)

	gohelper.setActive(arg_5_0._item, false)

	arg_5_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goscroll, SurvivalSimpleListPart)

	arg_5_0._simpleList:setCellUpdateCallBack(arg_5_0._createItem, arg_5_0, SurvivalBagItem, arg_5_0._item)
end

function var_0_0._onSortChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._curSort = arg_6_1
	arg_6_0._isDec = arg_6_2
	arg_6_0._filterList = arg_6_3

	arg_6_0:_refreshBag()
end

function var_0_0._refreshBag(arg_7_0)
	local var_7_0 = {}
	local var_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0:getBag().items) do
		if arg_7_0._curShowBag == 1 then
			if not iter_7_1:isNPC() and SurvivalBagSortHelper.filterItemMo(arg_7_0._filterList, iter_7_1) then
				table.insert(var_7_0, iter_7_1)

				if arg_7_0._preSelectUid == iter_7_1.uid then
					var_7_1 = iter_7_1.uid
				end
			end
		elseif iter_7_1:isNPC() then
			table.insert(var_7_0, iter_7_1)

			if arg_7_0._preSelectUid == iter_7_1.uid then
				var_7_1 = iter_7_1.uid
			end
		end
	end

	if arg_7_0._curShowBag == 1 then
		SurvivalBagSortHelper.sortItems(var_7_0, arg_7_0._curSort.type, arg_7_0._isDec)
	else
		SurvivalBagSortHelper.sortItems(var_7_0, SurvivalEnum.ItemSortType.NPC, true)
	end

	if not var_7_1 and var_7_0[1] then
		var_7_1 = var_7_0[1].uid
	end

	SurvivalHelper.instance:makeArrFull(var_7_0, SurvivalBagItemMo.Empty, 4, 5)

	arg_7_0._preSelectUid = var_7_1

	arg_7_0._simpleList:setList(var_7_0)
	arg_7_0:_refreshInfo()

	for iter_7_2 = 1, 3 do
		arg_7_0["_txtcurrency" .. iter_7_2].text = arg_7_0:getBag():getCurrencyNum(iter_7_2)
	end
end

function var_0_0._createItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1:updateMo(arg_8_2)
	arg_8_1:setClickCallback(arg_8_0._onItemClick, arg_8_0)

	if arg_8_2.uid == arg_8_0._preSelectUid and arg_8_0._preSelectUid then
		arg_8_1:setIsSelect(true)
	end
end

function var_0_0._onItemClick(arg_9_0, arg_9_1)
	if arg_9_1._mo:isEmpty() then
		return
	end

	arg_9_0._preSelectUid = arg_9_1._mo.uid

	for iter_9_0 in pairs(arg_9_0._simpleList:getAllComps()) do
		iter_9_0:setIsSelect(arg_9_0._preSelectUid and iter_9_0._mo.uid == arg_9_0._preSelectUid)
	end

	arg_9_0._anim.enabled = true

	arg_9_0._anim:Play("switch", 0, 0)
	arg_9_0:_refreshInfo()
end

function var_0_0._refreshInfo(arg_10_0)
	local var_10_0 = arg_10_0._preSelectUid and arg_10_0:getBag().itemsByUid[arg_10_0._preSelectUid]

	arg_10_0._infoPanel:updateMo(var_10_0)

	if var_10_0 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_details)
	end
end

function var_0_0.getBag(arg_11_0)
	return SurvivalMapModel.instance:getSceneMo().bag
end

function var_0_0.onClickModalMask(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0._openCurrencyTips(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.btn.transform
	local var_13_1 = var_13_0.lossyScale
	local var_13_2 = var_13_0.position
	local var_13_3 = recthelper.getWidth(var_13_0)
	local var_13_4 = recthelper.getHeight(var_13_0)

	var_13_2.x = var_13_2.x + var_13_3 / 2 * var_13_1.x
	var_13_2.y = var_13_2.y - var_13_4 / 2 * var_13_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		id = arg_13_1.id,
		pos = var_13_2
	})
end

function var_0_0.onClose(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_close)
	TaskDispatcher.cancelTask(arg_14_0._refreshInfo, arg_14_0)
end

return var_0_0
