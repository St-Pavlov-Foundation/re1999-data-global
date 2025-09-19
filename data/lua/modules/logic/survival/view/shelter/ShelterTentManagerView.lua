module("modules.logic.survival.view.shelter.ShelterTentManagerView", package.seeall)

local var_0_0 = class("ShelterTentManagerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goTentScroll = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_TentList")
	arg_1_0.goTentContent = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content")
	arg_1_0.goBigItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content/#go_BigItem")
	arg_1_0.goSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_TentList/Viewport/Content/#go_item")

	gohelper.setActive(arg_1_0.goBigItem, false)
	gohelper.setActive(arg_1_0.goSmallItem, false)

	arg_1_0.itemList = {}
	arg_1_0.goSelectPanel = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_SelectPanel")
	arg_1_0.selectPanelCanvasGroup = gohelper.onceAddComponent(arg_1_0.goSelectPanel, typeof(UnityEngine.CanvasGroup))
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.goSelectPanel, "#btn_Close")
	arg_1_0.btnSelect = gohelper.findChildButtonWithAudio(arg_1_0.goSelectPanel, "#btn_Select")
	arg_1_0.goFilter = gohelper.findChild(arg_1_0.goSelectPanel, "#btn_filter")
	arg_1_0.goNpcInfoRoot = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_SelectPanel/go_manageinfo")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.isNpcPanelVisible = false

	gohelper.setActive(arg_1_0.goSelectPanel, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSelect, arg_2_0.onClickBtnSelect, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_2_0.onBuildingInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_2_0.onNpcPostionChange, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnSelect)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_3_0.onNpcPostionChange, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
end

