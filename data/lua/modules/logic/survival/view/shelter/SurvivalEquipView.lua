module("modules.logic.survival.view.shelter.SurvivalEquipView", package.seeall)

local var_0_0 = class("SurvivalEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnAttr = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Overview")
	arg_1_0._animscore = gohelper.findChildAnim(arg_1_0.viewGO, "Left/Assess")
	arg_1_0._txtTotalScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/Assess/image_NumBG/#txt_Num")
	arg_1_0._imageScore = gohelper.findChildImage(arg_1_0.viewGO, "Left/Assess/image_NumBG/#txt_Num/txt_Assess/image_AssessIon")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_collection/Viewport/Content")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "#go_infoview")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "Right/#go_sort")
	arg_1_0._goplan = gohelper.findChild(arg_1_0.viewGO, "Left/plans")
	arg_1_0._goplanitem = gohelper.findChild(arg_1_0.viewGO, "Left/plans/item")
	arg_1_0._goequipitem = gohelper.findChild(arg_1_0.viewGO, "Left/equips/item")
	arg_1_0._gospequipitem = gohelper.findChild(arg_1_0.viewGO, "Left/equips/#go_sppos/item_sppos")
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
	local var_4_3 = gohelper.findChildAnim(var_4_2, "")

	if var_4_3 then
		var_4_3.enabled = false
	end

	arg_4_0._dragItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagItem)

	arg_4_0._dragItem:setShowNum(false)
	gohelper.setActive(var_4_2, false)

	arg_4_0._equipItems = {}

	local var_4_4 = #arg_4_0._equipBox.slots
	local var_4_5 = gohelper.findChild(arg_4_0.viewGO, "Left/equips/#go_Pos1")

	arg_4_0._gopos = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, var_4_4 do
		local var_4_6 = gohelper.findChild(var_4_5, "pos" .. iter_4_0)
		local var_4_7 = gohelper.clone(arg_4_0._goequipitem, var_4_6)
		local var_4_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_7, SurvivalEquipItem)

		var_4_8:initIndex(iter_4_0)
		var_4_8:setParentView(arg_4_0)
		var_4_8:setItemRes(arg_4_0._item)
		var_4_8:setClickCallback(arg_4_0._onClickEquipItem, arg_4_0)
		var_4_8:setParentRoot(arg_4_0.viewGO.transform)

		arg_4_0._equipItems[iter_4_0] = var_4_8
		arg_4_0._gopos[iter_4_0] = var_4_6
	end

	arg_4_0._spEquipItems = {}
	arg_4_0._spGoPos = {}

	for iter_4_1 = 1, 3 do
		local var_4_9 = gohelper.findChild(arg_4_0.viewGO, "Left/equips/#go_sppos/#go_pos" .. iter_4_1)
		local var_4_10 = gohelper.clone(arg_4_0._gospequipitem, var_4_9)
		local var_4_11 = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_10, SurvivalSpEquipItem)

		var_4_11:initIndex(iter_4_1)
		var_4_11:setParentView(arg_4_0)
		var_4_11:setClickCallback(arg_4_0._onClickEquipItem2, arg_4_0)
		var_4_11:setParentRoot(arg_4_0.viewGO.transform)

		arg_4_0._spEquipItems[iter_4_1] = var_4_11
		arg_4_0._spGoPos[iter_4_1] = var_4_9
	end

	gohelper.setActive(arg_4_0._goequipitem, false)
	gohelper.setActive(arg_4_0._gospequipitem, false)

	local var_4_12 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gosort, SurvivalSortAndFilterPart)
	local var_4_13 = {
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
	local var_4_14 = {}

	for iter_4_2, iter_4_3 in ipairs(lua_survival_equip_found.configList) do
		table.insert(var_4_14, {
			desc = iter_4_3.name,
			type = iter_4_3.id
		})
	end

	arg_4_0._curSort = var_4_13[1]
	arg_4_0._isDec = true
	arg_4_0._filterList = {}

	var_4_12:setOptions(var_4_13, var_4_14, arg_4_0._curSort, arg_4_0._isDec)
	var_4_12:setOptionChangeCallback(arg_4_0._onSortChange, arg_4_0)

	local var_4_15 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_16 = arg_4_0:getResInst(var_4_15, arg_4_0._goinfoview)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_16, SurvivalBagInfoPart)

	local var_4_17 = {
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.EquipBag,
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.EquipBag
	}

	arg_4_0._infoPanel:setChangeSource(var_4_17)
	arg_4_0._infoPanel:setCloseShow(true, arg_4_0._onTipsClose, arg_4_0)

	arg_4_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goscroll, SurvivalSimpleListPart)

	arg_4_0._simpleList:setCellUpdateCallBack(arg_4_0._createItem, arg_4_0, SurvivalBagItem, arg_4_0._item)
	arg_4_0:_refreshBag()
	arg_4_0:onChangePlan(true)

	arg_4_0._equipTagRed = arg_4_0:getUserDataTb_()

	gohelper.CreateObjList(arg_4_0, arg_4_0._createOneKeyEquipItem, var_4_14, nil, arg_4_0._goonekeyEquipTipsItem, nil, nil, nil, 1)
	arg_4_0:updateRed()
