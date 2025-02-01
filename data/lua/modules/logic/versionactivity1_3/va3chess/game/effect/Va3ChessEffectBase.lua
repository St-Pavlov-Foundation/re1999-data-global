module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessEffectBase", package.seeall)

slot0 = class("Va3ChessEffectBase")

function slot0.ctor(slot0, slot1)
	slot0._target = slot1
	slot0._effectCfg = slot0._target.effectCfg
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

function slot0.onAvatarFinish(slot0)
	if slot0._effectCfg and not string.nilorempty(slot0._effectCfg.avatar) then
		slot0.effectGO = UnityEngine.GameObject.New("effect_" .. slot0._effectCfg.id)
		slot0._loader = PrefabInstantiate.Create(slot0.effectGO)

		gohelper.addChild(slot0._target.avatar.sceneGo, slot0.effectGO)

		slot1 = nil

		if slot0._target.avatar.loader and not string.nilorempty(slot0._effectCfg.piontName) then
			slot1 = gohelper.findChild(slot0._target.avatar.loader:getInstGO(), slot0._effectCfg.piontName)
		end

		if not gohelper.isNil(slot1) then
			slot2, slot3, slot4 = transformhelper.getPos(slot1.transform)

			transformhelper.setPos(slot0.effectGO.transform, slot2, slot3, slot4)
		else
			transformhelper.setLocalPos(slot0.effectGO.transform, 0, 0, 0)
		end

		slot0._loader:startLoad(string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, slot0._effectCfg.avatar), slot0.onSceneObjectLoadFinish, slot0)
	else
		slot0.isLoadFinish = true

		slot0:onAvatarLoaded()
		slot0:onCheckEffect()
	end
end

function slot0.onSceneObjectLoadFinish(slot0)
	if slot0._loader then
		slot0.isLoadFinish = true

		transformhelper.setLocalPos(slot0._loader:getInstGO().transform, 0, 0, 0)
		slot0:onAvatarLoaded()
		slot0:onCheckEffect()
	end
end

function slot0.onSelected(slot0)
end

function slot0.onCancelSelect(slot0)
end

function slot0.onAvatarLoaded(slot0)
end

function slot0.onCheckEffect(slot0)
	if slot0._target then
		if slot0._target.originData and slot1.data and slot1.data.lostTarget ~= nil then
			slot0._target.effect:refreshSearchFailed()
			slot0._target.goToObject:refreshTarget()
		end

		slot0._target.goToObject:refreshSource()
	end
end

return slot0
