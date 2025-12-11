module("modules.logic.scene.fight.comp.FightSceneEntityMgr", package.seeall)

local var_0_0 = class("FightSceneEntityMgr", BaseSceneUnitMgr)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._remainCount = 0

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
	arg_3_0:addVorpalithUnit()

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
			arg_3_0:buildSpine(iter_3_1, FightEnum.EntityCreateStage.Init)
		end

		for iter_3_2, iter_3_3 in ipairs(var_3_4) do
			arg_3_0:buildSpine(iter_3_3, FightEnum.EntityCreateStage.Init)
		end

		if FightEntitySub.Online then
			for iter_3_4, iter_3_5 in ipairs(var_3_5) do
				arg_3_0:buildSubSpine(iter_3_5, FightEnum.EntityCreateStage.Init)

				break
			end
		else
			arg_3_0._remainCount = arg_3_0._remainCount - var_3_8
		end

		for iter_3_6, iter_3_7 in ipairs(var_3_6) do
			arg_3_0:buildSpine(iter_3_7, FightEnum.EntityCreateStage.Init)
		end

		for iter_3_8, iter_3_9 in ipairs(var_3_7) do
			arg_3_0:buildSpine(iter_3_9, FightEnum.EntityCreateStage.Init)
		end

		local var_3_9 = FightDataHelper.entityMgr:getAssistBoss()

		if var_3_9 then
			arg_3_0:buildSpine(var_3_9, FightEnum.EntityCreateStage.Init)
		end

		local var_3_10 = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.MySide)

		for iter_3_10, iter_3_11 in ipairs(var_3_10) do
			arg_3_0:buildSpine(iter_3_11, FightEnum.EntityCreateStage.Init)
		end

		local var_3_11 = FightDataHelper.entityMgr:getSpFightEntities(FightEnum.EntitySide.EnemySide)

		for iter_3_12, iter_3_13 in ipairs(var_3_11) do
			arg_3_0:buildSpine(iter_3_13, FightEnum.EntityCreateStage.Init)
		end
	end

	arg_3_0._up = nil
	arg_3_0._up = CameraMgr.instance:getUnitCameraTrs().up

	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)

	local var_3_12 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	var_3_12:AddPositionCallback(arg_3_0._adjustSpinesLookRotation, arg_3_0)
	var_3_12:AddRotationCallback(arg_3_0._adjustSpinesLookRotation, arg_3_0)
end

function var_0_0.addVorpalithUnit(arg_4_0)
	local var_4_0 = FightDataHelper.entityMgr:getVorpalith()

	if not var_4_0 then
		return
	end

	local var_4_1 = FightModel.instance:getSpeed()
	local var_4_2 = gohelper.create3d(arg_4_0._containerGO, "Vorpalith")
	local var_4_3 = MonoHelper.addLuaComOnceToGo(var_4_2, FightEntityVorpalith, var_4_0.id)

	var_4_3:setSpeed(var_4_1)
	arg_4_0:addUnit(var_4_3)
end

function var_0_0.addASFDUnit(arg_5_0)
	local var_5_0 = FightModel.instance:getSpeed()
	local var_5_1 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)

	if var_5_1 and not FightHelper.getEntity(var_5_1.id) then
		local var_5_2 = gohelper.create3d(arg_5_0._containerGO, "MyASFDEntityGo")
		local var_5_3 = MonoHelper.addLuaComOnceToGo(var_5_2, FightEntityASFD, var_5_1.id)

		var_5_3:setSpeed(var_5_0)
		arg_5_0:addUnit(var_5_3)
	end

	local var_5_4 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)

	if var_5_4 and not FightHelper.getEntity(var_5_4.id) then
		local var_5_5 = gohelper.create3d(arg_5_0._containerGO, "EnemyASFDEntityGo")
		local var_5_6 = MonoHelper.addLuaComOnceToGo(var_5_5, FightEntityASFD, var_5_4.id)

		var_5_6:setSpeed(var_5_0)
		arg_5_0:addUnit(var_5_6)
	end
