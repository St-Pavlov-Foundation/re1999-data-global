﻿module("modules.logic.survival.view.shelter.SurvivalBootyChooseView", package.seeall)

local var_0_0 = class("SurvivalBootyChooseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_FullBG")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_confirm")
	arg_1_0._btnabandon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_abandon")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_reward")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_reward/empty/#btn_add")
	arg_1_0._simagereward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/#go_reward/has/go_icon/#simage_reward")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_reward/has/#btn_switch")
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

function var_0_0._btnnpcfilterOnClick(arg_9_0)
	return
end

function var_0_0._btnnpcSelectOnClick(arg_10_0)
	SurvivalShelterChooseNpcListModel.instance:changeQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	arg_10_0:_refreshNpcSelectPanel()
end

function var_0_0._btnnpcSelectCloseOnClick(arg_11_0)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)
	SurvivalShelterChooseNpcListModel.instance:setSelectPos(nil)
	arg_11_0:_refreshNpcSelectPanel()
end

function var_0_0._btncollectionCloseOnClick(arg_12_0)
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)
	SurvivalShelterChooseEquipListModel.instance:setSelectPos(nil)
	arg_12_0:_refreshEquipSelectPanel()
end

function var_0_0._btnfilterOnClick(arg_13_0)
	return
end

function var_0_0._btnCloseOnClick(arg_14_0)
	arg_14_0:sendSurvivalChooseBooty(true)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0.goNpcInfoRoot = gohelper.findChild(arg_15_0.viewGO, "Panel/#go_npcselect/go_manageinfo")
	arg_15_0.goFilter = gohelper.findChild(arg_15_0.viewGO, "Panel/#go_npcselect/#btn_npc_filter")
	arg_15_0._allNpcPosItem = arg_15_0:getUserDataTb_()

	for iter_15_0 = 1, var_0_1 do
		local var_15_0 = arg_15_0["_goreward" .. iter_15_0]
		local var_15_1 = arg_15_0:getUserDataTb_()

		var_15_1.index = iter_15_0
		var_15_1.npcId = nil
		var_15_1.empty = gohelper.findChild(var_15_0, "empty")
		var_15_1.has = gohelper.findChild(var_15_0, "has")
		var_15_1.btnAdd = gohelper.findChildButtonWithAudio(var_15_0, "empty/btn_add")
		var_15_1.btnSwitch = gohelper.findChildButtonWithAudio(var_15_0, "has/btn_switch")
		var_15_1.simage = gohelper.findChildSingleImage(var_15_0, "has/go_icon/image")
		var_15_1.goSelect = gohelper.findChild(var_15_0, "#go_Selected")

		var_15_1.btnAdd:AddClickListener(arg_15_0._setNpcSelectPos, arg_15_0, var_15_1.index)
		var_15_1.btnSwitch:AddClickListener(arg_15_0._setNpcSelectPos, arg_15_0, var_15_1.index)
		gohelper.setActive(var_15_1.goSelect, false)
		table.insert(arg_15_0._allNpcPosItem, var_15_1)
	end

	local var_15_2 = arg_15_0.viewContainer._viewSetting.otherRes.equipInfoView
	local var_15_3 = arg_15_0:getResInst(var_15_2, arg_15_0._goinfoview)

	arg_15_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_3, SurvivalShowBagInfoPart)

	local var_15_4 = arg_15_0.viewContainer._viewSetting.otherRes.equipItemView

	arg_15_0._equipItem = arg_15_0:getResInst(var_15_4, arg_15_0.viewGO)

	gohelper.setActive(arg_15_0._equipItem, false)

	arg_15_0._equipHasGo = gohelper.findChild(arg_15_0.viewGO, "Panel/Left/#go_reward/has")
	arg_15_0._equipEmptyGo = gohelper.findChild(arg_15_0.viewGO, "Panel/Left/#go_reward/empty")

	local var_15_5 = gohelper.findChild(arg_15_0._equipHasGo, "go_icon")
	local var_15_6 = arg_15_0.viewContainer:getSetting().otherRes.itemRes
	local var_15_7 = arg_15_0.viewContainer:getResInst(var_15_6, var_15_5)

	arg_15_0._equipSelectedItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_7, SurvivalBagItem)
	arg_15_0._goscroll = gohelper.findChild(arg_15_0.viewGO, "Panel/#go_collectionselect/scroll_collection")
	arg_15_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_15_0._goscroll, SurvivalSimpleListPart)

	arg_15_0._simpleList:setCellUpdateCallBack(arg_15_0._createEquipItem, arg_15_0, SurvivalChooseBagItem, arg_15_0._equipItem)

	arg_15_0._npcCloseClick = gohelper.findChildClickWithAudio(arg_15_0.viewGO, "Panel/#go_npcselect/Mask")
	arg_15_0._collectionCloseClick = gohelper.findChildClickWithAudio(arg_15_0.viewGO, "Panel/#go_collectionselect/Mask")

	arg_15_0._npcCloseClick:AddClickListener(arg_15_0._btnnpcSelectCloseOnClick, arg_15_0)
	arg_15_0._collectionCloseClick:AddClickListener(arg_15_0._btncollectionCloseOnClick, arg_15_0)
