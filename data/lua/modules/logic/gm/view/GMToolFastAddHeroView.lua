module("modules.logic.gm.view.GMToolFastAddHeroView", package.seeall)

slot0 = class("GMToolFastAddHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._goinputcontainer = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer")
	slot0._goinptucontainer = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer")
	slot0._goheroid = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid")
	slot0._inputheroid = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/#input_heroid")
	slot0._goherolv = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv")
	slot0._inputherolv = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv/#input_herolv")
	slot0._goranklv = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv")
	slot0._inputranklv = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/#input_ranklv")
	slot0._gotalentlv = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv")
	slot0._inputtalentlv = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/#input_talentlv")
	slot0._goexskilllv = gohelper.findChild(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv")
	slot0._inputexskilllv = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/#input_exskilllv")
	slot0._btnfastadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_inputcontainer/#btn_fastadd")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#go_inputcontainer/#btn_switch")
	slot0._goherolistcontainer = gohelper.findChild(slot0.viewGO, "container/#go_herolistcontainer")
	slot0._inputfilter = gohelper.findChildTextMeshInputField(slot0.viewGO, "container/#go_herolistcontainer/#input_filter")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem")
	slot0._txtheroname = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_heroname")
	slot0._txtherolv = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_herolv")
	slot0._txtranklv = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_ranklv")
	slot0._txttalentlv = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_talentlv")
	slot0._txtexskilllv = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_exskilllv")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_close")
	slot0._goaddItem = gohelper.findChild(slot0.viewGO, "container/#go_addItem")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "container/#go_addItem/scroll/#go_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfastadd:AddClickListener(slot0._btnfastaddOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfastadd:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnfastaddOnClick(slot0)
	if slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		if not tonumber(slot0._inputheroid:GetText()) then
			return
		end

		slot2 = tonumber(slot0._inputherolv:GetText()) or 1
		slot3 = tonumber(slot0._inputranklv:GetText()) or 1
		slot4 = tonumber(slot0._inputtalentlv:GetText()) or 1
		slot5 = tonumber(slot0._inputexskilllv:GetText()) or 1

		GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", slot2, slot3, slot4, slot5))
		GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", slot1, slot2, slot3, slot4, slot5))
	elseif slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		if not tonumber(slot0._inputheroid:GetText()) then
			return
		end

		GMRpc.instance:sendGMRequest(string.format("add equip %d#%d#%d", slot1, tonumber(slot0._inputherolv:GetText()) or 1, tonumber(slot0._inputranklv:GetText()) or 0))
	end
end

function slot0._btnswitchOnClick(slot0)
	GMFastAddHeroHadHeroItemModel.instance:changeShowType()

	slot0.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()
	slot0.filterText = ""

	slot0:refreshUI()
end

