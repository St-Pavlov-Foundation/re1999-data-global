module("modules.logic.survival.view.map.SurvivalPreviewTeamView", package.seeall)

local var_0_0 = class("SurvivalPreviewTeamView", SurvivalInitTeamView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0._root, "#btn_Assist")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State1")
	arg_1_0._goselected = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State3")
	arg_1_0._gofull = gohelper.findChild(arg_1_0._root, "#btn_Assist/#go_State2")
	arg_1_0._goherocontent = gohelper.findChild(arg_1_0._root, "Team/Scroll View/Viewport/#go_content")
	arg_1_0._txtheronum = gohelper.findChildTextMesh(arg_1_0._root, "Team/Title/txt_Team/#txt_MemberNum")
	arg_1_0._gonpccontent = gohelper.findChild(arg_1_0._root, "Partner/Scroll View/Viewport/#go_content")
	arg_1_0._txtnpcnum = gohelper.findChildTextMesh(arg_1_0._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_talent")
	arg_1_0._txttalentname = gohelper.findChildTextMesh(arg_1_0._root, "Left/#btn_talent/txt_Attr1")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0._root, "Left/#btn_talent/simage_talent")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_equip")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0._root, "Left/image_Slider/Slider")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onViewClose, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNPCInTeamChange, arg_2_0._modifyNPCList, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnhelp:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNPCInTeamChange, arg_3_0._modifyNPCList, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)

	arg_4_0._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	local var_4_0 = lua_survival_item.configDict[SurvivalEnum.CurrencyType.Enthusiastic]
	local var_4_1 = var_4_0 and var_4_0.maxLimit or 100

	arg_4_0._slider:SetValue(SurvivalMapHelper.instance:getBagMo():getCurrencyNum(SurvivalEnum.CurrencyType.Enthusiastic) / var_4_1)
	arg_4_0:_initHeroItemList()
	arg_4_0:_updateHeroList()
	arg_4_0:_initNPCItemList()
	arg_4_0:_updateNPCList()
	arg_4_0:updateTalentIcon()
end

function var_0_0.updateTalentIcon(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.talentBox.groupId
	local var_5_2 = lua_survival_talent_group.configDict[var_5_1]

	arg_5_0._imagetalentskill:LoadImage(ResUrl.getSurvivalTalentIcon(var_5_2.folder .. "/icon_1"))

	arg_5_0._txttalentname.text = var_5_2.name
end

function var_0_0.onViewShow(arg_6_0)
	arg_6_0:_updateHeroList()
	arg_6_0:_updateNPCList()
end

function var_0_0._btnhelpOnClick(arg_7_0)
	if arg_7_0._helpState == SurvivalEnum.HelpState.Full then
		GameFacade.showToast(ToastEnum.SurvivalInitHeroLimit)

		return
	end

	if arg_7_0._helpState == SurvivalEnum.HelpState.Selected then
		arg_7_0._initGroupMo:removeAssistMo()
		arg_7_0:_modifyHeroGroup()

		return
	end

	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Survival, 1, nil, arg_7_0._onPickHandler, arg_7_0, true)
end

function var_0_0._btntalentOnClick(arg_8_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentOverView)
end

function var_0_0._btnequipOnClick(arg_9_0)
	SurvivalController.instance:openEquipView()
end

function var_0_0._onPickHandler(arg_10_0, arg_10_1)
	if not arg_10_1 then
		arg_10_0._initGroupMo.assistHeroMo = nil

		return
	end

	arg_10_0._initGroupMo:addAssistHeroMo(arg_10_1)
	arg_10_0:_modifyHeroGroup()
end

function var_0_0._checkHelpState(arg_11_0)
	if arg_11_0._initGroupMo.assistHeroMo then
		arg_11_0:_updateHelpState(SurvivalEnum.HelpState.Selected)

		return
	end

	if arg_11_0._initGroupMo:isHeroFull() then
		arg_11_0:_updateHelpState(SurvivalEnum.HelpState.Full)

		return
	end

	arg_11_0:_updateHelpState(SurvivalEnum.HelpState.UnSelected)
end

function var_0_0._updateHelpState(arg_12_0, arg_12_1)
	arg_12_0._helpState = arg_12_1

	gohelper.setActive(arg_12_0._gounselect, arg_12_1 == SurvivalEnum.HelpState.UnSelected)
	gohelper.setActive(arg_12_0._goselected, arg_12_1 == SurvivalEnum.HelpState.Selected)
	gohelper.setActive(arg_12_0._gofull, arg_12_1 == SurvivalEnum.HelpState.Full)
end