end

function var_0_0.onSceneClose(arg_6_0)
	var_0_0.super.onSceneClose(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_6_0._onUpdateSpeed, arg_6_0)

	local var_6_0 = ZProj.TransformListener.Get(CameraMgr.instance:getUnitCameraGO())

	var_6_0:RemovePositionCallback()
	var_6_0:RemoveRotationCallback()

	if arg_6_0._showSubWork then
		arg_6_0._showSubWork:disposeSelf()

		arg_6_0._showSubWork = nil
	end
end

function var_0_0._adjustSpinesLookRotation(arg_7_0)
	if not arg_7_0.enableSpineRotate then
		return
	end

	local var_7_0, var_7_1, var_7_2 = arg_7_0:_getCameraPos()
	local var_7_3 = arg_7_0:getTagUnitDict(SceneTag.UnitPlayer)
	local var_7_4 = arg_7_0:getTagUnitDict(SceneTag.UnitMonster)

	if var_7_3 then
		for iter_7_0, iter_7_1 in pairs(var_7_3) do
			arg_7_0:adjustSpineLookRotation(iter_7_1)
		end
	end

	if var_7_4 then
		for iter_7_2, iter_7_3 in pairs(var_7_4) do
			arg_7_0:adjustSpineLookRotation(iter_7_3)
		end
	end
end

function var_0_0.adjustSpineLookRotation(arg_8_0, arg_8_1)
	if not arg_8_0.enableSpineRotate then
		return
	end

	if arg_8_1 and not gohelper.isNil(arg_8_1.go) then
		local var_8_0 = arg_8_1.go.transform
		local var_8_1 = CameraMgr.instance:getMainCameraTrs()

		transformhelper.setLocalRotation(var_8_0, transformhelper.getLocalRotation(var_8_1))
	end
end

function var_0_0._getCameraPos(arg_9_0)
	if CameraMgr.instance:getSubCameraGO().activeInHierarchy then
		return transformhelper.getPos(CameraMgr.instance:getSubCameraTrs())
	end

	return transformhelper.getPos(CameraMgr.instance:getUnitCameraTrs())
end

function var_0_0._onUpdateSpeed(arg_10_0)
	local var_10_0 = FightModel.instance:getSpeed()

	for iter_10_0, iter_10_1 in pairs(arg_10_0:getTagUnitDict(SceneTag.UnitPlayer)) do
		iter_10_1:setSpeed(var_10_0)
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0:getTagUnitDict(SceneTag.UnitMonster)) do
		iter_10_3:setSpeed(var_10_0)
	end

	for iter_10_4, iter_10_5 in pairs(arg_10_0:getTagUnitDict(SceneTag.UnitNpc)) do
		iter_10_5:setSpeed(var_10_0)
	end

	arg_10_0._sceneEntityMySide:setSpeed(var_10_0)
	arg_10_0._sceneEntityEnemySide:setSpeed(var_10_0)
end

