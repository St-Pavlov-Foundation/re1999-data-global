module("modules.logic.survival.view.shelter.SurvivalEquipView", package.seeall)

local var_0_0 = class("SurvivalEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnAttr = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Overview")
	arg_1_0._animscore = gohelper.findChildAnim(arg_1_0.viewGO, "Left/Assess")
	arg_1_0._txtTotalScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Assess/image_NumBG/#txt_Num")
	arg_1_0._imageScore = gohelper.findChildImage(arg_1_0.viewGO, "Left/Assess/txt_Assess/image_AssessIon")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection/Viewport/Content")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "#go_infoview")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "Right/#go_sort")
	arg_1_0._goplan = gohelper.findChild(arg_1_0.viewGO, "Left/plans")
	arg_1_0._goplanitem = gohelper.findChild(arg_1_0.viewGO, "Left/plans/item")
	arg_1_0._goequipitem = gohelper.findChild(arg_1_0.viewGO, "Left/equips/item")
	arg_1_0._animskill = gohelper.findChildAnim(arg_1_0.viewGO, "Left/equips/Middle")
	arg_1_0._btnEquipSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/equips/Middle/#btn_click")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#go_Has")
	arg_1_0._imageSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/equips/Middle/#go_Has")
	arg_1_0._imageFrequency = gohelper.findChildImage(arg_1_0.viewGO, "Left/equips/Middle/#go_Has/Frequency/image_NumBG/#txt_Num/image_FrequencyIcon")
	arg_1_0._txtFrequency = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/equips/Middle/#go_Has/Frequency/image_NumBG/#txt_Num")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#go_Empty")
	arg_1_0._golevel32 = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#level3")
	arg_1_0._golevel1 = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#go_Has/#level1")
	arg_1_0._golevel2 = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#go_Has/#level2")
	arg_1_0._golevel3 = gohelper.findChild(arg_1_0.viewGO, "Left/equips/Middle/#go_Has/#level3")
	arg_1_0._btn_onekeyEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_onekeyEquip")
	arg_1_0._goequipred = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_onekeyEquip/#go_arrow")
	arg_1_0._btn_onekeyUnEquip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_onekeyUnEquip")
	arg_1_0._goonekeyEquipTips = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_onekeyEquip/#go_tips")
	arg_1_0._goonekeyEquipTipsItem = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_onekeyEquip/#go_tips/#go_item")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEquipSkill:AddClickListener(arg_2_0.onAttrClick, arg_2_0)
	arg_2_0._btnAttr:AddClickListener(arg_2_0.onAttrClick, arg_2_0)
	arg_2_0._btn_onekeyEquip:AddClickListener(arg_2_0.oneKeyEquip, arg_2_0)
	arg_2_0._btn_onekeyUnEquip:AddClickListener(arg_2_0.oneKeyUnEquip, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBag, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, arg_2_0._refreshBag, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipInfoUpdate, arg_2_0.onChangePlan, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipMaxTagUpdate, arg_2_0.onMaxTagChange, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0.updateRed, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0.onTouchScreen, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gocontent, arg_2_0._beginDrag, arg_2_0._onDrag, arg_2_0._endDrag, nil, arg_2_0, nil, true)
end

