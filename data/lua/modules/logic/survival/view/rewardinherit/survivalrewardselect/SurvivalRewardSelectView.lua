module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectView", package.seeall)

local var_0_0 = class("SurvivalRewardSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_closeInfo")
	arg_1_0._btnabandon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/btn/#btn_abandon")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/btn/#btn_confirm")
	arg_1_0._gogrey = gohelper.findChild(arg_1_0.viewGO, "root/Left/btn/#btn_confirm/#go_grey")
	arg_1_0._txtcurrent = gohelper.findChildText(arg_1_0.viewGO, "root/Left/score/#txt_current")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "root/Left/score/#txt_total")
	arg_1_0._scrollList = gohelper.findChild(arg_1_0.viewGO, "root/Left/#scroll_List")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "root/Left/#go_empty")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_empty")
	arg_1_0._gotab1 = gohelper.findChild(arg_1_0.viewGO, "root/Right/top/#go_tab1")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/Right/top/#go_tab1/#go_select")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "root/Right/top/#go_tab1/#go_num")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "root/Right/top/#go_tab1/#go_num/#txt_num")
	arg_1_0._btntab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Right/top/#go_tab1/#btn_tab")
	arg_1_0._gotab2 = gohelper.findChild(arg_1_0.viewGO, "root/Right/top/#go_tab2")
	arg_1_0._tabContent = gohelper.findChild(arg_1_0.viewGO, "root/Right/tabScroll/Viewport/#tabContent")
	arg_1_0._goSurvivalRewardInheritTab = gohelper.findChild(arg_1_0.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab/#go_Selected")
	arg_1_0._scroll_amplifier = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_amplifier")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_amplifier/Viewport/Content/#go_collectionitem")
	arg_1_0._scroll_npc = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_npc")
	arg_1_0._gonpcitem = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_npc/Viewport/Content/#go_npcitem")
	arg_1_0._btnquick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Right/#btn_quick")
	arg_1_0.go_infoview = gohelper.findChild(arg_1_0.viewGO, "root/#go_infoview")
	arg_1_0._goSelectGrey = gohelper.findChild(arg_1_0.viewGO, "root/Right/#btn_quick/#go_grey")

	gohelper.setActive(arg_1_0._goSurvivalRewardInheritTab, false)

	arg_1_0.handbookTabs = {}
	arg_1_0.tabs = {}

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.survivalmapbagitem

	arg_1_0._itemAmplifier = arg_1_0:getResInst(var_1_0, arg_1_0.viewGO)

	local var_1_1 = arg_1_0.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem

	arg_1_0._itemNpc = arg_1_0:getResInst(var_1_1, arg_1_0.viewGO)

	gohelper.setActive(arg_1_0._itemAmplifier, false)
	gohelper.setActive(arg_1_0._itemNpc, false)

	arg_1_0._selectSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._scrollList, SurvivalSimpleListPart)

	arg_1_0._selectSimpleList:setCellUpdateCallBack(arg_1_0._createItemSelect, arg_1_0, SurvivalBagItem, arg_1_0._itemAmplifier)

	arg_1_0._amplifierSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._scroll_amplifier, SurvivalSimpleListPart)

	arg_1_0._amplifierSimpleList:setCellUpdateCallBack(arg_1_0._createItemAmplifier, arg_1_0, SurvivalBagItem, arg_1_0._itemAmplifier)

	arg_1_0._npcSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._scroll_npc, SurvivalSimpleListPart)

	arg_1_0._npcSimpleList:setCellUpdateCallBack(arg_1_0._createItemNpc, arg_1_0, SurvivalRewardInheritNpcItem, arg_1_0._itemNpc)

	arg_1_0.selectMo = SurvivalRewardInheritModel.instance.selectMo

	local var_1_2 = arg_1_0.viewContainer._viewSetting.otherRes.infoView
	local var_1_3 = arg_1_0:getResInst(var_1_2, arg_1_0.go_infoview)

	arg_1_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_3, SurvivalShowBagInfoPart)

	arg_1_0._infoPanel:updateMo(nil)
	arg_1_0._infoPanel:setCloseShow(true, arg_1_0.onCloseInfo, arg_1_0)

	arg_1_0.handbookTypes = {
		SurvivalEnum.HandBookType.Amplifier,
		SurvivalEnum.HandBookType.Npc
	}

	local var_1_4 = SurvivalEnum.HandBookNpcSubType

	arg_1_0.npcSubType = {
		var_1_4.Foundation,
		var_1_4.Laplace,
		var_1_4.Zeno,
		var_1_4.People
	}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnabandon, arg_2_0.onClickBtnAbandon, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnconfirm, arg_2_0.onClickBtnConfirm, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnquick, arg_2_0.onClickBtnquick, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.selectMo:Record()
	arg_3_0:refreshScore()
	arg_3_0:refreshSelectList()
	arg_3_0:refreshHandbookTab()

	arg_3_0.mode = 1

	gohelper.setActive(arg_3_0._goSelectGrey, arg_3_0.mode == 1)
