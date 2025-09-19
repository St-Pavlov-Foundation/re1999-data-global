module("modules.logic.survival.view.SurvivalTalentView", package.seeall)

local var_0_0 = class("SurvivalTalentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnoverview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Overview")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "#go_infoview")
	arg_1_0._gotypeitem = gohelper.findChild(arg_1_0.viewGO, "Left/Types/item")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection/Viewport/Content")
	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "Left/Table")
	arg_1_0._btnequipAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_onekeyEquip")
	arg_1_0._btnunequipAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_onekeyUnEquip")
	arg_1_0._btntalenticon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/Table/Middle/#btn_click")
	arg_1_0._imageBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/Table/#simage_Table")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._animskill = gohelper.findChildAnim(arg_1_0.viewGO, "Left/Table/Middle")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntalenticon:AddClickListener(arg_2_0._onClickOverView, arg_2_0)
	arg_2_0._btnoverview:AddClickListener(arg_2_0._onClickOverView, arg_2_0)
	arg_2_0._btnequipAll:AddClickListener(arg_2_0._onClickEquipAll, arg_2_0)
	arg_2_0._btnunequipAll:AddClickListener(arg_2_0._onClickUnEquipAll, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_2_0.refreshViewByServer, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gocontent, arg_2_0._beginDrag, arg_2_0._onDrag, arg_2_0._endDrag, nil, arg_2_0, nil, true)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntalenticon:RemoveClickListener()
	arg_3_0._btnoverview:RemoveClickListener()
	arg_3_0._btnequipAll:RemoveClickListener()
	arg_3_0._btnunequipAll:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentGroupBoxUpdate, arg_3_0.refreshViewByServer, arg_3_0)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gocontent)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0.onViewClose, arg_3_0)
end

function var_0_0._onClickOverView(arg_4_0)
	if not arg_4_0._talentCo then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalTalentOverView, {
		talentCo = arg_4_0._talentCo
	})
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._talentGroupList = SurvivalConfig.instance:getAllTalentGroupCos()

	if #arg_5_0._talentGroupList == 0 then
		logError("没有天赋分支配置")

		return
	end

	arg_5_0._outSideMo = SurvivalModel.instance:getOutSideInfo()

	local var_5_0 = arg_5_0.viewContainer._viewSetting.otherRes.infoView
	local var_5_1 = arg_5_0:getResInst(var_5_0, arg_5_0._goinfoview)

	arg_5_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_1, SurvivalTalentInfoPart)

	arg_5_0._infoPanel:setClickCallback(arg_5_0._onClickCloseInfo, arg_5_0)
	arg_5_0._infoPanel:setEquipCallback(arg_5_0._onEquipTalent, arg_5_0)
	arg_5_0:initBagItems()
	arg_5_0:initCenterItems()

	arg_5_0._groupSelects = arg_5_0:getUserDataTb_()
	arg_5_0._groupRed = arg_5_0:getUserDataTb_()

	gohelper.CreateObjList(arg_5_0, arg_5_0._createTalentGroupItem, arg_5_0._talentGroupList, nil, arg_5_0._gotypeitem)
	arg_5_0:onTalentGroupClick(1, true)

	local var_5_2 = arg_5_0._outSideMo.clientData.data.newTalents

	if #var_5_2 > 0 then
		ViewMgr.instance:openView(ViewName.SurvivalTalentGetView, {
			talents = var_5_2
		})

		arg_5_0._outSideMo.clientData.data.newTalents = {}

		arg_5_0._outSideMo.clientData:saveDataToServer()
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_5_0.onViewClose, arg_5_0)
	else
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitTalentViewOpenFinish)
	end
end

function var_0_0.onViewClose(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.SurvivalTalentGetView then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitTalentViewOpenFinish)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0.onViewClose, arg_6_0)
	end
end

function var_0_0.initBagItems(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer._viewSetting.otherRes.itemRes

	arg_7_0._bagItems = {}

	for iter_7_0 = 1, 8 do
		local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._gocontent)

		arg_7_0._bagItems[iter_7_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, SurvivalTalentBagItem)

		arg_7_0._bagItems[iter_7_0]:setClickCallback(arg_7_0._onClickBagItem, arg_7_0)
	end

	local var_7_2 = arg_7_0:getResInst(var_7_0, arg_7_0.viewGO)

	arg_7_0._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_2, SurvivalTalentBagItem)

	gohelper.setActive(arg_7_0._dragItem.go, false)
