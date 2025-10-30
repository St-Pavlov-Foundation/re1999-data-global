module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusView", BaseView)

function var_0_0._setActive_text(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._textGo, arg_1_1)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simageFullBG = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_FullBG")
	arg_2_0._gobonus = gohelper.findChild(arg_2_0.viewGO, "#go_bonus")
	arg_2_0._goTab1 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab1")
	arg_2_0._goTab2 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab2")
	arg_2_0._goTab3 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab3")
	arg_2_0._goBlock = gohelper.findChild(arg_2_0.viewGO, "#go_Block")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_4_0._refreshRedDot, arg_4_0)
end

function var_0_0._btnOnClick(arg_5_0, arg_5_1)
	arg_5_0:cutTab(arg_5_1)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._textGo = gohelper.findChild(arg_6_0.viewGO, "text")
	arg_6_0._tabs = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_0:getUserDataTb_()
		local var_6_1 = arg_6_0["_goTab" .. iter_6_0]
		local var_6_2 = gohelper.findChild(var_6_1, "#go_UnSelect")
		local var_6_3 = gohelper.findChild(var_6_1, "#go_Selected")
		local var_6_4 = gohelper.findChild(var_6_1, "#go_RedDot")

		var_6_0.go = var_6_1
		var_6_0.goUnSelected = var_6_2
		var_6_0.txtUnSelected = gohelper.findChildText(var_6_2, "txt_Tab")
		var_6_0.goSelected = var_6_3
		var_6_0.txtSelected = gohelper.findChildText(var_6_3, "txt_Tab")
		var_6_0.goRedDot = var_6_4
		var_6_0.btn = gohelper.findChildButtonWithAudio(var_6_1, "#btn")

		var_6_0.btn:AddClickListener(arg_6_0._btnOnClick, arg_6_0, iter_6_0)

		arg_6_0._tabs[iter_6_0] = var_6_0
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._stage = arg_8_0.viewParam.stage
	arg_8_0._selectTab = arg_8_0.viewParam.defaultTab or V1a6_BossRush_BonusModel.instance:getTab()

	arg_8_0:_refreshRedDot()
	arg_8_0:activeTab()
	arg_8_0:_refreshTab()
	arg_8_0:_addRedDot()

	if arg_8_0._selectTab == BossRushEnum.BonusViewTab.AchievementTab then
		V1a6_BossRush_BonusModel.instance:selecAchievementTab(arg_8_0._stage)
	end
end

function var_0_0.onClose(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._tabs) do
		iter_9_1.btn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.openDefaultTab(arg_11_0)
	arg_11_0:selectTab(arg_11_0._selectTab)
	arg_11_0:_refreshRedDot()
end

function var_0_0.cutTab(arg_12_0, arg_12_1)
	if arg_12_0._selectTab and arg_12_0._selectTab == arg_12_1 then
		return
	end

	arg_12_0._selectTab = arg_12_1

	arg_12_0:activeTab()
	arg_12_0:selectTab(arg_12_0._selectTab)
end

function var_0_0.selectTab(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_setActive_text(arg_13_1 == BossRushEnum.BonusViewTab.AchievementTab)
	arg_13_0.viewContainer:selectTabView(arg_13_1, arg_13_2)
end

function var_0_0.activeTab(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._tabs) do
		gohelper.setActive(iter_14_1.goUnSelected, iter_14_0 ~= arg_14_0._selectTab)
		gohelper.setActive(iter_14_1.goSelected, iter_14_0 == arg_14_0._selectTab)
	end
end

function var_0_0._addRedDot(arg_15_0)
	local var_15_0 = BossRushModel.instance:getActivityBonus()

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = iter_15_1.Reddot
			local var_15_2 = arg_15_0._tabs[iter_15_0].goRedDot

			if var_15_1 and var_15_2 then
				local var_15_3 = BossRushRedModel.instance:getUId(var_15_1, arg_15_0._stage)

				RedDotController.instance:addRedDot(var_15_2, var_15_1, var_15_3)
			end
		end
	end
end

function var_0_0._refreshRedDot(arg_16_0)
	local var_16_0 = BossRushModel.instance:getActivityBonus()

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_1 = arg_16_0._tabs[iter_16_0].goRedDot

			if var_16_1 and iter_16_1.ListModel and iter_16_1.ListModel.instance.isReddot then
				local var_16_2 = iter_16_1.ListModel.instance:isReddot(arg_16_0._stage, iter_16_0)

				gohelper.setActive(var_16_1, var_16_2)
			end
		end
	end
end

function var_0_0._refreshTab(arg_17_0)
	local var_17_0 = BossRushModel.instance:getActivityBonus()
	local var_17_1 = #var_17_0 > 2 and 326 or 489

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._tabs) do
		recthelper.setWidth(iter_17_1.go.transform, var_17_1)
		gohelper.setActive(iter_17_1.go, iter_17_0 <= #var_17_0)

		local var_17_2 = var_17_0[iter_17_0] and var_17_0[iter_17_0].TabTitle

		if not string.nilorempty(var_17_2) then
			iter_17_1.txtUnSelected.text = luaLang(var_17_2)
			iter_17_1.txtSelected.text = luaLang(var_17_2)
		end
	end
end

return var_0_0
