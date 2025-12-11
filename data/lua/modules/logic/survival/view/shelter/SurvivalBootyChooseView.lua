module("modules.logic.survival.view.shelter.SurvivalBootyChooseView", package.seeall)

local var_0_0 = class("SurvivalBootyChooseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_FullBG")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_confirm")
	arg_1_0._btnabandon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_abandon")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_reward")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_reward/empty/#btn_add")
	arg_1_0._simagereward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/#go_reward/has/go_icon/#simage_reward")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_reward/has/#btn_switch")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_reward/has/#btn_remove")
	arg_1_0._goreward1 = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_reward1")
	arg_1_0._goreward2 = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_reward2")
	arg_1_0._goreward3 = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#go_reward3")
	arg_1_0._gonpcselect = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#go_npcselect/#simage_PanelBG")
	arg_1_0._scrollList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List")
	arg_1_0._goempty = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/#go_npcselect/go_empty")
	arg_1_0._goSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#image_Chess")
	arg_1_0._txtPartnerName = gohelper.findChildText(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#txt_PartnerName")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Tips")
	arg_1_0._txtTentName = gohelper.findChildText(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Tips/#txt_TentName")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem/#go_Selected")
	arg_1_0._btnnpcfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter")
	arg_1_0._gonpcNormal = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_npcNormal")
	arg_1_0._gonpcSelect = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_npcSelect")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips/#go_item")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter/#go_tips/#go_item/#txt_desc")
	arg_1_0._btnnpcSelect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npc_Select")
	arg_1_0._btnnpcSelectClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_npcselect/#btn_npcSelectClose")
	arg_1_0._gocollectionselect = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_collectionselect")
	arg_1_0._btncollectionClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_collectionselect/#btn_collectionClose")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_collectionselect/#btn_filter")
	arg_1_0._gocollectionFilterNormal = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_collectionselect/#btn_filter/#go_collectionFilterNormal")
	arg_1_0._gocollectionFilterSelect = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_collectionselect/#btn_filter/#go_collectionFilterSelect")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_collectionselect/#go_infoview")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_info")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnabandon:AddClickListener(arg_2_0._btnabandonOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._btnremoveOnClick, arg_2_0)
	arg_2_0._btnnpcfilter:AddClickListener(arg_2_0._btnnpcfilterOnClick, arg_2_0)
	arg_2_0._btnnpcSelect:AddClickListener(arg_2_0._btnnpcSelectOnClick, arg_2_0)
	arg_2_0._btnnpcSelectClose:AddClickListener(arg_2_0._btnnpcSelectCloseOnClick, arg_2_0)
	arg_2_0._btncollectionClose:AddClickListener(arg_2_0._btncollectionCloseOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnabandon:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btnremove:RemoveClickListener()
	arg_3_0._btnnpcfilter:RemoveClickListener()
	arg_3_0._btnnpcSelect:RemoveClickListener()
	arg_3_0._btnnpcSelectClose:RemoveClickListener()
	arg_3_0._btncollectionClose:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

local var_0_1 = 3
local var_0_2 = 1

function var_0_0._btnconfirmOnClick(arg_4_0)
	arg_4_0:sendSurvivalChooseBooty(false)
end

function var_0_0._btnabandonOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalCancelSelectNextReward, MsgBoxEnum.BoxType.Yes_No, arg_5_0._abandonSelect, nil, nil, arg_5_0, nil, nil)
end

function var_0_0._abandonSelect(arg_6_0)
	arg_6_0:sendSurvivalChooseBooty(true)
end

function var_0_0._btnaddOnClick(arg_7_0)
	arg_7_0:_selectEquip()
end

function var_0_0._btnswitchOnClick(arg_8_0)
	arg_8_0:_selectEquip()
end

function var_0_0._btnremoveOnClick(arg_9_0)
	arg_9_0.amplifierSelectMo:removeOneByPos(1)
	arg_9_0:refreshEquipSelectInfo()
end

function var_0_0._btnnpcfilterOnClick(arg_10_0)
	return
end

function var_0_0._btnnpcSelectOnClick(arg_11_0)
	SurvivalShelterChooseNpcListModel.instance:changeQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	arg_11_0:_refreshNpcSelectPanel()
end

function var_0_0._btnnpcSelectCloseOnClick(arg_12_0)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	SurvivalShelterChooseNpcListModel.instance:setSelectPos(nil)
	arg_12_0:_refreshNpcSelectPanel()
end

function var_0_0._btncollectionCloseOnClick(arg_13_0)
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)
	SurvivalShelterChooseEquipListModel.instance:setSelectPos(nil)
	arg_13_0:_refreshEquipSelectPanel()