function var_0_0._btnstartOnClick(arg_13_0)
	if not next(arg_13_0._initGroupMo.allSelectHeroMos) then
		GameFacade.showToast(ToastEnum.SurvivalNoHero)

		return
	end

	if tabletool.len(arg_13_0._initGroupMo.allSelectHeroMos) < arg_13_0._initGroupMo:getCarryHeroCount() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHeroNoFull, MsgBoxEnum.BoxType.Yes_No, var_0_0.super._btnstartOnClick, nil, nil, arg_13_0, nil, nil)

		return
	end

	var_0_0.super._btnstartOnClick(arg_13_0)
end

function var_0_0._initHeroItemList(arg_14_0)
	if arg_14_0._heroItemList then
		return
	end

	arg_14_0._heroItemList = arg_14_0:getUserDataTb_()

	local var_14_0 = arg_14_0.viewContainer:getSetting().otherRes.initHeroItemSmall
	local var_14_1 = arg_14_0._initGroupMo:getCarryHeroCount()
	local var_14_2 = math.max(var_14_1, arg_14_0._initGroupMo:getCarryHeroMax())

	for iter_14_0 = 1, var_14_2 do
		local var_14_3 = arg_14_0:getResInst(var_14_0, arg_14_0._goherocontent)

		var_14_3.name = "item_" .. tostring(iter_14_0)

		local var_14_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_3, SurvivalInitTeamHeroSmallItem)

		var_14_4:setIndex(iter_14_0)
		var_14_4:setIsLock(var_14_1 < iter_14_0)
		var_14_4:setParentView(arg_14_0)
		table.insert(arg_14_0._heroItemList, var_14_4)
	end
end

function var_0_0._updateHeroList(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._heroItemList) do
		if not iter_15_1._isLock then
			local var_15_1 = arg_15_0._initGroupMo.allSelectHeroMos[iter_15_0]
			local var_15_2 = arg_15_0._isModify and var_15_1 and iter_15_1:getHeroMo() ~= var_15_1

			iter_15_1:setTrialValue(var_15_1 and arg_15_0._initGroupMo.assistHeroMo and var_15_1 == arg_15_0._initGroupMo.assistHeroMo.heroMO)
			iter_15_1:onUpdateMO(var_15_1)

			if var_15_2 then
				iter_15_1:showSelectEffect()
			end

			if var_15_1 then
				var_15_0 = var_15_0 + 1
			end
		end
	end

	arg_15_0._txtheronum.text = string.format("(%d/%d)", var_15_0, arg_15_0._initGroupMo:getCarryHeroCount())

	arg_15_0:_checkHelpState()
	arg_15_0.viewContainer:setWeightNum()
end

function var_0_0._initNPCItemList(arg_16_0)
	if arg_16_0._npcItemList then
		return
	end

	arg_16_0._npcItemList = arg_16_0:getUserDataTb_()

	local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes.initNpcItemSmall
	local var_16_1 = arg_16_0._initGroupMo:getCarryNPCCount()
	local var_16_2 = math.max(var_16_1, arg_16_0._initGroupMo:getCarryNPCMax())

	for iter_16_0 = 1, var_16_2 do
		local var_16_3 = arg_16_0:getResInst(var_16_0, arg_16_0._gonpccontent)

		var_16_3.name = "item_" .. tostring(iter_16_0)

		local var_16_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_3, SurvivalInitNPCSmallItem)

		var_16_4:setIndex(iter_16_0)
		var_16_4:setIsLock(var_16_1 < iter_16_0)
		var_16_4:setParentView(arg_16_0)
		table.insert(arg_16_0._npcItemList, var_16_4)
	end
end

function var_0_0._updateNPCList(arg_17_0)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._npcItemList) do
		if not iter_17_1._isLock then
			local var_17_1 = arg_17_0._initGroupMo.allSelectNpcs[iter_17_0]
			local var_17_2 = arg_17_0._isModify and var_17_1 and iter_17_1:getNpcMo() ~= var_17_1

			iter_17_1:onUpdateMO(var_17_1)

			if var_17_2 then
				iter_17_1:showSelectEffect()
			end

			if var_17_1 then
				var_17_0 = var_17_0 + 1
			end
		end
	end

	arg_17_0._txtnpcnum.text = string.format("(%d/%d)", var_17_0, arg_17_0._initGroupMo:getCarryNPCCount())

	arg_17_0.viewContainer:setWeightNum()
end

function var_0_0._onViewClose(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.SurvivalInitHeroSelectView then
		arg_18_0:_modifyHeroGroup()
	elseif arg_18_1 == ViewName.SurvivalNPCSelectView then
		arg_18_0:_modifyNPCList()
	end
end

function var_0_0._modifyHeroGroup(arg_19_0)
	arg_19_0._isModify = true

	arg_19_0:_updateHeroList()

	arg_19_0._isModify = false
end

function var_0_0._modifyNPCList(arg_20_0)
	arg_20_0._isModify = true

	arg_20_0:_updateNPCList()

	arg_20_0._isModify = false
end

return var_0_0
