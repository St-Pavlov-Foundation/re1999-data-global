module("modules.logic.survival.view.handbook.SurvivalHandbookAmplifierComp", package.seeall)

local var_0_0 = class("SurvivalHandbookAmplifierComp", SurvivalHandbookViewComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentView = arg_1_1
	arg_1_0.handbookType = SurvivalEnum.HandBookType.Amplifier
	arg_1_0.handBookDatas = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.scroll = gohelper.findChild(arg_2_1, "#scroll")
	arg_2_0.tabContent = gohelper.findChild(arg_2_1, "tabScroll/Viewport/#tabContent")
	arg_2_0._goAmplifierTab = gohelper.findChild(arg_2_1, "tabScroll/Viewport/#go_AmplifierTab")

	gohelper.setActive(arg_2_0._goAmplifierTab, false)

	arg_2_0.tabs = {}

	local var_2_0 = SurvivalEnum.HandBookAmplifierSubTypeUIPos

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = gohelper.clone(arg_2_0._goAmplifierTab, arg_2_0.tabContent)

		gohelper.setActive(var_2_1, true)

		local var_2_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, SurvivalHandbookAmplifierTab)

		var_2_2:setData({
			index = iter_2_0,
			handbookType = arg_2_0.handbookType,
			subType = iter_2_1,
			onClickTabCallBack = arg_2_0.onClickTab,
			onClickTabContext = arg_2_0,
			isLast = iter_2_0 == #var_2_0
		})
		table.insert(arg_2_0.tabs, var_2_2)
	end

	local var_2_3 = arg_2_0._parentView.viewContainer:getSetting().otherRes.survivalmapbagitem

	arg_2_0._item = arg_2_0._parentView:getResInst(var_2_3, arg_2_0.go)

	gohelper.setActive(arg_2_0._item, false)

	arg_2_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.scroll, SurvivalSimpleListPart, {
		minUpdate = 6
	})

	arg_2_0._simpleList:setCellUpdateCallBack(arg_2_0._createItem, arg_2_0, SurvivalBagItem, arg_2_0._item)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:selectTab(1, true)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0:selectTab(nil)
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.onClickTab(arg_8_0, arg_8_1)
	arg_8_0:selectTab(arg_8_1.index)
end

function var_0_0._createItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2:getSurvivalBagItemMo()

	arg_9_1:updateMo(var_9_0, {
		jumpAnimHas = true
	})
	arg_9_1:setShowNum(false)
	arg_9_1:setClickCallback(arg_9_0.onClickItem, arg_9_0)
	arg_9_1:setExtraParam({
		index = arg_9_3,
		survivalHandbookMo = arg_9_2
	})

	local var_9_1 = arg_9_2.isUnlock and var_9_0.co.name
	local var_9_2 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_9_1._textName, "...") + 0.1
	local var_9_3 = GameUtil.getBriefNameByWidth(var_9_1, arg_9_1._textName, var_9_2, "...")
	local var_9_4 = string.format("<color=#422415>%s</color>", var_9_3)

	arg_9_1:setTextName(arg_9_2.isUnlock, var_9_4)
end

function var_0_0.onClickItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.extraParam.survivalHandbookMo

	if var_10_0.isUnlock then
		local var_10_1 = arg_10_0:getIndex(var_10_0)

		ViewMgr.instance:openView(ViewName.SurvivalHandbookInfoView, {
			handBookType = arg_10_0.handbookType,
			handBookDatas = arg_10_0.handBookDatas,
			select = var_10_1
		})
	end
end

function var_0_0.refreshList(arg_11_0, arg_11_1)
	if arg_11_0.curSelect == nil then
		arg_11_0._simpleList:setList({})

		return
	end

	tabletool.clear(arg_11_0.handBookDatas)

	local var_11_0 = SurvivalHandbookModel.instance:getHandBookDatas(arg_11_0.handbookType, arg_11_0.tabs[arg_11_0.curSelect].subType)

	table.sort(var_11_0, SurvivalHandbookModel.instance.handBookSortFunc)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.isUnlock then
			table.insert(arg_11_0.handBookDatas, iter_11_1)
		end
	end

	if arg_11_1 then
		arg_11_0._simpleList:setOpenAnimation(0.03, 6)
	end

	arg_11_0._simpleList:setList(var_11_0)
end

function var_0_0.getIndex(arg_12_0, arg_12_1)
	return tabletool.indexOf(arg_12_0.handBookDatas, arg_12_1)
end

function var_0_0.selectTab(arg_13_0, arg_13_1, arg_13_2)
	if (not arg_13_1 or not arg_13_0.curSelect or arg_13_0.curSelect ~= arg_13_1) and (not not arg_13_1 or not not arg_13_0.curSelect) then
		if arg_13_0.curSelect then
			arg_13_0.tabs[arg_13_0.curSelect]:setSelect(false)
		end

		arg_13_0.curSelect = arg_13_1

		if arg_13_0.curSelect then
			SurvivalHandbookController.instance:markNewHandbook(arg_13_0.handbookType, arg_13_0.tabs[arg_13_0.curSelect].subType)
			arg_13_0.tabs[arg_13_0.curSelect]:setSelect(true)
		end

		arg_13_0:refreshList(arg_13_2)
	end
end

return var_0_0