end

function var_0_0._btnfilterOnClick(arg_14_0)
	return
end

function var_0_0._btnCloseOnClick(arg_15_0)
	arg_15_0:sendSurvivalChooseBooty(true)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0.goNpcInfoRoot = gohelper.findChild(arg_16_0.viewGO, "Panel/#go_npcselect/go_manageinfo")
	arg_16_0.goFilter = gohelper.findChild(arg_16_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter")
	arg_16_0._allNpcPosItem = arg_16_0:getUserDataTb_()

	for iter_16_0 = 1, var_0_1 do
		local var_16_0 = arg_16_0["_goreward" .. iter_16_0]
		local var_16_1 = arg_16_0:getUserDataTb_()

		var_16_1.index = iter_16_0
		var_16_1.npcId = nil
		var_16_1.empty = gohelper.findChild(var_16_0, "empty")
		var_16_1.has = gohelper.findChild(var_16_0, "has")
		var_16_1.lock = gohelper.findChild(var_16_0, "lock")
		var_16_1.btnAdd = gohelper.findChildButtonWithAudio(var_16_0, "empty/btn_add")
		var_16_1.btnSwitch = gohelper.findChildButtonWithAudio(var_16_0, "has/btn_switch")
		var_16_1.btnRemove = gohelper.findChildButtonWithAudio(var_16_0, "has/#btn_remove")
		var_16_1.simage = gohelper.findChildSingleImage(var_16_0, "has/go_icon/image")
		var_16_1.goSelect = gohelper.findChild(var_16_0, "#go_Selected")

		var_16_1.btnAdd:AddClickListener(arg_16_0._setNpcSelectPos, arg_16_0, var_16_1.index)
		var_16_1.btnSwitch:AddClickListener(arg_16_0._setNpcSelectPos, arg_16_0, var_16_1.index)
		var_16_1.btnRemove:AddClickListener(arg_16_0._onClickBtnRemove, arg_16_0, var_16_1.index)
		gohelper.setActive(var_16_1.goSelect, false)
		table.insert(arg_16_0._allNpcPosItem, var_16_1)
	end

	local var_16_2 = arg_16_0.viewContainer._viewSetting.otherRes.equipInfoView
	local var_16_3 = arg_16_0:getResInst(var_16_2, arg_16_0._goinfoview)

	arg_16_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_3, SurvivalShowBagInfoPart)

	local var_16_4 = arg_16_0.viewContainer._viewSetting.otherRes.equipItemView

	arg_16_0._equipItem = arg_16_0:getResInst(var_16_4, arg_16_0.viewGO)

	gohelper.setActive(arg_16_0._equipItem, false)

	arg_16_0._equipHasGo = gohelper.findChild(arg_16_0.viewGO, "Panel/Left/#go_reward/has")
	arg_16_0._equipEmptyGo = gohelper.findChild(arg_16_0.viewGO, "Panel/Left/#go_reward/empty")

	local var_16_5 = gohelper.findChild(arg_16_0._equipHasGo, "go_icon")
	local var_16_6 = arg_16_0.viewContainer:getSetting().otherRes.itemRes
	local var_16_7 = arg_16_0.viewContainer:getResInst(var_16_6, var_16_5)

	arg_16_0._equipSelectedItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_7, SurvivalBagItem)
	arg_16_0._goscroll = gohelper.findChild(arg_16_0.viewGO, "Panel/#go_collectionselect/scroll_collection")
	arg_16_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_16_0._goscroll, SurvivalSimpleListPart)

	arg_16_0._simpleList:setCellUpdateCallBack(arg_16_0._createEquipItem, arg_16_0, SurvivalChooseBagItem, arg_16_0._equipItem)

	arg_16_0._npcCloseClick = gohelper.findChildClickWithAudio(arg_16_0.viewGO, "Panel/#go_npcselect/Mask")
	arg_16_0._collectionCloseClick = gohelper.findChildClickWithAudio(arg_16_0.viewGO, "Panel/#go_collectionselect/Mask")

	arg_16_0._npcCloseClick:AddClickListener(arg_16_0._btnnpcSelectCloseOnClick, arg_16_0)
	arg_16_0._collectionCloseClick:AddClickListener(arg_16_0._btncollectionCloseOnClick, arg_16_0)
