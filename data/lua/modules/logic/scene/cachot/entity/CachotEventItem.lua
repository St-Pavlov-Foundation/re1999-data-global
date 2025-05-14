module("modules.logic.scene.cachot.entity.CachotEventItem", package.seeall)

local var_0_0 = class("CachotEventItem", LuaCompBase)
local var_0_1 = "effects/prefabs_cachot/v1a6_huanghuijiaohu.prefab"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.go:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()
	arg_1_0._click = ZProj.BoxColliderClickListener.Get(arg_1_1)
	arg_1_0._bigIcon = gohelper.findChildSingleImage(arg_1_1, "event/#simage_event")
	arg_1_0._smallIcon = gohelper.findChildImage(arg_1_1, "event/#simage_icon")
	arg_1_0._txtName = gohelper.findChildTextMesh(arg_1_1, "event/#txt_name")
	arg_1_0._gobattle = gohelper.findChild(arg_1_1, "tips/#go_battle")
	arg_1_0._gocostheartnum = gohelper.findChild(arg_1_1, "tips/#go_normal")
	arg_1_0._txtcostheartnum = gohelper.findChildTextMesh(arg_1_1, "tips/#go_normal/#txt_num")
	arg_1_0._clickEffect = gohelper.findChild(arg_1_1, "event/#effect")

	if arg_1_0._clickEffect then
		arg_1_0._clickEffectLoader = PrefabInstantiate.Create(arg_1_0._clickEffect)

		arg_1_0._clickEffectLoader:startLoad(var_0_1, arg_1_0._onEffectLoaded, arg_1_0)
	end

	arg_1_0._goFrameNormal = gohelper.findChild(arg_1_1, "event/light/frame")
	arg_1_0._goFrameElite = gohelper.findChild(arg_1_1, "event/light/frame_orange")
	arg_1_0._goFrameBoss = gohelper.findChild(arg_1_1, "event/light/frame_red")
	arg_1_0._anim = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._anim.keepAnimatorControllerStateOnDisable = true
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._clickThis, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, arg_2_0._onNearEventChange, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_2_0._playClickAnim, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, arg_3_0._onNearEventChange, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, arg_3_0._playClickAnim, arg_3_0)
end

function var_0_0._onEffectLoaded(arg_4_0)
	local var_4_0 = arg_4_0._clickEffectLoader:getInstGO()

	gohelper.removeEffectNode(var_4_0)
end

function var_0_0.onStart(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_open)
end

