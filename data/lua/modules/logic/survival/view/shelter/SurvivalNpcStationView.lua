module("modules.logic.survival.view.shelter.SurvivalNpcStationView", package.seeall)

local var_0_0 = class("SurvivalNpcStationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/#simage_PanelBG2")
	arg_1_0._txttitledec = gohelper.findChildText(arg_1_0.viewGO, "Panel/Left/#txt_titledec")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#txt_dec")
	arg_1_0._scrolltag = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem")
	arg_1_0._imageType = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#image_Type")
	arg_1_0._txtType = gohelper.findChildText(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#txt_Type")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/Buff/Viewport/Content/#go_buffitem/#scroll_tag/viewport/content/#go_tagitem/#btn_click")
	arg_1_0._goNpcitem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Npc/layout/#go_Npcitem")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_empty")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_has")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/Npc/layout/#go_Npcitem/#go_has/#simage_hero")
	arg_1_0._scrollList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/Right/#scroll_List")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item")
	arg_1_0._goSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#image_Chess")
	arg_1_0._txtPartnerName = gohelper.findChildText(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#txt_PartnerName")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#go_Selected")
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_List/Viewport/Content/#go_Item/#go_SmallItem/#go_recommend")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/Btns/#btn_Next")
	arg_1_0._goNextLock = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/Btns/#go_NextLock")
	arg_1_0._btnCancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/Btns/#btn_Cancel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
	arg_2_0._btnCancel:AddClickListener(arg_2_0._btnCancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
	arg_3_0._btnCancel:RemoveClickListener()
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._btnclickOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnNextOnClick(arg_6_0)
	if not arg_6_0._fight:canSelectNpc() then
		GameFacade.showToast(ToastEnum.SurvivalBossDotSelectNpc)

		return
	end

	local var_6_0 = #SurvivalShelterNpcMonsterListModel.instance:getSelectList()
	local var_6_1 = false
	local var_6_2 = arg_6_0._fight.schemes

	for iter_6_0, iter_6_1 in pairs(var_6_2) do
		if SurvivalShelterMonsterModel.instance:calBuffIsRepress(iter_6_0) then
			var_6_1 = true
		end
	end

	if var_6_0 > 0 and not var_6_1 then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalSelectNpcNotRecommend, MsgBoxEnum.BoxType.Yes_No, arg_6_0._sendSelectNpc, nil, nil, arg_6_0, nil, nil)

		return
	else
		arg_6_0:_sendSelectNpc()
	end
end

function var_0_0._sendSelectNpc(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnCancelOnClick(arg_8_0)
	SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(arg_8_0._enterSelect)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._gobuffitem, false)
	gohelper.setActive(arg_9_0._goNpcitem, false)

	arg_9_0._nextUIEffect = var_0_1.Get(arg_9_0._btnNext.gameObject)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._enterSelect = SurvivalShelterNpcMonsterListModel.instance:getSelectList()
	arg_11_0._fight = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	arg_11_0:refreshView()
end

function var_0_0.refreshView(arg_12_0)
	SurvivalShelterNpcMonsterListModel.instance:refreshList()
	arg_12_0:_refreshSchemes()
	arg_12_0:_updateNpcInfo()

	local var_12_0 = arg_12_0._fight:canSelectNpc()

	if arg_12_0._nextUIEffect then
		arg_12_0._nextUIEffect:SetGray(not var_12_0)
	end
end

function var_0_0._refreshSchemes(arg_13_0)
	local var_13_0 = arg_13_0._fight.schemes

	if arg_13_0._schemesItems == nil then
		arg_13_0._schemesItems = arg_13_0:getUserDataTb_()
	end

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = arg_13_0._schemesItems[iter_13_0]

		if var_13_1 == nil then
			local var_13_2 = gohelper.cloneInPlace(arg_13_0._gobuffitem)

			var_13_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, SurvivalMonsterEventSelectBuffItem)

			var_13_1:initItem(iter_13_0)

			arg_13_0._schemesItems[iter_13_0] = var_13_1

			gohelper.setActive(var_13_2, true)
		end

		var_13_1:updateItem()
	end
end

function var_0_0._updateNpcInfo(arg_14_0)
	local var_14_0 = SurvivalShelterNpcMonsterListModel.instance:getSelectList()

	if var_14_0 == nil then
		return
	end

	if arg_14_0._smallNpcItems == nil then
		arg_14_0._smallNpcItems = arg_14_0:getUserDataTb_()
	end

	local var_14_1 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.ShelterMonsterSelectNpcMax)
	local var_14_2 = var_14_1 and tonumber(var_14_1) or 0

	for iter_14_0 = 1, var_14_2 do
		local var_14_3 = arg_14_0._smallNpcItems[iter_14_0]
		local var_14_4 = var_14_0[iter_14_0]

		if var_14_3 == nil then
			local var_14_5 = gohelper.cloneInPlace(arg_14_0._goNpcitem)

			var_14_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_5, SurvivalMonsterEventSmallNpcItem)

			gohelper.setActive(var_14_5, true)
			table.insert(arg_14_0._smallNpcItems, var_14_3)
		end

		var_14_3:setNeedShowEmpty(true)
		var_14_3:updateItem(var_14_4)
	end
end

function var_0_0.onClose(arg_15_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
