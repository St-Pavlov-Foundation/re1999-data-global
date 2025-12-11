module("modules.logic.survival.view.map.SurvivalMapResultView", package.seeall)

local var_0_0 = class("SurvivalMapResultView", BaseView)
local var_0_1 = {
	SurvivalEnum.CurrencyType.Gold,
	SurvivalEnum.CurrencyType.Decoding
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "Left/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "Left/#go_fail")
	arg_1_0._gonpcitem = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_npcitem")
	arg_1_0._gonpcline1 = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_npc/#go_line1")
	arg_1_0._gonpcline2 = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_npc/#go_line2")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_heroitem")
	arg_1_0._goheroline1 = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_hero/#go_line1")
	arg_1_0._goheroline2 = gohelper.findChild(arg_1_0.viewGO, "Left/team/#go_hero/#go_line2")
	arg_1_0._gofail2 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_fail")
	arg_1_0._txtTageLoss = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_fail/#txt_benifit")
	arg_1_0._gorightitem = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._gorightnpcitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_npc/scroll_npc/Viewport/Content/go_npcitem")
	arg_1_0._currencyroot = gohelper.findChild(arg_1_0.viewGO, "Right/topright")
	arg_1_0._gonpcpart = gohelper.findChild(arg_1_0.viewGO, "Right/#go_npc")
	arg_1_0._goitemscroll = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection")
	arg_1_0._txttag1 = gohelper.findChildTextMesh(arg_1_0._currencyroot, "tag1/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildTextMesh(arg_1_0._currencyroot, "tag2/#txt_tag2")
	arg_1_0._btntag1 = gohelper.findChildButtonWithAudio(arg_1_0._currencyroot, "tag1")
	arg_1_0._btntag2 = gohelper.findChildButtonWithAudio(arg_1_0._currencyroot, "tag2")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
	arg_2_0._btntag1:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
		id = var_0_1[1],
		btn = arg_2_0._btntag1
	})
	arg_2_0._btntag2:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
		id = var_0_1[2],
		btn = arg_2_0._btntag2
	})
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btntag1:RemoveClickListener()
	arg_3_0._btntag2:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = gohelper.create2d(arg_4_0.viewGO, "#go_info")
	local var_4_2 = arg_4_0:getResInst(var_4_0, var_4_1)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setCloseShow(true)
	arg_4_0._infoPanel:updateMo()

	arg_4_0._resultMo = SurvivalMapModel.instance.resultData

	local var_4_3 = arg_4_0.viewParam.isWin

	gohelper.setActive(arg_4_0._gosuccess, var_4_3)
	gohelper.setActive(arg_4_0._gofail, not var_4_3)
	gohelper.setActive(arg_4_0._gofail2, not var_4_3)
	arg_4_0:refreshPlaceAndTime(var_4_3 and arg_4_0._gosuccess or arg_4_0._gofail)
	arg_4_0:refreshHeroAndNpc()
	arg_4_0:refreshLoss()
	arg_4_0:refreshItemsAndNpcs()

	if var_4_3 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_2)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_fail_2)
	end
end

function var_0_0.refreshPlaceAndTime(arg_5_0, arg_5_1)
	local var_5_0 = gohelper.findChildTextMesh(arg_5_1, "place/#txt_place")
	local var_5_1 = gohelper.findChildTextMesh(arg_5_1, "time/#txt_time")

	var_5_0.text = lua_survival_map_group.configDict[arg_5_0._resultMo.copyId].name

	local var_5_2 = arg_5_0._resultMo.totalGameTime
	local var_5_3 = math.floor(var_5_2 / 60)
	local var_5_4 = math.fmod(var_5_2, 60)

	var_5_1.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_resultview_time"), var_5_3, var_5_4)
end

function var_0_0.refreshHeroAndNpc(arg_6_0)
	local var_6_0 = arg_6_0._resultMo.teamInfo
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}

	for iter_6_0 = 1, 10 do
		local var_6_4 = var_6_0:getHeroMo(var_6_0.heros[iter_6_0]) or true

		table.insert(iter_6_0 <= 5 and var_6_1 or var_6_2, var_6_4)
	end

	for iter_6_1 = 1, 4 do
		local var_6_5 = var_6_0.npcId[iter_6_1] or 0

		table.insert(var_6_3, var_6_5)
	end

	gohelper.CreateObjList(arg_6_0, arg_6_0._createHeroItem, var_6_1, arg_6_0._goheroline1, arg_6_0._goheroitem)
	gohelper.CreateObjList(arg_6_0, arg_6_0._createHeroItem, var_6_2, arg_6_0._goheroline2, arg_6_0._goheroitem)
	gohelper.CreateObjList(arg_6_0, arg_6_0._createNpcItem, var_6_3, arg_6_0._gonpcline1, arg_6_0._gonpcitem)