function var_0_0.updateMo(arg_6_0, arg_6_1)
	arg_6_0._anim:Play("open")

	arg_6_0._mo = arg_6_1
	arg_6_0.go.name = "event_" .. tostring(arg_6_1.eventId)

	local var_6_0 = lua_rogue_event.configDict[arg_6_1.eventId]

	if not var_6_0 then
		logError("没有肉鸽事件配置" .. tostring(arg_6_1.eventId))

		return
	end

	arg_6_0._bigIcon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_event" .. var_6_0.icon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_6_0._smallIcon, "v1a6_cachot_room_eventicon" .. var_6_0.icon)

	local var_6_1 = var_6_0.title
	local var_6_2 = GameUtil.utf8len(var_6_1)
	local var_6_3

	if var_6_2 >= 2 then
		local var_6_4 = GameUtil.utf8sub(var_6_1, 1, 1)
		local var_6_5 = GameUtil.utf8sub(var_6_1, 2, var_6_2 - 1)

		var_6_3 = string.format("<size=44>%s</size>%s", var_6_4, var_6_5)
	else
		var_6_3 = "<size=44>" .. var_6_1
	end

	local var_6_6 = V1a6_CachotModel.instance:getRogueInfo()

	arg_6_0._txtName.text = var_6_3

	local var_6_7 = V1a6_CachotEventConfig.instance:getEventHeartShow(arg_6_1.eventId, var_6_6 and var_6_6.difficulty or 1)

	if var_6_7 then
		gohelper.setActive(arg_6_0._gocostheartnum, true)

		arg_6_0._txtcostheartnum.text = var_6_7
	else
		gohelper.setActive(arg_6_0._gocostheartnum, false)
	end

	local var_6_8 = {}
	local var_6_9 = V1a6_CachotEnum.BossType.Normal

	if var_6_0.type == V1a6_CachotEnum.EventType.Battle then
		local var_6_10 = var_6_0.eventId
		local var_6_11 = lua_rogue_event_fight.configDict[var_6_10]

		if not var_6_11 then
			logError("没有肉鸽战斗事件配置" .. tostring(var_6_10))

			return
		end

		var_6_9 = var_6_11 and var_6_11.type or var_6_9

		local var_6_12 = DungeonConfig.instance:getEpisodeBattleId(var_6_11.episode)
		local var_6_13 = lua_battle.configDict[var_6_12]

		if var_6_13 and not string.nilorempty(var_6_13.monsterGroupIds) then
			local var_6_14 = string.splitToNumber(var_6_13.monsterGroupIds, "#")

			for iter_6_0, iter_6_1 in ipairs(var_6_14) do
				local var_6_15 = string.splitToNumber(lua_monster_group.configDict[iter_6_1].monster, "#")

				for iter_6_2, iter_6_3 in ipairs(var_6_15) do
					local var_6_16 = lua_monster.configDict[iter_6_3].career

					if not tabletool.indexOf(var_6_8, var_6_16) then
						table.insert(var_6_8, var_6_16)
					end
				end
			end
		end
	end

	local var_6_17 = var_6_6 and var_6_6.room
	local var_6_18
	local var_6_19

	if var_6_17 then
		var_6_18, var_6_19 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(var_6_17)
	end

	if var_6_18 == var_6_19 then
		var_6_9 = V1a6_CachotEnum.BossType.Boss
	end

	gohelper.setActive(arg_6_0._goFrameNormal, var_6_9 == V1a6_CachotEnum.BossType.Normal)
	gohelper.setActive(arg_6_0._goFrameElite, var_6_9 == V1a6_CachotEnum.BossType.Elite)
	gohelper.setActive(arg_6_0._goFrameBoss, var_6_9 == V1a6_CachotEnum.BossType.Boss)

	if var_6_8[1] then
		gohelper.setActive(arg_6_0._gobattle, true)

		for iter_6_4 = 1, 6 do
			local var_6_20 = gohelper.findChild(arg_6_0._gobattle, "icons/" .. iter_6_4)
			local var_6_21 = gohelper.findChildImage(var_6_20, "icon")

			if var_6_8[iter_6_4] then
				gohelper.setActive(var_6_20, true)
				UISpriteSetMgr.instance:setV1a6CachotSprite(var_6_21, "v1a6_cachot_fight_career" .. var_6_8[iter_6_4])
			else
				gohelper.setActive(var_6_20, false)
			end
		end
	else
		gohelper.setActive(arg_6_0._gobattle, false)
	end
end

function var_0_0._playClickAnim(arg_7_0)
	if arg_7_0._isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_interaction)
		arg_7_0._anim:Play("click")
	else
		arg_7_0._anim:Play("close")
	end
end

function var_0_0._clickThis(arg_8_0)
	if V1a6_CachotRoomModel.instance:getIsMoving() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) then
		return
	end

	if arg_8_0._isSelect then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ClickNearEvent)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMoveTo, GameSceneMgr.instance:getCurScene().level:getEventTr(arg_8_0._mo.index))
	end
end

function var_0_0._onNearEventChange(arg_9_0)
	if not arg_9_0.go or not arg_9_0.go.activeSelf then
		return
	end

	if not arg_9_0._mo then
		return
	end

	local var_9_0 = V1a6_CachotRoomModel.instance:getNearEventMo() == arg_9_0._mo

	if arg_9_0._isSelect ~= var_9_0 then
		local var_9_1 = arg_9_0._isSelect == nil

		arg_9_0._isSelect = var_9_0

		local var_9_2
		local var_9_3 = var_9_0 and "select" or "unselect"

		arg_9_0._anim:Play(var_9_3, 0, var_9_1 and 1 or 0)

		if var_9_0 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_lit)
		end
	end
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._clickEffectLoader then
		arg_10_0._clickEffectLoader:dispose()

		arg_10_0._clickEffectLoader = nil
	end

	arg_10_0._bigIcon:UnLoadImage()
end

return var_0_0
