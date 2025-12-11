module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritView", package.seeall)

local var_0_0 = class("SurvivalRewardInheritView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSurvivalRewardInheritTab = gohelper.findChild(arg_1_0.viewGO, "root/Right/tabScroll/Viewport/#tabContent/#go_SurvivalRewardInheritTab")
	arg_1_0._tabContent = gohelper.findChild(arg_1_0.viewGO, "root/Right/tabScroll/Viewport/#tabContent")
	arg_1_0._scroll_amplifier = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_amplifier")
	arg_1_0._scroll_npc = gohelper.findChild(arg_1_0.viewGO, "root/Right/#scroll_npc")
	arg_1_0._go_infoview = gohelper.findChild(arg_1_0.viewGO, "root/Left/#go_infoview")
	arg_1_0._go_collection_select = gohelper.findChild(arg_1_0.viewGO, "root/Left/#go_collection_select")
	arg_1_0._go_collection_txt_tips = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/#go_collection_select/txt_tips")
	arg_1_0._collection_go_empty = gohelper.findChild(arg_1_0._go_collection_select, "collection/#go_empty")
	arg_1_0._collection_go_has = gohelper.findChild(arg_1_0._go_collection_select, "collection/#go_has")
	arg_1_0._btn_remove = gohelper.findChildButtonWithAudio(arg_1_0._go_collection_select, "collection/#go_has/#btn_remove")
	arg_1_0._go_put = gohelper.findChild(arg_1_0._go_collection_select, "collection/#go_has/#go_put")
	arg_1_0._go_item_container = gohelper.findChild(arg_1_0._go_collection_select, "collection/#go_has/#go_item_container")
	arg_1_0._go_txt_name = gohelper.findChildTextMesh(arg_1_0._go_collection_select, "collection/#go_has/#txt_name")
	arg_1_0._go_npc_select = gohelper.findChild(arg_1_0.viewGO, "root/Left/#go_npc_select")
	arg_1_0._go_npc_txt_tips = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/Left/#go_npc_select/layout/#txt_tips")
	arg_1_0.btn_abandon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/btn/#btn_abandon")
	arg_1_0.btn_confirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/btn/#btn_confirm")
	arg_1_0.btn_closeInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_closeInfo")
	arg_1_0.go_empty = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_empty")
	arg_1_0.survivalRewardInheritNpcSelectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._go_npc_select, SurvivalRewardInheritNpcSelectComp, {
		parentView = arg_1_0,
		refreshFunc = arg_1_0.refresh
	})

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.survivalmapbagitem
	local var_1_1 = arg_1_0:getResInst(var_1_0, arg_1_0._go_item_container)

	arg_1_0.selectAmplifierItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, SurvivalBagItem)
	arg_1_0._itemAmplifier = arg_1_0:getResInst(var_1_0, arg_1_0.viewGO)

	local var_1_2 = 1.05

	transformhelper.setLocalScale(arg_1_0._itemAmplifier.transform, var_1_2, var_1_2, 1)

	local var_1_3 = arg_1_0.viewContainer:getSetting().otherRes.survivalrewardinheritnpcitem

	arg_1_0._itemNpc = arg_1_0:getResInst(var_1_3, arg_1_0.viewGO)

	gohelper.setActive(arg_1_0._itemAmplifier, false)
	gohelper.setActive(arg_1_0._itemNpc, false)

	arg_1_0._amplifierSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._scroll_amplifier, SurvivalSimpleListPart)

	arg_1_0._amplifierSimpleList:setCellUpdateCallBack(arg_1_0._createItemAmplifier, arg_1_0, SurvivalBagItem, arg_1_0._itemAmplifier)

	arg_1_0._npcSimpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._scroll_npc, SurvivalSimpleListPart)

	arg_1_0._npcSimpleList:setCellUpdateCallBack(arg_1_0._createItemNpc, arg_1_0, SurvivalRewardInheritNpcItem, arg_1_0._itemNpc)

	local var_1_4 = arg_1_0.viewContainer:getSetting().otherRes.infoView
	local var_1_5 = arg_1_0:getResInst(var_1_4, arg_1_0._go_infoview)

	arg_1_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_5, SurvivalBagInfoPart)

	arg_1_0._infoPanel:updateMo(nil)
	gohelper.setActive(arg_1_0._goSurvivalRewardInheritTab, false)

	arg_1_0.tabs = {}
	arg_1_0.selectSurvivalHandbookMo = nil
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn_abandon, arg_2_0.onClickBtn_abandon, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn_confirm, arg_2_0.onClickBtn_confirm, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btn_remove, arg_2_0.onClickBtn_remove, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btn_closeInfo, arg_2_0.onClickBtnCloseInfo, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0.handbookType = arg_3_0.viewParam.handbookType
	arg_3_0.closeCallBack = arg_3_0.viewParam.closeCallBack
	arg_3_0.closeCallBackContext = arg_3_0.viewParam.closeCallBackContext

	if arg_3_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		gohelper.setActive(arg_3_0._scroll_amplifier, true)
		gohelper.setActive(arg_3_0._scroll_npc, false)

		arg_3_0.survivalRewardInheritSelectMo = SurvivalRewardInheritModel.instance.amplifierSelectMo

		gohelper.setActive(arg_3_0._go_collection_select, true)
		gohelper.setActive(arg_3_0._go_npc_select, false)

		arg_3_0._go_collection_txt_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalRewardInheritView_1"), {
			arg_3_0.survivalRewardInheritSelectMo.maxAmount
		})
	elseif arg_3_0.handbookType == SurvivalEnum.HandBookType.Npc then
		gohelper.setActive(arg_3_0._scroll_amplifier, false)
		gohelper.setActive(arg_3_0._scroll_npc, true)

		arg_3_0.survivalRewardInheritSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo

		gohelper.setActive(arg_3_0._go_collection_select, false)
		gohelper.setActive(arg_3_0._go_npc_select, true)

		arg_3_0._go_npc_txt_tips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalRewardInheritView_2"), {
			arg_3_0.survivalRewardInheritSelectMo.maxAmount
		})
	end

	arg_3_0.oriSelectIdDic = arg_3_0.survivalRewardInheritSelectMo:copySelectIdDic()
	arg_3_0.readyPos = 1

	arg_3_0:refreshTab()
	arg_3_0:selectTab(1)
	arg_3_0:refreshInheritSelect(true)
