module("modules.logic.fight.view.cardeffect.FigthMasterCardRemoveEffect", package.seeall)

slot0 = class("FigthMasterCardRemoveEffect", BaseWork)
slot1 = {
	"ui/viewres/fight/ui_effect_wuduquan_a.prefab"
}

function slot0.onStart(slot0, slot1)
	slot0._loader = slot0._loader or LoaderComponent.New()

	slot0._loader:loadListAsset(uv0, slot0._onLoaded, slot0._onAllLoaded, slot0)
end

function slot0._onLoaded(slot0)
end

function slot0._onAllLoaded(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if slot0._loader:getAssetItem(slot5) then
			if slot4 == 1 then
				slot0.context.card:playAni(ViewAnim.FightCardWuDuQuan, UIAnimationName.Close)

				slot0._clonePrefab = gohelper.clone(slot6:GetResource(), slot0.context.card.go)

				gohelper.onceAddComponent(slot0._clonePrefab, typeof(UnityEngine.Animator)):Play("close", 0, 0)
			end
		end
	end

	TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.8 / FightModel.instance:getUISpeed())
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if not gohelper.isNil(slot0.context.card._forAnimGO) then
		gohelper.onceAddComponent(slot1, gohelper.Type_CanvasGroup).alpha = 1
	end

	if not gohelper.isNil(slot0._clonePrefab) then
		gohelper.destroy(slot0._clonePrefab)
	end

	gohelper.setActive(slot0.context.card.go, false)

	if slot0._loader then
		slot0._loader:releaseSelf()

		slot0._loader = nil
	end
end

return slot0
