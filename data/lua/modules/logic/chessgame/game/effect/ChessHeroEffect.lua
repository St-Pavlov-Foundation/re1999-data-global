module("modules.logic.chessgame.game.effect.ChessHeroEffect", package.seeall)

slot0 = class("ChessHeroEffect", ChessEffectBase)

function slot0.refreshEffect(slot0)
end

function slot0.onDispose(slot0)
end

function slot0.onSelected(slot0)
	slot0._isSelected = true

	slot0:refreshPlayerSelected()
end

function slot0.onCancelSelect(slot0)
	slot0._isSelected = false

	slot0:refreshPlayerSelected()
end

function slot0.refreshPlayerSelected(slot0)
	if ChessGameController.instance:isTempSelectObj(slot0._target.id) then
		return
	end

	gohelper.setActive(slot0._target.avatar.goSelectable, not slot0._isSelected)
end

function slot0.onAvatarLoaded(slot0)
	slot1 = slot0._loader

	if not slot0._loader then
		return
	end

	if not gohelper.isNil(slot1:getInstGO()) then
		slot3 = gohelper.findChild(slot2, "vx_tracked")
		slot4 = gohelper.findChild(slot2, "select")
		slot5 = gohelper.findChild(slot2, "vx_daoju")

		gohelper.setActive(slot0._target.avatar.goTracked, false)
		gohelper.setActive(slot0._target.avatar.goInteractEff, false)
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot4, false)
		gohelper.setActive(slot5, false)

		slot0._target.avatar.goTracked = slot3
		slot0._target.avatar.goSelectable = slot4
		slot0._target.avatar.goInteractEff = slot5
	end

	slot0:refreshPlayerSelected()
end

return slot0