end

function var_0_0._beginDrag(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0 = 1, 8 do
		if not arg_8_0._bagItems[iter_8_0]:isEmpty() and gohelper.isMouseOverGo(arg_8_0._bagItems[iter_8_0].go, arg_8_2.position) then
			arg_8_0._curPressIndex = iter_8_0

			arg_8_0._dragItem:updateMo(arg_8_0._bagItems[arg_8_0._curPressIndex]._talentCo)
			gohelper.setActive(arg_8_0._dragItem.go, true)

			local var_8_0 = recthelper.screenPosToAnchorPos(arg_8_2.position, arg_8_0.viewGO.transform)
			local var_8_1 = arg_8_0._dragItem.go.transform

			recthelper.setAnchor(var_8_1, var_8_0.x, var_8_0.y)

			break
		end
	end
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._curPressIndex then
		local var_9_0 = recthelper.screenPosToAnchorPos(arg_9_2.position, arg_9_0.viewGO.transform)
		local var_9_1 = arg_9_0._dragItem.go.transform
		local var_9_2, var_9_3 = recthelper.getAnchor(var_9_1)

		if math.abs(var_9_2 - var_9_0.x) > 10 or math.abs(var_9_3 - var_9_0.y) > 10 then
			ZProj.TweenHelper.DOAnchorPos(var_9_1, var_9_0.x, var_9_0.y, 0.2)
		else
			recthelper.setAnchor(var_9_1, var_9_0.x, var_9_0.y)
		end

		if gohelper.isMouseOverGo(arg_9_0._gocenter, arg_9_2.position) then
			gohelper.setActive(arg_9_0._golight, true)
		else
			gohelper.setActive(arg_9_0._golight, false)
		end
	end
end

function var_0_0._endDrag(arg_10_0, arg_10_1, arg_10_2)
	gohelper.setActive(arg_10_0._golight, false)

	if arg_10_0._curPressIndex then
		if gohelper.isMouseOverGo(arg_10_0._gocenter, arg_10_2.position) then
			arg_10_0:_onEquipTalent(arg_10_0._bagItems[arg_10_0._curPressIndex]._talentCo, true)
			gohelper.setActive(arg_10_0._goput, false)
			gohelper.setActive(arg_10_0._goput, true)
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_put_1)
		end

		gohelper.setActive(arg_10_0._dragItem.go, false)

		arg_10_0._curPressIndex = nil
	end
end

function var_0_0.initCenterItems(arg_11_0)
	arg_11_0._allItemRoots = {}
	arg_11_0._allItemRootsGo = arg_11_0:getUserDataTb_()
	arg_11_0._allEffectRoot = arg_11_0:getUserDataTb_()
	arg_11_0._allPutEffect = arg_11_0:getUserDataTb_()
	arg_11_0._allLightEffect = arg_11_0:getUserDataTb_()
	arg_11_0._allActiveEffect = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, 4 do
		arg_11_0._allItemRootsGo[iter_11_0] = gohelper.findChild(arg_11_0._gocenter, string.format("Suit_%02d", iter_11_0))
		arg_11_0._allEffectRoot[iter_11_0] = gohelper.findChild(arg_11_0._gocenter, string.format("Middle/#go_TableEffect/%02d", iter_11_0))
		arg_11_0._allPutEffect[iter_11_0] = gohelper.findChild(arg_11_0._gocenter, string.format("Middle/#go_TableEffect/%02d/#put", iter_11_0))
		arg_11_0._allLightEffect[iter_11_0] = gohelper.findChild(arg_11_0._gocenter, string.format("Middle/#go_TableEffect/%02d/#light", iter_11_0))
		arg_11_0._allActiveEffect[iter_11_0] = gohelper.findChild(arg_11_0._gocenter, string.format("Middle/#go_TableEffect/%02d/#active", iter_11_0))

		local var_11_0 = {}

		for iter_11_1 = 1, 8 do
			local var_11_1 = gohelper.findChild(arg_11_0._gocenter, string.format("Suit_%02d/item%d", iter_11_0, iter_11_1))

			var_11_0[iter_11_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, SurvivalTalentItem)

			var_11_0[iter_11_1]:setClickCallback(arg_11_0._onClickCenterItem, arg_11_0)
		end

		arg_11_0._allItemRoots[iter_11_0] = var_11_0
	end
