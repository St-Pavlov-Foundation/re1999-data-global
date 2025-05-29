module("modules.logic.scene.fight.comp.FightSceneEntityMgr", package.seeall)

local var_0_0 = class("FightSceneEntityMgr", BaseSceneUnitMgr)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.enableSpineRotate = true
	arg_1_0._forward = Vector3.New(0, 0, 0)
	arg_1_0._containerGO = gohelper.findChild(arg_1_0:getCurScene():getSceneContainerGO(), "Entitys")
end

function var_0_0.getEntityContainer(arg_2_0)
	return arg_2_0._containerGO
end

function var_0_0.onScenePrepared(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:removeAllUnits()

	local var_3_0 = FightModel.instance:getSpeed()
	local var_3_1 = gohelper.create3d(arg_3_0._containerGO, "SceneEntityMy")
	local var_3_2 = gohelper.create3d(arg_3_0._containerGO, "SceneEntityEnemy")

	arg_3_0._sceneEntityMySide = MonoHelper.addLuaComOnceToGo(var_3_1, FightEntityScene, FightEntityScene.MySideId)
	arg_3_0._sceneEntityEnemySide = MonoHelper.addLuaComOnceToGo(var_3_2, FightEntityScene, FightEntityScene.EnemySideId)

	arg_3_0._sceneEntityMySide:setSpeed(var_3_0)
	arg_3_0._sceneEntityEnemySide:setSpeed(var_3_0)
	arg_3_0:addUnit(arg_3_0._sceneEntityMySide)
	arg_3_0:addUnit(arg_3_0._sceneEntityEnemySide)
	arg_3_0:addASFDUnit()

	local var_3_3 = FightDataHelper.entityMgr:getMyNormalList()
	local var_3_4 = FightDataHelper.entityMgr:getEnemyNormalList()
	local var_3_5 = FightDataHelper.entityMgr:getMySubList()

	table.sort(var_3_5, FightEntityDataHelper.sortSubEntityList)

	local var_3_6 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide)
	local var_3_7 = FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide)
	local var_3_8 = #var_3_5 > 1 and 1 or #var_3_5

	arg_3_0._remainCount = #var_3_3 + #var_3_4 + var_3_8 + #var_3_6 + #var_3_7

	if arg_3_0._remainCount == 0 then
		arg_3_0:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
	else
		for iter_3_0, iter_3_1 in ipairs(var_3_3) do
			arg_3_0:buildSpine(iter_3_1)
		end

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			arg_3_0:buildSpine(iter_3_3)
		end

		if FightEntitySub.Online then
			for iter_3_4, iter_3_5 in ipairs(var_3_5) do
				arg_3_0:buildSubSpine(iter_3_5)

				break
			end
		else
			arg_3_0._remainCount = arg_3_0._remainCount - var_3_8
		end

		for iter_3_6, iter_3_7 in ipairs(var_3_6) do
			arg_3_0:buildSpine(iter_3_7)
		end

		for iter_3_8, iter_3_9 in ipairs(var_3_7) do
			arg_3_0:buildSpine(iter_3_9)
		end

		local var_3_9 = FightDataHelper.entityMgr:getAssistBoss()

		if var_3_9 then
			arg_3_0:buildSpine(var_3_9)
		end
	end

	arg_3_0._up = nil
	arg_3_0._up = CameraMgr.instance:getUnitCameraTrs().up

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)

	local var_3_10 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	var_3_10:AddPositionCallback(arg_3_0._adjustSpinesLookRotation, arg_3_0)
	var_3_10:AddRotationCallback(arg_3_0._adjustSpinesLookRotation, arg_3_0)
end