end

function var_0_0._setNpcSelectPos(arg_16_0, arg_16_1)
	if #SurvivalShelterChooseNpcListModel.instance:getShowList() <= 0 then
		-- block empty
	end

	SurvivalShelterChooseNpcListModel.instance:setSelectPos(arg_16_1)
	arg_16_0:refreshSelectPanel()
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:clearSelect()
	arg_18_0:refreshFilter()
	arg_18_0:refreshEquipFilter()
	arg_18_0:refreshSelectPanel()

	arg_18_0._isSendSurvivalChoose = false

	arg_18_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnSelectFinish, arg_18_0.refreshSelectPanel, arg_18_0)
	arg_18_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnSetNpcSelectPos, arg_18_0._setNpcSelectPos, arg_18_0)
end

function var_0_0.refreshSelectPanel(arg_19_0)
	arg_19_0:_refreshNpcSelectPanel()
	arg_19_0:_refreshEquipSelectPanel()
end

function var_0_0._refreshNpcSelectPanel(arg_20_0)
	local var_20_0 = SurvivalShelterChooseNpcListModel.instance:getSelectPos() and true or false

	gohelper.setActive(arg_20_0._gonpcselect, var_20_0)
	arg_20_0:refreshSelectInfo()

	if not var_20_0 then
		return
	end

	arg_20_0:refreshNpcInfoView()
	arg_20_0:refreshQuickSelect()
	SurvivalShelterChooseNpcListModel.instance:refreshNpcList(arg_20_0._filterList)

	local var_20_1 = #SurvivalShelterChooseNpcListModel.instance:getList() == 0

	gohelper.setActive(arg_20_0._scrollList, not var_20_1)
	gohelper.setActive(arg_20_0._goempty, var_20_1)
end

function var_0_0.refreshSelectInfo(arg_21_0)
	local var_21_0 = SurvivalShelterChooseNpcListModel.instance:getSelectPos()

	for iter_21_0 = 1, var_0_1 do
		local var_21_1 = arg_21_0._allNpcPosItem[iter_21_0]
		local var_21_2 = SurvivalShelterChooseNpcListModel.instance:getSelectNpcByPos(iter_21_0)
		local var_21_3 = var_21_2 == nil

		if var_21_1 ~= nil then
			gohelper.setActive(var_21_1.empty, var_21_3)
			gohelper.setActive(var_21_1.has, not var_21_3)
			gohelper.setActive(var_21_1.goSelect, var_21_0 == iter_21_0)

			if not var_21_3 and (var_21_1.npcId == nil or var_21_1.npcId ~= var_21_2) then
				local var_21_4 = SurvivalConfig.instance:getNpcConfig(var_21_2)

				if var_21_4 and not string.nilorempty(var_21_4.smallIcon) then
					local var_21_5 = ResUrl.getSurvivalNpcIcon(var_21_4.smallIcon)

					var_21_1.simage:LoadImage(var_21_5)
				end

				var_21_1.npcId = var_21_2
			end
		end
	end
end

function var_0_0.refreshFilter(arg_22_0)
	arg_22_0:_setFilterCb(false)

	local var_22_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_22_0.goFilter, SurvivalFilterPart)
	local var_22_1 = {}
	local var_22_2 = lua_survival_tag_type.configList

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		table.insert(var_22_1, {
			desc = iter_22_1.name,
			type = iter_22_1.id
		})
	end

	var_22_0:setOptionChangeCallback(arg_22_0._onFilterChange, arg_22_0)
	var_22_0:setOptions(var_22_1)
	var_22_0:setClickCb(arg_22_0._setFilterCb, arg_22_0)