function var_0_0.removeEvents(arg_3_0)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gocontent)
	arg_3_0._btnEquipSkill:RemoveClickListener()
	arg_3_0._btnAttr:RemoveClickListener()
	arg_3_0._btn_onekeyEquip:RemoveClickListener()
	arg_3_0._btn_onekeyUnEquip:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBag, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, arg_3_0._refreshBag, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipInfoUpdate, arg_3_0.onChangePlan, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipMaxTagUpdate, arg_3_0.onMaxTagChange, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0.updateRed, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	local var_4_0 = arg_4_0:isInSurvival()

	gohelper.setActive(arg_4_0._goplan, not var_4_0)

	if not var_4_0 then
		arg_4_0._planSelects = {}

		gohelper.CreateObjList(arg_4_0, arg_4_0._createPlanItem, {
			1,
			2,
			3,
			4
		}, nil, arg_4_0._goplanitem)
	end

	local var_4_1 = arg_4_0.viewContainer._viewSetting.otherRes.itemRes

	arg_4_0._item = arg_4_0:getResInst(var_4_1, arg_4_0.viewGO)

	gohelper.setActive(arg_4_0._item, false)

	local var_4_2 = arg_4_0:getResInst(var_4_1, arg_4_0.viewGO)

	arg_4_0._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagItem)

	arg_4_0._dragItem:setShowNum(false)
	gohelper.setActive(var_4_2, false)

	arg_4_0._equipItems = {}

	local var_4_3 = #arg_4_0._equipBox.slots
	local var_4_4 = 1

	if var_4_3 == 7 then
		var_4_4 = 2
	elseif var_4_3 == 6 then
		var_4_4 = 3
	end

	local var_4_5

	for iter_4_0 = 1, 3 do
		local var_4_6 = gohelper.findChild(arg_4_0.viewGO, "Left/equips/#go_Pos" .. iter_4_0)

		gohelper.setActive(var_4_6, var_4_4 == iter_4_0)

		if var_4_4 == iter_4_0 then
			var_4_5 = var_4_6
		end
	end

	arg_4_0._gopos = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, var_4_3 do
		local var_4_7 = gohelper.findChild(var_4_5, "pos" .. iter_4_1)
		local var_4_8 = gohelper.clone(arg_4_0._goequipitem, var_4_7)
		local var_4_9 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_8, SurvivalEquipItem)

		var_4_9:initIndex(iter_4_1)
		var_4_9:setIsSelect(iter_4_1 == 1)
		var_4_9:setParentView(arg_4_0)
		var_4_9:setItemRes(arg_4_0._item)
		var_4_9:setClickCallback(arg_4_0._onClickEquipItem, arg_4_0)
		var_4_9:setParentRoot(arg_4_0.viewGO.transform)

		arg_4_0._equipItems[iter_4_1] = var_4_9
		arg_4_0._gopos[iter_4_1] = var_4_7
	end

	gohelper.setActive(arg_4_0._goequipitem, false)

	local var_4_10 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gosort, SurvivalSortAndFilterPart)
	local var_4_11 = {
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
	local var_4_12 = {}

	for iter_4_2, iter_4_3 in ipairs(lua_survival_equip_found.configList) do
		table.insert(var_4_12, {
			desc = iter_4_3.name,
			type = iter_4_3.id
		})
	end

	arg_4_0._curSort = var_4_11[1]
	arg_4_0._isDec = true
	arg_4_0._filterList = {}

	var_4_10:setOptions(var_4_11, var_4_12, arg_4_0._curSort, arg_4_0._isDec)
	var_4_10:setOptionChangeCallback(arg_4_0._onSortChange, arg_4_0)

	local var_4_13 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_14 = arg_4_0:getResInst(var_4_13, arg_4_0._goinfoview)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_14, SurvivalBagInfoPart)
	arg_4_0._curSelectSlotId = 1

	arg_4_0._infoPanel:setCurEquipSlot(arg_4_0._curSelectSlotId)

	local var_4_15 = {
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.EquipBag,
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.EquipBag
	}

	arg_4_0._infoPanel:setChangeSource(var_4_15)
	arg_4_0._infoPanel:setCloseShow(true, arg_4_0._onTipsClose, arg_4_0)

	arg_4_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goscroll, SurvivalSimpleListPart)

	arg_4_0._simpleList:setCellUpdateCallBack(arg_4_0._createItem, arg_4_0, SurvivalBagItem, arg_4_0._item)
	arg_4_0:_refreshBag()
	arg_4_0:onChangePlan(true)

	arg_4_0._equipTagRed = arg_4_0:getUserDataTb_()

	gohelper.CreateObjList(arg_4_0, arg_4_0._createOneKeyEquipItem, var_4_12, nil, arg_4_0._goonekeyEquipTipsItem, nil, nil, nil, 1)
	arg_4_0:updateRed()