function var_0_0.addASFDUnit(arg_4_0)
	local var_4_0 = FightModel.instance:getSpeed()
	local var_4_1 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)

	if var_4_1 and not FightHelper.getEntity(var_4_1.id) then
		local var_4_2 = gohelper.create3d(arg_4_0._containerGO, "MyASFDEntityGo")
		local var_4_3 = MonoHelper.addLuaComOnceToGo(var_4_2, FightEntityASFD, var_4_1.id)

		var_4_3:setSpeed(var_4_0)
		arg_4_0:addUnit(var_4_3)
	end

	local var_4_4 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)

	if var_4_4 and not FightHelper.getEntity(var_4_4.id) then
		local var_4_5 = gohelper.create3d(arg_4_0._containerGO, "EnemyASFDEntityGo")
		local var_4_6 = MonoHelper.addLuaComOnceToGo(var_4_5, FightEntityASFD, var_4_4.id)

		var_4_6:setSpeed(var_4_0)
		arg_4_0:addUnit(var_4_6)
	end
end

function var_0_0.onSceneClose(arg_5_0)
	var_0_0.super.onSceneClose(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_5_0._onUpdateSpeed, arg_5_0)

	local var_5_0 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	var_5_0:RemovePositionCallback()
	var_5_0:RemoveRotationCallback()

	if arg_5_0._showSubWork then
		arg_5_0._showSubWork:disposeSelf()

		arg_5_0._showSubWork = nil
	end
end

function var_0_0._adjustSpinesLookRotation(arg_6_0)
	if not arg_6_0.enableSpineRotate then
		return
	end

	local var_6_0, var_6_1, var_6_2 = arg_6_0:_getCameraPos()
	local var_6_3 = arg_6_0:getTagUnitDict(SceneTag.UnitPlayer)
	local var_6_4 = arg_6_0:getTagUnitDict(SceneTag.UnitMonster)

	if var_6_3 then
		for iter_6_0, iter_6_1 in pairs(var_6_3) do
			arg_6_0:adjustSpineLookRotation(iter_6_1)
		end
	end

	if var_6_4 then
		for iter_6_2, iter_6_3 in pairs(var_6_4) do
			arg_6_0:adjustSpineLookRotation(iter_6_3)
		end
	end
end

function var_0_0.adjustSpineLookRotation(arg_7_0, arg_7_1)
	if not arg_7_0.enableSpineRotate then
		return
	end

	if arg_7_1 and not gohelper.isNil(arg_7_1.go) then
		local var_7_0 = arg_7_1.go.transform
		local var_7_1 = CameraMgr.instance:getMainCameraTrs()

		transformhelper.setLocalRotation(var_7_0, transformhelper.getLocalRotation(var_7_1))
	end
end

function var_0_0._getCameraPos(arg_8_0)
	if CameraMgr.instance:getSubCameraGO().activeInHierarchy then
		return transformhelper.getPos(CameraMgr.instance:getSubCameraTrs())
	end

	return transformhelper.getPos(CameraMgr.instance:getUnitCameraTrs())
end

function var_0_0._onUpdateSpeed(arg_9_0)
	local var_9_0 = FightModel.instance:getSpeed()

	for iter_9_0, iter_9_1 in pairs(arg_9_0:getTagUnitDict(SceneTag.UnitPlayer)) do
		iter_9_1:setSpeed(var_9_0)
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0:getTagUnitDict(SceneTag.UnitMonster)) do
		iter_9_3:setSpeed(var_9_0)
	end

	for iter_9_4, iter_9_5 in pairs(arg_9_0:getTagUnitDict(SceneTag.UnitNpc)) do
		iter_9_5:setSpeed(var_9_0)
	end

	arg_9_0._sceneEntityMySide:setSpeed(var_9_0)
	arg_9_0._sceneEntityEnemySide:setSpeed(var_9_0)
end

