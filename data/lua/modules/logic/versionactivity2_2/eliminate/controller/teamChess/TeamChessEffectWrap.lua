module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectWrap", package.seeall)

slot0 = class("TeamChessEffectWrap", LuaCompBase)

function slot0.ctor(slot0)
	slot0._uniqueId = 0
	slot0.effectType = nil
	slot0.path = nil
	slot0.containerGO = nil
	slot0.containerTr = nil
	slot0.effectGO = nil
	slot0._scaleX = 1
	slot0._scaleY = 1
	slot0._scaleZ = 1
	slot0.callback = nil
	slot0.callbackObj = nil
end

function slot0.setUniqueId(slot0, slot1)
	slot0._uniqueId = slot1
end

function slot0.init(slot0, slot1)
	slot0.containerGO = slot1
	slot0.containerTr = slot1.transform
end

function slot0.play(slot0, slot1)
	if slot0.effectGO then
		slot0:_setWorldScale()
		slot0:setActive(true)

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.ZhanHou then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_warcry)
		end

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.WangYu then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_deadwords)
		end

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.PowerDown then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_adverse_buff)
		end

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.PowerUp then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_front_buff)
		end

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.StrongHoldBattle then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_clearing_fight)
		end

		if slot0.effectType == EliminateTeamChessEnum.VxEffectType.Move then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_shift)
		end

		slot2 = slot1

		if slot1 == nil then
			slot2 = slot0.effectType ~= nil and EliminateTeamChessEnum.VxEffectTypePlayTime[slot0.effectType] or 0.5
		end

		TaskDispatcher.runDelay(slot0.returnPool, slot0, slot2)
	end
end

function slot0.returnPool(slot0)
	TaskDispatcher.cancelTask(slot0.returnPool, slot0)
	TeamChessEffectPool.returnEffect(slot0)
end

function slot0.setEffectType(slot0, slot1)
	slot0.effectType = slot1

	slot0:setPath(EliminateTeamChessEnum.VxEffectTypeToPath[slot1])
end

function slot0.setPath(slot0, slot1)
	slot0.path = slot1

	slot0:loadAsset(slot0.path)
end

function slot0.loadAsset(slot0, slot1)
	if not string.nilorempty(slot1) and not slot0._loader then
		slot0._loader = PrefabInstantiate.Create(slot0.containerGO)

		slot0._loader:startLoad(slot1, slot0._onResLoaded, slot0)
	end
end

function slot0._onResLoaded(slot0)
	slot0.effectGO = slot0._loader:getInstGO()

	slot0:setLayer(UnityLayer.Scene)
	slot0:_setWorldScale()

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end
end

function slot0.setEffectGO(slot0, slot1)
	slot0.effectGO = slot1

	if slot0._effectScale then
		transformhelper.setLocalScale(slot0.effectGO.transform, slot0._effectScale, slot0._effectScale, slot0._effectScale)
	end

	if slot0._renderOrder then
		slot0:setRenderOrder(slot0._renderOrder, true)
	end
end

function slot0.setLayer(slot0, slot1)
	slot0._layer = slot1

	gohelper.setLayer(slot0.effectGO, slot0._layer, true)
end

function slot0.setWorldPos(slot0, slot1, slot2, slot3)
	if slot0.containerTr then
		transformhelper.setPos(slot0.containerTr, slot1, slot2, slot3)
		slot0:clearTrail()
	end
end

function slot0.setWorldScale(slot0, slot1, slot2, slot3)
	slot0._scaleX = slot1
	slot0._scaleY = slot2
	slot0._scaleZ = slot3
end

function slot0._setWorldScale(slot0)
	if slot0.effectGO then
		transformhelper.setLocalScale(slot0.effectGO.transform, slot0._scaleX, slot0._scaleY, slot0._scaleZ)
	end
end

function slot0.clearTrail(slot0)
	if slot0.effectGO then
		gohelper.onceAddComponent(slot0.effectGO, typeof(ZProj.EffectTimeScale)):ClearTrail()
	end
end

function slot0.setCallback(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callbackObj = slot2
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.containerGO, slot1)
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._renderOrder = slot1

	if not slot2 and slot1 == slot0._renderOrder then
		return
	end

	if not gohelper.isNil(slot0.effectGO) and slot0.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer)) then
		slot4:SetBaseOrder(slot1)
	end
end

function slot0.setEffectScale(slot0, slot1)
	slot0._effectScale = slot1

	if slot0.effectGO then
		transformhelper.setLocalScale(slot0.effectGO.transform, slot0._effectScale, slot0._effectScale, slot0._effectScale)
	end
end

function slot0.clear(slot0)
	slot0.callback = nil
	slot0.callbackObj = nil

	slot0:setActive(false)
end

function slot0.onDestroy(slot0)
	slot0.containerGO = nil
	slot0.effectGO = nil
	slot0.callback = nil
	slot0.callbackObj = nil
	slot0.effectType = nil

	TaskDispatcher.cancelTask(slot0.returnPool, slot0)

	if slot0._loader then
		slot0._loader:onDestroy()

		slot0._loader = nil
	end
end

return slot0