end

function var_0_0.getDragIndex(arg_5_0, arg_5_1)
	if gohelper.isMouseOverGo(arg_5_0._goscroll) then
		return -1
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._gopos) do
		if gohelper.isMouseOverGo(iter_5_1, arg_5_1) then
			return iter_5_0, arg_5_0._equipItems[iter_5_0]
		end
	end
end

function var_0_0._createOneKeyEquipItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildTextMesh(arg_6_1, "#txt_desc")
	local var_6_1 = gohelper.findChild(arg_6_1, "#go_arrow")

	var_6_0.text = arg_6_2.desc

	local var_6_2 = gohelper.getClick(arg_6_1)

	arg_6_0:addClickCb(var_6_2, arg_6_0._onClickFilterItem, arg_6_0, arg_6_2)

	arg_6_0._equipTagRed[arg_6_2.type] = var_6_1
end

function var_0_0.updateRed(arg_7_0)
	gohelper.setActive(arg_7_0._goequipred, SurvivalEquipRedDotHelper.instance.reddotType >= 0)

	for iter_7_0, iter_7_1 in pairs(arg_7_0._equipTagRed) do
		gohelper.setActive(iter_7_1, iter_7_0 == SurvivalEquipRedDotHelper.instance.reddotType)
	end
end

function var_0_0._onClickFilterItem(arg_8_0, arg_8_1)
	GameFacade.showToast(ToastEnum.SurvivalOneKeyEquip)
	gohelper.setActive(arg_8_0._goonekeyEquipTips, false)
	SurvivalWeekRpc.instance:sendSurvivalEquipOneKeyWear(arg_8_1.type)
end

function var_0_0.onAttrClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipOverView)
end

function var_0_0.oneKeyEquip(arg_10_0)
	gohelper.setActive(arg_10_0._goonekeyEquipTips, not arg_10_0._goonekeyEquipTips.activeSelf)
end

function var_0_0.oneKeyUnEquip(arg_11_0)
	GameFacade.showToast(ToastEnum.SurvivalOneKeyUnEquip)
	SurvivalWeekRpc.instance:sendSurvivalEquipOneKeyDemount()
end

function var_0_0._createPlanItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._planSelects[arg_12_3] = gohelper.findChild(arg_12_1, "#go_select")

	local var_12_0 = gohelper.findChildTextMesh(arg_12_1, "#txt_planId")
	local var_12_1 = gohelper.findChildTextMesh(arg_12_1, "#go_select/#txt_planId")

	var_12_0.text = string.format("%02d", arg_12_3)
	var_12_1.text = string.format("%02d", arg_12_3)

	local var_12_2 = gohelper.findChildButtonWithAudio(arg_12_1, "#btn_click")

	arg_12_0:addClickCb(var_12_2, arg_12_0._onClickPlan, arg_12_0, arg_12_3)
end

function var_0_0._onClickPlan(arg_13_0, arg_13_1)
	if arg_13_0._equipBox.currPlanId == arg_13_1 then
		return
	end

	arg_13_0._lockUpdate = true

	SurvivalWeekRpc.instance:sendSurvivalEquipSwitchPlan(arg_13_1, arg_13_0._onServerSwitchPlan, arg_13_0)
end

