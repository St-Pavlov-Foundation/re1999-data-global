module("modules.logic.fight.view.preview.SkillEditorToolsAutoPlaySkillView", package.seeall)

local var_0_0 = class("SkillEditorToolsAutoPlaySkillView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._go = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill")
	arg_1_0._goHuazhi = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/huazhi")
	arg_1_0._inp = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "autoPlaySkill/inp")
	arg_1_0._goHuazhiItem = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/huazhi/item")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "autoPlaySkill/play")
	arg_1_0._btnSelectAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "autoPlaySkill/selectAll")
	arg_1_0._btnCancelAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "autoPlaySkill/cancel")
	arg_1_0._btnclean = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "autoPlaySkill/clean")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "autoPlaySkill/close")
	arg_1_0._scrollView = gohelper.findChildScrollRect(arg_1_0.viewGO, "autoPlaySkill/scroll")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/scroll/Content")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/scroll/Content/item")
	arg_1_0._selectScrollView = gohelper.findChildScrollRect(arg_1_0.viewGO, "autoPlaySkill/selectScroll")
	arg_1_0._goselectcontent = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/selectScroll/Content")
	arg_1_0._goselectitem = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/selectScroll/Content/item")
	arg_1_0._btnlist = {}
	arg_1_0._actionViewGO = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/selectSkin")
	arg_1_0._itemGOParent = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/selectSkin/scroll/content")
	arg_1_0._itemGOPrefab = gohelper.findChild(arg_1_0.viewGO, "autoPlaySkill/selectSkin/scroll/item")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._inp:AddOnValueChanged(arg_2_0._onInpValueChanged, arg_2_0)
	arg_2_0._btnSelectAll:AddClickListener(arg_2_0._onClickSelectAll, arg_2_0)
	arg_2_0._btnCancelAll:AddClickListener(arg_2_0._onClickCancelAll, arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._playTimeline, arg_2_0)
	arg_2_0._btnclean:AddClickListener(arg_2_0._onClickClean, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._closeview, arg_2_0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow2, arg_2_0._stopFlow, arg_2_0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._OpenAutoPlaySkin, arg_2_0._showSelectSkin, arg_2_0)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._actionViewGO):AddClickListener(arg_2_0._hideSelectSkinView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._inp:RemoveOnValueChanged()
	arg_3_0._btnSelectAll:RemoveClickListener()
	arg_3_0._btnPlay:RemoveClickListener()
	arg_3_0._btnclean:RemoveClickListener()
	arg_3_0._btnCancelAll:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._btnlist) do
		iter_3_1:RemoveClickListener()
	end

	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow2, arg_3_0._stopFlow, arg_3_0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._OpenAutoPlaySkin, arg_3_0._showSelectSkin, arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._actionViewGO):RemoveClickListener()
end

