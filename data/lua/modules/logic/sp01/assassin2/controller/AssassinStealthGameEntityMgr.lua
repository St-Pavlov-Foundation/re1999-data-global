module("modules.logic.sp01.assassin2.controller.AssassinStealthGameEntityMgr", package.seeall)

local var_0_0 = class("AssassinStealthGameEntityMgr", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearAll()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearAll()
end

function var_0_0.clearAll(arg_3_0)
	if arg_3_0._loader then
		arg_3_0._loader:dispose()

		arg_3_0._loader = nil
	end

	arg_3_0._hasLoadedRes = false

	UIBlockMgr.instance:endBlock(AssassinEnum.BlockKey.LoadGameRes)
	arg_3_0:clearAllEntity(true)
	arg_3_0:clearMap()
end

function var_0_0.clearAllEntity(arg_4_0, arg_4_1)
	if arg_4_1 then
		if arg_4_0._heroDict then
			for iter_4_0, iter_4_1 in pairs(arg_4_0._heroDict) do
				iter_4_1:destroy()
			end
		end

		arg_4_0._heroDict = {}
	end

	if arg_4_0._enemyDict then
		for iter_4_2, iter_4_3 in pairs(arg_4_0._enemyDict) do
			iter_4_3:destroy()
		end
	end

	arg_4_0._enemyDict = {}
end

function var_0_0.clearMap(arg_5_0)
	arg_5_0._gridDict = arg_5_0:getUserDataTb_()
	arg_5_0._horWallDict = arg_5_0:getUserDataTb_()
	arg_5_0._verWallDict = arg_5_0:getUserDataTb_()
	arg_5_0._goGridDecors = nil
	arg_5_0._goEntities = nil
	arg_5_0._goGridEffs = nil
	arg_5_0._goInfo = nil
	arg_5_0._transGridDecors = nil
	arg_5_0._transEntities = nil
	arg_5_0._transGridEffs = nil
	arg_5_0._transInfo = nil
end

function var_0_0.onInitBaseMap(arg_6_0, arg_6_1)
	arg_6_0:clearAll()
	arg_6_0:_initMap(arg_6_1)
	arg_6_0:_startLoadRes()
	UnityEngine.Canvas.ForceUpdateCanvases()
end

function var_0_0._initMap(arg_7_0, arg_7_1)
	arg_7_0._gridDict = {}
	arg_7_0._horWallDict = {}
	arg_7_0._verWallDict = {}

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.MapSize, true)

	for iter_7_0 = 1, var_7_3 do
		local var_7_4 = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, 0, iter_7_0)

		var_7_2[#var_7_2 + 1] = tonumber(var_7_4)
	end

	for iter_7_1 = 1, var_7_3 do
		local var_7_5 = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, iter_7_1, 0)

		var_7_1[#var_7_1 + 1] = tonumber(var_7_5)

		for iter_7_2 = 1, var_7_3 do
			local var_7_6 = string.format("%s%s", iter_7_1, iter_7_2)
			local var_7_7 = string.format("%s%s%s", AssassinEnum.StealthConst.HorWallSign, iter_7_1, iter_7_2)
			local var_7_8 = string.format("%s%s%s", AssassinEnum.StealthConst.VerWallSign, iter_7_1, iter_7_2)

			var_7_0[#var_7_0 + 1] = tonumber(var_7_6)
			var_7_1[#var_7_1 + 1] = tonumber(var_7_7)
			var_7_2[#var_7_2 + 1] = tonumber(var_7_8)
		end
	end

	local var_7_9 = gohelper.findChild(arg_7_1, "#go_grids")
	local var_7_10 = gohelper.findChild(arg_7_1, "#go_grids/#go_gridItem")
	local var_7_11 = gohelper.findChild(arg_7_1, "#go_walls/#go_hor")
	local var_7_12 = gohelper.findChild(arg_7_1, "#go_walls/#go_hor/#go_horWall")
	local var_7_13 = gohelper.findChild(arg_7_1, "#go_walls/#go_ver")
	local var_7_14 = gohelper.findChild(arg_7_1, "#go_walls/#go_ver/#go_verWall")

	arg_7_0._goGridDecors = gohelper.findChild(arg_7_1, "#go_gridDecors")
	arg_7_0._goEntities = gohelper.findChild(arg_7_1, "#go_entities")
	arg_7_0._goGridEffs = gohelper.findChild(arg_7_1, "#go_gridEffs")
	arg_7_0._goInfo = gohelper.findChild(arg_7_1, "#go_infos")
	arg_7_0._transGridDecors = arg_7_0._goGridDecors.transform
	arg_7_0._transEntities = arg_7_0._goEntities.transform
	arg_7_0._transGridEffs = arg_7_0._goGridEffs.transform
	arg_7_0._transInfo = arg_7_0._goInfo.transform

	gohelper.CreateObjList(arg_7_0, arg_7_0._onCreateGridItem, var_7_0, var_7_9, var_7_10, AssassinStealthGameGridItem)
	gohelper.CreateObjList(arg_7_0, arg_7_0._onCreateHorWallItem, var_7_1, var_7_11, var_7_12, AssassinStealthGameWallItem)
	gohelper.CreateObjList(arg_7_0, arg_7_0._onCreateVerWallItem, var_7_2, var_7_13, var_7_14, AssassinStealthGameWallItem)
end

function var_0_0._onCreateGridItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_1:initData(arg_8_2)
	arg_8_1:setEffParent(arg_8_0._goGridEffs, arg_8_0._transGridEffs)

	arg_8_0._gridDict[arg_8_2] = arg_8_1
end

function var_0_0._onCreateHorWallItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_1:initData(arg_9_2, true)

	arg_9_0._horWallDict[arg_9_2] = arg_9_1
end

function var_0_0._onCreateVerWallItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:initData(arg_10_2, false)

	arg_10_0._verWallDict[arg_10_2] = arg_10_1
end

function var_0_0._startLoadRes(arg_11_0)
	if arg_11_0._loader then
		arg_11_0._loader:dispose()
	end

	arg_11_0._hasLoadedRes = false
	arg_11_0._loader = MultiAbLoader.New()

	if string.nilorempty(next(AssassinEnum.StealthRes)) then
		arg_11_0:_loadResFinished()
	else
		for iter_11_0, iter_11_1 in pairs(AssassinEnum.StealthRes) do
			arg_11_0._loader:addPath(iter_11_1)
		end

		UIBlockMgr.instance:startBlock(AssassinEnum.BlockKey.LoadGameRes)
		arg_11_0._loader:startLoad(arg_11_0._loadResFinished, arg_11_0)
	end
end

function var_0_0._loadResFinished(arg_12_0)
	UIBlockMgr.instance:endBlock(AssassinEnum.BlockKey.LoadGameRes)

	arg_12_0._hasLoadedRes = true

	arg_12_0:setupMap()
end

function var_0_0.setupMap(arg_13_0)
	arg_13_0:_setMap()
	arg_13_0:_initEntities()
end

function var_0_0._setMap(arg_14_0)
	UnityEngine.Canvas.ForceUpdateCanvases()

	local var_14_0 = AssassinStealthGameModel.instance:getMapId()

	for iter_14_0, iter_14_1 in pairs(arg_14_0._gridDict) do
		iter_14_1:setMap(var_14_0)
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._horWallDict) do
		iter_14_3:setMap(var_14_0)
	end

	for iter_14_4, iter_14_5 in pairs(arg_14_0._verWallDict) do
		iter_14_5:setMap(var_14_0)
	end

	local var_14_1 = AssassinConfig.instance:getMapStairList(var_14_0)
	local var_14_2 = gohelper.findChild(arg_14_0._goGridDecors, "#go_stair")

	gohelper.CreateObjList(arg_14_0, arg_14_0._onCreateStairItem, var_14_1, arg_14_0._goGridDecors, var_14_2)
end

function var_0_0._onCreateStairItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1.transform
	local var_15_1 = arg_15_2.gridId
	local var_15_2 = arg_15_2.dir
	local var_15_3 = arg_15_0:getGridItem(var_15_1, true)
	local var_15_4 = var_15_3 and var_15_3:getEntranceNodeTrans(var_15_2)

	if var_15_4 then
		var_15_0.pivot = var_15_4.pivot
		var_15_0.anchorMin = var_15_4.anchorMin
		var_15_0.anchorMax = var_15_4.anchorMax

		local var_15_5 = var_15_4.rotation

		transformhelper.setRotation(var_15_0, var_15_5.x, var_15_5.y, var_15_5.z, var_15_5.w)

		local var_15_6 = var_15_4.position
		local var_15_7 = arg_15_0._transGridDecors:InverseTransformPoint(var_15_6)

		transformhelper.setLocalPosXY(var_15_0, var_15_7.x, var_15_7.y)
	end

	arg_15_1.name = string.format("%s-%s", var_15_1, var_15_2)
end

function var_0_0._initEntities(arg_16_0)
	arg_16_0:clearAllEntity(true)

	local var_16_0 = arg_16_0._loader:getAssetItem(AssassinEnum.StealthRes.HeroEntity)

	if var_16_0 then
		local var_16_1 = AssassinStealthGameModel.instance:getHeroUidList()

		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			local var_16_2 = gohelper.clone(var_16_0:GetResource(), arg_16_0._goEntities)
			local var_16_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_2, AssassinStealthGameHeroEntity, iter_16_1)

			arg_16_0._heroDict[iter_16_1] = var_16_3
		end
	end

	if arg_16_0._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity) then
		local var_16_4 = AssassinStealthGameModel.instance:getEnemyUidList()

		arg_16_0:addEnemyEntityByList(var_16_4)
	end
end

function var_0_0.addEnemyEntityByList(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity)

	if not var_17_0 then
		logError("AssassinStealthGameEntityMgr:addEnemyEntityByList error, no enemyAssetItem")

		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0:addEnemyEntity(iter_17_1, var_17_0)
	end
end

function var_0_0.addEnemyEntity(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0:getEnemyEntity(arg_18_1) then
		logError(string.format("AssassinStealthGameEntityMgr:addEnemyEntity error, enemy repeated, enemyUid:%s", arg_18_1))

		return
	end

	arg_18_2 = arg_18_2 or arg_18_0._loader:getAssetItem(AssassinEnum.StealthRes.EnemyEntity)

	if not arg_18_2 then
		logError("AssassinStealthGameEntityMgr:addEnemyEntity error, no enemyAssetItem")

		return
	end

	local var_18_0 = gohelper.clone(arg_18_2:GetResource(), arg_18_0._goEntities)
	local var_18_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_0, AssassinStealthGameEnemyEntity, arg_18_1)

	arg_18_0._enemyDict[arg_18_1] = var_18_1
end

function var_0_0.removeEnemyEntity(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getEnemyEntity(arg_19_1, true)

	if var_19_0 then
		var_19_0:playRemove()
	end

	arg_19_0._enemyDict[arg_19_1] = nil
end

function var_0_0.changeSkillPropTargetLayer(arg_20_0, arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in pairs(arg_20_0._gridDict) do
		if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(iter_20_0) then
			var_20_0 = true

			iter_20_1:changeHighlightClickParent(arg_20_1)
		else
			iter_20_1:changeHighlightClickParent()
		end
	end

	for iter_20_2, iter_20_3 in pairs(arg_20_0._heroDict) do
		if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(iter_20_2) then
			var_20_0 = true

			iter_20_3:changeParent(arg_20_1)
		else
			iter_20_3:changeParent(arg_20_0._transEntities)
		end
	end

	for iter_20_4, iter_20_5 in pairs(arg_20_0._enemyDict) do
		if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(iter_20_4) then
			var_20_0 = true

			iter_20_5:changeParent(arg_20_1)
		else
			iter_20_5:changeParent(arg_20_0._transEntities)
		end
	end

	return var_20_0
end

function var_0_0.refreshSkillPropTargetPos(arg_21_0)
	local var_21_0, var_21_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if not var_21_0 then
		return
	end

	local var_21_2 = AssassinConfig.instance:getSkillPropTargetType(var_21_0, var_21_1)

	if var_21_2 == AssassinEnum.SkillPropTargetType.Grid then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._gridDict) do
			if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(iter_21_0) then
				iter_21_1:refreshHighlightPos()
			end
		end
	end

	if var_21_2 == AssassinEnum.SkillPropTargetType.Hero then
		for iter_21_2, iter_21_3 in pairs(arg_21_0._heroDict) do
			if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToHero(iter_21_2) then
				iter_21_3:refreshPos()
			end
		end
	end

	if var_21_2 == AssassinEnum.SkillPropTargetType.Enemy then
		for iter_21_4, iter_21_5 in pairs(arg_21_0._enemyDict) do
			if AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(iter_21_4) then
				iter_21_5:refreshPos()
			end
		end
	end
end

function var_0_0.changeEnemyParent(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0:getEnemyEntity(arg_22_1, true)

	if not var_22_0 then
		return
	end

	var_22_0:changeParent(arg_22_2 or arg_22_0._transEntities)
end

function var_0_0.refreshAllGrid(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._gridDict) do
		iter_23_1:refresh()
	end
end

function var_0_0.refreshGrid(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:getGridItem(arg_24_1, true)

	if var_24_0 then
		var_24_0:refresh(arg_24_2)
	end
end

function var_0_0.refreshAllHeroEntities(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._heroDict) do
		iter_25_1:refresh()
	end
end

function var_0_0.refreshHeroEntity(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:getHeroEntity(arg_26_1, true)

	if var_26_0 then
		var_26_0:refresh(arg_26_2)
	end
end

function var_0_0.refreshAllEnemyEntities(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0._enemyDict) do
		iter_27_1:refresh()
	end
end

function var_0_0.refreshEnemyEntity(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getEnemyEntity(arg_28_1, true)

	if var_28_0 then
		var_28_0:refresh(arg_28_2)
	end
end

function var_0_0.playHeroEff(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0:getHeroEntity(arg_29_1, true)

	if not var_29_0 then
		return
	end

	var_29_0:playEffect(arg_29_2)
end

function var_0_0.playEnemyEff(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	local var_30_0 = arg_30_0:getEnemyEntity(arg_30_1, true)

	if not var_30_0 then
		return
	end

	var_30_0:playEffect(arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
end

function var_0_0.playGridScanEff(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = arg_31_0:getGridItem(arg_31_1, true)

	if not (var_31_0 and var_31_0:isShow()) then
		return
	end

	var_31_0:playEffect(AssassinEnum.EffectId.ScanEffectId, arg_31_2, arg_31_3, arg_31_4)
end

function var_0_0.playGridEff(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getGridItem(arg_32_1, true)

	if not (var_32_0 and var_32_0:isShow()) then
		return
	end

	var_32_0:playEffect(arg_32_2)
end

function var_0_0.getGridItem(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0._gridDict[arg_33_1]

	if not arg_33_1 and arg_33_2 then
		logError(string.format("AssassinStealthGameEntityMgr:getGridItem error, no grid Item, gridId:%s", arg_33_1))
	end

	return var_33_0
end

function var_0_0.getGridPointGoPosInEntityLayer(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = Vector2.zero
	local var_34_1 = arg_34_0:getGridItem(arg_34_1, true)
	local var_34_2 = var_34_1 and var_34_1:getPointTrans(arg_34_2)

	if var_34_2 then
		local var_34_3 = var_34_2.position

		if not gohelper.isNil(arg_34_3) then
			var_34_0 = arg_34_3:InverseTransformPoint(var_34_3)
		else
			var_34_0 = arg_34_0._transEntities:InverseTransformPoint(var_34_3)
		end
	end

	return var_34_0
end

function var_0_0.getHeroEntity(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0._heroDict[arg_35_1]

	if not var_35_0 and arg_35_2 then
		logError(string.format("AssassinStealthGameEntityMgr:getHeroEntity error, no entity uid:%s", arg_35_1))
	end

	return var_35_0
end

function var_0_0.getEnemyEntity(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0._enemyDict[arg_36_1]

	if not var_36_0 and arg_36_2 then
		logError(string.format("AssassinStealthGameEntityMgr:getEnemyEntity error, no entity uid:%s", arg_36_1))
	end

	return var_36_0
end

function var_0_0.getEnemyLocalPos(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getEnemyEntity(arg_37_1, true)

	if not var_37_0 then
		return
	end

	return var_37_0:getLocalPos()
end

function var_0_0.getInfoTrans(arg_38_0)
	return arg_38_0._transInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0