end

function var_0_0.onClose(arg_4_0)
	if arg_4_0.closeCallBack then
		arg_4_0.closeCallBack(arg_4_0.closeCallBackContext)
	end
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onClickBtn_abandon(arg_6_0)
	arg_6_0.survivalRewardInheritSelectMo:replaceSelectIdDic(arg_6_0.oriSelectIdDic)
	arg_6_0:closeThis()
end

function var_0_0.onClickBtn_confirm(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClickBtn_remove(arg_8_0)
	arg_8_0.survivalRewardInheritSelectMo:removeOneByPos(1)
	arg_8_0:refresh()
end

function var_0_0.onClickBtnCloseInfo(arg_9_0)
	if arg_9_0._infoPanel then
		arg_9_0._infoPanel:updateMo(nil)
	end
end

function var_0_0.refreshTab(arg_10_0)
	local var_10_0 = #arg_10_0.tabs
	local var_10_1

	if arg_10_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		var_10_1 = SurvivalEnum.HandBookAmplifierSubTypeUIPos
	elseif arg_10_0.handbookType == SurvivalEnum.HandBookType.Npc then
		local var_10_2 = SurvivalEnum.HandBookNpcSubType

		var_10_1 = {
			var_10_2.Foundation,
			var_10_2.Laplace,
			var_10_2.Zeno,
			var_10_2.People
		}
	end

	local var_10_3 = #var_10_1

	for iter_10_0 = 1, var_10_3 do
		local var_10_4 = var_10_1[iter_10_0]

		if var_10_0 < iter_10_0 then
			local var_10_5 = gohelper.clone(arg_10_0._goSurvivalRewardInheritTab, arg_10_0._tabContent)

			arg_10_0.tabs[iter_10_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_5, SurvivalRewardInheritTab)
		end

		gohelper.setActive(arg_10_0.tabs[iter_10_0].go, true)
		arg_10_0.tabs[iter_10_0]:setData({
			handbookType = arg_10_0.handbookType,
			subType = var_10_4,
			index = iter_10_0,
			survivalRewardInheritSelectMo = arg_10_0.survivalRewardInheritSelectMo,
			onClickTabCallBack = arg_10_0.onClickTabCallBack,
			onClickTabContext = arg_10_0,
			isLast = iter_10_0 == var_10_3
		})
	end

	for iter_10_1 = var_10_3 + 1, var_10_0 do
		gohelper.setActive(arg_10_0.tabs[iter_10_1].go, false)
		arg_10_0.tabs[iter_10_1]:setData(nil)
	end
end

function var_0_0.onClickTabCallBack(arg_11_0, arg_11_1)
	arg_11_0:selectTab(arg_11_1.index)
end

function var_0_0.selectTab(arg_12_0, arg_12_1)
	if (not arg_12_1 or not arg_12_0.curSelect or arg_12_0.curSelect ~= arg_12_1) and (not not arg_12_1 or not not arg_12_0.curSelect) then
		if arg_12_0.curSelect then
			arg_12_0.tabs[arg_12_0.curSelect]:setSelect(false)
		end

		arg_12_0.curSelect = arg_12_1

		if arg_12_0.curSelect then
			arg_12_0.tabs[arg_12_0.curSelect]:setSelect(true)
		end

		arg_12_0:refreshList()
	end
end

function var_0_0._createItemAmplifier(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_2:getSurvivalBagItemMo()

	arg_13_1:updateMo(var_13_0)
	arg_13_1:setClickCallback(arg_13_0.onClickItemAmplifier, arg_13_0)
	arg_13_1:setExtraParam({
		index = arg_13_3,
		survivalHandbookMo = arg_13_2
	})
	arg_13_1:setTextName(false)
	arg_13_1:setIsSelect(arg_13_0.selectHandbookMo and arg_13_0.selectHandbookMo.id == arg_13_2.id)

	local var_13_1 = arg_13_0.survivalRewardInheritSelectMo:isSelect(arg_13_2.id)
	local var_13_2 = var_13_0.co.name
	local var_13_3 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_13_1._textName, "...") + 0.1
	local var_13_4 = GameUtil.getBriefNameByWidth(var_13_2, arg_13_1._textName, var_13_3, "...")

	arg_13_1:showRewardInherit(var_13_4, var_13_1)
end

function var_0_0.onClickItemAmplifier(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.extraParam.survivalHandbookMo

	arg_14_0.selectHandbookMo = var_14_0

	arg_14_0._infoPanel:updateMo(var_14_0:getSurvivalBagItemMo())

	arg_14_0.selectSurvivalHandbookMo = var_14_0

	local var_14_1 = arg_14_0.survivalRewardInheritSelectMo:isSelect(var_14_0.id)

	arg_14_0._infoPanel:showRewardInheritBtn(arg_14_0, not var_14_1, arg_14_0.onClickSelectCallBack, arg_14_0.onClickUnSelectCallBack)
	arg_14_0:refreshList()
end

function var_0_0.refresh(arg_15_0)
	arg_15_0:refreshInheritSelect()
	arg_15_0:refreshList()
	arg_15_0:refreshTab()
end

function var_0_0._createItemNpc(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:updateMo(arg_16_2, arg_16_0.selectHandbookMo, arg_16_0.onClickItemNpc, arg_16_0)
end

function var_0_0.onClickItemNpc(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.mo

	arg_17_0.selectHandbookMo = var_17_0

	arg_17_0._infoPanel:updateMo(var_17_0:getSurvivalBagItemMo())

	arg_17_0.selectSurvivalHandbookMo = var_17_0

	local var_17_1 = arg_17_0.survivalRewardInheritSelectMo:isSelect(var_17_0.id)

	arg_17_0._infoPanel:showRewardInheritBtn(arg_17_0, not var_17_1, arg_17_0.onClickSelectCallBack, arg_17_0.onClickUnSelectCallBack)
	arg_17_0:refreshList()
end

function var_0_0.refreshList(arg_18_0)
	local var_18_0 = SurvivalHandbookModel.instance:getHandBookUnlockDatas(arg_18_0.handbookType, arg_18_0.tabs[arg_18_0.curSelect].subType)

	gohelper.setActive(arg_18_0.go_empty, #var_18_0 == 0)

	if arg_18_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		arg_18_0._amplifierSimpleList:setList(var_18_0)
	elseif arg_18_0.handbookType == SurvivalEnum.HandBookType.Npc then
		local var_18_1 = {}
		local var_18_2 = {}
		local var_18_3 = 4

		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			local var_18_4 = arg_18_0.survivalRewardInheritSelectMo:isSelect(iter_18_1.id)
			local var_18_5 = {
				isSelect = var_18_4,
				survivalHandbookMo = iter_18_1
			}

			table.insert(var_18_2, var_18_5)

			if iter_18_0 % var_18_3 == 0 or iter_18_0 == #var_18_0 then
				local var_18_6 = iter_18_0 ~= #var_18_0
				local var_18_7 = {
					viewContainer = arg_18_0.viewContainer,
					listData = tabletool.copy(var_18_2),
					isShowLine = var_18_6
				}

				table.insert(var_18_1, var_18_7)
				tabletool.clear(var_18_2)
			end
		end

		arg_18_0._npcSimpleList:setList(var_18_1)
	end
end

function var_0_0.onClickSelectCallBack(arg_19_0)
	if arg_19_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		arg_19_0.survivalRewardInheritSelectMo:replaceOne(1, arg_19_0.selectSurvivalHandbookMo.id)
	elseif arg_19_0.handbookType == SurvivalEnum.HandBookType.Npc then
		arg_19_0.survivalRewardInheritSelectMo:replaceOne(arg_19_0.readyPos, arg_19_0.selectSurvivalHandbookMo.id)
	end

	arg_19_0._infoPanel:updateMo(nil)

	arg_19_0.selectHandbookMo = nil

	arg_19_0:refresh()
end

function var_0_0.onClickUnSelectCallBack(arg_20_0)
	arg_20_0.survivalRewardInheritSelectMo:removeOne(arg_20_0.selectSurvivalHandbookMo.id)

	arg_20_0.selectHandbookMo = nil

	arg_20_0._infoPanel:updateMo(nil)
	arg_20_0:refresh()
end

function var_0_0.refreshInheritSelect(arg_21_0, arg_21_1)
	local var_21_0, var_21_1 = arg_21_0.survivalRewardInheritSelectMo:haveEmpty()

	if arg_21_0.survivalRewardInheritSelectMo:getSelect(arg_21_0.readyPos) ~= nil and var_21_0 then
		arg_21_0.readyPos = var_21_1
	end

	arg_21_0.readyPos = arg_21_0.readyPos or arg_21_0.survivalRewardInheritSelectMo.maxAmount

	if arg_21_0.handbookType == SurvivalEnum.HandBookType.Amplifier then
		if arg_21_0.survivalRewardInheritSelectMo:haveSelect() then
			gohelper.setActive(arg_21_0._collection_go_has, true)
			gohelper.setActive(arg_21_0._collection_go_empty, false)

			local var_21_2 = arg_21_0.survivalRewardInheritSelectMo:getSelect(1)
			local var_21_3 = SurvivalHandbookModel.instance:getMoById(var_21_2):getSurvivalBagItemMo()

			arg_21_0.selectAmplifierItem:updateMo(var_21_3)

			local var_21_4 = var_21_3.co.name

			arg_21_0._go_txt_name.text = var_21_4

			if not arg_21_1 then
				gohelper.setActive(arg_21_0._go_put, false)
				gohelper.setActive(arg_21_0._go_put, true)
			end
		else
			gohelper.setActive(arg_21_0._collection_go_has, false)
			gohelper.setActive(arg_21_0._collection_go_empty, true)
		end
	elseif arg_21_0.handbookType == SurvivalEnum.HandBookType.Npc then
		arg_21_0.survivalRewardInheritNpcSelectComp:refreshInheritSelect(arg_21_1, arg_21_0.readyPos)
	end
end

return var_0_0