end

function var_0_0._setNpcSelectPos(arg_17_0, arg_17_1)
	local var_17_0 = {
		closeCallBack = arg_17_0.onInheritViewClose,
		closeCallBackContext = arg_17_0
	}

	SurvivalController.instance:sendOpenSurvivalRewardInheritView(SurvivalEnum.HandBookType.Npc, var_17_0)
end

function var_0_0._onClickBtnRemove(arg_18_0, arg_18_1)
	arg_18_0.npcSelectMo:removeOneByPos(arg_18_1)
	arg_18_0:refreshSelectInfo()
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0.amplifierSelectMo = SurvivalRewardInheritModel.instance.amplifierSelectMo
	arg_20_0.npcSelectMo = SurvivalRewardInheritModel.instance.npcSelectMo

	arg_20_0:clearSelect()
	arg_20_0:refreshFilter()
	arg_20_0:refreshEquipFilter()
	arg_20_0:refreshSelectPanel()

	arg_20_0._isSendSurvivalChoose = false

	arg_20_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnSelectFinish, arg_20_0.refreshSelectPanel, arg_20_0)
	arg_20_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnSetNpcSelectPos, arg_20_0._setNpcSelectPos, arg_20_0)
end

function var_0_0.onInheritViewClose(arg_21_0)
	arg_21_0:refreshSelectInfo()
	arg_21_0:refreshEquipSelectInfo()
end

function var_0_0.refreshSelectPanel(arg_22_0)
	arg_22_0:_refreshNpcSelectPanel()
	arg_22_0:_refreshEquipSelectPanel()
end

function var_0_0._refreshNpcSelectPanel(arg_23_0)
	local var_23_0 = SurvivalShelterChooseNpcListModel.instance:getSelectPos() and true or false

	gohelper.setActive(arg_23_0._gonpcselect, var_23_0)
	arg_23_0:refreshSelectInfo()

	if not var_23_0 then
		return
	end

	arg_23_0:refreshNpcInfoView()
	arg_23_0:refreshQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:refreshNpcList(arg_23_0._filterList)

	local var_23_1 = #SurvivalShelterChooseNpcListModel.instance:getList() == 0

	gohelper.setActive(arg_23_0._scrollList, not var_23_1)
	gohelper.setActive(arg_23_0._goempty, var_23_1)
end

function var_0_0.refreshSelectInfo(arg_24_0)
	for iter_24_0 = 1, arg_24_0.npcSelectMo.maxAmount do
		local var_24_0 = arg_24_0._allNpcPosItem[iter_24_0]
		local var_24_1 = arg_24_0.npcSelectMo:getSelectCellCfgId(iter_24_0)
		local var_24_2 = var_24_1 == nil

		if var_24_0 ~= nil then
			gohelper.setActive(var_24_0.empty, var_24_2)
			gohelper.setActive(var_24_0.has, not var_24_2)
			gohelper.setActive(var_24_0.goSelect, false)

			if not var_24_2 and (var_24_0.npcId == nil or var_24_0.npcId ~= var_24_1) then
				local var_24_3 = SurvivalConfig.instance:getNpcConfig(var_24_1)

				if var_24_3 and not string.nilorempty(var_24_3.smallIcon) then
					local var_24_4 = ResUrl.getSurvivalNpcIcon(var_24_3.smallIcon)

					var_24_0.simage:LoadImage(var_24_4)
				end

				var_24_0.npcId = var_24_1
			end
		end
	end
end

function var_0_0.refreshFilter(arg_25_0)
	arg_25_0:_setFilterCb(false)

	local var_25_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_25_0.goFilter, SurvivalFilterPart)
	local var_25_1 = {}
	local var_25_2 = lua_survival_tag_type.configList

	for iter_25_0, iter_25_1 in ipairs(var_25_2) do
		table.insert(var_25_1, {
			desc = iter_25_1.name,
			type = iter_25_1.id
		})
	end

	var_25_0:setOptionChangeCallback(arg_25_0._onFilterChange, arg_25_0)
	var_25_0:setOptions(var_25_1)
	var_25_0:setClickCb(arg_25_0._setFilterCb, arg_25_0)
