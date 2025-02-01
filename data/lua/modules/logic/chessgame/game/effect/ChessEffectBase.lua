module("modules.logic.chessgame.game.effect.ChessEffectBase", package.seeall)

slot0 = class("ChessEffectBase")

function slot0.ctor(slot0, slot1)
	slot0._target = slot1
end

function slot0.dispose(slot0)
	slot0:onDispose()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	gohelper.destroy(slot0.effectGO)

	slot0.effectGO = nil
end

function slot0.onDispose(slot0)
end

function slot0.onAvatarFinish(slot0, slot1)
	if slot0._isLoading then
		return
	end

	if not slot0.isLoadFinish then
		slot0._isLoading = true
		slot0.effectGO = UnityEngine.GameObject.New("effect_" .. slot1)
		slot0._loader = PrefabInstantiate.Create(slot0.effectGO)

		gohelper.addChild(slot0._target.avatar.effectNode, slot0.effectGO)
		transformhelper.setLocalPos(slot0.effectGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(slot0.effectGO.transform, 0.8, 0.8, 0.8)
		slot0._loader:startLoad(ChessGameEnum.ChessGameEnum.EffectPath[slot1], slot0.onSceneObjectLoadFinish, slot0)
	else
		gohelper.setActive(slot0.effectGO, true)
		ChessGameInteractModel.instance:setShowEffect(slot0._target.mo.id)
	end
end

function slot0.onSceneObjectLoadFinish(slot0)
	if slot0._loader and slot0._loader:getInstGO() then
		slot0.isLoadFinish = true
		slot0._isLoading = false

		transformhelper.setLocalPos(slot0._loader:getInstGO().transform, 0, 0, 0)
		ChessGameInteractModel.instance:setShowEffect(slot0._target.mo.id)
		slot0:onAvatarLoaded()
	end
end

function slot0.hideEffect(slot0)
	if slot0.effectGO then
		gohelper.setActive(slot0.effectGO, false)
		ChessGameInteractModel.instance:setHideEffect(slot0._target.mo.id)
	end
end

function slot0.getIsLoadEffect(slot0)
	return slot0.isLoadFinish
end

function slot0.onSelected(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onAvatarLoaded(slot0)
end

return slot0
