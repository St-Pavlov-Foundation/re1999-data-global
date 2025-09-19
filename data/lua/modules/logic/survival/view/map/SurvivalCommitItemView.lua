module("modules.logic.survival.view.map.SurvivalCommitItemView", package.seeall)

local var_0_0 = class("SurvivalCommitItemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Center/#go_empty")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_close")
	arg_1_0._btncommit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_list/#btn_commit")
	arg_1_0._gocommitgray = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_commit_gray")
	arg_1_0._btncancledrop = gohelper.findChildClick(arg_1_0.viewGO, "Right/#go_drop/#btn_close")
	arg_1_0._goheavy = gohelper.findChild(arg_1_0.viewGO, "Left/#go_heavy")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "Left/#go_sort")
	arg_1_0._goleftscroll = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/#go_empty")
	arg_1_0._goleftcontent = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection/Viewport/Content")
	arg_1_0._goleftitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._gorightitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._gorightcontent = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection/Viewport/Content")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_empty")
	arg_1_0._gorightscroll = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection")
	arg_1_0._gorightinfo = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list")
	arg_1_0._gorighttips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tips")
	arg_1_0._godroparea = gohelper.findChild(arg_1_0.viewGO, "Right/#go_droparea")
	arg_1_0._godroptips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_drop")
	arg_1_0._animtips = gohelper.findChildAnim(arg_1_0._godroptips, "#go_droptips")
	arg_1_0._txttotalvalue = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_value/tag1/#txt_tag1")
	arg_1_0._txtitemvalue = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_tips/#txt_needcount")
	arg_1_0._txthave = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#txt_have")
	arg_1_0._txtafter = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#txt_after")
	arg_1_0._inputtipnum = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#go_num/valuebg/#input_value")
	arg_1_0._btnaddnum = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#go_num/#btn_add")
	arg_1_0._btnsubnum = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#go_num/#btn_sub")
	arg_1_0._btnput = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_drop/#go_droptips/#btn_put")
	arg_1_0._gotipitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_drop/itembg/#go_item")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btncommit:AddClickListener(arg_2_0.commitItems, arg_2_0)
	arg_2_0._btncancledrop:AddClickListener(arg_2_0.cancelDrop, arg_2_0)
	arg_2_0._inputtipnum:AddOnEndEdit(arg_2_0._ontipnuminputChange, arg_2_0)
	arg_2_0._btnaddnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, 1)
	arg_2_0._btnsubnum:AddClickListener(arg_2_0._addtipnum, arg_2_0, -1)
	arg_2_0._btnput:AddClickListener(arg_2_0._putItemToRight, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, arg_2_0._onTipsClick, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._goleftcontent, arg_2_0._beginLeftDrag, arg_2_0._onLeftDrag, arg_2_0._endLeftDrag, nil, arg_2_0, nil, true)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gorightcontent, arg_2_0._beginRightDrag, arg_2_0._onRightDrag, arg_2_0._endRightDrag, nil, arg_2_0, nil, true)
end