end

function var_0_0._setFilterCb(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._gonpcNormal, not arg_26_1)
	gohelper.setActive(arg_26_0._gonpcSelect, arg_26_1)
end

function var_0_0._onFilterChange(arg_27_0, arg_27_1)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)

	arg_27_0._filterList = arg_27_1

	arg_27_0:refreshSelectPanel()
end

local var_0_3

function var_0_0.refreshNpcInfoView(arg_28_0)
	local var_28_0 = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()

	if not var_28_0 or var_28_0 == 0 then
		gohelper.setActive(arg_28_0.goNpcInfoRoot, false)

		return
	end

	if arg_28_0.goNpcInfoRoot.activeSelf and (var_0_3 == nil or var_0_3 == var_28_0) then
		gohelper.setActive(arg_28_0.goNpcInfoRoot, false)

		return
	end

	var_0_3 = var_28_0

	gohelper.setActive(arg_28_0.goNpcInfoRoot, true)

	if not arg_28_0.npcInfoView then
		local var_28_1 = arg_28_0.viewContainer:getRes(arg_28_0.viewContainer:getSetting().otherRes.infoView)

		arg_28_0.npcInfoView = ShelterManagerInfoView.getView(var_28_1, arg_28_0.goNpcInfoRoot, "infoView")
	end

	local var_28_2 = {
		showType = SurvivalEnum.InfoShowType.NpcOnlyConfig,
		showId = var_28_0
	}

	var_28_2.showSelect = true
	var_28_2.showUnSelect = true

	arg_28_0.npcInfoView:refreshParam(var_28_2)
end

function var_0_0.refreshQuickSelect(arg_29_0)
	local var_29_0 = not SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	ZProj.UGUIHelper.SetGrayscale(arg_29_0._btnnpcSelect.gameObject, var_29_0)
end

function var_0_0._selectEquip(arg_30_0)
	local var_30_0 = {
		closeCallBack = arg_30_0.onInheritViewClose,
		closeCallBackContext = arg_30_0
	}

	SurvivalController.instance:sendOpenSurvivalRewardInheritView(SurvivalEnum.HandBookType.Amplifier, var_30_0)
end

function var_0_0._refreshEquipSelectPanel(arg_31_0)
	local var_31_0 = SurvivalShelterChooseEquipListModel.instance:getSelectPos() and true or false

	gohelper.setActive(arg_31_0._gocollectionselect, var_31_0)
	arg_31_0:refreshEquipSelectInfo()

	if not var_31_0 then
		return
	end

	SurvivalShelterChooseEquipListModel.instance:refreshList(arg_31_0._equipFilterList)
	arg_31_0._simpleList:setList(SurvivalShelterChooseEquipListModel.instance:getList())
	arg_31_0:refreshEquipInfoView()
end

function var_0_0.refreshEquipSelectInfo(arg_32_0)
	local var_32_0 = arg_32_0.amplifierSelectMo:getSelectCellCfgId(1)
	local var_32_1 = var_32_0 == nil

	gohelper.setActive(arg_32_0._equipEmptyGo, var_32_1)
	gohelper.setActive(arg_32_0._equipHasGo, not var_32_1)

	if not var_32_1 then
		local var_32_2 = SurvivalBagItemMo.New()

		var_32_2:init({
			count = 1,
			id = var_32_0
		})
		arg_32_0._equipSelectedItem:updateMo(var_32_2)
		arg_32_0._equipSelectedItem:setShowNum(false)
		arg_32_0._equipSelectedItem:setItemSize(180, 180)
	end
end

function var_0_0._createEquipItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_1:updateMo(arg_33_2)
	arg_33_1:setClickCallback(arg_33_0._onEquipItemClick, arg_33_0)

	local var_33_0 = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if arg_33_1:getEquipId() == var_33_0 then
		arg_33_1:setIsSelect(true)
	end
end

function var_0_0._onEquipItemClick(arg_34_0)
	arg_34_0:_refreshEquipSelectPanel()
end

local var_0_4