end

function var_0_0.getDragIndex(arg_5_0, arg_5_1, arg_5_2)
	if gohelper.isMouseOverGo(arg_5_0._goscroll) then
		return -1
	end

	if arg_5_2 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._spGoPos) do
			if gohelper.isMouseOverGo(iter_5_1, arg_5_1) then
				return iter_5_0, arg_5_0._spEquipItems[iter_5_0]
			end
		end
	else
		for iter_5_2, iter_5_3 in ipairs(arg_5_0._gopos) do
			if gohelper.isMouseOverGo(iter_5_3, arg_5_1) then
				return iter_5_2, arg_5_0._equipItems[iter_5_2]
			end
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

	for iter_16_3 = 1, #arg_16_0._spEquipItems do
		if arg_16_0._equipBox.jewelrySlots[iter_16_3] then
			var_16_0 = var_16_0 + arg_16_0._equipBox.jewelrySlots[iter_16_3]:getScore()
		end

		arg_16_0._spEquipItems[iter_16_3]:initData(arg_16_0._equipBox.jewelrySlots[iter_16_3], arg_16_1)
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
	local var_22_0 = arg_22_0._equipItems[arg_22_1].mo.item

	if not var_22_0:isEmpty() then
		gohelper.setActive(arg_22_0._btncloseinfoview, true)
		arg_22_0._infoPanel:updateMo(var_22_0)
	end
end

