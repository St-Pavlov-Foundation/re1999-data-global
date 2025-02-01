module("modules.logic.fight.entity.comp.buff.FightBuffPlayAnimation", package.seeall)

slot0 = class("FightBuffPlayAnimation", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0:__onInit()

	slot0._entity = slot1
	slot0._buff_mo = slot2
	slot0._url = slot3

	slot0:_beforePlayAni()

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(FightHelper.getEntityAniPath(slot3))
	slot0._loader:startLoad(slot0._onEntityAnimLoaded, slot0)
end

function slot0._beforePlayAni(slot0)
end

function slot0._onEntityAnimLoaded(slot0)
	slot1 = slot0._loader:getFirstAssetItem():GetResource(ResUrl.getEntityAnim(slot0._url))
	slot1.legacy = true
	slot2 = gohelper.onceAddComponent(slot0._entity.spine:getSpineGO(), typeof(UnityEngine.Animation))
	slot0._animStateName = slot1.name
	slot0._animComp = slot2
	slot2.enabled = true
	slot2.clip = slot1

	slot2:AddClip(slot1, slot1.name)

	if slot2.this:get(slot1.name) then
		slot3.speed = FightModel.instance:getSpeed()
	end

	slot2:Play()
	TaskDispatcher.runDelay(slot0._animDone, slot0, slot1.length / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
end

function slot0._animDone(slot0)
	if not gohelper.isNil(slot0._animComp) then
		if slot0._animComp:GetClip(slot0._animStateName) then
			slot0._animComp:RemoveClip(slot1)
		end

		if slot0._animComp.clip and slot0._animComp.clip.name == slot1 then
			slot0._animComp.clip = nil
		end

		slot0._animComp.enabled = false
	end

	ZProj.CharacterSetVariantHelper.Disable(slot0._entity.spine:getSpineGO())
end

function slot0._onUpdateSpeed(slot0)
	if not gohelper.isNil(slot0._animComp) and slot0._animComp.this:get(slot0._animStateName) then
		slot1.speed = FightModel.instance:getSpeed()
	end
end

function slot0.releaseSelf(slot0)
	slot0:_animDone()
	TaskDispatcher.cancelTask(slot0._animDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._entity = nil
	slot0._buff_mo = nil
	slot0._url = nil

	slot0:__onDispose()
end

return slot0