function var_0_0._onServerSwitchPlan(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == 0 then
		arg_14_0._anim:Play("switch", 0, 0)
		UIBlockHelper.instance:startBlock("SurvivalEquipView_swicth", 0.167)
		TaskDispatcher.runDelay(arg_14_0.onChangePlanBySwitch, arg_14_0, 0.167)
	end

	arg_14_0._lockUpdate = false
end

function var_0_0.onChangePlanBySwitch(arg_15_0)
	arg_15_0:onChangePlan(true)
end

local var_0_1 = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function var_0_0.onChangePlan(arg_16_0, arg_16_1)
	if arg_16_0._lockUpdate then
		return
	end

	if arg_16_0._planSelects then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._planSelects) do
			gohelper.setActive(iter_16_1, arg_16_0._equipBox.currPlanId == iter_16_0)
		end
	end

	local var_16_0 = 0

	for iter_16_2 = 1, #arg_16_0._equipItems do
		if arg_16_0._equipBox.slots[iter_16_2] then
			var_16_0 = var_16_0 + arg_16_0._equipBox.slots[iter_16_2]:getScore()
		end

		arg_16_0._equipItems[iter_16_2]:initData(arg_16_0._equipBox.slots[iter_16_2], arg_16_1)
	end

	if arg_16_0._tweenId then
		ZProj.TweenHelper.KillById(arg_16_0._tweenId, true)

		arg_16_0._tweenId = nil
	end

	if arg_16_1 or not arg_16_0._nowScore or arg_16_0._nowScore == var_16_0 then
		arg_16_0:onScoreChange(var_16_0)
	else
		arg_16_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_16_0._nowScore, var_16_0, 1, arg_16_0.onScoreChange, arg_16_0.onScoreEnd, arg_16_0)
	end

	arg_16_0:onMaxTagChange(arg_16_1)
end

function var_0_0.onScoreEnd(arg_17_0)
	arg_17_0._tweenId = nil

	arg_17_0._animscore:Play("change", 0, 0)
end

function var_0_0.onScoreChange(arg_18_0, arg_18_1)
	arg_18_1 = math.floor(arg_18_1)
	arg_18_0._nowScore = arg_18_1

	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.WorldLevel)
	local var_18_1 = lua_survival_equip_score.configDict[var_18_0][2].level
	local var_18_2 = 1

	if not string.nilorempty(var_18_1) then
		for iter_18_0, iter_18_1 in ipairs(string.splitToNumber(var_18_1, "#")) do
			if iter_18_1 <= arg_18_1 then
				var_18_2 = iter_18_0 + 1
			end
		end
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_18_0._imageScore, "survivalequip_scoreicon_" .. var_18_2)

	arg_18_0._txtTotalScore.text = string.format("<color=%s>%s</color>", var_0_1[var_18_2] or var_0_1[1], arg_18_1)
end

function var_0_0.onMaxTagChange(arg_19_0, arg_19_1)
	local var_19_0 = lua_survival_equip_found.configDict[arg_19_0._equipBox.maxTagId]
	local var_19_1 = 0

	if var_19_0 then
		local var_19_2 = arg_19_0._equipBox.values[var_19_0.value] or 0
		local var_19_3 = string.splitToNumber(var_19_0.level, "#") or {}

		for iter_19_0, iter_19_1 in ipairs(var_19_3) do
			if iter_19_1 <= var_19_2 then
				var_19_1 = iter_19_0
			end
		end
	end

	if arg_19_0._preLv == var_19_1 and arg_19_0._preTagCo == var_19_0 then
		if var_19_0 then
			UISpriteSetMgr.instance:setSurvivalSprite(arg_19_0._imageFrequency, var_19_0.value)

			arg_19_0._txtFrequency.text = arg_19_0._equipBox.values[var_19_0.value] or 0
		end

		return
	end

	if arg_19_0._nextLv then
		arg_19_0._preLv = arg_19_0._nextLv
	end

	TaskDispatcher.cancelTask(arg_19_0._delayShowTagCo, arg_19_0)

	if arg_19_1 or not arg_19_0._preLv then
		arg_19_0._preLv = var_19_1
		arg_19_0._preTagCo = var_19_0

		gohelper.setActive(arg_19_0._gohas, var_19_0)
		gohelper.setActive(arg_19_0._goempty, not var_19_0)
		gohelper.setActive(arg_19_0._golevel32, var_19_1 == 3)
		gohelper.setActive(arg_19_0._golevel1, var_19_1 == 1)
		gohelper.setActive(arg_19_0._golevel2, var_19_1 == 2)
		gohelper.setActive(arg_19_0._golevel3, var_19_1 == 3)

		if var_19_0 then
			arg_19_0._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(var_19_0.icon))
			UISpriteSetMgr.instance:setSurvivalSprite(arg_19_0._imageFrequency, var_19_0.value)

			arg_19_0._txtFrequency.text = arg_19_0._equipBox.values[var_19_0.value] or 0

			arg_19_0._animskill:Play("equip_in", 0, 1)
		else
			arg_19_0._animskill:Play("empty_in", 0, 1)
		end
	elseif arg_19_0._preTagCo ~= var_19_0 then
		arg_19_0._preLv = var_19_1
		arg_19_0._nextTagCo = var_19_0

		arg_19_0._animskill:Play(arg_19_0._preTagCo and "equipout" or "emptyout", 0, 0)
		TaskDispatcher.runDelay(arg_19_0._delayShowTagCo, arg_19_0, 0.1)

		arg_19_0._preTagCo = var_19_0
	else
		if var_19_0 then
			UISpriteSetMgr.instance:setSurvivalSprite(arg_19_0._imageFrequency, var_19_0.value)

			arg_19_0._txtFrequency.text = arg_19_0._equipBox.values[var_19_0.value] or 0
		end

		arg_19_0._nextLv = var_19_1

		arg_19_0:_delayShowLevelAnim()
	end