function var_0_0.compareUpdate(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._existBuffUidDict = {}

	local var_10_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0._existBuffUidDict[iter_10_1.id] = {}

		for iter_10_2, iter_10_3 in pairs(iter_10_1:getBuffDic()) do
			arg_10_0._existBuffUidDict[iter_10_1.id][iter_10_3.id] = iter_10_3
		end
	end

	arg_10_0._myStancePos2EntityId = {}
	arg_10_0._enemyStancePos2EntityId = {}

	for iter_10_4, iter_10_5 in pairs(arg_10_0:getTagUnitDict(SceneTag.UnitPlayer)) do
		arg_10_0._myStancePos2EntityId[iter_10_5:getMO().position] = iter_10_5.id
	end

	for iter_10_6, iter_10_7 in pairs(arg_10_0:getTagUnitDict(SceneTag.UnitMonster)) do
		arg_10_0._enemyStancePos2EntityId[iter_10_7:getMO().position] = iter_10_7.id
	end

	FightModel.instance:updateFight(arg_10_1, arg_10_2)
	arg_10_0:_rebuildEntity(SceneTag.UnitPlayer, arg_10_0._myStancePos2EntityId)
	arg_10_0:_rebuildEntity(SceneTag.UnitMonster, arg_10_0._enemyStancePos2EntityId)

	local var_10_1 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_10_8, iter_10_9 in ipairs(var_10_1) do
		local var_10_2 = arg_10_0._existBuffUidDict[iter_10_9.id]
		local var_10_3 = FightHelper.getEntity(iter_10_9.id)

		if var_10_3 and var_10_2 then
			for iter_10_10, iter_10_11 in pairs(var_10_2) do
				if not iter_10_9:getBuffMO(iter_10_10) then
					var_10_3.buff:delBuff(iter_10_11.uid)
				end
			end

			for iter_10_12, iter_10_13 in ipairs(iter_10_9:getBuffList()) do
				if not var_10_2[iter_10_13.id] then
					var_10_3.buff:addBuff(iter_10_13, true)
				end
			end
		end
	end
end

function var_0_0.changeWave(arg_11_0, arg_11_1)
	arg_11_0:compareUpdate(arg_11_1, true)
end

function var_0_0._rebuildEntity(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_2) do
		local var_12_0 = FightDataHelper.entityMgr:getById(iter_12_1)

		if not var_12_0 or var_12_0.position ~= iter_12_0 then
			arg_12_0:removeUnit(arg_12_1, iter_12_1)
		end

		if var_12_0 and not arg_12_0:getUnit(arg_12_1, var_12_0.id) then
			if FightDataHelper.entityMgr:isSub(iter_12_1) then
				if FightEntitySub.Online and var_12_0.side == FightEnum.EntitySide.MySide then
					arg_12_0:buildSubSpine(var_12_0)
				end
			else
				arg_12_0:buildSpine(var_12_0)
			end
		end
	end

	local var_12_1 = arg_12_1 == SceneTag.UnitPlayer and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	local var_12_2 = {}

	if var_12_1 == FightEnum.EntitySide.EnemySide then
		tabletool.addValues(var_12_2, FightDataHelper.entityMgr:getEnemyNormalList())
		tabletool.addValues(var_12_2, FightDataHelper.entityMgr:getEnemySpList())
	else
		var_12_2 = FightDataHelper.entityMgr:getNormalList(var_12_1)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		if not arg_12_0:getUnit(arg_12_1, iter_12_3.id) then
			arg_12_0:buildSpine(iter_12_3)
		end
	end

	if FightEntitySub.Online and var_12_1 == FightEnum.EntitySide.MySide then
		local var_12_3 = FightDataHelper.entityMgr:getMySubList()
		local var_12_4 = false

		for iter_12_4, iter_12_5 in ipairs(var_12_3) do
			if arg_12_0:getUnit(arg_12_1, iter_12_5.id) and arg_12_0:getEntityByPosId(arg_12_1, iter_12_5.position) then
				var_12_4 = true
			end
		end

		if not var_12_4 and var_12_3 and #var_12_3 > 0 then
			arg_12_0:buildSubSpine(var_12_3[1])
		end
	end
end

function var_0_0.getEntity(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getTagUnitDict(SceneTag.UnitPlayer)
	local var_13_1 = var_13_0 and var_13_0[arg_13_1]

	if var_13_1 then
		return var_13_1
	end

	local var_13_2 = arg_13_0:getTagUnitDict(SceneTag.UnitMonster)
	local var_13_3 = var_13_2 and var_13_2[arg_13_1]

	if var_13_3 then
		return var_13_3
	end

	local var_13_4 = arg_13_0:getTagUnitDict(SceneTag.UnitNpc)

	return var_13_4 and var_13_4[arg_13_1]
end

function var_0_0.getEntityByPosId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getTagUnitDict(arg_14_1)

	if var_14_0 then
		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if iter_14_1:getMO().position == arg_14_2 then
				return iter_14_1
			end
		end
	end
end

function var_0_0.buildSpine(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.side == FightEnum.EntitySide.MySide and FightEntityPlayer or FightEntityMonster
	local var_15_1 = lua_fight_assembled_monster.configDict[arg_15_1.skin]

	if var_15_1 then
		if var_15_1.part == 1 then
			var_15_0 = FightEntityAssembledMonsterMain
		else
			var_15_0 = FightEntityAssembledMonsterSub
		end
	end

	local var_15_2 = FightHelper.getEntitySpineLookDir(arg_15_1)
	local var_15_3 = arg_15_1:getIdName()
	local var_15_4 = gohelper.create3d(arg_15_0._containerGO, var_15_3)
	local var_15_5 = MonoHelper.addLuaComOnceToGo(var_15_4, var_15_0, arg_15_1.id)

	arg_15_0:addUnit(var_15_5)
	var_15_5:resetEntity()
	var_15_5:loadSpine(arg_15_0._onSpineLoaded, arg_15_0)
	var_15_5.spine:changeLookDir(var_15_2)

	if var_15_5.nameUI then
		var_15_5.nameUI:load(ResUrl.getSceneUIPrefab("fight", "fightname"))
	end

	var_15_5:setSpeed(FightModel.instance:getSpeed())

	return var_15_5
end

function var_0_0.buildSubSpine(arg_16_0, arg_16_1)
	if not FightEntitySub.Online then
		logError("替补不上线，该方法不应该被调用")
	end

	if arg_16_1.side == FightEnum.EntitySide.MySide then
		local var_16_0 = FightConfig.instance:getSkinCO(arg_16_1.skin)

		if var_16_0 and not string.nilorempty(var_16_0.alternateSpine) then
			local var_16_1 = FightHelper.getEntitySpineLookDir(arg_16_1)
			local var_16_2 = arg_16_1:getIdName()
			local var_16_3 = gohelper.create3d(arg_16_0._containerGO, var_16_2)
			local var_16_4 = MonoHelper.addLuaComOnceToGo(var_16_3, FightEntitySub, arg_16_1.id)

			arg_16_0:addUnit(var_16_4)
			var_16_4:resetEntity()
			var_16_4:loadSpine(arg_16_0._onSpineLoaded, arg_16_0)
			var_16_4.spine:changeLookDir(var_16_1)
			var_16_4:setSpeed(FightModel.instance:getSpeed())

			return var_16_4
		else
			logError("can't build sub spine, skin alternateSpine not exist: " .. (arg_16_1.skin or arg_16_1.modelId))
			arg_16_0:_onSpineLoaded()
		end
	else
		logError("can't build enemy sub spine")
	end
end

function var_0_0._onSpineLoaded(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2:getTag() ~= SceneTag.UnitNpc then
		arg_17_0._remainCount = arg_17_0._remainCount - 1

		if arg_17_0._remainCount == 0 then
			arg_17_0:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
		end
	end

	if arg_17_1 then
		local var_17_0 = arg_17_1.unitSpawn.spineRenderer:getReplaceMat()

		arg_17_0:adjustSpineLookRotation(arg_17_1.unitSpawn)
		GameSceneMgr.instance:getCurScene().bloom:addEntity(arg_17_2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_17_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_17_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, arg_17_2.id, var_17_0)
	end
end

function var_0_0.showSubEntity(arg_18_0)
	if arg_18_0._showSubWork then
		arg_18_0._showSubWork:disposeSelf()
	end

	arg_18_0._showSubWork = FightWorkBuildSubEntityAfterChangeHero.New()

	arg_18_0._showSubWork:start()
end

function var_0_0.buildTempSpineByName(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	local var_19_0 = tostring(arg_19_2)

	var_19_0 = string.nilorempty(var_19_0) and arg_19_1 or var_19_0

	if arg_19_0:getEntity(var_19_0) then
		var_19_0 = var_19_0 .. "_1"
	end

	local var_19_1 = gohelper.create3d(arg_19_0._containerGO, var_19_0)
	local var_19_2 = MonoHelper.addLuaComOnceToGo(var_19_1, FightEntityTemp, var_19_0)

	if arg_19_6 and arg_19_6.ingoreRainEffect then
		var_19_2.ingoreRainEffect = true
	end

	local var_19_3 = arg_19_4 and arg_19_3 and FightHelper.getSpineLookDir(arg_19_3) or SpineLookDir.Left

	var_19_2.spine:changeLookDir(var_19_3)
	var_19_2:setSide(arg_19_3)

	var_19_2.needLookCamera = false

	arg_19_0:addUnit(var_19_2)

	if arg_19_5 then
		var_19_2:loadSpineBySkin(arg_19_5, arg_19_0._onTempSpineLoaded, arg_19_0)
	else
		var_19_2:loadSpine(arg_19_1, arg_19_0._onTempSpineLoaded, arg_19_0)
	end

	var_19_2:setSpeed(FightModel.instance:getSpeed())

	return var_19_2
end

function var_0_0.buildTempSpine(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	local var_20_0 = arg_20_6

	if not var_20_0 then
		local var_20_1 = FightStrUtil.split(arg_20_1, "/")

		var_20_0 = var_20_1[#var_20_1]
	end

	local var_20_2 = gohelper.create3d(arg_20_0._containerGO, var_20_0)
	local var_20_3 = MonoHelper.addLuaComOnceToGo(var_20_2, arg_20_5 or FightEntityTemp, arg_20_2)

	var_20_3.needLookCamera = false

	if arg_20_4 then
		var_20_3.spine:setLayer(arg_20_4, true)
	end

	local var_20_4 = arg_20_3 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right

	var_20_3.spine:changeLookDir(var_20_4)
	var_20_3:setSide(arg_20_3)
	arg_20_0:addUnit(var_20_3)
	var_20_3:loadSpineBySpinePath(arg_20_1, arg_20_0._onTempSpineLoaded, arg_20_0)
	var_20_3:setSpeed(FightModel.instance:getSpeed())

	return var_20_3
end

function var_0_0._onTempSpineLoaded(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 then
		GameSceneMgr.instance:getCurScene().bloom:addEntity(arg_21_2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_21_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_21_1)
	end
end

function var_0_0.buildTempSceneEntity(arg_22_0, arg_22_1)
	local var_22_0 = "Temp_" .. arg_22_1
	local var_22_1 = gohelper.create3d(arg_22_0._containerGO, var_22_0)
	local var_22_2 = MonoHelper.addLuaComOnceToGo(var_22_1, FightEntityScene, var_22_0)

	var_22_2:setSpeed(FightModel.instance:getSpeed())
	arg_22_0:addUnit(var_22_2)

	return var_22_2
end

function var_0_0.destroyUnit(arg_23_0, arg_23_1)
	arg_23_1.IS_REMOVED = true

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_23_1.id) then
		FightSkillMgr.instance:afterTimeline(arg_23_1)
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDestroyEntity, arg_23_1)
	var_0_0.super.destroyUnit(arg_23_0, arg_23_1)
end

return var_0_0
