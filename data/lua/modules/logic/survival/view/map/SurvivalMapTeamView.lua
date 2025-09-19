module("modules.logic.survival.view.map.SurvivalMapTeamView", package.seeall)

local var_0_0 = class("SurvivalMapTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtWeight = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Weight/#txt_WeightNum")
	arg_1_0._root = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Overview")
	arg_1_0._goherocontent = gohelper.findChild(arg_1_0._root, "Team/Scroll View/Viewport/#go_content")
	arg_1_0._txtheronum = gohelper.findChildTextMesh(arg_1_0._root, "Team/Title/txt_Team/#txt_MemberNum")
	arg_1_0._gonpccontent = gohelper.findChild(arg_1_0._root, "Partner/Scroll View/Viewport/#go_content")
	arg_1_0._txtnpcnum = gohelper.findChildTextMesh(arg_1_0._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_talent")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0._root, "Left/#btn_talent/simage_talent")
	arg_1_0._txttalentname = gohelper.findChildTextMesh(arg_1_0._root, "Left/#btn_talent/txt_Attr1")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0._root, "Left/#btn_equip")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_info")
	arg_1_0._btnCloseTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_info/#btn_closeinfo")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0._root, "Left/image_Slider/Slider")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseTips:AddClickListener(arg_2_0._btnCloseTipsOnClick, arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTeamNpc, arg_2_0._showNpcInfoView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseTips:RemoveClickListener()
	arg_3_0._btntalent:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTeamNpc, arg_3_0._showNpcInfoView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)
	gohelper.setActive(arg_4_0._goinfo, false)

	arg_4_0._teamInfoMo = SurvivalMapModel.instance:getSceneMo().teamInfo
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

function var_0_0._btnCloseTipsOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._goinfo, false)
end

function var_0_0._btntalentOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentOverView)
end

function var_0_0._btnequipOnClick(arg_8_0)
	SurvivalController.instance:openEquipView()
end

function var_0_0._initHeroItemList(arg_9_0)
	arg_9_0._heroItemList = arg_9_0:getUserDataTb_()

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes.initHeroItemSmall
	local var_9_1 = arg_9_0._initGroupMo:getCarryHeroCount()
	local var_9_2 = math.max(var_9_1, arg_9_0._initGroupMo:getCarryHeroMax())

	for iter_9_0 = 1, var_9_2 do
		local var_9_3 = arg_9_0:getResInst(var_9_0, arg_9_0._goherocontent)

		var_9_3.name = "item_" .. tostring(iter_9_0)

		local var_9_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_3, SurvivalInitTeamHeroSmallItem)

		var_9_4:setIndex(iter_9_0)
		var_9_4:setIsLock(var_9_1 < iter_9_0)
		var_9_4:setNoShowAdd()
		var_9_4:setParentView(arg_9_0)
		table.insert(arg_9_0._heroItemList, var_9_4)
	end
end

function var_0_0._updateHeroList(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._heroItemList) do
		local var_10_1 = arg_10_0._teamInfoMo.heros[iter_10_0]
		local var_10_2, var_10_3 = arg_10_0._teamInfoMo:getHeroMo(var_10_1)

		iter_10_1:setTrialValue(var_10_3)
		iter_10_1:onUpdateMO(var_10_2)

		if var_10_2 then
			var_10_0 = var_10_0 + 1
		end
	end

	arg_10_0._txtheronum.text = string.format("(%d/%d)", var_10_0, arg_10_0._initGroupMo:getCarryHeroCount())

	local var_10_4 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroWeight)
	local var_10_5 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	arg_10_0._txtWeight.text = var_10_4 * var_10_0 + var_10_5
end

function var_0_0._initNPCItemList(arg_11_0)
	arg_11_0._npcItemList = arg_11_0:getUserDataTb_()

	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes.initNpcItemSmall
	local var_11_1 = arg_11_0._initGroupMo:getCarryNPCCount()
	local var_11_2 = math.max(var_11_1, arg_11_0._initGroupMo:getCarryNPCMax())

	for iter_11_0 = 1, var_11_2 do
		local var_11_3 = arg_11_0:getResInst(var_11_0, arg_11_0._gonpccontent)

		var_11_3.name = "item_" .. tostring(iter_11_0)

		local var_11_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_3, SurvivalInitNPCSmallItem)

		var_11_4:setNoShowAdd()
		var_11_4:setIsLock(var_11_1 < iter_11_0)
		var_11_4:setIndex(iter_11_0)
		var_11_4:setParentView(arg_11_0)
		table.insert(arg_11_0._npcItemList, var_11_4)
	end
end

function var_0_0._updateNPCList(arg_12_0)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._npcItemList) do
		local var_12_1 = arg_12_0._teamInfoMo.npcId[iter_12_0]
		local var_12_2 = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(var_12_1)

		iter_12_1:onUpdateMO(var_12_2)

		if var_12_2 then
			var_12_0 = var_12_0 + 1
		end
	end

	arg_12_0._txtnpcnum.text = string.format("(%d/%d)", var_12_0, arg_12_0._initGroupMo:getCarryNPCCount())
end

function var_0_0._showNpcInfoView(arg_13_0, arg_13_1)
	if not arg_13_0.npcInfoView then
		local var_13_0 = arg_13_0.viewContainer._viewSetting.otherRes.infoView
		local var_13_1 = arg_13_0:getResInst(var_13_0, arg_13_0._goinfo)

		arg_13_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, SurvivalSelectNPCInfoPart)
	end

	gohelper.setActive(arg_13_0._goinfo, true)
	arg_13_0._infoPanel:updateMo(arg_13_1, true)
end

return var_0_0