end

function var_0_0._delayShowTagCo(arg_20_0)
	gohelper.setActive(arg_20_0._gohas, arg_20_0._nextTagCo)
	gohelper.setActive(arg_20_0._goempty, not arg_20_0._nextTagCo)
	arg_20_0._animskill:Play(arg_20_0._nextTagCo and "equip_in" or "empty_in", 0, 0)

	if arg_20_0._nextTagCo then
		arg_20_0._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(arg_20_0._nextTagCo.icon))
		UISpriteSetMgr.instance:setSurvivalSprite(arg_20_0._imageFrequency, arg_20_0._nextTagCo.value)

		arg_20_0._txtFrequency.text = arg_20_0._equipBox.values[arg_20_0._nextTagCo.value] or 0
	end

	gohelper.setActive(arg_20_0._golevel32, arg_20_0._preLv == 3)
	gohelper.setActive(arg_20_0._golevel1, arg_20_0._preLv == 1)
	gohelper.setActive(arg_20_0._golevel2, arg_20_0._preLv == 2)
	gohelper.setActive(arg_20_0._golevel3, arg_20_0._preLv == 3)
end

function var_0_0._delayShowLevelAnim(arg_21_0)
	if arg_21_0._nextLv ~= arg_21_0._preLv and arg_21_0._preTagCo then
		if arg_21_0._nextLv > arg_21_0._preLv then
			arg_21_0._animskill:Play("equip_levelup")
		else
			arg_21_0._animskill:Play("equip_leveldown")
		end

		arg_21_0._preLv = arg_21_0._nextLv
		arg_21_0._nextLv = nil

		gohelper.setActive(arg_21_0._golevel32, arg_21_0._preLv == 3)
		gohelper.setActive(arg_21_0._golevel1, arg_21_0._preLv == 1)
		gohelper.setActive(arg_21_0._golevel2, arg_21_0._preLv == 2)
		gohelper.setActive(arg_21_0._golevel3, arg_21_0._preLv == 3)
	end
end