function slot0._editableInitView(slot0)
	slot0._txtheroidlabel = gohelper.findChildText(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/label")
	slot0._txtranklvlabel = gohelper.findChildText(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/label")
	slot0._txttalentlvlabel = gohelper.findChildText(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/label")
	slot0._txtexskilllvlabel = gohelper.findChildText(slot0.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/label")
	slot0._txtnewlabel = gohelper.findChildText(slot0.viewGO, "container/#go_inputcontainer/newlabelbutton/#txt_newlabel")
	slot0._txthadlabel = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/hadlabelbutton/#txt_hadlabel")
	slot0._txtplaceholder = gohelper.findChildText(slot0.viewGO, "container/#go_herolistcontainer/#input_filter/textarea/Placeholder")

	gohelper.setActive(slot0._goaddItem, false)
	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._goheroitem, false)

	slot0.heroIdClick = gohelper.getClick(slot0._goheroid)

	slot0.heroIdClick:AddClickListener(slot0.onClickHeroId, slot0)

	slot0.addItemClick = gohelper.getClick(slot0._goaddItem)

	slot0.addItemClick:AddClickListener(slot0.onClickAddItem, slot0)

	slot0.inputHeroIdClick = gohelper.getClick(slot0._inputheroid.gameObject)

	slot0.inputHeroIdClick:AddClickListener(slot0.onClickHeroId, slot0)
	slot0._inputfilter:AddOnValueChanged(slot0.inputFilterValueChange, slot0)

	slot0.filterText = ""
end

function slot0.onClickHeroId(slot0)
	slot0:showAddItemContainer()
end

function slot0.onClickAddItem(slot0)
	slot0:hideAddItemContainer()
end

function slot0.inputFilterValueChange(slot0, slot1)
	if slot0.filterText ~= slot1 then
		slot0.filterText = slot1

		slot0:refreshHaveHeroList()
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	GMAddItemModel.instance:setFastAddHeroView(slot0)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(slot0)
	GMFastAddHeroHadHeroItemModel.instance:setShowType(GMFastAddHeroHadHeroItemModel.ShowType.Hero)

	slot0.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()

	slot0:refreshUI()
	slot0:resetInputText()
	slot0._inputfilter:SetText("")
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0.refreshHaveHeroList, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshHaveHeroList, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshAddItemCoList()
	slot0:refreshHaveHeroList()
	slot0:refreshLabelUI()
end

function slot0.refreshLabelUI(slot0)
	if slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		slot0:showHeroLabelUI()
	elseif slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		slot0:showEquipLabelUI()
	else
		slot0:showHeroLabelUI()
	end
end

function slot0.showEquipLabelUI(slot0)
	slot0._txtheroidlabel.text = "装备ID"
	slot0._txtranklvlabel.text = "精炼"
	slot0._txttalentlvlabel.text = ""
	slot0._txtexskilllvlabel.text = ""

	gohelper.setActive(slot0._inputexskilllv.gameObject, false)
	gohelper.setActive(slot0._inputtalentlv.gameObject, false)

	slot0._txtnewlabel.text = "新增装备"
	slot0._txthadlabel.text = "已有装备"
	slot0._txtplaceholder.text = "搜索装备..."
end

function slot0.showHeroLabelUI(slot0)
	slot0._txtheroidlabel.text = "角色ID"
	slot0._txtranklvlabel.text = "洞悉"
	slot0._txttalentlvlabel.text = "共鸣"
	slot0._txtexskilllvlabel.text = "塑造"

	gohelper.setActive(slot0._inputexskilllv.gameObject, true)
	gohelper.setActive(slot0._inputtalentlv.gameObject, true)

	slot0._txtnewlabel.text = "新增英雄"
	slot0._txthadlabel.text = "已有英雄"
	slot0._txtplaceholder.text = "搜索英雄..."
end

function slot0.onAddItemOnClick(slot0, slot1)
	slot0:hideAddItemContainer()
	slot0:resetInputText()
	slot0._inputheroid:SetText(slot1.id)

	if slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		slot0:refreshCharacterCoShow(slot1)
	elseif slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		slot0:refreshEquipCoShow(slot1)
	else
		slot0:refreshCharacterCoShow(slot1)
	end
end

function slot0.refreshCharacterCoShow(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot1.id) then
		slot0._inputherolv:SetText(slot2.level)
		slot0._inputranklv:SetText(slot2.rank)
		slot0._inputtalentlv:SetText(slot2.talent)
		slot0._inputexskilllv:SetText(slot2.exSkillLevel)
	end
end

function slot0.refreshEquipCoShow(slot0, slot1)
	slot0._inputherolv:SetText(1)
	slot0._inputranklv:SetText(1)
	slot0._inputtalentlv:SetText(1)
end

function slot0.showAddItemContainer(slot0)
	gohelper.setActive(slot0._goaddItem, true)
end

function slot0.hideAddItemContainer(slot0)
	gohelper.setActive(slot0._goaddItem, false)
end

function slot0.resetInputText(slot0)
	slot0._inputheroid:SetText("")
	slot0._inputherolv:SetText("")
	slot0._inputranklv:SetText("")
	slot0._inputtalentlv:SetText("")
	slot0._inputexskilllv:SetText("")
end

function slot0.refreshAddItemCoList(slot0)
	slot1 = {
		{
			id = 0,
			name = "All",
			rare = 5
		}
	}
	slot2 = nil

	for slot6, slot7 in ipairs((slot0.showType ~= GMFastAddHeroHadHeroItemModel.ShowType.Hero or lua_character.configList) and (slot0.showType ~= GMFastAddHeroHadHeroItemModel.ShowType.Equip or lua_equip.configList) and lua_character.configList) do
		table.insert(slot1, slot7)
	end

	GMAddItemModel.instance:setList(slot1)
end

function slot0.refreshHaveHeroList(slot0)
	slot1 = nil

	GMFastAddHeroHadHeroItemModel.instance:refreshList((slot0.showType ~= GMFastAddHeroHadHeroItemModel.ShowType.Hero or slot0:getHeroMoList()) and (slot0.showType ~= GMFastAddHeroHadHeroItemModel.ShowType.Equip or slot0:getEquipMoList()) and {})
end

function slot0.getHeroMoList(slot0)
	slot1 = {}

	if string.nilorempty(slot0.filterText) then
		slot1 = HeroModel.instance:getList()
	else
		for slot5, slot6 in ipairs(HeroModel.instance:getList()) do
			if string.match(slot6.config.name, slot0.filterText) then
				table.insert(slot1, slot6)
			end
		end
	end

	return slot1
end

function slot0.getEquipMoList(slot0)
	slot1 = {}

	if string.nilorempty(slot0.filterText) then
		for slot5, slot6 in ipairs(EquipModel.instance:getEquips()) do
			table.insert(slot1, slot6)
		end
	else
		for slot5, slot6 in ipairs(EquipModel.instance:getEquips()) do
			if string.match(slot6.config.name, slot0.filterText) then
				table.insert(slot1, slot6)
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot7 == nil or slot7.config == nil then
			logError(string.format("equipId %s not config, uid is %s", slot7.equipId, slot7.id))
			table.insert(slot2, slot7)
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		table.remove(slot1, tabletool.indexOf(slot1, slot7))
	end

	return slot1
end

function slot0.changeSelectHeroItemMo(slot0, slot1)
	if slot1 then
		slot0._inputheroid:SetText(slot1.config.id)
		slot0._inputherolv:SetText(slot1.level)

		if slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
			slot0._inputranklv:SetText(slot1.rank)
			slot0._inputtalentlv:SetText(slot1.talent)
			slot0._inputexskilllv:SetText(slot1.exSkillLevel)
		elseif slot0.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
			slot0._inputranklv:SetText(slot1.refineLv)
			slot0._inputtalentlv:SetText(slot1.breakLv)
		else
			slot0._inputranklv:SetText(slot1.rank)
			slot0._inputtalentlv:SetText(slot1.talent)
			slot0._inputexskilllv:SetText(slot1.exSkillLevel)
		end
	else
		slot0._inputheroid:SetText("")
		slot0._inputherolv:SetText("")
		slot0._inputranklv:SetText("")
		slot0._inputtalentlv:SetText("")
		slot0._inputexskilllv:SetText("")
	end
end

function slot0.onClose(slot0)
	slot0.heroIdClick:RemoveClickListener()
	slot0.addItemClick:RemoveClickListener()
	slot0.inputHeroIdClick:RemoveClickListener()
	slot0._inputfilter:RemoveOnValueChanged()
	GMAddItemModel.instance:setFastAddHeroView(nil)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(nil)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0.refreshHaveHeroList, slot0)
	slot0:removeEventCb(EquipController.instance, EquipEvent.onUpdateEquip, slot0.refreshHaveHeroList, slot0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function slot0.onDestroyView(slot0)
end

return slot0
