module("modules.logic.fight.view.preview.SkillEditorSkillSelectTargetView", package.seeall)

local var_0_0 = class("SkillEditorSkillSelectTargetView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._side = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	local var_2_0 = arg_2_0._side == FightEnum.EntitySide.MySide and "right" or "left"
	local var_2_1 = gohelper.findChild(arg_2_0.viewGO, var_2_0)

	arg_2_0._containerGO = gohelper.findChild(var_2_1, "skillSelect")
	arg_2_0._containerTr = arg_2_0._containerGO.transform
	arg_2_0._imgSelectGO = gohelper.findChild(var_2_1, "skillSelect/imgSkillSelect")
	arg_2_0._imgSelectTr = arg_2_0._imgSelectGO.transform
	arg_2_0._clickGOArr = {
		gohelper.findChild(var_2_1, "skillSelect/click")
	}

	gohelper.setActive(arg_2_0._imgSelectGO, false)
	arg_2_0:_updateClickPos()
	arg_2_0:_updateSelectUI()

	local var_2_2 = ViewMgr.instance:getUILayer(UILayerName.Hud)

	gohelper.addChild(var_2_2, arg_2_0._containerGO)
	gohelper.setAsFirstSibling(arg_2_0._containerGO)

	arg_2_0._containerGO.name = "skillSelect" .. var_2_0
end

function var_0_0.onDestroyView(arg_3_0)
	gohelper.destroy(arg_3_0._containerGO)
end

function var_0_0.addEvents(arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_4_0._onSpineLoaded, arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
	TaskDispatcher.runRepeat(arg_4_0._onSecond, arg_4_0, 3)
end

function var_0_0.removeEvents(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._clickGOArr) do
		SLFramework.UGUI.UIClickListener.Get(iter_5_1):RemoveClickListener()
		SLFramework.UGUI.UILongPressListener.Get(iter_5_1):RemoveLongPressListener()
	end

	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_5_0._onSpineLoaded, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_5_0._onSkillPlayStart, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_5_0._onSkillPlayFinish, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onSecond, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._hideSelectGO, arg_5_0)
end

function var_0_0._onSkillPlayStart(arg_6_0)
	gohelper.setActive(arg_6_0._containerGO, false)
end

function var_0_0._onSkillPlayFinish(arg_7_0)
	gohelper.setActive(arg_7_0._containerGO, true)
end

function var_0_0._onSecond(arg_8_0)
	arg_8_0:_updateClickPos()
end

function var_0_0._onSpineLoaded(arg_9_0)
	arg_9_0:_updateClickPos()
end

function var_0_0._updateSelectUI(arg_10_0)
	local var_10_0 = SkillEditorView.selectPosId[arg_10_0._side]
	local var_10_1 = FightDataHelper.entityMgr:getByPosId(arg_10_0._side, var_10_0)
	local var_10_2 = FightHelper.getEntity(var_10_1 and var_10_1.id or 0)

	gohelper.setActive(arg_10_0._imgSelectGO, var_10_2 ~= nil)

	if var_10_2 then
		local var_10_3, var_10_4 = arg_10_0:_getEntityMiddlePos(var_10_2)

		recthelper.setAnchor(arg_10_0._imgSelectTr, var_10_3, var_10_4)
	else
		SkillEditorView.selectPosId[arg_10_0._side] = 1

		local var_10_5 = FightDataHelper.entityMgr:getByPosId(arg_10_0._side, 1)
		local var_10_6 = FightHelper.getEntity(var_10_5 and var_10_5.id or 0)

		gohelper.setActive(arg_10_0._imgSelectGO, var_10_6 ~= nil)

		if var_10_6 then
			local var_10_7, var_10_8 = arg_10_0:_getEntityMiddlePos(var_10_6)

			recthelper.setAnchor(arg_10_0._imgSelectTr, var_10_7, var_10_8)
		end
	end

	TaskDispatcher.cancelTask(arg_10_0._hideSelectGO, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._hideSelectGO, arg_10_0, 0.5)
end

function var_0_0._getEntityMiddlePos(arg_11_0, arg_11_1)
	if FightHelper.isAssembledMonster(arg_11_1) then
		local var_11_0 = arg_11_1:getMO()
		local var_11_1 = lua_fight_assembled_monster.configDict[var_11_0.skin]
		local var_11_2 = arg_11_1.go.transform.position
		local var_11_3 = Vector3.New(var_11_2.x + var_11_1.selectPos[1], var_11_2.y + var_11_1.selectPos[2], var_11_2.z)
		local var_11_4 = recthelper.worldPosToAnchorPos(var_11_3, arg_11_0._containerTr)

		return var_11_4.x, var_11_4.y
	end

	local var_11_5 = arg_11_0:_getHangPointObj(arg_11_1, ModuleEnum.SpineHangPoint.mountmiddle)

	if var_11_5 and var_11_5.name == ModuleEnum.SpineHangPoint.mountmiddle then
		local var_11_6 = Vector3.New(transformhelper.getPos(var_11_5.transform))
		local var_11_7 = recthelper.worldPosToAnchorPos(var_11_6, arg_11_0._containerTr)

		return var_11_7.x, var_11_7.y
	else
		local var_11_8, var_11_9 = arg_11_0:_calcRect(arg_11_1)

		return (var_11_8.x + var_11_9.x) / 2, (var_11_8.y + var_11_9.y) / 2
	end
end

function var_0_0._hideSelectGO(arg_12_0)
	gohelper.setActive(arg_12_0._imgSelectGO, false)
end

function var_0_0._updateClickPos(arg_13_0)
	local var_13_0 = {}

	FightDataHelper.entityMgr:getNormalList(arg_13_0._side, var_13_0)
	FightDataHelper.entityMgr:getSubList(arg_13_0._side, var_13_0)

	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = arg_13_0._clickGOArr[iter_13_0]

		if not var_13_2 then
			var_13_2 = gohelper.clone(arg_13_0._clickGOArr[1], arg_13_0._containerGO, "click" .. iter_13_0)

			table.insert(arg_13_0._clickGOArr, var_13_2)
		end

		gohelper.setActive(var_13_2, true)

		local var_13_3 = FightHelper.getEntity(iter_13_1.id)

		if var_13_3 then
			local var_13_4, var_13_5 = arg_13_0:_calcRect(var_13_3)
			local var_13_6 = var_13_2.transform

			recthelper.setAnchor(var_13_6, (var_13_4.x + var_13_5.x) / 2, (var_13_4.y + var_13_5.y) / 2)
			recthelper.setSize(var_13_6, math.abs(var_13_4.x - var_13_5.x), math.abs(var_13_4.y - var_13_5.y))
			SLFramework.UGUI.UIClickListener.Get(var_13_2):AddClickListener(arg_13_0._onClick, arg_13_0, iter_13_1.id)

			local var_13_7 = FightHelper.getEntity(iter_13_1.id)

			if isTypeOf(var_13_7, FightEntityAssembledMonsterMain) or isTypeOf(var_13_7, FightEntityAssembledMonsterSub) then
				table.insert(var_13_1, {
					entity = var_13_7,
					clickTr = var_13_6,
					clickGO = var_13_2
				})
			end

			local var_13_8 = SLFramework.UGUI.UILongPressListener.Get(var_13_2)

			var_13_8:AddLongPressListener(arg_13_0._onLongPress, arg_13_0, iter_13_1.id)
			var_13_8:SetLongPressTime({
				0.5,
				99999
			})
		end
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0._clickGOArr do
		gohelper.setActive(arg_13_0._clickGOArr[iter_13_2], false)
	end

	if #var_13_1 > 0 then
		arg_13_0:_dealAssembledMonsterClick(var_13_1)
	end
end

function var_0_0.sortAssembledMonster(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.entity:getMO()
	local var_14_1 = arg_14_1.entity:getMO()
	local var_14_2 = lua_fight_assembled_monster.configDict[var_14_0.skin]
	local var_14_3 = lua_fight_assembled_monster.configDict[var_14_1.skin]

	return var_14_2.clickIndex < var_14_3.clickIndex
end

function var_0_0._dealAssembledMonsterClick(arg_15_0, arg_15_1)
	table.sort(arg_15_1, var_0_0.sortAssembledMonster)

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		gohelper.setAsLastSibling(iter_15_1.clickGO)

		local var_15_0 = iter_15_1.entity:getMO()
		local var_15_1 = lua_fight_assembled_monster.configDict[var_15_0.skin]
		local var_15_2 = iter_15_1.entity.go.transform.position
		local var_15_3 = Vector3.New(var_15_2.x + var_15_1.virtualSpinePos[1], var_15_2.y + var_15_1.virtualSpinePos[2], var_15_2.z + var_15_1.virtualSpinePos[3])
		local var_15_4 = recthelper.worldPosToAnchorPos(var_15_3, arg_15_0._containerTr)

		recthelper.setAnchor(iter_15_1.clickTr, var_15_4.x, var_15_4.y)

		local var_15_5 = var_15_1.virtualSpineSize[1] * 0.5
		local var_15_6 = var_15_1.virtualSpineSize[2] * 0.5
		local var_15_7 = Vector3.New(var_15_3.x - var_15_5, var_15_3.y - var_15_6, var_15_3.z)
		local var_15_8 = Vector3.New(var_15_3.x + var_15_5, var_15_3.y + var_15_6, var_15_3.z)
		local var_15_9 = recthelper.worldPosToAnchorPos(var_15_7, arg_15_0._containerTr)
		local var_15_10 = recthelper.worldPosToAnchorPos(var_15_8, arg_15_0._containerTr)

		recthelper.setSize(iter_15_1.clickTr, var_15_10.x - var_15_9.x, var_15_10.y - var_15_9.y)
	end
end

function var_0_0._calcRect(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:_getHangPointObj(arg_16_1, ModuleEnum.SpineHangPoint.BodyStatic).transform.position
	local var_16_1, var_16_2 = FightHelper.getEntityBoxSizeOffsetV2(arg_16_1)
	local var_16_3 = arg_16_1:isMySide() and 1 or -1
	local var_16_4 = Vector3.New(var_16_0.x - var_16_1.x * 0.5, var_16_0.y - var_16_1.y * 0.5 * var_16_3, var_16_0.z)
	local var_16_5 = Vector3.New(var_16_0.x + var_16_1.x * 0.5, var_16_0.y + var_16_1.y * 0.5 * var_16_3, var_16_0.z)
	local var_16_6 = recthelper.worldPosToAnchorPos(var_16_4, arg_16_0._containerTr)
	local var_16_7 = recthelper.worldPosToAnchorPos(var_16_5, arg_16_0._containerTr)

	return var_16_6, var_16_7
end

function var_0_0._getHangPointObj(arg_17_0, arg_17_1, arg_17_2)
	return FightDataHelper.entityMgr:isSub(arg_17_1:getMO().uid) and arg_17_1.go or arg_17_1:getHangPoint(arg_17_2)
end

function var_0_0._onClick(arg_18_0, arg_18_1)
	local var_18_0 = SkillEditorView.selectPosId[arg_18_0._side]
	local var_18_1 = FightDataHelper.entityMgr:getById(arg_18_1)

	SkillEditorView.setSelectPosId(arg_18_0._side, var_18_1.position)

	SkillEditorMgr.instance.cur_select_entity_id = arg_18_1
	SkillEditorMgr.instance.cur_select_side = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(SkillEditorMgr.instance.cur_select_entity_id):getSide()

	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, SkillEditorMgr.instance.cur_select_side, arg_18_1)
	arg_18_0:_updateSelectUI()

	if var_18_1.position == var_18_0 and arg_18_0._lastClickTime and Time.time - arg_18_0._lastClickTime < 0.5 then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.ShowHeroSelectView, arg_18_0._side, var_18_1.position)
	end

	arg_18_0._lastClickTime = Time.time
end

function var_0_0._onLongPress(arg_19_0, arg_19_1)
	local var_19_0 = FightDataHelper.entityMgr:getById(arg_19_1)

	if var_19_0 then
		ViewMgr.instance:openView(ViewName.FightFocusView, {
			entityId = var_19_0.id
		})
	end
end

return var_0_0
