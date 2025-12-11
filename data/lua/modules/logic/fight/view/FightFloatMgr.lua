module("modules.logic.fight.view.FightFloatMgr", package.seeall)

local var_0_0 = class("FightFloatMgr")
local var_0_1 = 1
local var_0_2 = 5
local var_0_3 = 10
local var_0_4 = 0.3
local var_0_5 = 3
local var_0_6 = {
	[FightEnum.FloatType.buff] = true
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._loader = nil
	arg_1_0._id2PlayingItem = {}
	arg_1_0._type2ItemPool = {}
	arg_1_0._entityTimeDict = {}
	arg_1_0._dataQueue4 = {}
	arg_1_0._floatParent = nil
	arg_1_0._entityId2PlayingItems = {}
	arg_1_0.canShowFightNumUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function var_0_0.removeInterval(arg_2_0)
	var_0_4 = 0
end

function var_0_0.resetInterval(arg_3_0)
	var_0_4 = 0.3 / FightModel.instance:getUISpeed()
end

function var_0_0.init(arg_4_0)
	arg_4_0._classEnabled = true
	arg_4_0._loader = MultiAbLoader.New()

	arg_4_0._loader:addPath(arg_4_0:getFloatPrefab())
	arg_4_0._loader:startLoad(arg_4_0._onLoadCallback, arg_4_0)

	arg_4_0._entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
end

function var_0_0.getFloatPrefab(arg_5_0)
	local var_5_0 = FightUISwitchModel.instance:getCurUseFightUIFloatStyleId()
	local var_5_1 = var_5_0 and lua_fight_ui_style.configDict[var_5_0]

	if not var_5_1 then
		return ResUrl.getSceneUIPrefab("fight", "fightfloat")
	end

	local var_5_2 = var_5_1.itemId
	local var_5_3 = var_5_2 and lua_fight_float_effect.configDict[var_5_2]

	if not var_5_3 then
		logError(string.format("lua_fight_float_effect 战斗飘字表没找到 道具id : '%s' 对应的配置", var_5_2))

		return ResUrl.getSceneUIPrefab("fight", "fightfloat")
	end

	return ResUrl.getSceneUIPrefab("fight", var_5_3.prefabPath)
end

function var_0_0._onLoadCallback(arg_6_0)
	local var_6_0 = arg_6_0._loader:getFirstAssetItem():GetResource()
	local var_6_1 = ViewMgr.instance:getUILayer(UILayerName.Hud)

	arg_6_0._floatParent = gohelper.create2d(var_6_1, "Float")
	arg_6_0._floatParentRectTr = arg_6_0._floatParent:GetComponent(gohelper.Type_RectTransform)

	local var_6_2 = arg_6_0._floatParent.transform
	local var_6_3 = Vector2.zero

	var_6_2.anchorMin = var_6_3
	var_6_2.anchorMax = Vector2.one
	var_6_2.offsetMin = var_6_3
	var_6_2.offsetMax = var_6_3

	arg_6_0:_initPrefab(FightEnum.FloatType.equipeffect, gohelper.findChild(var_6_0, "equipeffect"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_restrain, gohelper.findChild(var_6_0, "crit_restrain"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_berestrain, gohelper.findChild(var_6_0, "crit_berestrain"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_heal, gohelper.findChild(var_6_0, "crit_heal"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_damage, gohelper.findChild(var_6_0, "crit_damage"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.restrain, gohelper.findChild(var_6_0, "restrain"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.berestrain, gohelper.findChild(var_6_0, "berestrain"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.heal, gohelper.findChild(var_6_0, "heal"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.damage, gohelper.findChild(var_6_0, "damage"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.buff, gohelper.findChild(var_6_0, "buff"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.miss, gohelper.findChild(var_6_0, "miss"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.total, gohelper.findChild(var_6_0, "total_damage"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.damage_origin, gohelper.findChild(var_6_0, "damage_origin"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_damage_origin, gohelper.findChild(var_6_0, "crit_damage_origin"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.total_origin, gohelper.findChild(var_6_0, "total_damage_origin"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.stress, gohelper.findChild(var_6_0, "stress"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.additional_damage, gohelper.findChild(var_6_0, "additional_damage"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.crit_additional_damage, gohelper.findChild(var_6_0, "crit_additional_damage"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.addShield, gohelper.findChild(var_6_0, "shield"), 0)
	arg_6_0:_initPrefab(FightEnum.FloatType.secret_key, gohelper.findChild(var_6_0, "secret_key"), 0)
end

function var_0_0.dispose(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._id2PlayingItem) do
		iter_7_1:stopFloat()
		arg_7_0._type2ItemPool[iter_7_1.type]:putObject(iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._type2ItemPool) do
		iter_7_3:dispose()
	end

	arg_7_0._id2PlayingItem = {}
	arg_7_0._type2ItemPool = {}
	arg_7_0._dataQueue4 = {}

	if arg_7_0._floatParent then
		gohelper.destroy(arg_7_0._floatParent)

		arg_7_0._floatParent = nil
	end

	if arg_7_0._loader then
		arg_7_0._loader:dispose()

		arg_7_0._loader = nil
	end

	arg_7_0._classEnabled = false
end

function var_0_0.clearFloatItem(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onTick, arg_8_0)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._id2PlayingItem) do
		iter_8_1:stopFloat()
		arg_8_0._type2ItemPool[iter_8_1.type]:putObject(iter_8_1)
	end

	arg_8_0._dataQueue4 = {}
end

function var_0_0.float(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if isDebugBuild and GMController.instance.hideFloat then
		return
	end

	if FightDataHelper.entityMgr:isAssistBoss(arg_9_1) then
		return
	end

	if FightDataHelper.entityMgr:isAct191Boss(arg_9_1) then
		return
	end

	if not arg_9_0._classEnabled then
		return
	end

	if arg_9_4 == nil then
		arg_9_4 = 0
	end

	if not arg_9_0.canShowFightNumUI and arg_9_2 ~= FightEnum.FloatType.buff and arg_9_2 ~= FightEnum.FloatType.miss then
		return
	end

	local var_9_0 = FightDataHelper.entityMgr:getById(arg_9_1)

	if var_9_0 and var_9_0:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return
	end

	table.insert(arg_9_0._dataQueue4, arg_9_1)
	table.insert(arg_9_0._dataQueue4, arg_9_2)
	table.insert(arg_9_0._dataQueue4, arg_9_3)
	table.insert(arg_9_0._dataQueue4, arg_9_4)
	table.insert(arg_9_0._dataQueue4, arg_9_5 or false)
	TaskDispatcher.runRepeat(arg_9_0._onTick, arg_9_0, 0.1 / FightModel.instance:getUISpeed())
end

function var_0_0.floatEnd(arg_10_0, arg_10_1)
	arg_10_0._id2PlayingItem[arg_10_1.id] = nil

	arg_10_0._type2ItemPool[arg_10_1.type]:putObject(arg_10_1)

	local var_10_0 = arg_10_0._entityId2PlayingItems[arg_10_1.entityId]

	if var_10_0 then
		tabletool.removeValue(var_10_0, arg_10_1)
	end
end

function var_0_0.nameUIBeforeDestroy(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.transform

	for iter_11_0 = var_11_0.childCount, 1, -1 do
		local var_11_1 = var_11_0:GetChild(iter_11_0 - 1)

		if string.find(var_11_1.name, "float") then
			if arg_11_0._floatParent then
				gohelper.addChild(arg_11_0._floatParent, var_11_1.gameObject)
				gohelper.setActive(var_11_1.gameObject, false)
			else
				gohelper.destroy(var_11_1.gameObject)
			end
		end
	end
end

function var_0_0._initPrefab(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0._floatParent

	arg_12_0._type2ItemPool[arg_12_1] = LuaObjPool.New(20, function()
		return FightFloatItem.New(arg_12_1, gohelper.clone(arg_12_2, var_12_0, "float" .. arg_12_1), arg_12_3)
	end, function(arg_14_0)
		arg_14_0:onDestroy()
	end, function(arg_15_0)
		arg_15_0:reset()
	end)
end

function var_0_0._onTick(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = Time.time
	local var_16_2

	for iter_16_0 = 1, #arg_16_0._dataQueue4, var_0_2 do
		local var_16_3 = arg_16_0._dataQueue4[iter_16_0]
		local var_16_4 = arg_16_0._dataQueue4[iter_16_0 + 1]
		local var_16_5 = arg_16_0._dataQueue4[iter_16_0 + 2]
		local var_16_6 = arg_16_0._dataQueue4[iter_16_0 + 3]
		local var_16_7 = arg_16_0._dataQueue4[iter_16_0 + 4]
		local var_16_8 = arg_16_0._entityTimeDict[var_16_3]

		if not var_0_6[var_16_4] and var_16_8 and var_16_1 - var_16_8 < var_0_4 then
			var_16_2 = var_16_2 or {}

			table.insert(var_16_2, var_16_3)
			table.insert(var_16_2, var_16_4)
			table.insert(var_16_2, var_16_5)
			table.insert(var_16_2, var_16_6)
			table.insert(var_16_2, var_16_7)
		else
			arg_16_0._entityTimeDict[var_16_3] = var_16_1

			arg_16_0:_doShowTip(var_16_3, var_16_4, var_16_5, var_16_6, var_16_7)

			var_16_0 = var_16_0 + 1
		end

		if var_16_0 == var_0_3 then
			break
		end
	end

	local var_16_9 = var_16_2 and #var_16_2 or 0

	for iter_16_1 = 1, var_16_9 do
		arg_16_0._dataQueue4[iter_16_1] = var_16_2[iter_16_1]
	end

	local var_16_10 = var_16_0 * var_0_2

	for iter_16_2 = var_16_9 + 1, #arg_16_0._dataQueue4 do
		arg_16_0._dataQueue4[iter_16_2] = arg_16_0._dataQueue4[iter_16_2 + var_16_10]
	end

	if #arg_16_0._dataQueue4 == 0 then
		TaskDispatcher.cancelTask(arg_16_0._onTick, arg_16_0)
	end
end

function var_0_0._doShowTip(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0._entityId2PlayingItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = {}
		arg_17_0._entityId2PlayingItems[arg_17_1] = var_17_0
	end

	if #var_17_0 >= var_0_5 then
		table.remove(var_17_0, #var_17_0):stopFloat()
	end

	local var_17_1 = FightHelper.getEntity(arg_17_1)
	local var_17_2 = arg_17_0._type2ItemPool[arg_17_2]:getObject()

	var_17_2.id = var_0_1
	var_0_1 = var_0_1 + 1
	arg_17_0._id2PlayingItem[var_17_2.id] = var_17_2

	table.insert(var_17_0, 1, var_17_2)

	if FightDataHelper.entityMgr:isAssistBoss(arg_17_1) then
		gohelper.addChild(arg_17_0._floatParent, var_17_2:getGO())
	elseif FightDataHelper.entityMgr:isAct191Boss(arg_17_1) then
		gohelper.addChild(arg_17_0._floatParent, var_17_2:getGO())
	elseif var_17_1 and var_17_1.nameUI then
		gohelper.addChild(var_17_1.nameUI:getFloatContainerGO(), var_17_2:getGO())
	end

	var_17_2:startFloat(arg_17_1, arg_17_3, arg_17_4, arg_17_5)

	local var_17_3 = 0
	local var_17_4 = var_17_1 and var_17_1.nameUI and var_17_1.nameUI:getFloatItemStartY() or 0

	var_17_2:setPos(var_17_3, var_17_4)

	if var_17_1 then
		local var_17_5 = var_17_1:getMO()

		if var_17_5 then
			local var_17_6 = lua_monster_skin.configDict[var_17_5.skin]

			if var_17_6 then
				local var_17_7 = FightStrUtil.instance:getSplitToNumberCache(var_17_6.floatOffset, "#")

				if #var_17_7 > 0 then
					var_17_2:setPos(var_17_7[1], var_17_7[2])

					var_17_3 = var_17_7[1]
					var_17_4 = var_17_7[2]
				end
			end
		end
	end

	if arg_17_4 and _G.type(arg_17_4) == "table" then
		if arg_17_4.pos_x then
			local var_17_8 = recthelper.rectToRelativeAnchorPos(Vector3.New(arg_17_4.pos_x, arg_17_4.pos_y, 0), arg_17_0._floatParent.transform)

			var_17_3 = var_17_8.x
			var_17_4 = var_17_8.y

			var_17_2:setPos(var_17_3, var_17_4)
			gohelper.addChild(arg_17_0._floatParent, var_17_2:getGO())
		end

		if arg_17_4.offset_x then
			local var_17_9 = var_17_3 + arg_17_4.offset_x

			var_17_4 = var_17_4 + arg_17_4.offset_y

			var_17_2:setPos(var_17_9, var_17_4)
		end
	end

	local var_17_10 = var_17_4

	if FightDataHelper.entityMgr:isAssistBoss(arg_17_1) or FightDataHelper.entityMgr:isAct191Boss(arg_17_1) then
		local var_17_11 = var_17_1:getHangPoint(ModuleEnum.SpineHangPoint.mounttop) or var_17_1:getHangPoint(ModuleEnum.SpineHangPointRoot)
		local var_17_12, var_17_13 = recthelper.worldPosToAnchorPos2(var_17_11.transform.position, arg_17_0._floatParentRectTr, nil, CameraMgr.instance:getUnitCamera())

		var_17_2:setPos(var_17_12, var_17_13)

		var_17_10 = var_17_13
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		var_17_10 = 50 + var_17_10

		iter_17_1:tweenPosY(var_17_10)

		if iter_17_1.type == FightEnum.FloatType.total or iter_17_1.type == FightEnum.FloatType.total_origin then
			var_17_10 = var_17_10 + 50
		end

		gohelper.setAsFirstSibling(iter_17_1:getGO())
	end
end

function var_0_0.hideEntityEquipFloat(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._entityId2PlayingItems[arg_18_1]

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			iter_18_1:hideEquipFloat()
		end
	end
end

function var_0_0.setCanShowFightNumUI(arg_19_0, arg_19_1)
	arg_19_0.canShowFightNumUI = arg_19_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
