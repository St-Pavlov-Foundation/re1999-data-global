module("modules.logic.survival.view.map.SurvivalPreviewTeamView", package.seeall)

local var_0_0 = class("SurvivalPreviewTeamView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gounselect = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State1")
	arg_1_0._goselected = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State3")
	arg_1_0._gofull = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State2")
	arg_1_0._goherocontent = gohelper.findChild(arg_1_0._root, "Team/Scroll View/Viewport/#go_content")
	arg_1_0._txtheronum = gohelper.findChildTextMesh(arg_1_0._root, "Team/Title/txt_Team/#txt_MemberNum")
	arg_1_0._gonpccontent = gohelper.findChild(arg_1_0._root, "Partner/Scroll View/Viewport/#go_content")
	arg_1_0._txtnpcnum = gohelper.findChildTextMesh(arg_1_0._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_equip")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onViewClose, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, arg_2_0._modifyNPCList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, arg_3_0._modifyNPCList, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)

	arg_4_0._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	arg_4_0:_initHeroItemList()
	arg_4_0:_updateHeroList()
	arg_4_0:_initNPCItemList()
	arg_4_0:_updateNPCList()
end

function var_0_0.onViewShow(arg_5_0)
	arg_5_0:_updateHeroList()
	arg_5_0:_updateNPCList()
end

function var_0_0._btnreturnOnClick(arg_6_0)
	arg_6_0.viewContainer:playAnim("go_map")
	arg_6_0.viewContainer:preStep()
end

function var_0_0._btnequipOnClick(arg_7_0)
	SurvivalController.instance:openEquipView()
end

function var_0_0._btnstartOnClick(arg_8_0)
	if not next(arg_8_0._initGroupMo.allSelectHeroMos) then
		GameFacade.showToast(ToastEnum.SurvivalNoHero)

		return
	end

	arg_8_0:enterNextStep()
end

function var_0_0.enterNextStep(arg_9_0)
	arg_9_0.viewContainer:nextStep()
end

function var_0_0._initHeroItemList(arg_10_0)
	if arg_10_0._heroItemList then
		return
	end

	arg_10_0._heroItemList = arg_10_0:getUserDataTb_()

	local var_10_0 = arg_10_0.viewContainer:getSetting().otherRes.initHeroItemSmall
	local var_10_1 = arg_10_0._initGroupMo:getCarryHeroCount()
	local var_10_2 = math.max(var_10_1, arg_10_0._initGroupMo:getCarryHeroMax())

	for iter_10_0 = 1, var_10_2 do
		local var_10_3 = arg_10_0:getResInst(var_10_0, arg_10_0._goherocontent)

		var_10_3.name = "item_" .. tostring(iter_10_0)

		local var_10_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_3, SurvivalInitTeamHeroSmallItem)

		var_10_4:setIndex(iter_10_0)
		var_10_4:setIsLock(var_10_1 < iter_10_0)
		var_10_4:setParentView(arg_10_0)
		table.insert(arg_10_0._heroItemList, var_10_4)
	end
end

function var_0_0._updateHeroList(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._heroItemList) do
		if not iter_11_1._isLock then
			local var_11_1 = arg_11_0._initGroupMo.allSelectHeroMos[iter_11_0]
			local var_11_2 = arg_11_0._isModify and var_11_1 and iter_11_1:getHeroMo() ~= var_11_1

			iter_11_1:setTrialValue(var_11_1 and arg_11_0._initGroupMo.assistHeroMo and var_11_1 == arg_11_0._initGroupMo.assistHeroMo.heroMO)
			iter_11_1:onUpdateMO(var_11_1)

			if var_11_2 then
				iter_11_1:showSelectEffect()
			end

			if var_11_1 then
				var_11_0 = var_11_0 + 1
			end
		end
	end

	arg_11_0._txtheronum.text = string.format("(%d/%d)", var_11_0, arg_11_0._initGroupMo:getCarryHeroCount())

	arg_11_0.viewContainer:setWeightNum()
end

function var_0_0._initNPCItemList(arg_12_0)
	if arg_12_0._npcItemList then
		return
	end

	arg_12_0._npcItemList = arg_12_0:getUserDataTb_()

	local var_12_0 = arg_12_0.viewContainer:getSetting().otherRes.initNpcItemSmall
	local var_12_1 = arg_12_0._initGroupMo:getCarryNPCCount()
	local var_12_2 = math.max(var_12_1, arg_12_0._initGroupMo:getCarryNPCMax())

	for iter_12_0 = 1, var_12_2 do
		local var_12_3 = arg_12_0:getResInst(var_12_0, arg_12_0._gonpccontent)

		var_12_3.name = "item_" .. tostring(iter_12_0)

		local var_12_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_3, SurvivalInitNPCSmallItem)

		var_12_4:setIndex(iter_12_0)
		var_12_4:setIsLock(var_12_1 < iter_12_0)
		var_12_4:setParentView(arg_12_0)
		table.insert(arg_12_0._npcItemList, var_12_4)
	end
end

function var_0_0._updateNPCList(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._npcItemList) do
		if not iter_13_1._isLock then
			local var_13_1 = arg_13_0._initGroupMo.allSelectNpcs[iter_13_0]
			local var_13_2 = arg_13_0._isModify and var_13_1 and iter_13_1:getNpcMo() ~= var_13_1

			iter_13_1:onUpdateMO(var_13_1)

			if var_13_2 then
				iter_13_1:showSelectEffect()
			end

			if var_13_1 then
				var_13_0 = var_13_0 + 1
			end
		end
	end

	arg_13_0._txtnpcnum.text = string.format("(%d/%d)", var_13_0, arg_13_0._initGroupMo:getCarryNPCCount())

	arg_13_0.viewContainer:setWeightNum()
end

function var_0_0._onViewClose(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.SurvivalInitHeroSelectView then
		arg_14_0:_modifyHeroGroup()
	elseif arg_14_1 == ViewName.SurvivalNPCSelectView then
		arg_14_0:_modifyNPCList()
	end
end

function var_0_0._modifyHeroGroup(arg_15_0)
	arg_15_0._isModify = true

	arg_15_0:_updateHeroList()

	arg_15_0._isModify = false
end

function var_0_0._modifyNPCList(arg_16_0)
	arg_16_0._isModify = true

	arg_16_0:_updateNPCList()

	arg_16_0._isModify = false
end

return var_0_0