end

function var_0_0._createHeroItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = gohelper.findChildSingleImage(arg_7_1, "#image_rolehead")
	local var_7_1 = gohelper.findChild(arg_7_1, "empty")

	gohelper.setActive(var_7_0, arg_7_2 ~= true)
	gohelper.setActive(var_7_1, arg_7_2 == true)

	if arg_7_2 ~= true then
		local var_7_2 = FightConfig.instance:getSkinCO(arg_7_2.skin)

		var_7_0:LoadImage(ResUrl.getHeadIconSmall(var_7_2.headIcon))
	end
end

function var_0_0._createNpcItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildSingleImage(arg_8_1, "#image_rolehead")
	local var_8_1 = gohelper.findChild(arg_8_1, "empty")

	gohelper.setActive(var_8_0, arg_8_2 ~= 0)
	gohelper.setActive(var_8_1, arg_8_2 == 0)

	if arg_8_2 ~= 0 then
		local var_8_2 = SurvivalConfig.instance.npcIdToItemCo[arg_8_2]

		if var_8_2 then
			var_8_0:LoadImage(ResUrl.getSurvivalNpcIcon(var_8_2.icon))
		end
	end
end

function var_0_0.refreshLoss(arg_9_0)
	arg_9_0._txtTageLoss.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_resultview_loss"), arg_9_0._resultMo.percentageLoss)
end

function var_0_0.refreshItemsAndNpcs(arg_10_0)
	local var_10_0 = #arg_10_0._resultMo.firstNpcs > 0

	gohelper.setActive(arg_10_0._gonpcpart, var_10_0)
	recthelper.setHeight(arg_10_0._goitemscroll.transform, var_10_0 and 513.14 or 800)

	arg_10_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._goitemscroll, SurvivalSimpleListPart)

	arg_10_0._simpleList:setCellUpdateCallBack(arg_10_0._createItem, arg_10_0, nil, arg_10_0._gorightitem)
	arg_10_0._simpleList:setRecycleCallBack(arg_10_0._recycleItem, arg_10_0)

	arg_10_0._allItemComps = {}

	arg_10_0:refreshCurrency(false)
	arg_10_0._simpleList:setList(arg_10_0._resultMo.firstItems)
	gohelper.CreateObjList(arg_10_0, arg_10_0._createRightNpcItem, arg_10_0._resultMo.firstNpcs, nil, arg_10_0._gorightnpcitem)
	TaskDispatcher.runDelay(arg_10_0._delayCheckChange, arg_10_0, 1)
end

function var_0_0._delayCheckChange(arg_11_0)
	if arg_11_0._resultMo.haveChange1 then
		UIBlockHelper.instance:startBlock("SurvivalMapResultView_ItemEffect", 1)
		TaskDispatcher.runDelay(arg_11_0._delayShowChangeItem, arg_11_0, 1)

		for iter_11_0, iter_11_1 in pairs(arg_11_0._allItemComps) do
			local var_11_0 = iter_11_1._mo

			if not var_11_0:isEmpty() then
				local var_11_1 = arg_11_0._resultMo.beforeChanges[var_11_0.uid]

				if var_11_1 and var_11_1:isEmpty() then
					iter_11_1:playComposeAnim()
				end
			end
		end
	else
		arg_11_0:showAfterItems()
	end
end

function var_0_0._delayShowChangeItem(arg_12_0)
	tabletool.clear(arg_12_0._allItemComps)
	arg_12_0._simpleList:setList(arg_12_0._resultMo.beforeItems)
	gohelper.CreateObjList(arg_12_0, arg_12_0._createRightNpcItem, arg_12_0._resultMo.beforeNpcs, nil, arg_12_0._gorightnpcitem)
	arg_12_0:showAfterItems()
end