function var_0_0.removeEvents(arg_3_0)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._goleftcontent)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gorightcontent)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, arg_3_0._onTipsClick, arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncommit:RemoveClickListener()
	arg_3_0._btncancledrop:RemoveClickListener()
	arg_3_0._inputtipnum:RemoveOnEndEdit()
	arg_3_0._btnaddnum:RemoveClickListener()
	arg_3_0._btnsubnum:RemoveClickListener()
	arg_3_0._btnput:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._choiceMo = arg_4_0.viewParam

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open)

	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = gohelper.findChild(arg_4_0.viewGO, "Center/#go_info")
	local var_4_2 = gohelper.findChild(arg_4_0.viewGO, "Center/#go_info/go_infoview")
	local var_4_3 = arg_4_0:getResInst(var_4_0, var_4_2)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setHideParent(var_4_1)
	arg_4_0._infoPanel:setCloseShow(true, arg_4_0.closeInfoView, arg_4_0)
	arg_4_0._infoPanel:updateMo()
	gohelper.setActive(arg_4_0._godroptips, false)
	gohelper.setActive(arg_4_0._goempty, true)
	arg_4_0:setShowRightTips(false)

	local var_4_4 = SurvivalMapModel.instance:getSceneMo().bag
	local var_4_5 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_4.items) do
		if iter_4_1.co.worth > 0 then
			local var_4_6 = iter_4_1:clone()

			var_4_6.source = SurvivalEnum.ItemSource.Commit

			table.insert(var_4_5, var_4_6)
		end
	end

	for iter_4_2 = 1, 3 do
		gohelper.findChildTextMesh(arg_4_0.viewGO, "Left/#go_tag/tag" .. iter_4_2 .. "/#txt_tag" .. iter_4_2).text = var_4_4:getCurrencyNum(iter_4_2)
	end

	local var_4_7 = arg_4_0.viewContainer._viewSetting.otherRes.itemRes
	local var_4_8 = arg_4_0:getResInst(var_4_7, arg_4_0.viewGO)

	arg_4_0._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_8, SurvivalBagItem)

	local var_4_9 = arg_4_0:getResInst(var_4_7, arg_4_0._gotipitem)

	arg_4_0._tipsItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_9, SurvivalBagItem)

	arg_4_0._tipsItem:setShowNum(false)

	arg_4_0._simpleLeftList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goleftscroll, SurvivalSimpleListPart)

	arg_4_0._simpleLeftList:setCellUpdateCallBack(arg_4_0._createLeftItem, arg_4_0, nil, arg_4_0._goleftitem)

	arg_4_0._simpleRightList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gorightscroll, SurvivalSimpleListPart)

	arg_4_0._simpleRightList:setCellUpdateCallBack(arg_4_0._createRightItem, arg_4_0, nil, arg_4_0._gorightitem)

	arg_4_0._curSelectUid = nil
	arg_4_0._isSelectLeft = false

	gohelper.setActive(var_4_8, false)

	arg_4_0.leftItems = var_4_5
	arg_4_0.rightItems = {}

	arg_4_0:initWeightAndSort()
	arg_4_0:updateView()
end

function var_0_0._beginLeftDrag(arg_5_0, arg_5_1, arg_5_2)
	ZProj.UGUIHelper.PassEvent(arg_5_0._goleftscroll, arg_5_2, 4)

	for iter_5_0 in pairs(arg_5_0._simpleLeftList:getAllGos()) do
		local var_5_0 = gohelper.findChild(iter_5_0, "inst")

		if gohelper.isMouseOverGo(var_5_0) then
			local var_5_1 = MonoHelper.getLuaComFromGo(var_5_0, SurvivalBagItem)

			if var_5_1 and not var_5_1._mo:isEmpty() then
				arg_5_0._curPressItem = var_5_1
			end

			break
		end
	end
end