function var_0_0.onShelterBagUpdate(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0.onBuildingInfoUpdate(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onNpcPostionChange(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onClickBtnSelect(arg_7_0)
	SurvivalShelterTentListModel.instance:changeQuickSelect()

	if SurvivalShelterTentListModel.instance:isQuickSelect() then
		SurvivalShelterTentListModel.instance:setSelectNpc(0)
	end

	arg_7_0:refreshSelectPanel()
end

function var_0_0.onClickBtnClose(arg_8_0)
	SurvivalShelterTentListModel.instance:setSelectPos()
	arg_8_0:refreshSelectPanel()
end

function var_0_0.onClickBigItem(arg_9_0, arg_9_1)
	if not arg_9_1.data then
		return
	end

	local var_9_0 = arg_9_1.data.buildingInfo

	if SurvivalShelterTentListModel.instance:setSelectBuildingId(var_9_0.id) then
		arg_9_0:refreshView()
	end
end

function var_0_0.onClickSmallItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.parentItem.data.buildingInfo
	local var_10_1 = SurvivalShelterTentListModel.instance:setSelectBuildingId(var_10_0.id)
	local var_10_2 = false

	if not var_10_1 then
		local var_10_3 = arg_10_1.index - 1

		var_10_2 = SurvivalShelterTentListModel.instance:setSelectPos(var_10_3)
	end

	if var_10_2 or var_10_1 then
		arg_10_0:refreshView()
	end
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	SurvivalShelterTentListModel.instance:initViewParam(arg_11_0.viewParam)
	arg_11_0:refreshFilter()
	arg_11_0:refreshView()
	arg_11_0:foucsTent()
end

function var_0_0.foucsTent(arg_12_0)
	local var_12_0 = SurvivalShelterTentListModel.instance:getSelectBuilding()

	if var_12_0 == 0 then
		return
	end

	local var_12_1
	local var_12_2 = #arg_12_0.tentDataList

	for iter_12_0 = 1, var_12_2 do
		if arg_12_0.tentDataList[iter_12_0].buildingInfo.id == var_12_0 then
			var_12_1 = iter_12_0

			break
		end
	end

	if var_12_1 then
		local var_12_3 = 380 * var_12_2 - recthelper.getHeight(arg_12_0.goTentScroll.transform)
		local var_12_4 = math.max(0, var_12_3)
		local var_12_5 = (var_12_1 - 1) * 380

		recthelper.setAnchorY(arg_12_0.goTentContent.transform, math.min(var_12_4, var_12_5))
	end
end

function var_0_0.refreshView(arg_13_0)
	arg_13_0:refreshTentList()
	arg_13_0:refreshInfoView()
	arg_13_0:refreshSelectPanel()
end

function var_0_0.refreshTentList(arg_14_0)
	local var_14_0 = SurvivalShelterTentListModel.instance:getShowList()

	for iter_14_0 = 1, math.max(#arg_14_0.itemList, #var_14_0) do
		local var_14_1 = arg_14_0:getBigItem(iter_14_0)

		arg_14_0:refreshBigItem(var_14_1, var_14_0[iter_14_0])
	end

	arg_14_0.tentDataList = var_14_0
end

function var_0_0.getBigItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.itemList[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.index = arg_15_1
		var_15_0.go = gohelper.cloneInPlace(arg_15_0.goBigItem, tostring(arg_15_1))
		var_15_0.txtName = gohelper.findChildTextMesh(var_15_0.go, "Title/Layout/#txt_Tent")
		var_15_0.txtLevel = gohelper.findChildTextMesh(var_15_0.go, "Title/Layout/#txt_Lv")
		var_15_0.txtNpcCount = gohelper.findChildTextMesh(var_15_0.go, "Title/Layout/#txt_MemberNum")
		var_15_0.scroll = gohelper.findChildComponent(var_15_0.go, "Scroll View", typeof(ZProj.LimitedScrollRect))
		var_15_0.scroll.parentGameObject = arg_15_0.goTentScroll
		var_15_0.goGrid = gohelper.findChild(var_15_0.go, "Scroll View/Viewport/#go_content")
		var_15_0.goDestoryed = gohelper.findChild(var_15_0.go, "#go_Destoryed")
		var_15_0.goLocked = gohelper.findChild(var_15_0.go, "#go_Locked")
		var_15_0.txtLocked = gohelper.findChildTextMesh(var_15_0.go, "#go_Locked/#txt_Locked")
		var_15_0.goSelected = gohelper.findChild(var_15_0.go, "#go_Selected")
		var_15_0.goSelectFrame1 = gohelper.findChild(var_15_0.go, "#go_Selected/image_Frame1")
		var_15_0.goSelectFrame2 = gohelper.findChild(var_15_0.go, "#go_Selected/image_Frame2")
		var_15_0.smallItemList = {}
		var_15_0.btn = gohelper.findChildButtonWithAudio(var_15_0.go, "Scroll View/Viewport")

		var_15_0.btn:AddClickListener(arg_15_0.onClickBigItem, arg_15_0, var_15_0)

		arg_15_0.itemList[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.refreshBigItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1.data = arg_16_2

	if not arg_16_2 then
		gohelper.setActive(arg_16_1.go, false)

		return
	end

	gohelper.setActive(arg_16_1.go, true)

	local var_16_0 = arg_16_2.buildingInfo
	local var_16_1 = var_16_0.level == 0
	local var_16_2 = var_16_0.status == SurvivalEnum.BuildingStatus.Destroy

	gohelper.setActive(arg_16_1.goLocked, var_16_1)

	if var_16_1 then
		local var_16_3, var_16_4 = SurvivalShelterModel.instance:getWeekInfo():isBuildingUnlock(var_16_0.buildingId, 1, true)

		if var_16_3 then
			arg_16_1.txtLocked.text = luaLang("survivalbuildingmanageview_unbuild_txt")
		else
			arg_16_1.txtLocked.text = var_16_4
		end
	end

	gohelper.setActive(arg_16_1.goDestoryed, var_16_2)

	local var_16_5 = SurvivalShelterTentListModel.instance:isSelectBuilding(var_16_0.id)

	gohelper.setActive(arg_16_1.goSelected, var_16_5)

	if var_16_5 then
		gohelper.setActive(arg_16_1.goSelectFrame1, not var_16_2)
		gohelper.setActive(arg_16_1.goSelectFrame2, var_16_2)
	end

	arg_16_1.txtName.text = var_16_0.baseCo.name

	if var_16_1 then
		arg_16_1.txtLevel.text = ""
	else
		arg_16_1.txtLevel.text = string.format("Lv.%s", var_16_0.level)
	end

	arg_16_1.txtNpcCount.text = string.format("%s/%s", arg_16_2.npcNum, arg_16_2.npcCount)

	for iter_16_0 = 1, math.max(#arg_16_1.smallItemList, arg_16_2.npcCount) do
		local var_16_6 = arg_16_0:getSmallItem(arg_16_1, iter_16_0)

		arg_16_0:refreshSmallItem(var_16_6, arg_16_2.npcList[iter_16_0 - 1], var_16_1, var_16_2)
	end
end

function var_0_0.getSmallItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.smallItemList[arg_17_2]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.index = arg_17_2
		var_17_0.go = gohelper.clone(arg_17_0.goSmallItem, arg_17_1.goGrid, tostring(arg_17_2))
		var_17_0.goNpc = gohelper.findChild(var_17_0.go, "#go_HaveHero")
		var_17_0.imageNpc = gohelper.findChildImage(var_17_0.go, "#go_HaveHero/#image_Chess")
		var_17_0.txtName = gohelper.findChildTextMesh(var_17_0.go, "#go_HaveHero/#txt_PartnerName")
		var_17_0.goEmpty = gohelper.findChild(var_17_0.go, "#go_Empty")
		var_17_0.goDestoryed = gohelper.findChild(var_17_0.go, "#go_Destoryed")
		var_17_0.goLocked = gohelper.findChild(var_17_0.go, "#go_Locked")
		var_17_0.btn = gohelper.findChildButtonWithAudio(var_17_0.go, "click")

		var_17_0.btn:AddClickListener(arg_17_0.onClickSmallItem, arg_17_0, var_17_0)

		var_17_0.heroAnim = var_17_0.goNpc:GetComponent(gohelper.Type_Animator)
		arg_17_1.smallItemList[arg_17_2] = var_17_0
	end

	var_17_0.parentItem = arg_17_1

	return var_17_0
end

function var_0_0.refreshSmallItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_1.npcId = arg_18_2

	if not arg_18_2 then
		arg_18_1.lastNpcId = arg_18_2

		gohelper.setActive(arg_18_1.go, false)

		return
	end

	gohelper.setActive(arg_18_1.go, true)

	local var_18_0 = arg_18_2 == 0
	local var_18_1 = var_18_0 and arg_18_1.lastNpcId and arg_18_1.lastNpcId ~= 0
	local var_18_2 = not var_18_0 and arg_18_1.lastNpcId ~= arg_18_2

	if var_18_1 then
		gohelper.setActive(arg_18_1.goNpc, true)
		arg_18_1.heroAnim:Play("out", 0, 0)
	elseif var_18_2 then
		gohelper.setActive(arg_18_1.goNpc, true)
		arg_18_1.heroAnim:Play("in", 0, 0)
	else
		gohelper.setActive(arg_18_1.goNpc, not var_18_0 and not arg_18_3 and not arg_18_4)
	end

	gohelper.setActive(arg_18_1.goDestoryed, arg_18_3)
	gohelper.setActive(arg_18_1.goLocked, arg_18_4)
	gohelper.setActive(arg_18_1.goEmpty, var_18_0 and not arg_18_3 and not arg_18_4)

	arg_18_1.lastNpcId = arg_18_2

	if var_18_0 then
		return
	end

	local var_18_3 = SurvivalConfig.instance:getNpcConfig(arg_18_2)

	if var_18_3 then
		arg_18_1.txtName.text = var_18_3.name

		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_18_1.imageNpc, var_18_3.headIcon)
	end
end

function var_0_0.refreshInfoView(arg_19_0)
	if not arg_19_0.infoView then
		local var_19_0 = arg_19_0.viewContainer:getRes(arg_19_0.viewContainer:getSetting().otherRes.infoView)
		local var_19_1 = gohelper.findChild(arg_19_0.viewGO, "Panel/go_manageinfo")

		arg_19_0.infoView = ShelterManagerInfoView.getView(var_19_0, var_19_1, "infoView")
	end

	local var_19_2 = {
		showType = SurvivalEnum.InfoShowType.Building,
		showId = SurvivalShelterTentListModel.instance:getSelectBuilding()
	}

	arg_19_0.infoView:refreshParam(var_19_2)
end

function var_0_0.refreshSelectPanel(arg_20_0)
	local var_20_0 = SurvivalShelterTentListModel.instance:getSelectBuilding()
	local var_20_1 = SurvivalShelterTentListModel.instance:getSelectPos()
	local var_20_2 = var_20_0 and var_20_1 and true or false

	if var_20_2 then
		local var_20_3 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(var_20_0)

		var_20_2 = var_20_3 and var_20_3:isBuild() and true or false
	end

	arg_20_0:setNpcPanelVisible(var_20_2)

	if not var_20_2 then
		return
	end

	arg_20_0:refreshQuickSelect()
	arg_20_0:refreshNpcInfoView()
	SurvivalShelterTentListModel.instance:refreshNpcList(arg_20_0._filterList)
end

function var_0_0.setNpcPanelVisible(arg_21_0, arg_21_1)
	if arg_21_0.isNpcPanelVisible == arg_21_1 then
		return
	end

	arg_21_0.isNpcPanelVisible = arg_21_1

	gohelper.setActive(arg_21_0.goSelectPanel, true)

	if arg_21_1 then
		arg_21_0.animator:Play("panel_in")

		arg_21_0.selectPanelCanvasGroup.interactable = true
		arg_21_0.selectPanelCanvasGroup.blocksRaycasts = true
	else
		arg_21_0.animator:Play("panel_out")

		arg_21_0.selectPanelCanvasGroup.interactable = false
		arg_21_0.selectPanelCanvasGroup.blocksRaycasts = false
	end
end

function var_0_0.refreshFilter(arg_22_0)
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
end

function var_0_0._onFilterChange(arg_23_0, arg_23_1)
	arg_23_0._filterList = arg_23_1

	arg_23_0:refreshView()
end

function var_0_0.refreshQuickSelect(arg_24_0)
	local var_24_0 = not SurvivalShelterTentListModel.instance:isQuickSelect()

	ZProj.UGUIHelper.SetGrayscale(arg_24_0.btnSelect.gameObject, var_24_0)
end

function var_0_0.refreshNpcInfoView(arg_25_0)
	local var_25_0 = SurvivalShelterTentListModel.instance:getSelectNpc()

	if not var_25_0 or var_25_0 == 0 then
		gohelper.setActive(arg_25_0.goNpcInfoRoot, false)

		return
	end

	gohelper.setActive(arg_25_0.goNpcInfoRoot, true)

	if not arg_25_0.npcInfoView then
		local var_25_1 = arg_25_0.viewContainer:getRes(arg_25_0.viewContainer:getSetting().otherRes.infoView)

		arg_25_0.npcInfoView = ShelterManagerInfoView.getView(var_25_1, arg_25_0.goNpcInfoRoot, "infoView")
	end

	local var_25_2 = {
		showType = SurvivalEnum.InfoShowType.Npc,
		showId = var_25_0,
		otherParam = {
			tentBuildingId = SurvivalShelterTentListModel.instance:getSelectBuilding(),
			tentBuildingPos = SurvivalShelterTentListModel.instance:getSelectPos()
		}
	}

	arg_25_0.npcInfoView:refreshParam(var_25_2)
end

function var_0_0.onDestroyView(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.itemList) do
		iter_26_1.btn:RemoveClickListener()

		for iter_26_2, iter_26_3 in pairs(iter_26_1.smallItemList) do
			iter_26_3.btn:RemoveClickListener()
		end
	end
end

return var_0_0