end

function var_0_0._createTalentGroupItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "#txt_Type")
	local var_12_1 = gohelper.findChild(arg_12_1, "#go_select")
	local var_12_2 = gohelper.findChildTextMesh(arg_12_1, "#go_select/#txt_Type")
	local var_12_3 = gohelper.findChildButtonWithAudio(arg_12_1, "#btn_click")
	local var_12_4 = gohelper.findChild(arg_12_1, "#go_red")

	arg_12_0._groupSelects[arg_12_3] = var_12_1
	arg_12_0._groupRed[arg_12_3] = var_12_4

	arg_12_0:addClickCb(var_12_3, arg_12_0.onTalentGroupClick, arg_12_0, arg_12_3)

	var_12_0.text = arg_12_2.name
	var_12_2.text = arg_12_2.name

	gohelper.setActive(var_12_4, not arg_12_0._outSideMo.talentBox:getTalentGroup(arg_12_2.id):isEquipAll())
end

function var_0_0.onTalentGroupClick(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._curIndex == arg_13_1 then
		return
	end

	arg_13_0._curIndex = arg_13_1
	arg_13_0._centerItems = arg_13_0._allItemRoots[arg_13_1]
	arg_13_0._goput = arg_13_0._allPutEffect[arg_13_1]

	gohelper.setActive(arg_13_0._goput, false)

	arg_13_0._golight = arg_13_0._allLightEffect[arg_13_1]
	arg_13_0._goactive = arg_13_0._allActiveEffect[arg_13_1]

	for iter_13_0, iter_13_1 in pairs(arg_13_0._groupSelects) do
		gohelper.setActive(iter_13_1, iter_13_0 == arg_13_1)
	end

	arg_13_0._talentCo = arg_13_0._talentGroupList[arg_13_1]

	if arg_13_2 then
		arg_13_0:refreshView()
	else
		arg_13_0._anim:Play("switch", 0, 0)
		TaskDispatcher.runDelay(arg_13_0.refreshView, arg_13_0, 0.167)
		UIBlockHelper.instance:startBlock("SurvivalTalentView_swicth", 0.167)
	end
end

function var_0_0.refreshViewByServer(arg_14_0)
	arg_14_0:refreshView(true)
end

function var_0_0.refreshView(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._allEffectRoot) do
		gohelper.setActive(iter_15_1, iter_15_0 == arg_15_0._curIndex)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0._allItemRootsGo) do
		gohelper.setActive(iter_15_3, iter_15_2 == arg_15_0._curIndex)
	end

	arg_15_0._imageBg:LoadImage(ResUrl.getSurvivalTalentIcon(arg_15_0._talentCo.folder .. "/img_di_5"))

	arg_15_0._talentGroupMo = arg_15_0._outSideMo.talentBox:getTalentGroup(arg_15_0._talentCo.id)

	local var_15_0 = arg_15_0._talentGroupMo:getTalentCos()

	for iter_15_4 = 1, 8 do
		local var_15_1 = var_15_0[iter_15_4]
		local var_15_2 = var_15_1 and var_15_1.id
		local var_15_3 = arg_15_0._talentGroupMo:isTalentUnlock(var_15_2)
		local var_15_4 = arg_15_0._talentGroupMo.talents[var_15_2]

		arg_15_0._bagItems[iter_15_4]:updateMo(var_15_3 and not var_15_4 and var_15_1)
		arg_15_0._centerItems[iter_15_4]:updateMo(var_15_3 and var_15_4 and var_15_1, arg_15_1)
	end

	arg_15_0._infoPanel:updateMo()

	local var_15_5 = tabletool.len(arg_15_0._talentGroupMo.talents)

	if var_15_5 > 0 then
		gohelper.setActive(arg_15_0._goactive, true)
	else
		gohelper.setActive(arg_15_0._goactive, false)
	end

	local var_15_6 = SurvivalConfig.instance.talentCollectCos[arg_15_0._talentCo.id] or {}
	local var_15_7 = 0

	for iter_15_5, iter_15_6 in ipairs(var_15_6) do
		if var_15_5 >= iter_15_6.num then
			var_15_7 = iter_15_5
		end
	end

	if arg_15_1 and arg_15_0._preLv then
		if arg_15_0._preLv ~= var_15_7 and var_15_5 > 0 then
			if var_15_7 < arg_15_0._preLv then
				arg_15_0._animskill:Play("talent_leveldown", 0, 0)
			else
				arg_15_0._animskill:Play("talent_levelup", 0, 0)
			end
		elseif arg_15_0._preHave ~= (var_15_5 > 0) then
			if arg_15_0._preHave then
				arg_15_0._animskill:Play("card_out", 0, 0)
			else
				arg_15_0._animskill:Play("card_in", 0, 0)
			end
		end
	end

	arg_15_0._preLv = var_15_7
	arg_15_0._preHave = var_15_5 > 0

	if not arg_15_1 then
		if var_15_5 > 0 then
			arg_15_0._animskill:Play("card_in", 0, 1)
		else
			arg_15_0._animskill:Play("card_out", 0, 1)
		end
	end

	gohelper.setActive(arg_15_0._groupRed[arg_15_0._curIndex], not arg_15_0._talentGroupMo:isEquipAll())