function var_0_0.showAfterItems(arg_13_0)
	if arg_13_0._resultMo.haveChange2 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_3)
		UIBlockHelper.instance:startBlock("SurvivalMapResultView_ItemEffect", 1)
		TaskDispatcher.runDelay(arg_13_0._delayShowAfterItem, arg_13_0, 1)
		arg_13_0._anim:Play("searching", 0, 0)

		for iter_13_0, iter_13_1 in pairs(arg_13_0._allItemComps) do
			local var_13_0 = iter_13_1._mo

			if not var_13_0:isEmpty() then
				local var_13_1 = arg_13_0._resultMo.afterChanges[var_13_0.uid]

				if var_13_1 then
					if var_13_1:isEmpty() then
						iter_13_1:playSearch()
						iter_13_1:playCompose()
					else
						iter_13_1:playSearch()
					end
				end
			end
		end
	else
		arg_13_0:_onFinishShow()
	end
end

function var_0_0._delayShowAfterItem(arg_14_0)
	arg_14_0:refreshCurrency(true)
	tabletool.clear(arg_14_0._allItemComps)
	arg_14_0._simpleList:setList(arg_14_0._resultMo.afterItems)
	gohelper.CreateObjList(arg_14_0, arg_14_0._createRightNpcItem, arg_14_0._resultMo.afterNpcs, nil, arg_14_0._gorightnpcitem)
	arg_14_0:_onFinishShow()
end

function var_0_0._onFinishShow(arg_15_0)
	return
end

function var_0_0._createItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0.viewContainer._abLoader then
		return
	end

	local var_16_0 = arg_16_0.viewContainer._viewSetting.otherRes.itemRes
	local var_16_1 = gohelper.findChild(arg_16_1, "inst") or arg_16_0:getResInst(var_16_0, arg_16_1, "inst")
	local var_16_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, SurvivalBagItem)

	var_16_2:updateMo(arg_16_2)
	var_16_2:setClickCallback(arg_16_0._onClickItem, arg_16_0)

	arg_16_0._allItemComps[arg_16_3] = var_16_2
end

function var_0_0._recycleItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._allItemComps[arg_17_2] = nil
end

function var_0_0._onClickItem(arg_18_0, arg_18_1)
	arg_18_0._infoPanel:updateMo(arg_18_1._mo)
end

function var_0_0._createRightNpcItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = gohelper.findChildSingleImage(arg_19_1, "#simage_chess")
	local var_19_1 = gohelper.findChildButtonWithAudio(arg_19_1, "")

	SurvivalUnitIconHelper.instance:setNpcIcon(var_19_0, arg_19_2.npcCo.headIcon)
	arg_19_0:removeClickCb(var_19_1)
	arg_19_0:addClickCb(var_19_1, arg_19_0._onClickNpc, arg_19_0, arg_19_2)
end

function var_0_0._onClickNpc(arg_20_0, arg_20_1)
	arg_20_0._infoPanel:updateMo(arg_20_1)
end

function var_0_0.refreshCurrency(arg_21_0, arg_21_1)
	if arg_21_1 then
		arg_21_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_21_0.setCurrItem, nil, arg_21_0)
	else
		arg_21_0:setCurrItem(0)
	end
end

function var_0_0.setCurrItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._resultMo.beforeCurrencyItems
	local var_22_1 = arg_22_0._resultMo.afterCurrencyItems

	for iter_22_0 = 1, #var_0_1 do
		local var_22_2 = var_22_0[var_0_1[iter_22_0]] or 0
		local var_22_3 = var_22_1[var_0_1[iter_22_0]] or 0
		local var_22_4 = math.floor(var_22_2 + (var_22_3 - var_22_2) * arg_22_1)

		arg_22_0["_txttag" .. iter_22_0].text = var_22_4
	end
end

function var_0_0.onClickModalMask(arg_23_0)
	arg_23_0:closeThis()
end

function var_0_0.onClose(arg_24_0)
	if arg_24_0._tweenId then
		ZProj.TweenHelper.KillById(arg_24_0._tweenId)
	end

	TaskDispatcher.cancelTask(arg_24_0._delayShowChangeItem, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._delayShowAfterItem, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._delayCheckChange, arg_24_0)
end

function var_0_0._openCurrencyTips(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.btn.transform
	local var_25_1 = var_25_0.lossyScale
	local var_25_2 = var_25_0.position
	local var_25_3 = recthelper.getWidth(var_25_0)
	local var_25_4 = recthelper.getHeight(var_25_0)

	var_25_2.x = var_25_2.x + var_25_3 / 2 * var_25_1.x
	var_25_2.y = var_25_2.y - var_25_4 / 2 * var_25_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		id = arg_25_1.id,
		pos = var_25_2
	})
end

return var_0_0
