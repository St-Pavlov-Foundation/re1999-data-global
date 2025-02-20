module("modules.logic.fight.view.preview.SkillEditorToolsAutoPlaySkillView", package.seeall)

slot0 = class("SkillEditorToolsAutoPlaySkillView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._go = gohelper.findChild(slot0.viewGO, "autoPlaySkill")
	slot0._goHuazhi = gohelper.findChild(slot0.viewGO, "autoPlaySkill/huazhi")
	slot0._inp = gohelper.findChildTextMeshInputField(slot0.viewGO, "autoPlaySkill/inp")
	slot0._goHuazhiItem = gohelper.findChild(slot0.viewGO, "autoPlaySkill/huazhi/item")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "autoPlaySkill/play")
	slot0._btnSelectAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "autoPlaySkill/selectAll")
	slot0._btnCancelAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "autoPlaySkill/cancel")
	slot0._btnclean = gohelper.findChildButtonWithAudio(slot0.viewGO, "autoPlaySkill/clean")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "autoPlaySkill/close")
	slot0._scrollView = gohelper.findChildScrollRect(slot0.viewGO, "autoPlaySkill/scroll")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "autoPlaySkill/scroll/Content")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "autoPlaySkill/scroll/Content/item")
	slot0._selectScrollView = gohelper.findChildScrollRect(slot0.viewGO, "autoPlaySkill/selectScroll")
	slot0._goselectcontent = gohelper.findChild(slot0.viewGO, "autoPlaySkill/selectScroll/Content")
	slot0._goselectitem = gohelper.findChild(slot0.viewGO, "autoPlaySkill/selectScroll/Content/item")
	slot0._btnlist = {}
	slot0._actionViewGO = gohelper.findChild(slot0.viewGO, "autoPlaySkill/selectSkin")
	slot0._itemGOParent = gohelper.findChild(slot0.viewGO, "autoPlaySkill/selectSkin/scroll/content")
	slot0._itemGOPrefab = gohelper.findChild(slot0.viewGO, "autoPlaySkill/selectSkin/scroll/item")
end

function slot0.addEvents(slot0)
	slot0._inp:AddOnValueChanged(slot0._onInpValueChanged, slot0)
	slot0._btnSelectAll:AddClickListener(slot0._onClickSelectAll, slot0)
	slot0._btnCancelAll:AddClickListener(slot0._onClickCancelAll, slot0)
	slot0._btnPlay:AddClickListener(slot0._playTimeline, slot0)
	slot0._btnclean:AddClickListener(slot0._onClickClean, slot0)
	slot0._btnClose:AddClickListener(slot0._closeview, slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow2, slot0._stopFlow, slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._OpenAutoPlaySkin, slot0._showSelectSkin, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):AddClickListener(slot0._hideSelectSkinView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._inp:RemoveOnValueChanged()
	slot0._btnSelectAll:RemoveClickListener()
	slot0._btnPlay:RemoveClickListener()
	slot0._btnclean:RemoveClickListener()
	slot0._btnCancelAll:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()

	for slot4, slot5 in ipairs(slot0._btnlist) do
		slot5:RemoveClickListener()
	end

	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow2, slot0._stopFlow, slot0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._OpenAutoPlaySkin, slot0._showSelectSkin, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._actionViewGO):RemoveClickListener()
end