function var_0_0._onLeftDrag(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if not arg_6_0._isDragOut then
		ZProj.UGUIHelper.PassEvent(arg_6_0._goleftscroll, arg_6_2, 5)

		if arg_6_0._curPressItem and arg_6_2.position.x - arg_6_2.pressPosition.x > 100 then
			arg_6_0._isDragOut = true

			arg_6_0._dragItem:updateMo(arg_6_0._curPressItem._mo)
			gohelper.setActive(arg_6_0._dragItem.go, true)

			var_6_0 = true

			ZProj.UGUIHelper.PassEvent(arg_6_0._goleftscroll, arg_6_2, 6)
			arg_6_0._inputtipnum:SetText("1")
			arg_6_0:updateTipCount()
		end
	end

	if arg_6_0._isDragOut then
		local var_6_1 = recthelper.screenPosToAnchorPos(arg_6_2.position, arg_6_0.viewGO.transform)
		local var_6_2 = arg_6_0._dragItem.go.transform
		local var_6_3, var_6_4 = recthelper.getAnchor(var_6_2)

		if not var_6_0 and (math.abs(var_6_3 - var_6_1.x) > 10 or math.abs(var_6_4 - var_6_1.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(var_6_2, var_6_1.x, var_6_1.y, 0.2)
		else
			recthelper.setAnchor(var_6_2, var_6_1.x, var_6_1.y)
		end

		local var_6_5 = gohelper.isMouseOverGo(arg_6_0._godroparea)

		arg_6_0:setShowRightTips(var_6_5)
	end
end

function var_0_0._endLeftDrag(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._isDragOut then
		arg_7_0._isDragOut = nil

		gohelper.setActive(arg_7_0._dragItem.go, false)

		if gohelper.isMouseOverGo(arg_7_0._godroparea) then
			local var_7_0 = arg_7_0._curPressItem._mo

			if var_7_0.count > 1 then
				arg_7_0._tipsItem:updateMo(arg_7_0._curPressItem._mo)
				gohelper.setActive(arg_7_0._godroptips, true)
			else
				arg_7_0:setShowRightTips(false)
				arg_7_0:moveData(arg_7_0.leftItems, arg_7_0.rightItems, var_7_0, 1, SurvivalEnum.ItemSource.Commited)

				arg_7_0._curPressItem = nil
			end
		end
	else
		arg_7_0._curPressItem = nil

		ZProj.UGUIHelper.PassEvent(arg_7_0._goleftscroll, arg_7_2, 6)
	end
end

function var_0_0.setShowRightTips(arg_8_0, arg_8_1)
	if arg_8_0._isShowTips == arg_8_1 then
		return
	end

	arg_8_0._isShowTips = arg_8_1

	gohelper.setActive(arg_8_0._gorightinfo, not arg_8_1)
	gohelper.setActive(arg_8_0._gorighttips, arg_8_1)
end

function var_0_0.cancelDrop(arg_9_0)
	arg_9_0._animtips:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_9_0._delayHideTips, arg_9_0, 0.167)
	UIBlockHelper.instance:startBlock("SurvivalCommitItemView_closetips", 0.167)
end

function var_0_0._delayHideTips(arg_10_0)
	gohelper.setActive(arg_10_0._godroptips, false)
	arg_10_0:setShowRightTips(false)

	arg_10_0._curPressItem = nil
end

function var_0_0._ontipnuminputChange(arg_11_0)
	local var_11_0 = tonumber(arg_11_0._inputtipnum:GetText()) or 0
	local var_11_1 = Mathf.Clamp(var_11_0, 1, arg_11_0._curPressItem._mo.count)

	if tostring(var_11_1) ~= arg_11_0._inputtipnum:GetText() then
		arg_11_0._inputtipnum:SetText(tostring(var_11_1))
		arg_11_0:updateTipCount()
	end
end

function var_0_0._addtipnum(arg_12_0, arg_12_1)
	local var_12_0 = (tonumber(arg_12_0._inputtipnum:GetText()) or 0) + arg_12_1
	local var_12_1 = Mathf.Clamp(var_12_0, 1, arg_12_0._curPressItem._mo.count)

	arg_12_0._inputtipnum:SetText(tostring(var_12_1))
	arg_12_0:updateTipCount()
end

function var_0_0.updateTipCount(arg_13_0)
	local var_13_0 = tonumber(arg_13_0._inputtipnum:GetText()) or 0

	arg_13_0._txthave.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_have"), arg_13_0._curPressItem._mo.count)
	arg_13_0._txtafter.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_bag_place"), arg_13_0._curPressItem._mo.count - var_13_0)

	local var_13_1 = SurvivalShelterModel.instance:getWeekInfo()

	arg_13_0._txtitemvalue.text = var_13_0 * var_13_1:getAttr(SurvivalEnum.AttrType.NpcRecruitment, arg_13_0._curPressItem._mo.co.worth)
end

function var_0_0._putItemToRight(arg_14_0)
	local var_14_0 = tonumber(arg_14_0._inputtipnum:GetText()) or 0

	arg_14_0:moveData(arg_14_0.leftItems, arg_14_0.rightItems, arg_14_0._curPressItem._mo, var_14_0, SurvivalEnum.ItemSource.Commited)
	arg_14_0:cancelDrop()
end

function var_0_0.moveData(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_3.uid

	arg_15_3.count = arg_15_3.count - arg_15_4

	if arg_15_3.count == 0 then
		tabletool.removeValue(arg_15_1, arg_15_3)
	end

	local var_15_1 = false

	for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
		if iter_15_1.uid == var_15_0 then
			iter_15_1.count = iter_15_1.count + arg_15_4
			var_15_1 = true

			break
		end
	end

	if not var_15_1 then
		local var_15_2 = arg_15_3:clone()

		var_15_2.count = arg_15_4
		var_15_2.source = arg_15_5

		table.insert(arg_15_2, var_15_2)
	end

	arg_15_0:updateView()
end

function var_0_0.updateView(arg_16_0)
	arg_16_0:_refreshLeftView()
	arg_16_0:_refreshRightView()
	arg_16_0:closeInfoView()
end

function var_0_0.initWeightAndSort(arg_17_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_17_0._goheavy, SurvivalWeightPart)

	local var_17_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_17_0._gosort, SurvivalSortAndFilterPart)
	local var_17_1 = {
		{
			desc = luaLang("survival_sort_time"),
			type = SurvivalEnum.ItemSortType.Time
		},
		{
			desc = luaLang("survival_sort_mass"),
			type = SurvivalEnum.ItemSortType.Mass
		},
		{
			desc = luaLang("survival_sort_worth"),
			type = SurvivalEnum.ItemSortType.Worth
		},
		{
			desc = luaLang("survival_sort_type"),
			type = SurvivalEnum.ItemSortType.Type
		}
	}
	local var_17_2 = {
		{
			desc = luaLang("survival_filter_material"),
			type = SurvivalEnum.ItemFilterType.Material
		},
		{
			desc = luaLang("survival_filter_equip"),
			type = SurvivalEnum.ItemFilterType.Equip
		},
		{
			desc = luaLang("survival_filter_consume"),
			type = SurvivalEnum.ItemFilterType.Consume
		}
	}

	arg_17_0._curSort = var_17_1[1]
	arg_17_0._isDec = true
	arg_17_0._filterList = {}

	var_17_0:setOptions(var_17_1, var_17_2, arg_17_0._curSort, arg_17_0._isDec)
	var_17_0:setOptionChangeCallback(arg_17_0._onSortChange, arg_17_0)
end

function var_0_0._onSortChange(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._curSort = arg_18_1
	arg_18_0._isDec = arg_18_2
	arg_18_0._filterList = arg_18_3

	arg_18_0:_refreshLeftView()
end

function var_0_0._refreshLeftView(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.leftItems) do
		if SurvivalBagSortHelper.filterItemMo(arg_19_0._filterList, iter_19_1) then
			table.insert(var_19_0, iter_19_1)
		end
	end

	SurvivalBagSortHelper.sortItems(var_19_0, arg_19_0._curSort.type, arg_19_0._isDec)
	SurvivalHelper.instance:makeArrFull(var_19_0, SurvivalBagItemMo.Empty, 3, 5)
	arg_19_0._simpleLeftList:setList(var_19_0)
	gohelper.setActive(arg_19_0._goleftscroll, #var_19_0 > 0)
	gohelper.setActive(arg_19_0._goleftempty, #var_19_0 == 0)
end

function var_0_0._createLeftItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0.viewContainer._viewSetting.otherRes.itemRes
	local var_20_1 = gohelper.findChild(arg_20_1, "inst") or arg_20_0:getResInst(var_20_0, arg_20_1, "inst")
	local var_20_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_1, SurvivalBagItem)

	var_20_2:updateMo(arg_20_2)
	var_20_2:setClickCallback(arg_20_0._onLeftItemClick, arg_20_0)

	local var_20_3 = arg_20_0._isSelectLeft and arg_20_0._curSelectUid

	var_20_2:setIsSelect(var_20_3 and var_20_3 == var_20_2._mo.uid)
end

function var_0_0._createRightItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_0.viewContainer._viewSetting.otherRes.itemRes
	local var_21_1 = gohelper.findChild(arg_21_1, "inst") or arg_21_0:getResInst(var_21_0, arg_21_1, "inst")
	local var_21_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_1, SurvivalBagItem)

	var_21_2:updateMo(arg_21_2)
	var_21_2:setClickCallback(arg_21_0._onRightItemClick, arg_21_0)

	local var_21_3 = not arg_21_0._isSelectLeft and arg_21_0._curSelectUid

	var_21_2:setIsSelect(var_21_3 and var_21_3 == var_21_2._mo.uid)
end

function var_0_0._onLeftItemClick(arg_22_0, arg_22_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_22_0._infoPanel:updateMo(arg_22_1._mo)
	gohelper.setActive(arg_22_0._goempty, false)

	arg_22_0._curSelectUid = arg_22_1._mo.uid
	arg_22_0._isSelectLeft = true

	arg_22_0:updateItemSelect()
end

function var_0_0._onRightItemClick(arg_23_0, arg_23_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_23_0._infoPanel:updateMo(arg_23_1._mo)
	gohelper.setActive(arg_23_0._goempty, false)

	arg_23_0._curSelectUid = arg_23_1._mo.uid
	arg_23_0._isSelectLeft = false

	arg_23_0:updateItemSelect()
end

function var_0_0._refreshRightView(arg_24_0)
	arg_24_0._simpleRightList:setList(arg_24_0.rightItems)
	gohelper.setActive(arg_24_0._gorightscroll, #arg_24_0.rightItems > 0)
	gohelper.setActive(arg_24_0._gorightempty, #arg_24_0.rightItems == 0)

	local var_24_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_24_1 = 0

	for iter_24_0 = 1, #arg_24_0.rightItems do
		var_24_1 = var_24_1 + var_24_0:getAttr(SurvivalEnum.AttrType.NpcRecruitment, arg_24_0.rightItems[iter_24_0].co.worth) * arg_24_0.rightItems[iter_24_0].count
	end

	local var_24_2 = var_24_1 >= arg_24_0.viewParam.npcWorthCheck

	if var_24_2 then
		arg_24_0._txttotalvalue.text = string.format("%d/%d", var_24_1, arg_24_0.viewParam.npcWorthCheck)
	else
		arg_24_0._txttotalvalue.text = string.format("<#D74242>%d</COLOR>/%d", var_24_1, arg_24_0.viewParam.npcWorthCheck)
	end

	gohelper.setActive(arg_24_0._btncommit, var_24_2)
	gohelper.setActive(arg_24_0._gocommitgray, not var_24_2)
end

function var_0_0.onClickModalMask(arg_25_0)
	arg_25_0:closeThis()
end

function var_0_0.commitItems(arg_26_0)
	local var_26_0 = tostring(arg_26_0._choiceMo.param)
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.rightItems) do
		table.insert(var_26_1, string.format("%s:%s", iter_26_1.uid, iter_26_1.count))
	end

	if var_26_1[1] then
		var_26_0 = var_26_0 .. "#" .. table.concat(var_26_1, "&")
	end

	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", arg_26_0._choiceMo.unitId, arg_26_0._choiceMo.param, arg_26_0._choiceMo.treeId)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, var_26_0)
	arg_26_0:closeThis()
end

function var_0_0._beginRightDrag(arg_27_0, arg_27_1, arg_27_2)
	ZProj.UGUIHelper.PassEvent(arg_27_0._gorightscroll, arg_27_2, 4)

	for iter_27_0 in pairs(arg_27_0._simpleRightList:getAllGos()) do
		local var_27_0 = gohelper.findChild(iter_27_0, "inst")

		if gohelper.isMouseOverGo(var_27_0) then
			local var_27_1 = MonoHelper.getLuaComFromGo(var_27_0, SurvivalBagItem)

			if var_27_1 and not var_27_1._mo:isEmpty() then
				arg_27_0._curPressItem = var_27_1
			end

			break
		end
	end
end

function var_0_0._onRightDrag(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0

	if not arg_28_0._isDragOut then
		ZProj.UGUIHelper.PassEvent(arg_28_0._goleftscroll, arg_28_2, 5)

		if arg_28_0._curPressItem and arg_28_2.position.x - arg_28_2.pressPosition.x < -100 then
			arg_28_0._isDragOut = true

			arg_28_0._dragItem:updateMo(arg_28_0._curPressItem._mo)
			gohelper.setActive(arg_28_0._dragItem.go, true)

			var_28_0 = true

			ZProj.UGUIHelper.PassEvent(arg_28_0._goleftscroll, arg_28_2, 6)
		end
	end

	if arg_28_0._isDragOut then
		local var_28_1 = recthelper.screenPosToAnchorPos(arg_28_2.position, arg_28_0.viewGO.transform)
		local var_28_2 = arg_28_0._dragItem.go.transform
		local var_28_3, var_28_4 = recthelper.getAnchor(var_28_2)

		if not var_28_0 and (math.abs(var_28_3 - var_28_1.x) > 10 or math.abs(var_28_4 - var_28_1.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(var_28_2, var_28_1.x, var_28_1.y, 0.2)
		else
			recthelper.setAnchor(var_28_2, var_28_1.x, var_28_1.y)
		end
	end
end

function var_0_0._endRightDrag(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._isDragOut then
		arg_29_0._isDragOut = nil

		gohelper.setActive(arg_29_0._dragItem.go, false)

		if not gohelper.isMouseOverGo(arg_29_0._godroparea) then
			arg_29_0:moveData(arg_29_0.rightItems, arg_29_0.leftItems, arg_29_0._curPressItem._mo, arg_29_0._curPressItem._mo.count, SurvivalEnum.ItemSource.Commit)
		end
	else
		ZProj.UGUIHelper.PassEvent(arg_29_0._goleftscroll, arg_29_2, 6)
	end

	arg_29_0._curPressItem = nil
end

function var_0_0._onTipsClick(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_1 == "Place" then
		arg_30_0:moveData(arg_30_0.leftItems, arg_30_0.rightItems, arg_30_2, arg_30_3, SurvivalEnum.ItemSource.Commited)
	elseif arg_30_1 == "UnPlace" then
		arg_30_0:moveData(arg_30_0.rightItems, arg_30_0.leftItems, arg_30_2, arg_30_3, SurvivalEnum.ItemSource.Commit)
	end

	arg_30_0:closeInfoView()
end

function var_0_0.closeInfoView(arg_31_0)
	arg_31_0._infoPanel:updateMo()
	gohelper.setActive(arg_31_0._goempty, true)

	arg_31_0._curSelectUid = nil
	arg_31_0._isSelectLeft = false

	arg_31_0:updateItemSelect()
end

function var_0_0.updateItemSelect(arg_32_0)
	for iter_32_0 in pairs(arg_32_0._simpleLeftList:getAllGos()) do
		local var_32_0 = gohelper.findChild(iter_32_0, "inst")
		local var_32_1 = MonoHelper.getLuaComFromGo(var_32_0, SurvivalBagItem)

		if var_32_1 and not var_32_1._mo:isEmpty() then
			var_32_1:setIsSelect(arg_32_0._isSelectLeft and arg_32_0._curSelectUid == var_32_1._mo.uid)
		end
	end

	for iter_32_1 in pairs(arg_32_0._simpleRightList:getAllGos()) do
		local var_32_2 = gohelper.findChild(iter_32_1, "inst")
		local var_32_3 = MonoHelper.getLuaComFromGo(var_32_2, SurvivalBagItem)

		if var_32_3 and not var_32_3._mo:isEmpty() then
			var_32_3:setIsSelect(not arg_32_0._isSelectLeft and arg_32_0._curSelectUid == var_32_3._mo.uid)
		end
	end
end

function var_0_0.onClose(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._delayHideTips, arg_33_0)
end

return var_0_0
