module("modules.logic.gm.view.GMToolFastAddHeroView", package.seeall)

local var_0_0 = class("GMToolFastAddHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinputcontainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer")
	arg_1_0._goinptucontainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer")
	arg_1_0._goheroid = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid")
	arg_1_0._inputheroid = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/#input_heroid")
	arg_1_0._goherolv = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv")
	arg_1_0._inputherolv = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv/#input_herolv")
	arg_1_0._goranklv = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv")
	arg_1_0._inputranklv = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/#input_ranklv")
	arg_1_0._gotalentlv = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv")
	arg_1_0._inputtalentlv = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/#input_talentlv")
	arg_1_0._goexskilllv = gohelper.findChild(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv")
	arg_1_0._inputexskilllv = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/#input_exskilllv")
	arg_1_0._btnfastadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_inputcontainer/#btn_fastadd")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#go_inputcontainer/#btn_switch")
	arg_1_0._goherolistcontainer = gohelper.findChild(arg_1_0.viewGO, "container/#go_herolistcontainer")
	arg_1_0._inputfilter = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "container/#go_herolistcontainer/#input_filter")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem")
	arg_1_0._txtheroname = gohelper.findChildText(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_heroname")
	arg_1_0._txtherolv = gohelper.findChildText(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_herolv")
	arg_1_0._txtranklv = gohelper.findChildText(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_ranklv")
	arg_1_0._txttalentlv = gohelper.findChildText(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_talentlv")
	arg_1_0._txtexskilllv = gohelper.findChildText(arg_1_0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_exskilllv")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_close")
	arg_1_0._goaddItem = gohelper.findChild(arg_1_0.viewGO, "container/#go_addItem")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "container/#go_addItem/scroll/#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfastadd:AddClickListener(arg_2_0._btnfastaddOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfastadd:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnfastaddOnClick(arg_5_0)
	if arg_5_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		local var_5_0 = tonumber(arg_5_0._inputheroid:GetText())

		if not var_5_0 then
			return
		end

		local var_5_1 = tonumber(arg_5_0._inputherolv:GetText()) or 1
		local var_5_2 = tonumber(arg_5_0._inputranklv:GetText()) or 1
		local var_5_3 = tonumber(arg_5_0._inputtalentlv:GetText()) or 1
		local var_5_4 = tonumber(arg_5_0._inputexskilllv:GetText()) or 1

		GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", var_5_1, var_5_2, var_5_3, var_5_4))
		GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", var_5_0, var_5_1, var_5_2, var_5_3, var_5_4))
	elseif arg_5_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		local var_5_5 = tonumber(arg_5_0._inputheroid:GetText())

		if not var_5_5 then
			return
		end

		local var_5_6 = tonumber(arg_5_0._inputherolv:GetText()) or 1
		local var_5_7 = tonumber(arg_5_0._inputranklv:GetText()) or 0

		GMRpc.instance:sendGMRequest(string.format("add equip %d#%d#%d", var_5_5, var_5_6, var_5_7))
	end
end

function var_0_0._btnswitchOnClick(arg_6_0)
	GMFastAddHeroHadHeroItemModel.instance:changeShowType()

	arg_6_0.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()
	arg_6_0.filterText = ""

	arg_6_0:refreshUI()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtheroidlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/label")
	arg_7_0._txtranklvlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/label")
	arg_7_0._txttalentlvlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/label")
	arg_7_0._txtexskilllvlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/label")
	arg_7_0._txtnewlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_inputcontainer/newlabelbutton/#txt_newlabel")
	arg_7_0._txthadlabel = gohelper.findChildText(arg_7_0.viewGO, "container/#go_herolistcontainer/hadlabelbutton/#txt_hadlabel")
	arg_7_0._txtplaceholder = gohelper.findChildText(arg_7_0.viewGO, "container/#go_herolistcontainer/#input_filter/textarea/Placeholder")

	gohelper.setActive(arg_7_0._goaddItem, false)
	gohelper.setActive(arg_7_0._goitem, false)
	gohelper.setActive(arg_7_0._goheroitem, false)

	arg_7_0.heroIdClick = gohelper.getClick(arg_7_0._goheroid)

	arg_7_0.heroIdClick:AddClickListener(arg_7_0.onClickHeroId, arg_7_0)

	arg_7_0.addItemClick = gohelper.getClick(arg_7_0._goaddItem)

	arg_7_0.addItemClick:AddClickListener(arg_7_0.onClickAddItem, arg_7_0)

	arg_7_0.inputHeroIdClick = gohelper.getClick(arg_7_0._inputheroid.gameObject)

	arg_7_0.inputHeroIdClick:AddClickListener(arg_7_0.onClickHeroId, arg_7_0)
	arg_7_0._inputfilter:AddOnValueChanged(arg_7_0.inputFilterValueChange, arg_7_0)

	arg_7_0.filterText = ""
end

function var_0_0.onClickHeroId(arg_8_0)
	arg_8_0:showAddItemContainer()
end

function var_0_0.onClickAddItem(arg_9_0)
	arg_9_0:hideAddItemContainer()
end

function var_0_0.inputFilterValueChange(arg_10_0, arg_10_1)
	if arg_10_0.filterText ~= arg_10_1 then
		arg_10_0.filterText = arg_10_1

		arg_10_0:refreshHaveHeroList()
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	GMAddItemModel.instance:setFastAddHeroView(arg_12_0)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(arg_12_0)
	GMFastAddHeroHadHeroItemModel.instance:setShowType(GMFastAddHeroHadHeroItemModel.ShowType.Hero)

	arg_12_0.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()

	arg_12_0:refreshUI()
	arg_12_0:resetInputText()
	arg_12_0._inputfilter:SetText("")
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_12_0.refreshHaveHeroList, arg_12_0)
	arg_12_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_12_0.refreshHaveHeroList, arg_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0:refreshAddItemCoList()
	arg_13_0:refreshHaveHeroList()
	arg_13_0:refreshLabelUI()
end

function var_0_0.refreshLabelUI(arg_14_0)
	if arg_14_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		arg_14_0:showHeroLabelUI()
	elseif arg_14_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		arg_14_0:showEquipLabelUI()
	else
		arg_14_0:showHeroLabelUI()
	end
end

function var_0_0.showEquipLabelUI(arg_15_0)
	arg_15_0._txtheroidlabel.text = "装备ID"
	arg_15_0._txtranklvlabel.text = "精炼"
	arg_15_0._txttalentlvlabel.text = ""
	arg_15_0._txtexskilllvlabel.text = ""

	gohelper.setActive(arg_15_0._inputexskilllv.gameObject, false)
	gohelper.setActive(arg_15_0._inputtalentlv.gameObject, false)

	arg_15_0._txtnewlabel.text = "新增装备"
	arg_15_0._txthadlabel.text = "已有装备"
	arg_15_0._txtplaceholder.text = "搜索装备..."
end

function var_0_0.showHeroLabelUI(arg_16_0)
	arg_16_0._txtheroidlabel.text = "角色ID"
	arg_16_0._txtranklvlabel.text = "洞悉"
	arg_16_0._txttalentlvlabel.text = "共鸣"
	arg_16_0._txtexskilllvlabel.text = "塑造"

	gohelper.setActive(arg_16_0._inputexskilllv.gameObject, true)
	gohelper.setActive(arg_16_0._inputtalentlv.gameObject, true)

	arg_16_0._txtnewlabel.text = "新增英雄"
	arg_16_0._txthadlabel.text = "已有英雄"
	arg_16_0._txtplaceholder.text = "搜索英雄..."
end

function var_0_0.onAddItemOnClick(arg_17_0, arg_17_1)
	arg_17_0:hideAddItemContainer()
	arg_17_0:resetInputText()
	arg_17_0._inputheroid:SetText(arg_17_1.id)

	if arg_17_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		arg_17_0:refreshCharacterCoShow(arg_17_1)
	elseif arg_17_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		arg_17_0:refreshEquipCoShow(arg_17_1)
	else
		arg_17_0:refreshCharacterCoShow(arg_17_1)
	end
end

function var_0_0.refreshCharacterCoShow(arg_18_0, arg_18_1)
	local var_18_0 = HeroModel.instance:getByHeroId(arg_18_1.id)

	if var_18_0 then
		arg_18_0._inputherolv:SetText(var_18_0.level)
		arg_18_0._inputranklv:SetText(var_18_0.rank)
		arg_18_0._inputtalentlv:SetText(var_18_0.talent)
		arg_18_0._inputexskilllv:SetText(var_18_0.exSkillLevel)
	end
end

function var_0_0.refreshEquipCoShow(arg_19_0, arg_19_1)
	arg_19_0._inputherolv:SetText(1)
	arg_19_0._inputranklv:SetText(1)
	arg_19_0._inputtalentlv:SetText(1)
end

function var_0_0.showAddItemContainer(arg_20_0)
	gohelper.setActive(arg_20_0._goaddItem, true)
end

function var_0_0.hideAddItemContainer(arg_21_0)
	gohelper.setActive(arg_21_0._goaddItem, false)
end

function var_0_0.resetInputText(arg_22_0)
	arg_22_0._inputheroid:SetText("")
	arg_22_0._inputherolv:SetText("")
	arg_22_0._inputranklv:SetText("")
	arg_22_0._inputtalentlv:SetText("")
	arg_22_0._inputexskilllv:SetText("")
end

function var_0_0.refreshAddItemCoList(arg_23_0)
	local var_23_0 = {
		{
			id = 0,
			name = "All",
			rare = 5
		}
	}
	local var_23_1

	if arg_23_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		var_23_1 = lua_character.configList
	elseif arg_23_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		var_23_1 = lua_equip.configList
	else
		var_23_1 = lua_character.configList
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		table.insert(var_23_0, iter_23_1)
	end

	GMAddItemModel.instance:setList(var_23_0)
end

function var_0_0.refreshHaveHeroList(arg_24_0)
	local var_24_0

	if arg_24_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		var_24_0 = arg_24_0:getHeroMoList()
	elseif arg_24_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		var_24_0 = arg_24_0:getEquipMoList()
	else
		var_24_0 = {}
	end

	GMFastAddHeroHadHeroItemModel.instance:refreshList(var_24_0)
end

function var_0_0.getHeroMoList(arg_25_0)
	local var_25_0 = {}

	if string.nilorempty(arg_25_0.filterText) then
		var_25_0 = HeroModel.instance:getList()
	else
		for iter_25_0, iter_25_1 in ipairs(HeroModel.instance:getList()) do
			if string.match(iter_25_1.config.name, arg_25_0.filterText) then
				table.insert(var_25_0, iter_25_1)
			end
		end
	end

	return var_25_0
end

function var_0_0.getEquipMoList(arg_26_0)
	local var_26_0 = {}

	if string.nilorempty(arg_26_0.filterText) then
		for iter_26_0, iter_26_1 in ipairs(EquipModel.instance:getEquips()) do
			table.insert(var_26_0, iter_26_1)
		end
	else
		for iter_26_2, iter_26_3 in ipairs(EquipModel.instance:getEquips()) do
			if string.match(iter_26_3.config.name, arg_26_0.filterText) then
				table.insert(var_26_0, iter_26_3)
			end
		end
	end

	local var_26_1 = {}

	for iter_26_4, iter_26_5 in ipairs(var_26_0) do
		if iter_26_5 == nil or iter_26_5.config == nil then
			logError(string.format("equipId %s not config, uid is %s", iter_26_5.equipId, iter_26_5.id))
			table.insert(var_26_1, iter_26_5)
		end
	end

	for iter_26_6, iter_26_7 in ipairs(var_26_1) do
		local var_26_2 = tabletool.indexOf(var_26_0, iter_26_7)

		table.remove(var_26_0, var_26_2)
	end

	return var_26_0
end

function var_0_0.changeSelectHeroItemMo(arg_27_0, arg_27_1)
	if arg_27_1 then
		arg_27_0._inputheroid:SetText(arg_27_1.config.id)
		arg_27_0._inputherolv:SetText(arg_27_1.level)

		if arg_27_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
			arg_27_0._inputranklv:SetText(arg_27_1.rank)
			arg_27_0._inputtalentlv:SetText(arg_27_1.talent)
			arg_27_0._inputexskilllv:SetText(arg_27_1.exSkillLevel)
		elseif arg_27_0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
			arg_27_0._inputranklv:SetText(arg_27_1.refineLv)
			arg_27_0._inputtalentlv:SetText(arg_27_1.breakLv)
		else
			arg_27_0._inputranklv:SetText(arg_27_1.rank)
			arg_27_0._inputtalentlv:SetText(arg_27_1.talent)
			arg_27_0._inputexskilllv:SetText(arg_27_1.exSkillLevel)
		end
	else
		arg_27_0._inputheroid:SetText("")
		arg_27_0._inputherolv:SetText("")
		arg_27_0._inputranklv:SetText("")
		arg_27_0._inputtalentlv:SetText("")
		arg_27_0._inputexskilllv:SetText("")
	end
end

function var_0_0.onClose(arg_28_0)
	arg_28_0.heroIdClick:RemoveClickListener()
	arg_28_0.addItemClick:RemoveClickListener()
	arg_28_0.inputHeroIdClick:RemoveClickListener()
	arg_28_0._inputfilter:RemoveOnValueChanged()
	GMAddItemModel.instance:setFastAddHeroView(nil)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(nil)
	arg_28_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_28_0.refreshHaveHeroList, arg_28_0)
	arg_28_0:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_28_0.refreshHaveHeroList, arg_28_0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0