function slot0._playTimeline(slot0)
	slot0._count = 0
	slot0.flow = FlowSequence.New()
	slot5 = FunctionWork.New

	slot0.flow:addWork(slot5(slot0._closeview, slot0))

	for slot5, slot6 in ipairs(SkillEditorToolAutoPlaySkillSelectModel.instance:getList()) do
		slot0.flow:addWork(FunctionWork.New(slot0.switchEntity, slot0, slot6))
		slot0.flow:addWork(FunctionWork.New(function ()
			slot0 = nil

			if uv0.type == SkillEditorMgr.SelectType.Group then
				slot2 = string.splitToNumber(uv0.co.monster, "#")
				slot3 = lua_monster.configDict[slot2[1]]

				for slot7 = 2, #slot2 do
					if tabletool.indexOf(string.splitToNumber(slot1.bossId, "#"), slot2[slot7]) then
						slot3 = lua_monster.configDict[slot2[slot7]]

						break
					end
				end

				slot0 = slot3 and slot3.name
			else
				slot0 = uv0.co.name
			end

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
				rolestr = uv0.co.id .. "\n" .. string.format("当前角色\n%s\n剩余角色%s/%s", slot0, #uv1 - uv2, #uv1)
			})
		end, slot0))
		slot0.flow:addWork(SkillEditorPlayTimelineWork.New())
		slot0.flow:addWork(FunctionWork.New(function ()
			uv0._count = uv0._count + 1
		end, slot0))
	end

	slot0.flow:addWork(FunctionWork.New(slot0._checkSkillDone, slot0, #slot1))
	slot0.flow:start()
end

function slot0._checkSkillDone(slot0, slot1)
	if slot0._count == slot1 and slot0.flow then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
		slot0.flow:onDone(true)
	end
end

function slot0.switchEntity(slot0, slot1)
	slot4 = SkillEditorHeroSelectModel.instance.stancePosId or 1
	slot5, slot6 = SkillEditorMgr.instance:getTypeInfo(FightEnum.EntitySide.MySide)
	slot7 = slot1.co
	slot8 = slot1.co.id

	if slot1.type == SkillEditorMgr.SelectType.Group then
		slot6.ids = {}
		slot6.skinIds = {}
		slot6.groupId = slot8

		for slot14, slot15 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot8].monster, "#")) do
			if lua_monster.configDict[slot15] then
				if not FightConfig.instance:getSkinCO(slot16.skinId) or string.nilorempty(slot17.spine) then
					GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, slot7.skinId or slot7.id)

					return
				end

				table.insert(slot6.ids, slot15)
				table.insert(slot6.skinIds, slot16.skinId)
			end
		end

		slot0:_onSelectStance(slot9.stanceId, true)
	elseif slot2 == SkillEditorMgr.SelectType.SubHero then
		SkillEditorMgr.instance:addSubHero(slot1.co.id, slot1.co.skinId)

		return
	else
		slot9 = slot6.ids[1]

		if not FightConfig.instance:getSkinCO(slot1.skinId) or string.nilorempty(slot11.spine) then
			GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, slot1.skinId or (slot2 == SkillEditorMgr.SelectType.Hero and slot1.co or lua_monster.configDict[slot8]).id)

			return
		end

		if slot4 then
			slot6.ids[slot4] = slot8
			slot6.skinIds[slot4] = slot1.skinId
		else
			for slot15, slot16 in ipairs(slot6.ids) do
				if slot16 == slot9 or slot5 ~= slot2 then
					slot6.ids[slot15] = slot8
					slot6.skinIds[slot15] = slot1.skinId
				end
			end
		end

		slot6.groupId = nil
	end

	SkillEditorMgr.instance:setTypeInfo(slot3, slot2, slot6.ids, slot6.skinIds, slot6.groupId)
	SkillEditorMgr.instance:refreshInfo(slot3)
	SkillEditorMgr.instance:rebuildEntitys(slot3)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, slot3)
end