function var_0_0._playTimeline(arg_4_0)
	arg_4_0._count = 0

	local var_4_0 = SkillEditorToolAutoPlaySkillSelectModel.instance:getList()

	arg_4_0.flow = FlowSequence.New()

	arg_4_0.flow:addWork(FunctionWork.New(arg_4_0._closeview, arg_4_0))

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0.flow:addWork(FunctionWork.New(arg_4_0.switchEntity, arg_4_0, iter_4_1))
		arg_4_0.flow:addWork(FunctionWork.New(function()
			local var_5_0

			if iter_4_1.type == SkillEditorMgr.SelectType.Group then
				local var_5_1 = iter_4_1.co
				local var_5_2 = string.splitToNumber(var_5_1.monster, "#")
				local var_5_3 = lua_monster.configDict[var_5_2[1]]

				for iter_5_0 = 2, #var_5_2 do
					if tabletool.indexOf(string.splitToNumber(var_5_1.bossId, "#"), var_5_2[iter_5_0]) then
						var_5_3 = lua_monster.configDict[var_5_2[iter_5_0]]

						break
					end
				end

				var_5_0 = var_5_3 and var_5_3.name
			else
				var_5_0 = iter_4_1.co.name
			end

			local var_5_4 = iter_4_1.co.id .. "\n" .. string.format("当前角色\n%s\n剩余角色%s/%s", var_5_0, #var_4_0 - iter_4_0, #var_4_0)

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
				rolestr = var_5_4
			})
		end, arg_4_0))
		arg_4_0.flow:addWork(SkillEditorPlayTimelineWork.New())
		arg_4_0.flow:addWork(FunctionWork.New(function()
			arg_4_0._count = arg_4_0._count + 1
		end, arg_4_0))
	end

	arg_4_0.flow:addWork(FunctionWork.New(arg_4_0._checkSkillDone, arg_4_0, #var_4_0))
	arg_4_0.flow:start()
end

function var_0_0._checkSkillDone(arg_7_0, arg_7_1)
	if arg_7_0._count == arg_7_1 and arg_7_0.flow then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
		arg_7_0.flow:onDone(true)
	end
end

function var_0_0.switchEntity(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.type
	local var_8_1 = FightEnum.EntitySide.MySide
	local var_8_2 = SkillEditorHeroSelectModel.instance.stancePosId or 1
	local var_8_3, var_8_4 = SkillEditorMgr.instance:getTypeInfo(var_8_1)
	local var_8_5 = arg_8_1.co
	local var_8_6 = arg_8_1.co.id

	if var_8_0 == SkillEditorMgr.SelectType.Group then
		var_8_4.ids = {}
		var_8_4.skinIds = {}
		var_8_4.groupId = var_8_6

		local var_8_7 = lua_monster_group.configDict[var_8_6]
		local var_8_8 = string.splitToNumber(var_8_7.monster, "#")

		for iter_8_0, iter_8_1 in ipairs(var_8_8) do
			local var_8_9 = lua_monster.configDict[iter_8_1]

			if var_8_9 then
				local var_8_10 = FightConfig.instance:getSkinCO(var_8_9.skinId)

				if not var_8_10 or string.nilorempty(var_8_10.spine) then
					GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, var_8_5.skinId or var_8_5.id)

					return
				end

				table.insert(var_8_4.ids, iter_8_1)
				table.insert(var_8_4.skinIds, var_8_9.skinId)
			end
		end

		arg_8_0:_onSelectStance(var_8_7.stanceId, true)
	elseif var_8_0 == SkillEditorMgr.SelectType.SubHero then
		SkillEditorMgr.instance:addSubHero(arg_8_1.co.id, arg_8_1.co.skinId)

		return
	else
		local var_8_11 = var_8_4.ids[1]
		local var_8_12 = var_8_0 == SkillEditorMgr.SelectType.Hero and arg_8_1.co or lua_monster.configDict[var_8_6]
		local var_8_13 = FightConfig.instance:getSkinCO(arg_8_1.skinId)

		if not var_8_13 or string.nilorempty(var_8_13.spine) then
			GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, arg_8_1.skinId or var_8_12.id)

			return
		end

		if var_8_2 then
			var_8_4.ids[var_8_2] = var_8_6
			var_8_4.skinIds[var_8_2] = arg_8_1.skinId
		else
			for iter_8_2, iter_8_3 in ipairs(var_8_4.ids) do
				if iter_8_3 == var_8_11 or var_8_3 ~= var_8_0 then
					var_8_4.ids[iter_8_2] = var_8_6
					var_8_4.skinIds[iter_8_2] = arg_8_1.skinId
				end
			end
		end

		var_8_4.groupId = nil
	end

	SkillEditorMgr.instance:setTypeInfo(var_8_1, var_8_0, var_8_4.ids, var_8_4.skinIds, var_8_4.groupId)
	SkillEditorMgr.instance:refreshInfo(var_8_1)
	SkillEditorMgr.instance:rebuildEntitys(var_8_1)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, var_8_1)
end