function var_0_0._onClickEquipItem2(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._spEquipItems[arg_23_1].mo.item

	if not var_23_0:isEmpty() then
		gohelper.setActive(arg_23_0._btncloseinfoview, true)
		arg_23_0._infoPanel:updateMo(var_23_0)
	end
end

function var_0_0._onSortChange(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._curSort = arg_24_1
	arg_24_0._isDec = arg_24_2
	arg_24_0._filterList = arg_24_3

	arg_24_0:_refreshBag()
end

function var_0_0.isInSurvival(arg_25_0)
	return SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0.getBag(arg_26_0)
	local var_26_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_26_1 = var_26_0:getBag(SurvivalEnum.ItemSource.Shelter)
	local var_26_2

	if var_26_0.inSurvival then
		var_26_2 = var_26_0:getBag(SurvivalEnum.ItemSource.Map)
	end

	return var_26_1, var_26_2
end

function var_0_0._refreshBag(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0:getBag()
	local var_27_2 = {}
	local var_27_3

	for iter_27_0, iter_27_1 in ipairs(var_27_0.items) do
		if iter_27_1.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(arg_27_0._filterList, iter_27_1) then
			table.insert(var_27_2, iter_27_1)

			if arg_27_0._preSelectUid == iter_27_1.uid then
				var_27_3 = iter_27_1.uid
			end
		end
	end

	if var_27_1 then
		for iter_27_2, iter_27_3 in ipairs(var_27_1.items) do
			if iter_27_3.co.type == SurvivalEnum.ItemType.Equip and SurvivalBagSortHelper.filterEquipMo(arg_27_0._filterList, iter_27_3) then
				table.insert(var_27_2, iter_27_3)

				if arg_27_0._preSelectUid == iter_27_3.uid then
					var_27_3 = iter_27_3.uid
				end
			end
		end
	end

	SurvivalBagSortHelper.sortItems(var_27_2, arg_27_0._curSort.type, arg_27_0._isDec)
	SurvivalHelper.instance:makeArrFull(var_27_2, SurvivalBagItemMo.Empty, 5, 4)

	arg_27_0._preSelectUid = var_27_3

	arg_27_0._simpleList:setList(var_27_2)
	arg_27_0:_refreshInfo()
end

function var_0_0._createItem(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_1:updateMo(arg_28_2)
	arg_28_1:setClickCallback(arg_28_0._onItemClick, arg_28_0)

	if arg_28_2.uid == arg_28_0._preSelectUid and arg_28_0._preSelectUid then
		arg_28_1:setIsSelect(true)
	end
end

function var_0_0._onItemClick(arg_29_0, arg_29_1)
	if arg_29_1._mo:isEmpty() then
		return
	end

	arg_29_0._preSelectUid = arg_29_1._mo.uid

	for iter_29_0 in pairs(arg_29_0._simpleList:getAllComps()) do
		iter_29_0:setIsSelect(arg_29_0._preSelectUid and iter_29_0._mo.uid == arg_29_0._preSelectUid)
	end

	arg_29_0:_refreshInfo()
end

function var_0_0._onTipsClose(arg_30_0)
	arg_30_0._preSelectUid = nil

	for iter_30_0 in pairs(arg_30_0._simpleList:getAllComps()) do
		iter_30_0:setIsSelect(false)
	end
end

function var_0_0._refreshInfo(arg_31_0)
	local var_31_0, var_31_1 = arg_31_0:getBag()
	local var_31_2 = arg_31_0._preSelectUid and (var_31_0.itemsByUid[arg_31_0._preSelectUid] or var_31_1 and var_31_1.itemsByUid[arg_31_0._preSelectUid])

	arg_31_0._infoPanel:updateMo(var_31_2)
end

function var_0_0.onTouchScreen(arg_32_0)
	if arg_32_0._goonekeyEquipTips.activeSelf then
		if gohelper.isMouseOverGo(arg_32_0._goonekeyEquipTips) or gohelper.isMouseOverGo(arg_32_0._btn_onekeyEquip) then
			return
		end

		gohelper.setActive(arg_32_0._goonekeyEquipTips, false)
	end
end

function var_0_0._beginDrag(arg_33_0, arg_33_1, arg_33_2)
	ZProj.UGUIHelper.PassEvent(arg_33_0._goscroll, arg_33_2, 4)

	for iter_33_0 in pairs(arg_33_0._simpleList:getAllComps()) do
		if gohelper.isMouseOverGo(iter_33_0.go) then
			if not iter_33_0._mo:isEmpty() then
				arg_33_0._curPressItem = iter_33_0
			end

			break
		end
	end
end

function var_0_0._onDrag(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0._isDragOut then
		ZProj.UGUIHelper.PassEvent(arg_34_0._goscroll, arg_34_2, 5)

		if arg_34_0._curPressItem and arg_34_2.position.x - arg_34_2.pressPosition.x < -100 then
			arg_34_0._isDragOut = true

			arg_34_0._dragItem:updateMo(arg_34_0._curPressItem._mo)
			gohelper.setActive(arg_34_0._dragItem.go, true)

			var_34_0 = true

			ZProj.UGUIHelper.PassEvent(arg_34_0._goscroll, arg_34_2, 6)
		end
	end

	if arg_34_0._isDragOut then
		local var_34_1 = recthelper.screenPosToAnchorPos(arg_34_2.position, arg_34_0.viewGO.transform)
		local var_34_2 = arg_34_0._dragItem.go.transform
		local var_34_3, var_34_4 = recthelper.getAnchor(var_34_2)

		if not var_34_0 and (math.abs(var_34_3 - var_34_1.x) > 10 or math.abs(var_34_4 - var_34_1.y) > 10) then
			ZProj.TweenHelper.DOAnchorPos(var_34_2, var_34_1.x, var_34_1.y, 0.2)
		else
			recthelper.setAnchor(var_34_2, var_34_1.x, var_34_1.y)
		end

		local var_34_5 = arg_34_0._curPressItem._mo.equipCo.equipType == 1
		local var_34_6, var_34_7 = arg_34_0:getDragIndex(arg_34_2.position, var_34_5)

		if var_34_7 ~= arg_34_0._curOverEquip then
			if arg_34_0._curOverEquip then
				arg_34_0._curOverEquip:setLightActive(false)
			end

			arg_34_0._curOverEquip = var_34_7

			if arg_34_0._curOverEquip then
				arg_34_0._curOverEquip:setLightActive(true)
			end
		end
	end
end

function var_0_0._endDrag(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0._curOverEquip then
		arg_35_0._curOverEquip:setLightActive(false)

		arg_35_0._curOverEquip = nil
	end

	if arg_35_0._isDragOut then
		arg_35_0._isDragOut = nil

		gohelper.setActive(arg_35_0._dragItem.go, false)

		local var_35_0 = arg_35_0._curPressItem._mo
		local var_35_1 = var_35_0.equipCo.equipType == 1

		arg_35_0._curPressItem = nil

		local var_35_2 = arg_35_0:getDragIndex(arg_35_2.position, var_35_1)

		if var_35_2 and var_35_2 > 0 then
			local var_35_3 = var_35_1 and arg_35_0._equipBox.jewelrySlots or arg_35_0._equipBox.slots

			if not var_35_3[var_35_2] then
				return
			end

			if not var_35_3[var_35_2].unlock then
				GameFacade.showToast(ToastEnum.SurvivalEquipLock)

				return
			end

			if var_35_0.equipLevel > var_35_3[var_35_2].level then
				GameFacade.showToast(ToastEnum.SurvivalEquipLevelLimit)

				return false
			end

			if var_35_1 then
				SurvivalWeekRpc.instance:sendSurvivalJewelryEquipWear(var_35_2, var_35_0.uid)
			else
				SurvivalWeekRpc.instance:sendSurvivalEquipWear(var_35_2, var_35_0.uid)
			end
		end
	else
		arg_35_0._curPressItem = nil

		ZProj.UGUIHelper.PassEvent(arg_35_0._goscroll, arg_35_2, 6)
	end
end

function var_0_0.onClose(arg_36_0)
	if arg_36_0._tweenId then
		ZProj.TweenHelper.KillById(arg_36_0._tweenId)

		arg_36_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_36_0.onChangePlanBySwitch, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._delayShowTagCo, arg_36_0)
end

return var_0_0