function slot0._onSelectStance(slot0, slot1, slot2)
	slot3 = FightEnum.EntitySide.MySide

	if not lua_stance.configDict[slot1] then
		logError("站位不存在: " .. slot1)

		return
	end

	SkillEditorMgr.instance.enemy_stance_id = slot4.id

	for slot9 = 1, 4 do
		if #slot4["pos" .. slot9] ~= 0 then
			slot5 = 0 + 1
		end
	end

	slot6, slot7 = SkillEditorMgr.instance:getTypeInfo(slot3)

	while slot5 < #slot7.ids do
		if SkillEditorMgr.instance.cur_select_entity_id == slot7.ids[#slot7.ids] then
			SkillEditorMgr.instance.cur_select_entity_id = slot7.ids[slot8 - 1]
		end

		table.remove(slot7.ids, slot8)
		table.remove(slot7.skinIds, slot8)
	end

	SkillEditorMgr.instance.enemy_stance_count_limit = slot5

	SkillEditorMgr.instance:refreshInfo(slot3)
	SkillEditorMgr.instance:clearSubHero()

	if slot2 then
		SkillEditorMgr.instance:rebuildEntitys(slot3)
	end
end

function slot0._onClickSelectAll(slot0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:selectAll()
end

function slot0._onClickCancelAll(slot0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:cancelSelectAll()
end

function slot0._onClickClean(slot0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:clear()
end

function slot0._closeview(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0._onInpValueChanged(slot0)
	slot0:_updateItems()
end

function slot0._hideSelectSkinView(slot0)
	gohelper.setActive(slot0._actionViewGO, false)
end

function slot0._showSelectSkin(slot0, slot1)
	gohelper.setActive(slot0._actionViewGO, true)

	slot3 = SkinConfig.instance:getCharacterSkinCoList(slot1.co.id) or {}

	gohelper.CreateObjList(slot0, slot0.OnItemShow, slot3, slot0._itemGOParent, slot0._itemGOPrefab)

	if #slot3 == 0 then
		logError("所选对象没有可选皮肤")
		slot0:_hideSelectSkinView()
	end
end

function slot0.OnItemShow(slot0, slot1, slot2, slot3)
	slot1.transform:Find("Text"):GetComponent(gohelper.Type_TextMesh).text = slot2.des
	slot6 = slot1:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	slot0:removeClickCb(slot6)
	slot0:addClickCb(slot6, slot0.OnItemClick, slot0, slot2)
end

function slot0.OnItemClick(slot0, slot1)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._SelectAutoPlaySkin, {
		skinid = slot1.id,
		roleid = slot1.characterId
	})
end

function slot0._updateItems(slot0)
	SkillEditorToolAutoPlaySkillModel.instance:setSelect(slot0._inp:GetText())
end

function slot0.onOpen(slot0)
	slot0:_updateItems()
	slot0:_showData()
end

function slot0._showData(slot0)
	gohelper.CreateObjList(slot0, slot0._onItemShow, {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}, slot0._goHuazhi, slot0._goHuazhiItem)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "txt")
	slot5 = ""

	if slot2 == ModuleEnum.Performance.High then
		slot5 = "高"
	elseif slot2 == ModuleEnum.Performance.Middle then
		slot5 = "中"
	elseif slot2 == ModuleEnum.Performance.Low then
		slot5 = "低"
	end

	slot4.text = slot5
	slot6 = gohelper.getClick(slot1)

	slot6:AddClickListener(slot0._onItemClick, slot0, slot2)
	table.insert(slot0._btnlist, slot6)
end

function slot0._onItemClick(slot0, slot1)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(slot1)
	FightEffectPool.dispose()
end

function slot0._stopFlow(slot0)
	if slot0.flow and slot0.flow.status == WorkStatus.Running then
		slot3 = SkillEditorToolAutoPlaySkillSelectModel.instance:getList()

		for slot7 = slot0.flow._curIndex, #slot0.flow:getWorkList() do
			slot1[slot7]:onDone(true)
		end

		if slot0._count == #slot3 then
			if GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(SceneTag.UnitPlayer) then
				for slot9, slot10 in pairs(slot5) do
					if slot10.skill then
						slot10.skill:stopSkill()
					end
				end
			end

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
			slot0.flow:onDone(true)
		end
	end
end

function slot0.onClose(slot0)
	if slot0.flow then
		slot0.flow:stop()

		slot0.flow = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