end

function var_0_0._onClickCloseInfo(arg_16_0)
	if arg_16_0._curItem then
		arg_16_0._curItem:setIsSelect(false)
	end

	arg_16_0._infoPanel:updateMo()
end

function var_0_0._onEquipTalent(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0 in pairs(arg_17_0._talentGroupMo.talents) do
		table.insert(var_17_0, iter_17_0)
	end

	if arg_17_2 then
		table.insert(var_17_0, arg_17_1.id)
	else
		tabletool.removeValue(var_17_0, arg_17_1.id)
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideAlterTalentGroup(arg_17_0._talentGroupMo.groupId, var_17_0)
end

function var_0_0._onClickEquipAll(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = arg_18_0._talentGroupMo:getTalentCos()

	for iter_18_0 = 1, 8 do
		local var_18_2 = var_18_1[iter_18_0]
		local var_18_3 = var_18_2 and var_18_2.id

		if arg_18_0._talentGroupMo:isTalentUnlock(var_18_3) then
			table.insert(var_18_0, var_18_3)
		end
	end

	local var_18_4 = tabletool.len(arg_18_0._talentGroupMo.talents)

	GameFacade.showToast(ToastEnum.SurvivalOneKeyEquip)

	if var_18_4 == #var_18_0 then
		return
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideAlterTalentGroup(arg_18_0._talentGroupMo.groupId, var_18_0)
	gohelper.setActive(arg_18_0._goput, false)
	gohelper.setActive(arg_18_0._goput, true)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_put_1)
end

function var_0_0._onClickUnEquipAll(arg_19_0)
	local var_19_0 = tabletool.len(arg_19_0._talentGroupMo.talents)

	GameFacade.showToast(ToastEnum.SurvivalOneKeyUnEquip)

	if var_19_0 <= 0 then
		return
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideAlterTalentGroup(arg_19_0._talentGroupMo.groupId)
end

function var_0_0._onClickBagItem(arg_20_0, arg_20_1)
	arg_20_0._curItem = arg_20_1

	arg_20_1:setIsSelect(true)

	local var_20_0 = arg_20_1._talentCo

	arg_20_0._infoPanel:updateMo(var_20_0, true)
end

function var_0_0._onClickCenterItem(arg_21_0, arg_21_1)
	arg_21_0._curItem = arg_21_1

	arg_21_1:setIsSelect(true)

	local var_21_0 = arg_21_1._talentCo

	arg_21_0._infoPanel:updateMo(var_21_0, false)
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.refreshView, arg_22_0)
end

return var_0_0