function var_0_0.refreshEquipInfoView(arg_35_0)
	local var_35_0 = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if not var_35_0 or var_35_0 == 0 then
		gohelper.setActive(arg_35_0._goinfoview, false)

		return
	end

	if arg_35_0._goinfoview.activeSelf and (var_0_4 == nil or var_0_4 == var_35_0) then
		gohelper.setActive(arg_35_0._goinfoview, false)

		return
	end

	var_0_4 = var_35_0

	gohelper.setActive(arg_35_0._goinfoview, true)

	local var_35_1 = SurvivalBagItemMo.New()

	var_35_1:init({
		id = var_35_0
	})
	arg_35_0._infoPanel:updateMo(var_35_1)
end

function var_0_0.refreshEquipFilter(arg_36_0)
	arg_36_0:_setEquipFilterCb(false)

	local var_36_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_36_0._btnfilter.gameObject, SurvivalFilterPart)
	local var_36_1 = {}
	local var_36_2 = lua_survival_equip_found.configList

	for iter_36_0, iter_36_1 in ipairs(var_36_2) do
		table.insert(var_36_1, {
			desc = iter_36_1.name,
			type = iter_36_1.id
		})
	end

	var_36_0:setOptionChangeCallback(arg_36_0._onEquipFilterChange, arg_36_0)
	var_36_0:setOptions(var_36_1)
	var_36_0:setClickCb(arg_36_0._setEquipFilterCb, arg_36_0)
end

function var_0_0._setEquipFilterCb(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._gocollectionFilterNormal, not arg_37_1)
	gohelper.setActive(arg_37_0._gocollectionFilterSelect, arg_37_1)
end

function var_0_0._onEquipFilterChange(arg_38_0, arg_38_1)
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)

	arg_38_0._equipFilterList = arg_38_1

	arg_38_0:refreshSelectPanel()
end

function var_0_0.clearSelect(arg_39_0)
	arg_39_0.equipSelectList = {}
	arg_39_0.npcSelectList = {}
end

function var_0_0.sendSurvivalChooseBooty(arg_40_0, arg_40_1)
	arg_40_0._isSendSurvivalChoose = true

	if arg_40_1 then
		arg_40_0:clearSelect()
	else
		arg_40_0._selectNpcList = SurvivalShelterChooseNpcListModel.instance:getAllSelectPosNpc()
		arg_40_0._selectEquipList = SurvivalShelterChooseEquipListModel.instance:getAllSelectPosEquip()
		arg_40_0.equipSelectList = arg_40_0.amplifierSelectMo:getSelectList()
		arg_40_0.npcSelectList = arg_40_0.npcSelectMo:getSelectList()
	end

	SurvivalWeekRpc.instance:sendSurvivalChooseBooty(arg_40_0.npcSelectList, arg_40_0.equipSelectList, arg_40_0._selectFinish, arg_40_0)
end

function var_0_0._selectFinish(arg_41_0)
	arg_41_0:closeThis()

	local var_41_0 = GameSceneMgr.instance:getCurSceneType()

	if var_41_0 == SceneType.SurvivalShelter or var_41_0 == SceneType.Fight then
		SurvivalController.instance:exitMap()
	end

	SurvivalShelterChooseNpcListModel.instance:setNeedSelectNpcList()
	SurvivalShelterChooseEquipListModel.instance:setNeedSelectEquipList()
	arg_41_0.amplifierSelectMo:clear()
	arg_41_0.npcSelectMo:clear()
end

function var_0_0.onClose(arg_42_0)
	if not arg_42_0._isSendSurvivalChoose then
		arg_42_0:sendSurvivalChooseBooty(true)
	end
end

function var_0_0.onDestroyView(arg_43_0)
	if arg_43_0._npcCloseClick then
		arg_43_0._npcCloseClick:RemoveClickListener()

		arg_43_0._npcCloseClick = nil
	end

	if arg_43_0._collectionCloseClick then
		arg_43_0._collectionCloseClick:RemoveClickListener()

		arg_43_0._collectionCloseClick = nil
	end

	for iter_43_0 = 1, var_0_1 do
		local var_43_0 = arg_43_0._allNpcPosItem[iter_43_0]

		if var_43_0 ~= nil then
			var_43_0.btnAdd:RemoveClickListener()
			var_43_0.btnSwitch:RemoveClickListener()
			var_43_0.btnRemove:RemoveClickListener()

			local var_43_1
		end
	end
end

return var_0_0
