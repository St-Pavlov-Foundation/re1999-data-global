module("modules.logic.scene.cachot.entity.CachotEventItem", package.seeall)

slot0 = class("CachotEventItem", LuaCompBase)
slot1 = "effects/prefabs_cachot/v1a6_huanghuijiaohu.prefab"

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.go:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()
	slot0._click = ZProj.BoxColliderClickListener.Get(slot1)
	slot0._bigIcon = gohelper.findChildSingleImage(slot1, "event/#simage_event")
	slot0._smallIcon = gohelper.findChildImage(slot1, "event/#simage_icon")
	slot0._txtName = gohelper.findChildTextMesh(slot1, "event/#txt_name")
	slot0._gobattle = gohelper.findChild(slot1, "tips/#go_battle")
	slot0._gocostheartnum = gohelper.findChild(slot1, "tips/#go_normal")
	slot0._txtcostheartnum = gohelper.findChildTextMesh(slot1, "tips/#go_normal/#txt_num")
	slot0._clickEffect = gohelper.findChild(slot1, "event/#effect")

	if slot0._clickEffect then
		slot0._clickEffectLoader = PrefabInstantiate.Create(slot0._clickEffect)

		slot0._clickEffectLoader:startLoad(uv0, slot0._onEffectLoaded, slot0)
	end

	slot0._goFrameNormal = gohelper.findChild(slot1, "event/light/frame")
	slot0._goFrameElite = gohelper.findChild(slot1, "event/light/frame_orange")
	slot0._goFrameBoss = gohelper.findChild(slot1, "event/light/frame_red")
	slot0._anim = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._anim.keepAnimatorControllerStateOnDisable = true
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._clickThis, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, slot0._onNearEventChange, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._playClickAnim, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, slot0._onNearEventChange, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, slot0._playClickAnim, slot0)
end

function slot0._onEffectLoaded(slot0)
	gohelper.removeEffectNode(slot0._clickEffectLoader:getInstGO())
end

function slot0.onStart(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_open)
end

function slot0.updateMo(slot0, slot1)
	slot0._anim:Play("open")

	slot0._mo = slot1
	slot0.go.name = "event_" .. tostring(slot1.eventId)

	if not lua_rogue_event.configDict[slot1.eventId] then
		logError("没有肉鸽事件配置" .. tostring(slot1.eventId))

		return
	end

	slot0._bigIcon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_event" .. slot2.icon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._smallIcon, "v1a6_cachot_room_eventicon" .. slot2.icon)

	slot5 = nil
	slot0._txtName.text = (GameUtil.utf8len(slot2.title) < 2 or string.format("<size=44>%s</size>%s", GameUtil.utf8sub(slot3, 1, 1), GameUtil.utf8sub(slot3, 2, slot4 - 1))) and "<size=44>" .. slot3

	if V1a6_CachotEventConfig.instance:getEventHeartShow(slot1.eventId, V1a6_CachotModel.instance:getRogueInfo() and slot6.difficulty or 1) then
		gohelper.setActive(slot0._gocostheartnum, true)

		slot0._txtcostheartnum.text = slot7
	else
		gohelper.setActive(slot0._gocostheartnum, false)
	end

	slot8 = {}
	slot9 = V1a6_CachotEnum.BossType.Normal

	if slot2.type == V1a6_CachotEnum.EventType.Battle then
		if not lua_rogue_event_fight.configDict[slot2.eventId] then
			logError("没有肉鸽战斗事件配置" .. tostring(slot10))

			return
		end

		if slot11 then
			slot9 = slot11.type or slot9
		end

		if lua_battle.configDict[DungeonConfig.instance:getEpisodeBattleId(slot11.episode)] and not string.nilorempty(slot13.monsterGroupIds) then
			for slot18, slot19 in ipairs(string.splitToNumber(slot13.monsterGroupIds, "#")) do
				for slot24, slot25 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot19].monster, "#")) do
					if not tabletool.indexOf(slot8, lua_monster.configDict[slot25].career) then
						table.insert(slot8, slot26)
					end
				end
			end
		end
	end

	slot11, slot12 = nil

	if slot6 and slot6.room then
		slot11, slot12 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(slot10)
	end

	if slot11 == slot12 then
		slot9 = V1a6_CachotEnum.BossType.Boss
	end

	gohelper.setActive(slot0._goFrameNormal, slot9 == V1a6_CachotEnum.BossType.Normal)
	gohelper.setActive(slot0._goFrameElite, slot9 == V1a6_CachotEnum.BossType.Elite)
	gohelper.setActive(slot0._goFrameBoss, slot9 == V1a6_CachotEnum.BossType.Boss)

	if slot8[1] then
		gohelper.setActive(slot0._gobattle, true)

		for slot16 = 1, 6 do
			if slot8[slot16] then
				gohelper.setActive(slot17, true)
				UISpriteSetMgr.instance:setV1a6CachotSprite(gohelper.findChildImage(gohelper.findChild(slot0._gobattle, "icons/" .. slot16), "icon"), "v1a6_cachot_fight_career" .. slot8[slot16])
			else
				gohelper.setActive(slot17, false)
			end
		end
	else
		gohelper.setActive(slot0._gobattle, false)
	end
end

function slot0._playClickAnim(slot0)
	if slot0._isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_interaction)
		slot0._anim:Play("click")
	else
		slot0._anim:Play("close")
	end
end

function slot0._clickThis(slot0)
	if V1a6_CachotRoomModel.instance:getIsMoving() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) then
		return
	end

	if slot0._isSelect then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ClickNearEvent)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMoveTo, GameSceneMgr.instance:getCurScene().level:getEventTr(slot0._mo.index))
	end
end

function slot0._onNearEventChange(slot0)
	if not slot0.go or not slot0.go.activeSelf then
		return
	end

	if not slot0._mo then
		return
	end

	if slot0._isSelect ~= (V1a6_CachotRoomModel.instance:getNearEventMo() == slot0._mo) then
		slot0._isSelect = slot2
		slot4 = nil

		slot0._anim:Play(slot2 and "select" or "unselect", 0, slot0._isSelect == nil and 1 or 0)

		if slot2 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_lit)
		end
	end
end

function slot0.onDestroy(slot0)
	if slot0._clickEffectLoader then
		slot0._clickEffectLoader:dispose()

		slot0._clickEffectLoader = nil
	end

	slot0._bigIcon:UnLoadImage()
end

return slot0