function var_0_0._onSelectStance(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = FightEnum.EntitySide.MySide
	local var_9_1 = lua_stance.configDict[arg_9_1]

	if not var_9_1 then
		logError("站位不存在: " .. arg_9_1)

		return
	end

	SkillEditorMgr.instance.enemy_stance_id = var_9_1.id

	local var_9_2 = 0

	for iter_9_0 = 1, 4 do
		if #var_9_1["pos" .. iter_9_0] ~= 0 then
			var_9_2 = var_9_2 + 1
		end
	end

	local var_9_3, var_9_4 = SkillEditorMgr.instance:getTypeInfo(var_9_0)

	while var_9_2 < #var_9_4.ids do
		local var_9_5 = #var_9_4.ids

		if SkillEditorMgr.instance.cur_select_entity_id == var_9_4.ids[var_9_5] then
			SkillEditorMgr.instance.cur_select_entity_id = var_9_4.ids[var_9_5 - 1]
		end

		table.remove(var_9_4.ids, var_9_5)
		table.remove(var_9_4.skinIds, var_9_5)
	end

	SkillEditorMgr.instance.enemy_stance_count_limit = var_9_2

	SkillEditorMgr.instance:refreshInfo(var_9_0)
	SkillEditorMgr.instance:clearSubHero()

	if arg_9_2 then
		SkillEditorMgr.instance:rebuildEntitys(var_9_0)
	end
end

function var_0_0._onClickSelectAll(arg_10_0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:selectAll()
end

function var_0_0._onClickCancelAll(arg_11_0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:cancelSelectAll()
end

function var_0_0._onClickClean(arg_12_0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:clear()
end

function var_0_0._closeview(arg_13_0)
	gohelper.setActive(arg_13_0._go, false)
end

function var_0_0._onInpValueChanged(arg_14_0)
	arg_14_0:_updateItems()
end

function var_0_0._hideSelectSkinView(arg_15_0)
	gohelper.setActive(arg_15_0._actionViewGO, false)
end

function var_0_0._showSelectSkin(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._actionViewGO, true)

	local var_16_0 = arg_16_1.co
	local var_16_1 = SkinConfig.instance:getCharacterSkinCoList(var_16_0.id) or {}

	gohelper.CreateObjList(arg_16_0, arg_16_0.OnItemShow, var_16_1, arg_16_0._itemGOParent, arg_16_0._itemGOPrefab)

	if #var_16_1 == 0 then
		logError("所选对象没有可选皮肤")
		arg_16_0:_hideSelectSkinView()
	end
end

function var_0_0.OnItemShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = arg_17_2.des

	local var_17_0 = arg_17_1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	arg_17_0:removeClickCb(var_17_0)
	arg_17_0:addClickCb(var_17_0, arg_17_0.OnItemClick, arg_17_0, arg_17_2)
end

function var_0_0.OnItemClick(arg_18_0, arg_18_1)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._SelectAutoPlaySkin, {
		skinid = arg_18_1.id,
		roleid = arg_18_1.characterId
	})
end

function var_0_0._updateItems(arg_19_0)
	SkillEditorToolAutoPlaySkillModel.instance:setSelect(arg_19_0._inp:GetText())
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:_updateItems()
	arg_20_0:_showData()
end

function var_0_0._showData(arg_21_0)
	local var_21_0 = {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}

	gohelper.CreateObjList(arg_21_0, arg_21_0._onItemShow, var_21_0, arg_21_0._goHuazhi, arg_21_0._goHuazhiItem)
end

function var_0_0._onItemShow(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = gohelper.findChildText(arg_22_1, "txt")
	local var_22_1 = ""

	if arg_22_2 == ModuleEnum.Performance.High then
		var_22_1 = "高"
	elseif arg_22_2 == ModuleEnum.Performance.Middle then
		var_22_1 = "中"
	elseif arg_22_2 == ModuleEnum.Performance.Low then
		var_22_1 = "低"
	end

	var_22_0.text = var_22_1

	local var_22_2 = gohelper.getClick(arg_22_1)

	var_22_2:AddClickListener(arg_22_0._onItemClick, arg_22_0, arg_22_2)
	table.insert(arg_22_0._btnlist, var_22_2)
end

function var_0_0._onItemClick(arg_23_0, arg_23_1)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(arg_23_1)
	FightEffectPool.dispose()
end

function var_0_0._stopFlow(arg_24_0)
	if arg_24_0.flow and arg_24_0.flow.status == WorkStatus.Running then
		local var_24_0 = arg_24_0.flow:getWorkList()
		local var_24_1 = arg_24_0.flow._curIndex
		local var_24_2 = SkillEditorToolAutoPlaySkillSelectModel.instance:getList()

		for iter_24_0 = var_24_1, #var_24_0 do
			var_24_0[iter_24_0]:onDone(true)
		end

		if arg_24_0._count == #var_24_2 then
			local var_24_3 = GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitPlayer)

			if var_24_3 then
				for iter_24_1, iter_24_2 in pairs(var_24_3) do
					if iter_24_2.skill then
						iter_24_2.skill:stopSkill()
					end
				end
			end

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
			arg_24_0.flow:onDone(true)
		end
	end
end

function var_0_0.onClose(arg_25_0)
	if arg_25_0.flow then
		arg_25_0.flow:stop()

		arg_25_0.flow = nil
	end
end

function var_0_0.onDestroyView(arg_26_0)
	return
end

return var_0_0
