module("modules.logic.fight.view.FightFloatMgr", package.seeall)

slot0 = class("FightFloatMgr")
slot1 = 1
slot2 = 4
slot3 = 10
slot4 = 0.3
slot5 = 3
slot6 = {
	[FightEnum.FloatType.buff] = true
}

function slot0.ctor(slot0)
	slot0._loader = nil
	slot0._id2PlayingItem = {}
	slot0._type2ItemPool = {}
	slot0._entityTimeDict = {}
	slot0._dataQueue4 = {}
	slot0._floatParent = nil
	slot0._entityId2PlayingItems = {}
	slot0.canShowFightNumUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function slot0.removeInterval(slot0)
	uv0 = 0
end

function slot0.resetInterval(slot0)
	uv0 = 0.3 / FightModel.instance:getUISpeed()
end

function slot0.init(slot0)
	slot0._classEnabled = true
	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getFloatPrefab())
	slot0._loader:startLoad(slot0._onLoadCallback, slot0)

	slot0._entityMgr = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
end

function slot0.getFloatPrefab(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(lua_fight_float_effect.configList) do
		slot8 = true
		slot9 = false

		if not string.nilorempty(slot7.startTime) then
			slot8 = TimeUtil.stringToTimestamp(slot7.startTime) <= os.time()
		end

		if not string.nilorempty(slot7.endTime) then
			slot9 = TimeUtil.stringToTimestamp(slot7.endTime) <= slot2
		end

		if slot8 and not slot9 then
			if not slot1 then
				slot1 = slot7
			elseif slot1.priority < slot7.priority then
				slot1 = slot7
			end
		end
	end

	if not slot1 then
		return ResUrl.getSceneUIPrefab("fight", "fightfloat")
	end

	return ResUrl.getSceneUIPrefab("fight", slot1.prefabPath)
end

function slot0._onLoadCallback(slot0)
	slot2 = slot0._loader:getFirstAssetItem():GetResource()
	slot0._floatParent = gohelper.create2d(ViewMgr.instance:getUILayer(UILayerName.Hud), "Float")
	slot0._floatParentRectTr = slot0._floatParent:GetComponent(gohelper.Type_RectTransform)
	slot4 = slot0._floatParent.transform
	slot5 = Vector2.zero
	slot4.anchorMin = slot5
	slot4.anchorMax = Vector2.one
	slot4.offsetMin = slot5
	slot4.offsetMax = slot5

	slot0:_initPrefab(FightEnum.FloatType.equipeffect, gohelper.findChild(slot2, "equipeffect"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_restrain, gohelper.findChild(slot2, "crit_restrain"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_berestrain, gohelper.findChild(slot2, "crit_berestrain"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_heal, gohelper.findChild(slot2, "crit_heal"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_damage, gohelper.findChild(slot2, "crit_damage"), 0)
	slot0:_initPrefab(FightEnum.FloatType.restrain, gohelper.findChild(slot2, "restrain"), 0)
	slot0:_initPrefab(FightEnum.FloatType.berestrain, gohelper.findChild(slot2, "berestrain"), 0)
	slot0:_initPrefab(FightEnum.FloatType.heal, gohelper.findChild(slot2, "heal"), 0)
	slot0:_initPrefab(FightEnum.FloatType.damage, gohelper.findChild(slot2, "damage"), 0)
	slot0:_initPrefab(FightEnum.FloatType.buff, gohelper.findChild(slot2, "buff"), 0)
	slot0:_initPrefab(FightEnum.FloatType.miss, gohelper.findChild(slot2, "miss"), 0)
	slot0:_initPrefab(FightEnum.FloatType.total, gohelper.findChild(slot2, "total_damage"), 0)
	slot0:_initPrefab(FightEnum.FloatType.damage_origin, gohelper.findChild(slot2, "damage_origin"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_damage_origin, gohelper.findChild(slot2, "crit_damage_origin"), 0)
	slot0:_initPrefab(FightEnum.FloatType.total_origin, gohelper.findChild(slot2, "total_damage_origin"), 0)
	slot0:_initPrefab(FightEnum.FloatType.stress, gohelper.findChild(slot2, "stress"), 0)
	slot0:_initPrefab(FightEnum.FloatType.additional_damage, gohelper.findChild(slot2, "additional_damage"), 0)
	slot0:_initPrefab(FightEnum.FloatType.crit_additional_damage, gohelper.findChild(slot2, "crit_additional_damage"), 0)
	slot0:_initPrefab(FightEnum.FloatType.addShield, gohelper.findChild(slot2, "shield"), 0)
end

function slot0.dispose(slot0)
	for slot4, slot5 in pairs(slot0._id2PlayingItem) do
		slot5:stopFloat()
		slot0._type2ItemPool[slot5.type]:putObject(slot5)
	end

	for slot4, slot5 in pairs(slot0._type2ItemPool) do
		slot5:dispose()
	end

	slot0._id2PlayingItem = {}
	slot0._type2ItemPool = {}
	slot0._dataQueue4 = {}

	if slot0._floatParent then
		gohelper.destroy(slot0._floatParent)

		slot0._floatParent = nil
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._classEnabled = false
end

function slot0.clearFloatItem(slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)

	for slot4, slot5 in pairs(slot0._id2PlayingItem) do
		slot5:stopFloat()
		slot0._type2ItemPool[slot5.type]:putObject(slot5)
	end

	slot0._dataQueue4 = {}
end

function slot0.float(slot0, slot1, slot2, slot3, slot4)
	if FightDataHelper.entityMgr:isAssistBoss(slot1) then
		return
	end

	if not slot0._classEnabled then
		return
	end

	if slot4 == nil then
		slot4 = 0
	end

	if not slot0.canShowFightNumUI and slot2 ~= FightEnum.FloatType.buff and slot2 ~= FightEnum.FloatType.miss then
		return
	end

	if FightDataHelper.entityMgr:getById(slot1) and slot5:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return
	end

	table.insert(slot0._dataQueue4, slot1)
	table.insert(slot0._dataQueue4, slot2)
	table.insert(slot0._dataQueue4, slot3)
	table.insert(slot0._dataQueue4, slot4)
	TaskDispatcher.runRepeat(slot0._onTick, slot0, 0.1 / FightModel.instance:getUISpeed())
end

function slot0.floatEnd(slot0, slot1)
	slot0._id2PlayingItem[slot1.id] = nil

	slot0._type2ItemPool[slot1.type]:putObject(slot1)

	if slot0._entityId2PlayingItems[slot1.entityId] then
		tabletool.removeValue(slot2, slot1)
	end
end

function slot0.nameUIBeforeDestroy(slot0, slot1)
	for slot6 = slot1.transform.childCount, 1, -1 do
		if string.find(slot2:GetChild(slot6 - 1).name, "float") then
			if slot0._floatParent then
				gohelper.addChild(slot0._floatParent, slot7.gameObject)
				gohelper.setActive(slot7.gameObject, false)
			else
				gohelper.destroy(slot7.gameObject)
			end
		end
	end
end

function slot0._initPrefab(slot0, slot1, slot2, slot3)
	slot4 = slot0._floatParent
	slot0._type2ItemPool[slot1] = LuaObjPool.New(20, function ()
		return FightFloatItem.New(uv0, gohelper.clone(uv1, uv2, "float" .. uv0), uv3)
	end, function (slot0)
		slot0:onDestroy()
	end, function (slot0)
		slot0:reset()
	end)
end

function slot0._onTick(slot0)
	slot1 = 0

	for slot7 = 1, #slot0._dataQueue4, uv0 do
		slot12 = slot0._entityTimeDict[slot0._dataQueue4[slot7]]

		if not uv1[slot0._dataQueue4[slot7 + 1]] and slot12 and Time.time - slot12 < uv2 then
			slot3 = nil or {}

			table.insert(slot3, slot8)
			table.insert(slot3, slot9)
			table.insert(slot3, slot0._dataQueue4[slot7 + 2])
			table.insert(slot3, slot0._dataQueue4[slot7 + 3])
		else
			slot0._entityTimeDict[slot8] = slot2

			slot0:_doShowTip(slot8, slot9, slot10, slot11)

			slot1 = slot1 + 1
		end

		if slot1 == uv3 then
			break
		end
	end

	slot4 = slot3 and #slot3 or 0

	for slot8 = 1, slot4 do
		slot0._dataQueue4[slot8] = slot3[slot8]
	end

	for slot9 = slot4 + 1, #slot0._dataQueue4 do
		slot0._dataQueue4[slot9] = slot0._dataQueue4[slot9 + slot1 * uv0]
	end

	if #slot0._dataQueue4 == 0 then
		TaskDispatcher.cancelTask(slot0._onTick, slot0)
	end
end

function slot0._doShowTip(slot0, slot1, slot2, slot3, slot4)
	if not slot0._entityId2PlayingItems[slot1] then
		slot0._entityId2PlayingItems[slot1] = {}
	end

	if uv0 <= #slot5 then
		table.remove(slot5, #slot5):stopFloat()
	end

	slot6 = FightHelper.getEntity(slot1)
	slot7 = slot0._type2ItemPool[slot2]:getObject()
	slot7.id = uv1
	uv1 = uv1 + 1
	slot0._id2PlayingItem[slot7.id] = slot7

	table.insert(slot5, 1, slot7)

	if FightDataHelper.entityMgr:isAssistBoss(slot1) then
		gohelper.addChild(slot0._floatParent, slot7:getGO())
	elseif slot6 and slot6.nameUI then
		gohelper.addChild(slot6.nameUI:getFloatContainerGO(), slot7:getGO())
	end

	slot7:startFloat(slot1, slot3, slot4)
	slot7:setPos(0, slot6 and slot6.nameUI and slot6.nameUI:getFloatItemStartY() or 0)

	if slot6 and slot6:getMO() and lua_monster_skin.configDict[slot10.skin] and #FightStrUtil.instance:getSplitToNumberCache(slot11.floatOffset, "#") > 0 then
		slot7:setPos(slot12[1], slot12[2])

		slot8 = slot12[1]
		slot9 = slot12[2]
	end

	if slot4 and _G.type(slot4) == "table" then
		if slot4.pos_x then
			slot10 = recthelper.rectToRelativeAnchorPos(Vector3.New(slot4.pos_x, slot4.pos_y, 0), slot0._floatParent.transform)

			slot7:setPos(slot10.x, slot10.y)
			gohelper.addChild(slot0._floatParent, slot7:getGO())
		end

		if slot4.offset_x then
			slot7:setPos(slot8 + slot4.offset_x, slot9 + slot4.offset_y)
		end
	end

	slot10 = slot9

	if FightDataHelper.entityMgr:isAssistBoss(slot1) then
		slot12, slot13 = recthelper.worldPosToAnchorPos2((slot6:getHangPoint(ModuleEnum.SpineHangPoint.mounttop) or slot6:getHangPoint(ModuleEnum.SpineHangPointRoot)).transform.position, slot0._floatParentRectTr, nil, CameraMgr.instance:getUnitCamera())

		slot7:setPos(slot12, slot13)

		slot10 = slot13
	end

	for slot14, slot15 in ipairs(slot5) do
		slot15:tweenPosY(50 + slot10)

		if slot15.type == FightEnum.FloatType.total or slot15.type == FightEnum.FloatType.total_origin then
			slot10 = slot10 + 50
		end

		gohelper.setAsFirstSibling(slot15:getGO())
	end
end

function slot0.hideEntityEquipFloat(slot0, slot1)
	if slot0._entityId2PlayingItems[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			slot7:hideEquipFloat()
		end
	end
end

function slot0.setCanShowFightNumUI(slot0, slot1)
	slot0.canShowFightNumUI = slot1
end

slot0.instance = slot0.New()

return slot0