function var_0_0._onClickEquipItem(arg_22_0, arg_22_1)
	if arg_22_1 ~= arg_22_0._curSelectSlotId then
		arg_22_0._equipItems[arg_22_0._curSelectSlotId]:setIsSelect(false)

		arg_22_0._curSelectSlotId = arg_22_1

		arg_22_0._equipItems[arg_22_0._curSelectSlotId]:setIsSelect(true)
		arg_22_0._infoPanel:setCurEquipSlot(arg_22_1)
	end

	local var_22_0 = arg_22_0._equipItems[arg_22_1].mo.item

	if not var_22_0:isEmpty() then
		gohelper.setActive(arg_22_0._btncloseinfoview, true)
		arg_22_0._infoPanel:updateMo(var_22_0)
	end
end

function var_0_0._onSortChange(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0._curSort = arg_23_1
	arg_23_0._isDec = arg_23_2
	arg_23_0._filterList = arg_23_3

	arg_23_0:_refreshBag()
end

function var_0_0.isInSurvival(arg_24_0)
	return SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0.getBag(arg_25_0)
	local var_25_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_25_1 = var_25_0.bag
	local var_25_2

	if var_25_0.inSurvival then
		var_25_2 = SurvivalMapModel.instance:getSceneMo().bag
	end

	return var_25_1, var_25_2
end

function var_0_0._refreshBag(arg_26_0)
	local var_26_0, var_26_1 = arg_26_0:getBag()
	local var_26_2 = {}
	local var_26_3

	for iter_26_0, iter_26_1 in ipairs(var_26_0.items) do
		if iter_26_1.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(arg_26_0._filterList, iter_26_1) then
			table.insert(var_26_2, iter_26_1)

			if arg_26_0._preSelectUid == iter_26_1.uid then
				var_26_3 = iter_26_1.uid
			end
		end
	end

	if var_26_1 then
		for iter_26_2, iter_26_3 in ipairs(var_26_1.items) do
			if iter_26_3.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(arg_26_0._filterList, iter_26_3) then
				table.insert(var_26_2, iter_26_3)

				if arg_26_0._preSelectUid == iter_26_3.uid then
					var_26_3 = iter_26_3.uid
				end
			end
		end
	end

	SurvivalBagSortHelper.sortItems(var_26_2, arg_26_0._curSort.type, arg_26_0._isDec)
	SurvivalHelper.instance:makeArrFull(var_26_2, SurvivalBagItemMo.Empty, 5, 4)

	arg_26_0._preSelectUid = var_26_3

	arg_26_0._simpleList:setList(var_26_2)
	arg_26_0:_refreshInfo()
end

function var_0_0._createItem(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_1:updateMo(arg_27_2)
	arg_27_1:setClickCallback(arg_27_0._onItemClick, arg_27_0)

	if arg_27_2.uid == arg_27_0._preSelectUid and arg_27_0._preSelectUid then
		arg_27_1:setIsSelect(true)
	end
end

function var_0_0._onItemClick(arg_28_0, arg_28_1)
	if arg_28_1._mo:isEmpty() then
		return
	end

	arg_28_0._preSelectUid = arg_28_1._mo.uid

	for iter_28_0 in pairs(arg_28_0._simpleList:getAllComps()) do
		iter_28_0:setIsSelect(arg_28_0._preSelectUid and iter_28_0._mo.uid == arg_28_0._preSelectUid)
	end

	arg_28_0:_refreshInfo()
end

function var_0_0._onTipsClose(arg_29_0)
	arg_29_0._preSelectUid = nil

	for iter_29_0 in pairs(arg_29_0._simpleList:getAllComps()) do
		iter_29_0:setIsSelect(false)
	end
end

function var_0_0._refreshInfo(arg_30_0)
	local var_30_0, var_30_1 = arg_30_0:getBag()
	local var_30_2 = arg_30_0._preSelectUid and (var_30_0.itemsByUid[arg_30_0._preSelectUid] or var_30_1 and var_30_1.itemsByUid[arg_30_0._preSelectUid])

	arg_30_0._infoPanel:updateMo(var_30_2)
end

function var_0_0.onTouchScreen(arg_31_0)
	if arg_31_0._goonekeyEquipTips.activeSelf then
		if gohelper.isMouseOverGo(arg_31_0._goonekeyEquipTips) or gohelper.isMouseOverGo(arg_31_0._btn_onekeyEquip) then
			return
		end

		gohelper.setActive(arg_31_0._goonekeyEquipTips, false)
	end
end

function var_0_0._beginDrag(arg_32_0, arg_32_1, arg_32_2)
	ZProj.UGUIHelper.PassEvent(arg_32_0._goscroll, arg_32_2, 4)

	for iter_32_0 in pairs(arg_32_0._simpleList:getAllComps()) do
		if gohelper.isMouseOverGo(iter_32_0.go) then
			if not iter_32_0._mo:isEmpty() then
				arg_32_0._curPressItem = iter_32_0
			end

			break
		end
	end
end

function var_0_0._onDrag(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0._isDragOut then
		ZProj.UGUIHelper.PassEvent(arg_33_0._goscroll, arg_33_2, 5)

		if arg_33_0._curPressItem and arg_33_2.position.x - arg_33_2.pressPosition.x < -100 then
			arg_33_0._isDragOut = true

			arg_33_0._dragItem:updateMo(arg_33_0._curPressItem._mo)
			gohelper.setActive(arg_33_0._dragItem.go, true)

			var_33_0 = true

			ZProj.UGUIHelper.PassEvent(arg_33_0._goscroll, arg_33_2, 6)
		end
	end

	if arg_33_0._isDragOut then
		local var_33_1 = recthelper.screenPosToAnchorPos(arg_33_2.position, arg_33_0.viewGO.transform)
		local var_33_2 = arg_33_0._dragItem.go.transform
		local var_33_3, var_33_4 = recthelper.getAnchor(var_33_2)

		if not var_33_0 and (math.abs(var_33_3 - var_33_1.x) > 10 or math.abs(var_33_4 - var_33_1.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(var_33_2, var_33_1.x, var_33_1.y, 0.2)
		else
			recthelper.setAnchor(var_33_2, var_33_1.x, var_33_1.y)
		end

		local var_33_5, var_33_6 = arg_33_0:getDragIndex(arg_33_2.position)

		if var_33_6 ~= arg_33_0._curOverEquip then
			if arg_33_0._curOverEquip then
				arg_33_0._curOverEquip:setLightActive(false)
			end

			arg_33_0._curOverEquip = var_33_6

			if arg_33_0._curOverEquip then
				arg_33_0._curOverEquip:setLightActive(true)
			end
		end
	end
end

function var_0_0._endDrag(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0._curOverEquip then
		arg_34_0._curOverEquip:setLightActive(false)

		arg_34_0._curOverEquip = nil
	end

	if arg_34_0._isDragOut then
		arg_34_0._isDragOut = nil

		gohelper.setActive(arg_34_0._dragItem.go, false)

		local var_34_0 = arg_34_0._curPressItem._mo

		arg_34_0._curPressItem = nil

		local var_34_1 = arg_34_0:getDragIndex(arg_34_2.position)

		if var_34_1 and var_34_1 > 0 then
			local var_34_2 = arg_34_0._equipBox.slots

			if not var_34_2[var_34_1] then
				return
			end

			if not var_34_2[var_34_1].unlock then
				GameFacade.showToast(ToastEnum.SurvivalEquipLock)

				return
			end

			if var_34_0.equipLevel > var_34_2[var_34_1].level then
				GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

				return false
			end

			SurvivalWeekRpc.instance:sendSurvivalEquipWear(var_34_1, var_34_0.uid)
		end
	else
		arg_34_0._curPressItem = nil

		ZProj.UGUIHelper.PassEvent(arg_34_0._goscroll, arg_34_2, 6)
	end
end

function var_0_0.onClose(arg_35_0)
	if arg_35_0._tweenId then
		ZProj.TweenHelper.KillById(arg_35_0._tweenId)

		arg_35_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_35_0.onChangePlanBySwitch, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._delayShowTagCo, arg_35_0)
end

return var_0_0