end

function var_0_0.refreshScore(arg_4_0)
	arg_4_0.curExtendScore = SurvivalRewardInheritModel.instance:getCurExtendScore()
	arg_4_0._txtcurrent.text = arg_4_0.curExtendScore
	arg_4_0.extendScore = SurvivalRewardInheritModel.instance:getExtendScore()
	arg_4_0._txttotal.text = arg_4_0.extendScore
end

function var_0_0.onClose(arg_5_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRewardInheritRefresh)
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

function var_0_0.onClickModalMask(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClickBtnAbandon(arg_8_0)
	arg_8_0.selectMo:Revert()
	arg_8_0:closeThis()
end

function var_0_0.onClickBtnConfirm(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onClickBtnquick(arg_10_0)
	arg_10_0.mode = -arg_10_0.mode

	gohelper.setActive(arg_10_0._goSelectGrey, arg_10_0.mode == 1)
end

function var_0_0.refreshHandbookTab(arg_11_0)
	for iter_11_0 = 1, 2 do
		local var_11_0 = arg_11_0["_gotab" .. iter_11_0]

		arg_11_0.handbookTabs[iter_11_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_0, SurvivalRewardSelectTab)

		arg_11_0.handbookTabs[iter_11_0]:setData({
			index = iter_11_0,
			handbookType = arg_11_0.handbookTypes[iter_11_0],
			onClickTabCallBack = arg_11_0.onClickHandbookTabCallBack,
			onClickTabContext = arg_11_0
		})
	end

	arg_11_0.curSelectHandbookTab = nil

	if arg_11_0.curSelectHandbookTab == nil then
		arg_11_0:selectHandbookTab(1, nil)
	end
end

function var_0_0.onClickHandbookTabCallBack(arg_12_0, arg_12_1)
	arg_12_0:selectHandbookTab(arg_12_1.index)
end

function var_0_0.selectHandbookTab(arg_13_0, arg_13_1, arg_13_2)
	if (not arg_13_1 or not arg_13_0.curSelectHandbookTab or arg_13_0.curSelectHandbookTab ~= arg_13_1) and (not not arg_13_1 or not not arg_13_0.curSelectHandbookTab) then
		if arg_13_1 then
			local var_13_0 = arg_13_0.handbookTypes[arg_13_1]
			local var_13_1, var_13_2 = arg_13_0:haveHandbookData(var_13_0)

			if arg_13_2 == nil then
				arg_13_2 = var_13_2
			end
		end

		if arg_13_0.curSelectHandbookTab then
			arg_13_0.handbookTabs[arg_13_0.curSelectHandbookTab]:setSelect(false)
		end

		arg_13_0.curSelectHandbookTab = arg_13_1

		if arg_13_0.curSelectHandbookTab then
			arg_13_0.handbookTabs[arg_13_0.curSelectHandbookTab]:setSelect(true)
		end

		arg_13_0.handbookType = arg_13_0:getCurHandbookType()

		arg_13_0:refreshTab(arg_13_2)
	end
end

function var_0_0.getCurHandbookType(arg_14_0)
	if arg_14_0.curSelectHandbookTab == 1 then
		return SurvivalEnum.HandBookType.Amplifier
	elseif arg_14_0.curSelectHandbookTab == 2 then
		return SurvivalEnum.HandBookType.Npc
	end
end

function var_0_0.haveHandbookData(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getSubTypes(arg_15_1)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if arg_15_0:haveHandbookSubTypeData(arg_15_1, iter_15_1) then
			return true, iter_15_0
		end
	end
end

function var_0_0.haveHandbookSubTypeData(arg_16_0, arg_16_1, arg_16_2)
	if #SurvivalRewardInheritModel.instance:getInheritHandBookDatas(arg_16_1, arg_16_2) > 0 then
		return true
	end
end

function var_0_0.getSubTypes(arg_17_0, arg_17_1)
	if arg_17_1 == SurvivalEnum.HandBookType.Amplifier then
		return SurvivalEnum.HandBookAmplifierSubTypeUIPos
	elseif arg_17_1 == SurvivalEnum.HandBookType.Npc then
		return arg_17_0.npcSubType
	end
end

function var_0_0.refreshTab(arg_18_0, arg_18_1)
	local var_18_0 = #arg_18_0.tabs
	local var_18_1 = arg_18_0:getSubTypes(arg_18_0.handbookType)
	local var_18_2 = #var_18_1

	for iter_18_0 = 1, var_18_2 do
		local var_18_3 = var_18_1[iter_18_0]

		if var_18_0 < iter_18_0 then
			local var_18_4 = gohelper.clone(arg_18_0._goSurvivalRewardInheritTab, arg_18_0._tabContent)

			gohelper.setActive(var_18_4, true)

			arg_18_0.tabs[iter_18_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_4, SurvivalRewardInheritTab)
		end

		gohelper.setActive(arg_18_0.tabs[iter_18_0].go, true)

		local var_18_5 = #SurvivalRewardInheritModel.instance:getInheritHandBookDatas(arg_18_0.handbookType, var_18_3) == 0

		arg_18_0.tabs[iter_18_0]:setData({
			handbookType = arg_18_0.handbookType,
			subType = var_18_3,
			index = iter_18_0,
			onClickTabCallBack = arg_18_0.onClickTabCallBack,
			onClickTabContext = arg_18_0,
			isLast = iter_18_0 == var_18_2,
			isTransflective = var_18_5
		})
	end

	for iter_18_1 = var_18_2 + 1, var_18_0 do
		gohelper.setActive(arg_18_0.tabs[iter_18_1].go, false)
		arg_18_0.tabs[iter_18_1]:setData(nil)
	end

	arg_18_0:selectTab(nil)
	arg_18_0:selectTab(arg_18_1)
end

function var_0_0.onClickTabCallBack(arg_19_0, arg_19_1)
	arg_19_0:selectTab(arg_19_1.index, true)
end

function var_0_0.selectTab(arg_20_0, arg_20_1, arg_20_2)
	if (not arg_20_1 or not arg_20_0.curSelect or arg_20_0.curSelect ~= arg_20_1) and (not not arg_20_1 or not not arg_20_0.curSelect) then
		if arg_20_1 and arg_20_2 and not arg_20_0:haveHandbookSubTypeData(arg_20_0.handbookType, arg_20_0.tabs[arg_20_1].subType) then
			GameFacade.showToastString(luaLang("SurvivalRewardSelectView_2"))

			return
		end

		if arg_20_0.curSelect then
			arg_20_0.tabs[arg_20_0.curSelect]:setSelect(false)
		end

		arg_20_0.curSelect = arg_20_1

		if arg_20_0.curSelect then
			arg_20_0.tabs[arg_20_0.curSelect]:setSelect(true)
		end

		arg_20_0:refreshList()
	end
end

function var_0_0.refreshSelectAmount(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.handbookTabs) do
		iter_21_1:refreshAmount()
	end

	for iter_21_2, iter_21_3 in ipairs(arg_21_0.tabs) do
		iter_21_3:refreshAmount()
	end
end

function var_0_0.refreshSelectList(arg_22_0)
	local var_22_0 = SurvivalRewardInheritModel.instance:getSelectMo()

	arg_22_0._selectSimpleList:setList(var_22_0)
	gohelper.setActive(arg_22_0._goleftempty, #var_22_0 == 0)
end

function var_0_0._createItemSelect(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_2:getSurvivalBagItemMo()

	arg_23_1:updateMo(var_23_0)
	arg_23_1:setClickCallback(arg_23_0.onClickItemSelect, arg_23_0)
	arg_23_1:setExtraParam({
		index = arg_23_3,
		survivalHandbookMo = arg_23_2
	})
	arg_23_1:setTextName(false)
	arg_23_1:setShowNum(false)
	arg_23_1:showInheritScore()
end

function var_0_0.onClickItemSelect(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.extraParam.survivalHandbookMo

	if arg_24_0.mode == 1 then
		arg_24_0:showInfo(var_24_0)
		arg_24_0:refreshList()
	elseif arg_24_0.mode == -1 then
		arg_24_0.selectMo:removeByValue(arg_24_0:getInheritId(var_24_0))
		arg_24_0:refreshSelect()
	end
end

function var_0_0.refreshList(arg_25_0)
	if arg_25_0.curSelect == nil then
		gohelper.setActive(arg_25_0._scroll_amplifier, false)
		gohelper.setActive(arg_25_0._scroll_npc, false)

		return
	end

	local var_25_0 = SurvivalRewardInheritModel.instance:getInheritHandBookDatas(arg_25_0.handbookType, arg_25_0.tabs[arg_25_0.curSelect].subType)

	table.sort(var_25_0, SurvivalHandbookModel.instance.handBookSortFunc)

	arg_25_0.data = var_25_0

	gohelper.setActive(arg_25_0.go_empty, #var_25_0 == 0)

	if arg_25_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		gohelper.setActive(arg_25_0._scroll_amplifier, true)
		gohelper.setActive(arg_25_0._scroll_npc, false)
		arg_25_0._amplifierSimpleList:setList(var_25_0)
	elseif arg_25_0.handbookType == SurvivalEnum.HandBookType.Npc then
		gohelper.setActive(arg_25_0._scroll_amplifier, false)
		gohelper.setActive(arg_25_0._scroll_npc, true)

		local var_25_1 = {}
		local var_25_2 = {}
		local var_25_3 = 4

		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			local var_25_4 = arg_25_0.selectMo:isSelect(arg_25_0:getInheritId(iter_25_1))
			local var_25_5 = {
				isSelect = var_25_4,
				survivalHandbookMo = iter_25_1
			}

			table.insert(var_25_2, var_25_5)

			if iter_25_0 % var_25_3 == 0 or iter_25_0 == #var_25_0 then
				local var_25_6 = iter_25_0 ~= #var_25_0
				local var_25_7 = {
					lineYOffset = -20,
					isShowCost = true,
					viewContainer = arg_25_0.viewContainer,
					listData = tabletool.copy(var_25_2),
					isShowLine = var_25_6
				}

				table.insert(var_25_1, var_25_7)
				tabletool.clear(var_25_2)
			end
		end

		arg_25_0._npcSimpleList:setList(var_25_1)
	end

	gohelper.setActive(arg_25_0._gorightempty, #var_25_0 == 0)
end

function var_0_0._createItemAmplifier(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_2:getSurvivalBagItemMo()

	arg_26_1:updateMo(var_26_0)
	arg_26_1:setClickCallback(arg_26_0.onClickItemAmplifier, arg_26_0)
	arg_26_1:setExtraParam({
		index = arg_26_3,
		survivalHandbookMo = arg_26_2
	})
	arg_26_1:setTextName(false)
	arg_26_1:setShowNum(false)
	arg_26_1:setIsSelect(arg_26_0.selectHandbookMo and arg_26_0:getInheritId(arg_26_0.selectHandbookMo) == arg_26_0:getInheritId(arg_26_2))

	local var_26_1 = arg_26_0.selectMo:isSelect(arg_26_0:getInheritId(arg_26_2))
	local var_26_2 = ""

	arg_26_1:showRewardInherit(var_26_2, var_26_1)
	arg_26_1:showInheritScore()
end

function var_0_0.onClickItemAmplifier(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.extraParam.survivalHandbookMo

	if not var_27_0.isUnlock then
		return
	end

	if arg_27_0.mode == 1 then
		arg_27_0:showInfo(var_27_0)
		arg_27_0:refreshList()
	elseif arg_27_0.mode == -1 then
		local var_27_1 = arg_27_0:getInheritId(var_27_0)

		if arg_27_0.selectMo:isSelect(var_27_1) then
			arg_27_0.selectMo:removeByValue(var_27_1)
		else
			local var_27_2 = var_27_0:getSurvivalBagItemMo():getExtendCost()

			if arg_27_0.curExtendScore + var_27_2 > arg_27_0.extendScore then
				GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

				return
			end

			arg_27_0.selectMo:addToEmptyPos(var_27_1)
		end

		arg_27_0:refreshSelect()
	end
end

function var_0_0._createItemNpc(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_1:updateMo(arg_28_2, arg_28_0.selectHandbookMo, arg_28_0.onClickItemNpc, arg_28_0)
end

function var_0_0.onClickItemNpc(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.mo

	if not var_29_0.isUnlock then
		return
	end

	if arg_29_0.mode == 1 then
		arg_29_0:showInfo(var_29_0)
		arg_29_0:refreshList()
	elseif arg_29_0.mode == -1 then
		local var_29_1 = arg_29_0:getInheritId(var_29_0)

		if arg_29_0.selectMo:isSelect(var_29_1) then
			arg_29_0.selectMo:removeByValue(var_29_1)
		else
			local var_29_2 = var_29_0:getSurvivalBagItemMo():getExtendCost()

			if arg_29_0.curExtendScore + var_29_2 > arg_29_0.extendScore then
				GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

				return
			end

			arg_29_0.selectMo:addToEmptyPos(var_29_1)
		end

		arg_29_0:refreshSelect()
	end
end

function var_0_0.showInfo(arg_30_0, arg_30_1)
	arg_30_0.selectHandbookMo = arg_30_1

	arg_30_0._infoPanel:updateMo(arg_30_1:getSurvivalBagItemMo())

	arg_30_0.selectSurvivalHandbookMo = arg_30_1

	local var_30_0 = arg_30_0.selectMo:isSelect(arg_30_0:getInheritId(arg_30_1))

	arg_30_0._infoPanel:showRewardInheritBtn(arg_30_0, not var_30_0, arg_30_0.onClickSelectCallBack, arg_30_0.onClickUnSelectCallBack)
end

function var_0_0.onCloseInfo(arg_31_0)
	arg_31_0.selectHandbookMo = nil

	arg_31_0:refreshList()
end

function var_0_0.onClickSelectCallBack(arg_32_0)
	local var_32_0 = arg_32_0:getInheritId(arg_32_0.selectSurvivalHandbookMo)
	local var_32_1 = arg_32_0.selectSurvivalHandbookMo:getSurvivalBagItemMo():getExtendCost()

	if arg_32_0.curExtendScore + var_32_1 > arg_32_0.extendScore then
		GameFacade.showToastString(luaLang("SurvivalRewardSelectView_1"))

		return
	end

	arg_32_0.selectMo:addToEmptyPos(var_32_0)
	arg_32_0._infoPanel:updateMo(nil)

	arg_32_0.selectHandbookMo = nil

	arg_32_0:refreshSelect()
end

function var_0_0.onClickUnSelectCallBack(arg_33_0)
	arg_33_0.selectMo:removeByValue(arg_33_0:getInheritId(arg_33_0.selectSurvivalHandbookMo))
	arg_33_0._infoPanel:updateMo(nil)

	arg_33_0.selectHandbookMo = nil

	arg_33_0:refreshSelect()
	arg_33_0:refreshList()
end

function var_0_0.refreshSelect(arg_34_0)
	arg_34_0:refreshScore()
	arg_34_0:refreshSelectAmount()
	arg_34_0:refreshList()
	arg_34_0:refreshSelectList()
end

function var_0_0.getInheritId(arg_35_0, arg_35_1)
	return SurvivalRewardInheritModel.instance:getInheritId(arg_35_1)
end

return var_0_0
