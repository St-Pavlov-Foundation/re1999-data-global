module("modules.logic.survival.view.map.SurvivalMapTeamView", package.seeall)

local var_0_0 = class("SurvivalMapTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtWeight = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Weight/#txt_WeightNum")
	arg_1_0._root = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Overview")
	arg_1_0._goherocontent = gohelper.findChild(arg_1_0._root, "Team/Scroll View/Viewport/#go_content")
	arg_1_0._txtheronum = gohelper.findChildTextMesh(arg_1_0._root, "Team/Title/txt_Team/#txt_MemberNum")
	arg_1_0._gonpccontent = gohelper.findChild(arg_1_0._root, "Partner/Scroll View/Viewport/#go_content")
	arg_1_0._txtnpcnum = gohelper.findChildTextMesh(arg_1_0._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_equip")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_info")
	arg_1_0._btnCloseTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_info/#btn_closeinfo")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseTips:AddClickListener(arg_2_0._btnCloseTipsOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTeamNpc, arg_2_0._showNpcInfoView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseTips:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTeamNpc, arg_3_0._showNpcInfoView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)
	gohelper.setActive(arg_4_0._goinfo, false)

	arg_4_0._teamInfoMo = SurvivalMapModel.instance:getSceneMo().teamInfo
	arg_4_0._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	arg_4_0:_initHeroItemList()
	arg_4_0:_updateHeroList()
	arg_4_0:_initNPCItemList()
	arg_4_0:_updateNPCList()
end

function var_0_0._btnCloseTipsOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goinfo, false)
end

function var_0_0._btnequipOnClick(arg_6_0)
	SurvivalController.instance:openEquipView()
end

function var_0_0._initHeroItemList(arg_7_0)
	arg_7_0._heroItemList = arg_7_0:getUserDataTb_()

	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes.initHeroItemSmall
	local var_7_1 = arg_7_0._initGroupMo:getCarryHeroCount()
	local var_7_2 = math.max(var_7_1, arg_7_0._initGroupMo:getCarryHeroMax())

	for iter_7_0 = 1, var_7_2 do
		local var_7_3 = arg_7_0:getResInst(var_7_0, arg_7_0._goherocontent)

		var_7_3.name = "item_" .. tostring(iter_7_0)

		local var_7_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_3, SurvivalInitTeamHeroSmallItem)

		var_7_4:setIndex(iter_7_0)
		var_7_4:setIsLock(var_7_1 < iter_7_0)
		var_7_4:setNoShowAdd()
		var_7_4:setParentView(arg_7_0)
		table.insert(arg_7_0._heroItemList, var_7_4)
	end
end

function var_0_0._updateHeroList(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._heroItemList) do
		local var_8_1 = arg_8_0._teamInfoMo.heros[iter_8_0]
		local var_8_2, var_8_3 = arg_8_0._teamInfoMo:getHeroMo(var_8_1)

		iter_8_1:setTrialValue(var_8_3)
		iter_8_1:onUpdateMO(var_8_2)

		if var_8_2 then
			var_8_0 = var_8_0 + 1
		end
	end

	arg_8_0._txtheronum.text = string.format("(%d/%d)", var_8_0, arg_8_0._initGroupMo:getCarryHeroCount())

	local var_8_4 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	arg_8_0._txtWeight.text = var_8_4
end

function var_0_0._initNPCItemList(arg_9_0)
	arg_9_0._npcItemList = arg_9_0:getUserDataTb_()

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes.initNpcItemSmall
	local var_9_1 = arg_9_0._initGroupMo:getCarryNPCCount()
	local var_9_2 = math.max(var_9_1, arg_9_0._initGroupMo:getCarryNPCMax())

	for iter_9_0 = 1, var_9_2 do
		local var_9_3 = arg_9_0:getResInst(var_9_0, arg_9_0._gonpccontent)

		var_9_3.name = "item_" .. tostring(iter_9_0)

		local var_9_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_3, SurvivalInitNPCSmallItem)

		var_9_4:setNoShowAdd()
		var_9_4:setIsLock(var_9_1 < iter_9_0)
		var_9_4:setIndex(iter_9_0)
		var_9_4:setParentView(arg_9_0)
		table.insert(arg_9_0._npcItemList, var_9_4)
	end
end

function var_0_0._updateNPCList(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._npcItemList) do
		local var_10_1 = arg_10_0._teamInfoMo.npcId[iter_10_0]
		local var_10_2 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(var_10_1)

		iter_10_1:onUpdateMO(var_10_2)

		if var_10_2 then
			var_10_0 = var_10_0 + 1
		end
	end

	arg_10_0._txtnpcnum.text = string.format("(%d/%d)", var_10_0, arg_10_0._initGroupMo:getCarryNPCCount())
end

function var_0_0._showNpcInfoView(arg_11_0, arg_11_1)
	if not arg_11_0.npcInfoView then
		local var_11_0 = arg_11_0.viewContainer._viewSetting.otherRes.infoView
		local var_11_1 = arg_11_0:getResInst(var_11_0, arg_11_0._goinfo)

		arg_11_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, SurvivalSelectNPCInfoPart)
	end

	gohelper.setActive(arg_11_0._goinfo, true)
	arg_11_0._infoPanel:updateMo(arg_11_1, true)
end

return var_0_0
