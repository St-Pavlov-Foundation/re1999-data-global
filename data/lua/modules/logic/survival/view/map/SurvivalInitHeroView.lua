module("modules.logic.survival.view.map.SurvivalInitHeroView", package.seeall)

local var_0_0 = class("SurvivalInitHeroView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._txtnum = gohelper.findChildTextMesh(arg_1_0._root, "Title/txt_Member/#txt_MemberNum")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0._root, "Scroll View/Viewport/#go_content")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0._root, "#btn_Assist")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State1")
	arg_1_0._goselected = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State3")
	arg_1_0._gofull = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnhelp:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0._btnhelpOnClick(arg_4_0)
	if arg_4_0._helpState == SurvivalEnum.HelpState.Full then
		GameFacade.showToast(ToastEnum.SurvivalInitHeroLimit)

		return
	end

	if arg_4_0._helpState == SurvivalEnum.HelpState.Selected then
		arg_4_0._initGroupMo:removeAssistMo()
		arg_4_0:_modifyHeroGroup()

		return
	end

	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Survival, 1, nil, arg_4_0._onPickHandler, arg_4_0, true)
end

function var_0_0._onPickHandler(arg_5_0, arg_5_1)
	if not arg_5_1 then
		arg_5_0._initGroupMo.assistHeroMo = nil

		return
	end

	arg_5_0._initGroupMo:addAssistHeroMo(arg_5_1)
	arg_5_0:_modifyHeroGroup()
end

function var_0_0._checkHelpState(arg_6_0)
	if arg_6_0._initGroupMo.assistHeroMo then
		arg_6_0:_updateHelpState(SurvivalEnum.HelpState.Selected)

		return
	end

	if arg_6_0._initGroupMo:isHeroFull() then
		arg_6_0:_updateHelpState(SurvivalEnum.HelpState.Full)

		return
	end

	arg_6_0:_updateHelpState(SurvivalEnum.HelpState.UnSelected)
end

function var_0_0._updateHelpState(arg_7_0, arg_7_1)
	arg_7_0._helpState = arg_7_1

	gohelper.setActive(arg_7_0._gounselect, arg_7_1 == SurvivalEnum.HelpState.UnSelected)
	gohelper.setActive(arg_7_0._goselected, arg_7_1 == SurvivalEnum.HelpState.Selected)
	gohelper.setActive(arg_7_0._gofull, arg_7_1 == SurvivalEnum.HelpState.Full)
end

function var_0_0._btnreturnOnClick(arg_8_0)
	arg_8_0.viewContainer:playAnim("go_map")
	arg_8_0.viewContainer:preStep()
end

function var_0_0._btnstartOnClick(arg_9_0)
	if not next(arg_9_0._initGroupMo.allSelectHeroMos) then
		GameFacade.showToast(ToastEnum.SurvivalNoHero)

		return
	end

	var_0_0.super._btnstartOnClick(arg_9_0)
end

function var_0_0._initHeroItemList(arg_10_0)
	if arg_10_0._heroItemList then
		return
	end

	arg_10_0._heroItemList = arg_10_0:getUserDataTb_()

	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes.initHeroItem
	local var_10_1 = arg_10_0._initGroupMo:getCarryHeroCount()
	local var_10_2 = math.max(var_10_1, arg_10_0._initGroupMo:getCarryHeroMax())

	for iter_10_0 = 1, var_10_2 do
		local var_10_3 = arg_10_0:getResInst(var_10_0, arg_10_0._gocontent)

		var_10_3.name = "item_" .. tostring(iter_10_0)

		local var_10_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_3, SurvivalInitTeamHeroItem)

		var_10_4:setIndex(iter_10_0)
		var_10_4:setIsLock(var_10_1 < iter_10_0)
		var_10_4:setParentView(arg_10_0)
		table.insert(arg_10_0._heroItemList, var_10_4)
	end
end

function var_0_0._updateHeroList(arg_11_0)
	local var_11_0 = 0
	local var_11_1 = SurvivalShelterModel.instance:getWeekInfo().clientData.data.heroCount
	local var_11_2 = arg_11_0._initGroupMo:getCarryHeroCount()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._heroItemList) do
		if not iter_11_1._isLock then
			local var_11_3 = arg_11_0._initGroupMo.allSelectHeroMos[iter_11_0]
			local var_11_4 = arg_11_0._isModify and var_11_3 and iter_11_1:getHeroMo() ~= var_11_3

			iter_11_1:setTrialValue(var_11_3 and arg_11_0._initGroupMo.assistHeroMo and var_11_3 == arg_11_0._initGroupMo.assistHeroMo.heroMO)
			iter_11_1:onUpdateMO(var_11_3)
			iter_11_1:setNew(var_11_1 < iter_11_0 and iter_11_0 <= var_11_2)

			if var_11_4 then
				iter_11_1:showSelectEffect()
			end

			if var_11_3 then
				var_11_0 = var_11_0 + 1
			end
		end
	end

	arg_11_0._txtnum.text = string.format("(%d/%d)", var_11_0, arg_11_0._initGroupMo:getCarryHeroCount())

	arg_11_0:_checkHelpState()
	arg_11_0.viewContainer:setWeightNum()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	arg_12_0:_initHeroItemList()
	arg_12_0:_updateHeroList()
end

function var_0_0.onViewShow(arg_13_0)
	arg_13_0:_updateHeroList()

	local var_13_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_13_1 = var_13_0.clientData.data.heroCount
	local var_13_2 = arg_13_0._initGroupMo:getCarryHeroCount()

	if var_13_1 ~= var_13_2 then
		var_13_0.clientData.data.heroCount = var_13_2

		var_13_0.clientData:saveDataToServer()
	end
end

function var_0_0._onViewClose(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.SurvivalInitHeroSelectView then
		arg_14_0:_modifyHeroGroup()
	end
end

function var_0_0._modifyHeroGroup(arg_15_0)
	arg_15_0._isModify = true

	arg_15_0:_updateHeroList()

	arg_15_0._isModify = false
end

return var_0_0