end

function var_0_0._setFilterCb(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._gonpcNormal, not arg_23_1)
	gohelper.setActive(arg_23_0._gonpcSelect, arg_23_1)
end

function var_0_0._onFilterChange(arg_24_0, arg_24_1)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpc(nil)

	arg_24_0._filterList = arg_24_1

	arg_24_0:refreshSelectPanel()
end

local var_0_3

function var_0_0.refreshNpcInfoView(arg_25_0)
	local var_25_0 = SurvivalShelterChooseNpcListModel.instance:getSelectNpc()

	if not var_25_0 or var_25_0 == 0 then
		gohelper.setActive(arg_25_0.goNpcInfoRoot, false)

		return
	end

	if arg_25_0.goNpcInfoRoot.activeSelf and (var_0_3 == nil or var_0_3 == var_25_0) then
		gohelper.setActive(arg_25_0.goNpcInfoRoot, false)

		return
	end

	var_0_3 = var_25_0

	gohelper.setActive(arg_25_0.goNpcInfoRoot, true)

	if not arg_25_0.npcInfoView then
		local var_25_1 = arg_25_0.viewContainer:getRes(arg_25_0.viewContainer:getSetting().otherRes.infoView)

		arg_25_0.npcInfoView = ShelterManagerInfoView.getView(var_25_1, arg_25_0.goNpcInfoRoot, "infoView")
	end

	local var_25_2 = {
		showType = SurvivalEnum.InfoShowType.NpcOnlyConfig,
		showId = var_25_0
	}

	var_25_2.showSelect = true
	var_25_2.showUnSelect = true

	arg_25_0.npcInfoView:refreshParam(var_25_2)
end

function var_0_0.refreshQuickSelect(arg_26_0)
	local var_26_0 = not SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	ZProj.UGUIHelper.SetGrayscale(arg_26_0._btnnpcSelect.gameObject, var_26_0)
end

function var_0_0._selectEquip(arg_27_0)
	if #SurvivalShelterChooseEquipListModel.instance:getShowList() <= 0 then
		-- block empty
	end

	SurvivalShelterChooseEquipListModel.instance:setSelectPos(var_0_2)
	arg_27_0:refreshSelectPanel()
end

function var_0_0._refreshEquipSelectPanel(arg_28_0)
	local var_28_0 = SurvivalShelterChooseEquipListModel.instance:getSelectPos() and true or false

	gohelper.setActive(arg_28_0._gocollectionselect, var_28_0)
	arg_28_0:refreshEquipSelectInfo()

	if not var_28_0 then
		return
	end

	SurvivalShelterChooseEquipListModel.instance:refreshList(arg_28_0._equipFilterList)
	arg_28_0._simpleList:setList(SurvivalShelterChooseEquipListModel.instance:getList())
	arg_28_0:refreshEquipInfoView()
end

function var_0_0.refreshEquipSelectInfo(arg_29_0)
	local var_29_0 = SurvivalShelterChooseEquipListModel.instance:getSelectIdByPos(var_0_2)
	local var_29_1 = var_29_0 == nil

	gohelper.setActive(arg_29_0._equipEmptyGo, var_29_1)
	gohelper.setActive(arg_29_0._equipHasGo, not var_29_1)

	if not var_29_1 then
		local var_29_2 = SurvivalBagItemMo.New()

		var_29_2:init({
			count = 1,
			id = var_29_0
		})
		arg_29_0._equipSelectedItem:updateMo(var_29_2)
		arg_29_0._equipSelectedItem:setShowNum(false)
		arg_29_0._equipSelectedItem:setItemSize(180, 180)
	end
end

function var_0_0._createEquipItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_1:updateMo(arg_30_2)
	arg_30_1:setClickCallback(arg_30_0._onEquipItemClick, arg_30_0)

	local var_30_0 = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if arg_30_1:getEquipId() == var_30_0 then
		arg_30_1:setIsSelect(true)
	end
end