function var_0_0.compareUpdate(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._existBuffUidDict = {}

	local var_11_0 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		arg_11_0._existBuffUidDict[iter_11_1.id] = {}

		for iter_11_2, iter_11_3 in pairs(iter_11_1:getBuffDic()) do
			arg_11_0._existBuffUidDict[iter_11_1.id][iter_11_3.id] = iter_11_3
		end
	end

	arg_11_0._myStancePos2EntityId = {}
	arg_11_0._enemyStancePos2EntityId = {}

	for iter_11_4, iter_11_5 in pairs(arg_11_0:getTagUnitDict(SceneTag.UnitPlayer)) do
		arg_11_0._myStancePos2EntityId[iter_11_5:getMO().position] = iter_11_5.id
	end

	for iter_11_6, iter_11_7 in pairs(arg_11_0:getTagUnitDict(SceneTag.UnitMonster)) do
		arg_11_0._enemyStancePos2EntityId[iter_11_7:getMO().position] = iter_11_7.id
	end

	FightModel.instance:updateFight(arg_11_1, arg_11_2)
	arg_11_0:_rebuildEntity(SceneTag.UnitPlayer, arg_11_0._myStancePos2EntityId)
	arg_11_0:_rebuildEntity(SceneTag.UnitMonster, arg_11_0._enemyStancePos2EntityId)

	local var_11_1 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_11_8, iter_11_9 in ipairs(var_11_1) do
		local var_11_2 = arg_11_0._existBuffUidDict[iter_11_9.id]
		local var_11_3 = FightHelper.getEntity(iter_11_9.id)

		if var_11_3 and var_11_2 then
			for iter_11_10, iter_11_11 in pairs(var_11_2) do
				if not iter_11_9:getBuffMO(iter_11_10) then
					var_11_3.buff:delBuff(iter_11_11.uid)
				end
			end

			for iter_11_12, iter_11_13 in ipairs(iter_11_9:getBuffList()) do
				if not var_11_2[iter_11_13.id] then
					var_11_3.buff:addBuff(iter_11_13, true)
				end
			end
		end
	end
end

function var_0_0.changeWave(arg_12_0, arg_12_1)
	arg_12_0:compareUpdate(arg_12_1, true)
end

function var_0_0._rebuildEntity(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(arg_13_2) do
		local var_13_0 = FightDataHelper.entityMgr:getById(iter_13_1)

		if not var_13_0 or var_13_0.position ~= iter_13_0 then
			arg_13_0:removeUnit(arg_13_1, iter_13_1)
		end

		if var_13_0 and not arg_13_0:getUnit(arg_13_1, var_13_0.id) then
			if FightDataHelper.entityMgr:isSub(iter_13_1) then
				if FightEntitySub.Online and var_13_0.side == FightEnum.EntitySide.MySide then
					arg_13_0:buildSubSpine(var_13_0)
				end
			else
				arg_13_0:buildSpine(var_13_0)
			end
		end
	end

	local var_13_1 = arg_13_1 == SceneTag.UnitPlayer and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	local var_13_2 = {}

	if var_13_1 == FightEnum.EntitySide.EnemySide then
		tabletool.addValues(var_13_2, FightDataHelper.entityMgr:getEnemyNormalList())
		tabletool.addValues(var_13_2, FightDataHelper.entityMgr:getEnemySpList())
	else
		var_13_2 = FightDataHelper.entityMgr:getNormalList(var_13_1)
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		if not arg_13_0:getUnit(arg_13_1, iter_13_3.id) then
			arg_13_0:buildSpine(iter_13_3)
		end
	end

	if FightEntitySub.Online and var_13_1 == FightEnum.EntitySide.MySide then
		local var_13_3 = FightDataHelper.entityMgr:getMySubList()
		local var_13_4 = false

		for iter_13_4, iter_13_5 in ipairs(var_13_3) do
			if arg_13_0:getUnit(arg_13_1, iter_13_5.id) and arg_13_0:getEntityByPosId(arg_13_1, iter_13_5.position) then
				var_13_4 = true
			end
		end

		if not var_13_4 and var_13_3 and #var_13_3 > 0 then
			arg_13_0:buildSubSpine(var_13_3[1])
		end
	end
end

function var_0_0.getEntity(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getTagUnitDict(SceneTag.UnitPlayer)
	local var_14_1 = var_14_0 and var_14_0[arg_14_1]

	if var_14_1 then
		return var_14_1
	end

	local var_14_2 = arg_14_0:getTagUnitDict(SceneTag.UnitMonster)
	local var_14_3 = var_14_2 and var_14_2[arg_14_1]

	if var_14_3 then
		return var_14_3
	end

	local var_14_4 = arg_14_0:getTagUnitDict(SceneTag.UnitNpc)

	return var_14_4 and var_14_4[arg_14_1]
end

function var_0_0.getEntityByPosId(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getTagUnitDict(arg_15_1)

	if var_15_0 then
		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			if iter_15_1:getMO().position == arg_15_2 then
				return iter_15_1
			end
		end
	end
end

function var_0_0.getSpineClass(arg_16_0, arg_16_1)
	local var_16_0 = lua_fight_assembled_monster.configDict[arg_16_1.skin]

	if var_16_0 then
		if var_16_0.part == 1 then
			return FightEntityAssembledMonsterMain
		else
			return FightEntityAssembledMonsterSub
		end
	end

	if lua_fight_sp_500m_model.configDict[arg_16_1.modelId] then
		return FightEntityMonster_500M
	end

	return arg_16_1.side == FightEnum.EntitySide.MySide and FightEntityPlayer or FightEntityMonster
end

function var_0_0.buildSpine(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getSpineClass(arg_17_1)
	local var_17_1 = FightHelper.getEntitySpineLookDir(arg_17_1)
	local var_17_2 = arg_17_1:getIdName()
	local var_17_3 = gohelper.create3d(arg_17_0._containerGO, var_17_2)
	local var_17_4 = MonoHelper.addLuaComOnceToGo(var_17_3, var_17_0, arg_17_1.id)

	arg_17_0:addUnit(var_17_4)
	var_17_4:resetEntity()
	var_17_4:loadSpine(arg_17_0._onSpineLoaded, arg_17_0)
	var_17_4.spine:changeLookDir(var_17_1)
	var_17_4:setCreateStage(arg_17_2)

	if var_17_4.nameUI then
		var_17_4.nameUI:load(ResUrl.getSceneUIPrefab("fight", "fightname"))
	end

	var_17_4:setSpeed(FightModel.instance:getSpeed())

	return var_17_4
end

function var_0_0.buildSubSpine(arg_18_0, arg_18_1, arg_18_2)
	if not FightEntitySub.Online then
		logError("替补不上线，该方法不应该被调用")
	end

	if arg_18_1.side == FightEnum.EntitySide.MySide then
		local var_18_0 = FightConfig.instance:getSkinCO(arg_18_1.skin)

		if var_18_0 and not string.nilorempty(var_18_0.alternateSpine) then
			local var_18_1 = FightHelper.getEntitySpineLookDir(arg_18_1)
			local var_18_2 = arg_18_1:getIdName()
			local var_18_3 = gohelper.create3d(arg_18_0._containerGO, var_18_2)
			local var_18_4 = MonoHelper.addLuaComOnceToGo(var_18_3, FightEntitySub, arg_18_1.id)

			arg_18_0:addUnit(var_18_4)
			var_18_4:resetEntity()
			var_18_4:loadSpine(arg_18_0._onSpineLoaded, arg_18_0)
			var_18_4.spine:changeLookDir(var_18_1)
			var_18_4:setSpeed(FightModel.instance:getSpeed())
			var_18_4:setCreateStage(arg_18_2)

			return var_18_4
		else
			logError("can't build sub spine, skin alternateSpine not exist: " .. (arg_18_1.skin or arg_18_1.modelId))
			arg_18_0:_onSpineLoaded()
		end
	else
		logError("can't build enemy sub spine")
	end
end

function var_0_0._onSpineLoaded(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2:getTag() ~= SceneTag.UnitNpc then
		arg_19_0._remainCount = arg_19_0._remainCount - 1

		if arg_19_0._remainCount == 0 then
			arg_19_0:dispatchEvent(FightSceneEvent.OnAllEntityLoaded)
		end
	end

	if arg_19_1 then
		local var_19_0 = arg_19_1.unitSpawn.spineRenderer:getReplaceMat()

		arg_19_0:adjustSpineLookRotation(arg_19_1.unitSpawn)
		GameSceneMgr.instance:getCurScene().bloom:addEntity(arg_19_2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_19_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_19_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineMaterialChange, arg_19_2.id, var_19_0)
	end
end

function var_0_0.showSubEntity(arg_20_0)
	if arg_20_0._showSubWork then
		arg_20_0._showSubWork:disposeSelf()
	end

	arg_20_0._showSubWork = FightWorkBuildSubEntityAfterChangeHero.New()

	arg_20_0._showSubWork:start()
end

function var_0_0.buildTempSpineByName(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6)
	local var_21_0 = tostring(arg_21_2)

	var_21_0 = string.nilorempty(var_21_0) and arg_21_1 or var_21_0

	if arg_21_0:getEntity(var_21_0) then
		var_21_0 = var_21_0 .. "_1"
	end

	local var_21_1 = gohelper.create3d(arg_21_0._containerGO, var_21_0)
	local var_21_2 = MonoHelper.addLuaComOnceToGo(var_21_1, FightEntityTemp, var_21_0)

	if arg_21_6 and arg_21_6.ingoreRainEffect then
		var_21_2.ingoreRainEffect = true
	end

	local var_21_3 = arg_21_4 and arg_21_3 and FightHelper.getSpineLookDir(arg_21_3) or SpineLookDir.Left

	var_21_2.spine:changeLookDir(var_21_3)
	var_21_2:setSide(arg_21_3)

	var_21_2.needLookCamera = false

	arg_21_0:addUnit(var_21_2)

	if arg_21_5 then
		var_21_2:loadSpineBySkin(arg_21_5, arg_21_0._onTempSpineLoaded, arg_21_0)
	else
		var_21_2:loadSpine(arg_21_1, arg_21_0._onTempSpineLoaded, arg_21_0)
	end

	var_21_2:setSpeed(FightModel.instance:getSpeed())

	return var_21_2
end

function var_0_0.buildTempSpine(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6)
	local var_22_0 = arg_22_6

	if not var_22_0 then
		local var_22_1 = FightStrUtil.split(arg_22_1, "/")

		var_22_0 = var_22_1[#var_22_1]
	end

	local var_22_2 = gohelper.create3d(arg_22_0._containerGO, var_22_0)
	local var_22_3 = MonoHelper.addLuaComOnceToGo(var_22_2, arg_22_5 or FightEntityTemp, arg_22_2)

	var_22_3.needLookCamera = false

	if arg_22_4 then
		var_22_3.spine:setLayer(arg_22_4, true)
	end

	local var_22_4 = arg_22_3 == FightEnum.EntitySide.MySide and SpineLookDir.Left or SpineLookDir.Right

	var_22_3.spine:changeLookDir(var_22_4)
	var_22_3:setSide(arg_22_3)
	arg_22_0:addUnit(var_22_3)
	var_22_3:loadSpineBySpinePath(arg_22_1, arg_22_0._onTempSpineLoaded, arg_22_0)
	var_22_3:setSpeed(FightModel.instance:getSpeed())

	return var_22_3
end

function var_0_0._onTempSpineLoaded(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 then
		GameSceneMgr.instance:getCurScene().bloom:addEntity(arg_23_2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_23_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_23_1)
	end
end

function var_0_0.buildTempSceneEntity(arg_24_0, arg_24_1)
	local var_24_0 = "Temp_" .. arg_24_1
	local var_24_1 = gohelper.create3d(arg_24_0._containerGO, var_24_0)
	local var_24_2 = MonoHelper.addLuaComOnceToGo(var_24_1, FightEntityScene, var_24_0)

	var_24_2:setSpeed(FightModel.instance:getSpeed())
	arg_24_0:addUnit(var_24_2)

	return var_24_2
end

function var_0_0.destroyUnit(arg_25_0, arg_25_1)
	if arg_25_1.IS_REMOVED then
		return
	end

	arg_25_1.IS_REMOVED = true

	if FightSkillMgr.instance:isEntityPlayingTimeline(arg_25_1.id) then
		FightSkillMgr.instance:afterTimeline(arg_25_1)
	end

	FightController.instance:dispatchEvent(FightEvent.BeforeDestroyEntity, arg_25_1)
	var_0_0.super.destroyUnit(arg_25_0, arg_25_1)
end

return var_0_0
