module("modules.logic.survival.view.handbook.SurvivalHandbookView", package.seeall)

local var_0_0 = class("SurvivalHandbookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.eventComp = gohelper.findChild(arg_1_0.viewGO, "right/#eventComp")
	arg_1_0.amplifierComp = gohelper.findChild(arg_1_0.viewGO, "right/#amplifierComp")
	arg_1_0.npcComp = gohelper.findChild(arg_1_0.viewGO, "right/#npcComp")
	arg_1_0.resultComp = gohelper.findChild(arg_1_0.viewGO, "right/#resultComp")
	arg_1_0.eventTab = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/container/#eventTab")
	arg_1_0.amplifierTab = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/container/#amplifierTab")
	arg_1_0.npcTab = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/container/#npcTab")
	arg_1_0.resultTab = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/container/#resultTab")
	arg_1_0.tabs = {}

	local var_1_0 = {
		arg_1_0.eventTab,
		arg_1_0.amplifierTab,
		arg_1_0.npcTab,
		arg_1_0.resultTab
	}
	local var_1_1 = SurvivalEnum.HandBookType
	local var_1_2 = {
		var_1_1.Event,
		var_1_1.Amplifier,
		var_1_1.Npc,
		var_1_1.Result
	}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_3 = MonoHelper.addNoUpdateLuaComOnceToGo(iter_1_1, SurvivalHandbookViewTab)

		var_1_3:setData({
			index = iter_1_0,
			type = var_1_2[iter_1_0],
			onClickTabCallBack = arg_1_0.onClickTab,
			onClickTabContext = arg_1_0
		})
		table.insert(arg_1_0.tabs, var_1_3)
	end

	arg_1_0.survivalHandbookEventComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.eventComp, SurvivalHandbookEventComp, arg_1_0)
	arg_1_0.survivalHandbookAmplifierComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.amplifierComp, SurvivalHandbookAmplifierComp, arg_1_0)
	arg_1_0.survivalHandbookNpcComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.npcComp, SurvivalHandbookNpcComp, arg_1_0)
	arg_1_0.survivalHandbookResultComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.resultComp, SurvivalHandbookResultComp, arg_1_0)
	arg_1_0.fragment = {
		arg_1_0.survivalHandbookEventComp,
		arg_1_0.survivalHandbookAmplifierComp,
		arg_1_0.survivalHandbookNpcComp,
		arg_1_0.survivalHandbookResultComp
	}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.fragment) do
		gohelper.setActive(iter_1_3.go, true)

		iter_1_3.canvasGroup.alpha = 0
		iter_1_3.canvasGroup.blocksRaycasts = false
	end

	arg_1_0.curSelect = nil
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:selectTab(1)
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onClickTab(arg_6_0, arg_6_1)
	arg_6_0:selectTab(arg_6_1.index)
end

function var_0_0.selectTab(arg_7_0, arg_7_1)
	if (not arg_7_1 or not arg_7_0.curSelect or arg_7_0.curSelect ~= arg_7_1) and (not not arg_7_1 or not not arg_7_0.curSelect) then
		if arg_7_0.curSelect then
			arg_7_0.tabs[arg_7_0.curSelect]:setSelect(false)
			arg_7_0.fragment[arg_7_0.curSelect]:onClose()

			local var_7_0 = arg_7_0.fragment[arg_7_0.curSelect].canvasGroup

			var_7_0.alpha = 0
			var_7_0.blocksRaycasts = false
		end

		arg_7_0.curSelect = arg_7_1

		if arg_7_0.curSelect then
			arg_7_0.tabs[arg_7_0.curSelect]:setSelect(true)

			local var_7_1 = arg_7_0.fragment[arg_7_0.curSelect].canvasGroup

			var_7_1.alpha = 1
			var_7_1.blocksRaycasts = true

			arg_7_0.fragment[arg_7_0.curSelect]:onOpen()
		end
	end
end

return var_0_0