function var_0_0._onEquipItemClick(arg_31_0)
	arg_31_0:_refreshEquipSelectPanel()
end

local var_0_4

function var_0_0.refreshEquipInfoView(arg_32_0)
	local var_32_0 = SurvivalShelterChooseEquipListModel.instance:getSelectEquip()

	if not var_32_0 or var_32_0 == 0 then
		gohelper.setActive(arg_32_0._goinfoview, false)

		return
	end

	if arg_32_0._goinfoview.activeSelf and (var_0_4 == nil or var_0_4 == var_32_0) then
		gohelper.setActive(arg_32_0._goinfoview, false)

		return
	end

	var_0_4 = var_32_0

	gohelper.setActive(arg_32_0._goinfoview, true)

	local var_32_1 = SurvivalBagItemMo.New()

	var_32_1:init({
		id = var_32_0
	})
	arg_32_0._infoPanel:updateMo(var_32_1)
end

function var_0_0.refreshEquipFilter(arg_33_0)
	arg_33_0:_setEquipFilterCb(false)

	local var_33_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_33_0._btnfilter.gameObject, SurvivalFilterPart)
	local var_33_1 = {}
	local var_33_2 = lua_survival_equip_found.configList

	for iter_33_0, iter_33_1 in ipairs(var_33_2) do
		table.insert(var_33_1, {
			desc = iter_33_1.name,
			type = iter_33_1.id
		})
	end

	var_33_0:setOptionChangeCallback(arg_33_0._onEquipFilterChange, arg_33_0)
	var_33_0:setOptions(var_33_1)
	var_33_0:setClickCb(arg_33_0._setEquipFilterCb, arg_33_0)
end

function var_0_0._setEquipFilterCb(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._gocollectionFilterNormal, not arg_34_1)
	gohelper.setActive(arg_34_0._gocollectionFilterSelect, arg_34_1)
end

function var_0_0._onEquipFilterChange(arg_35_0, arg_35_1)
	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(nil)

	arg_35_0._equipFilterList = arg_35_1

	arg_35_0:refreshSelectPanel()
end

function var_0_0.clearSelect(arg_36_0)
	arg_36_0._selectNpcList = {}
	arg_36_0._selectEquipList = {}
end

function var_0_0.sendSurvivalChooseBooty(arg_37_0, arg_37_1)
	arg_37_0._isSendSurvivalChoose = true

	if arg_37_1 then
		arg_37_0:clearSelect()
	else
		arg_37_0._selectNpcList = SurvivalShelterChooseNpcListModel.instance:getAllSelectPosNpc()
		arg_37_0._selectEquipList = SurvivalShelterChooseEquipListModel.instance:getAllSelectPosEquip()
	end

	SurvivalWeekRpc.instance:sendSurvivalChooseBooty(arg_37_0._selectNpcList, arg_37_0._selectEquipList, arg_37_0._selectFinish, arg_37_0)
end

function var_0_0._selectFinish(arg_38_0)
	arg_38_0:closeThis()

	local var_38_0 = GameSceneMgr.instance:getCurSceneType()

	if var_38_0 == SceneType.SurvivalShelter or var_38_0 == SceneType.Fight then
		SurvivalController.instance:exitMap()
	end

	SurvivalShelterChooseNpcListModel.instance:setNeedSelectNpcList()
	SurvivalShelterChooseEquipListModel.instance:setNeedSelectEquipList()
end

function var_0_0.onClose(arg_39_0)
	if not arg_39_0._isSendSurvivalChoose then
		arg_39_0:sendSurvivalChooseBooty(true)
	end
end

function var_0_0.onDestroyView(arg_40_0)
	if arg_40_0._npcCloseClick then
		arg_40_0._npcCloseClick:RemoveClickListener()

		arg_40_0._npcCloseClick = nil
	end

	if arg_40_0._collectionCloseClick then
		arg_40_0._collectionCloseClick:RemoveClickListener()

		arg_40_0._collectionCloseClick = nil
	end

	for iter_40_0 = 1, var_0_1 do
		local var_40_0 = arg_40_0._allNpcPosItem[iter_40_0]

		if var_40_0 ~= nil then
			var_40_0.btnAdd:RemoveClickListener()
			var_40_0.btnSwitch:RemoveClickListener()

			local var_40_1
		end
	end
end

return var_0_0
