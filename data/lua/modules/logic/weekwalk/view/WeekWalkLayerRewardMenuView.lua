module("modules.logic.weekwalk.view.WeekWalkLayerRewardMenuView", package.seeall)

local var_0_0 = class("WeekWalkLayerRewardMenuView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goTabContent = gohelper.findChild(arg_4_0.viewGO, "top/#scroll_TabList/Viewport/Content")
	arg_4_0._goTabItem = gohelper.findChild(arg_4_0.viewGO, "top/#scroll_TabList/Viewport/Content/#go_tabitem")
	arg_4_0._scrollreward = gohelper.findChildScrollRect(arg_4_0.viewGO, "right/#scroll_reward")

	gohelper.setActive(arg_4_0._goTabItem, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.mapId

	if WeekWalkModel.isShallowMap(var_6_0) then
		return
	end

	arg_6_0:_initPageList()
	arg_6_0:_initTabList()

	arg_6_0._selectedId = var_6_0

	arg_6_0:_updateTabItems()
	arg_6_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, arg_6_0._onWeekwalkTaskUpdate, arg_6_0)
end

function var_0_0._onWeekwalkTaskUpdate(arg_7_0)
	arg_7_0:_updateTabItems()
end

function var_0_0._initPageList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = WeekWalkModel.instance:getInfo()
	local var_8_2 = WeekWalkConfig.instance:getDeepLayer(var_8_1.issueId)
	local var_8_3 = ResSplitConfig.instance:getMaxWeekWalkLayer()

	if var_8_2 then
		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			if not arg_8_0.isVerifing or not (var_8_3 < iter_8_1.layer) then
				table.insert(var_8_0, iter_8_1)
			end
		end
	end

	arg_8_0._pageList = var_8_0
end

function var_0_0._initTabList(arg_9_0)
	arg_9_0._tabItemList = arg_9_0:getUserDataTb_()

	gohelper.CreateObjList(arg_9_0, arg_9_0._onTabItemShow, arg_9_0._pageList, arg_9_0._goTabContent, arg_9_0._goTabItem)
end

function var_0_0._onTabItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.setActive(arg_10_1, true)

	local var_10_0 = gohelper.findChild(arg_10_1, "Select")
	local var_10_1 = gohelper.findChildText(arg_10_1, "Select/#txt_SelectLevel")
	local var_10_2 = gohelper.findChild(arg_10_1, "Select/hasget")
	local var_10_3 = gohelper.findChild(arg_10_1, "Select/canget")
	local var_10_4 = gohelper.findChild(arg_10_1, "UnSelect")
	local var_10_5 = gohelper.findChildText(arg_10_1, "UnSelect/#txt_UnSelectLevel")
	local var_10_6 = gohelper.findChild(arg_10_1, "UnSelect/hasget")
	local var_10_7 = gohelper.findChild(arg_10_1, "UnSelect/canget")
	local var_10_8 = gohelper.findChildButtonWithAudio(arg_10_1, "btn_click")

	var_10_8:AddClickListener(arg_10_0._btnClick, arg_10_0, arg_10_2.id)

	local var_10_9 = GameUtil.getRomanNums(arg_10_3)

	var_10_1.text = var_10_9
	var_10_5.text = var_10_9
	arg_10_0._tabItemList[arg_10_3] = {
		data = arg_10_2,
		select = var_10_0,
		selectHasGet = var_10_2,
		selectCanGet = var_10_3,
		unselect = var_10_4,
		unselectHasGet = var_10_6,
		unselectCanGet = var_10_7,
		btnClick = var_10_8
	}
end

function var_0_0._btnClick(arg_11_0, arg_11_1)
	arg_11_0._selectedId = arg_11_1

	arg_11_0:_updateTabItems()
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeLayerRewardMapId, arg_11_1)

	arg_11_0._scrollreward.verticalNormalizedPosition = 1
end

function var_0_0._updateTabItems(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._tabItemList) do
		local var_12_0 = iter_12_1.data.id
		local var_12_1 = var_12_0 == arg_12_0._selectedId

		gohelper.setActive(iter_12_1.select, var_12_1)
		gohelper.setActive(iter_12_1.unselect, not var_12_1)

		local var_12_2 = WeekWalkRewardView.getTaskType(var_12_0)
		local var_12_3, var_12_4 = WeekWalkTaskListModel.instance:canGetRewardNum(var_12_2, var_12_0)
		local var_12_5 = var_12_3 > 0

		if var_12_1 then
			gohelper.setActive(iter_12_1.selectHasGet, not var_12_5 and var_12_4 <= 0)
			gohelper.setActive(iter_12_1.selectCanGet, var_12_5)
		else
			gohelper.setActive(iter_12_1.unselectHasGet, not var_12_5 and var_12_4 <= 0)
			gohelper.setActive(iter_12_1.unselectCanGet, var_12_5)
		end
	end
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._tabItemList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._tabItemList) do
			iter_13_1.btnClick:RemoveClickListener()
		end
	end
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
