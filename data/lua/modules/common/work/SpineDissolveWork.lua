module("modules.common.work.SpineDissolveWork", package.seeall)

slot0 = class("SpineDissolveWork", BaseWork)
slot1 = {
	[FightEnum.DissolveType.Player] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_player
	},
	[FightEnum.DissolveType.Monster] = {
		duration = 1.67,
		path = FightPreloadOthersWork.die_monster
	},
	[FightEnum.DissolveType.ZaoWu] = {
		duration = 1.67,
		path = "rolesbuff/die_zaowu.controller"
	},
	[FightEnum.DissolveType.Abjqr4] = {
		duration = 3,
		path = "rolesbuff/die_monster_670401_abjqr4.controller"
	}
}

function slot0.onStart(slot0, slot1)
	slot0.context = slot1

	if string.nilorempty(lua_skin_spine_action.configDict[slot0.context.dissolveEntity:getMO().skin] and slot2.die and slot2.die.dieAnim) then
		slot0:_playDissolve()
	else
		slot0._ani_path = slot3
		slot0._animationLoader = MultiAbLoader.New()

		slot0._animationLoader:addPath(FightHelper.getEntityAniPath(slot3))
		slot0._animationLoader:startLoad(slot0._onAnimationLoaded, slot0)
	end
end

function slot0._onAnimationLoaded(slot0)
	slot1 = slot0._animationLoader:getFirstAssetItem():GetResource(ResUrl.getEntityAnim(slot0._ani_path))
	slot1.legacy = true
	slot0._animStateName = slot1.name
	slot0._animCompList = {}
	slot3 = gohelper.onceAddComponent(slot0.context.dissolveEntity.spine:getSpineGO(), typeof(UnityEngine.Animation))

	table.insert(slot0._animCompList, slot3)

	slot3.enabled = true
	slot3.clip = slot1

	slot3:AddClip(slot1, slot0._animStateName)

	if slot3.this:get(slot0._animStateName) then
		slot4.speed = FightModel.instance:getSpeed()
	end

	slot3:Play()
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	TaskDispatcher.runDelay(slot0._afterPlayDissolve, slot0, slot1.length / FightModel.instance:getSpeed())
end

function slot0._onUpdateSpeed(slot0)
	for slot4, slot5 in ipairs(slot0._animCompList) do
		if slot5.this:get(slot0._animStateName) then
			slot6.speed = FightModel.instance:getSpeed()
		end
	end
end

function slot0._clearAnim(slot0)
	if slot0._animCompList then
		for slot4, slot5 in ipairs(slot0._animCompList) do
			if not gohelper.isNil(slot5) then
				if slot5:GetClip(slot0._animStateName) then
					slot5:RemoveClip(slot0._animStateName)
				end

				if slot5.clip and slot5.clip.name == slot0._animStateName then
					slot5.clip = nil
				end

				slot5.enabled = false
			end
		end

		slot0._animCompList = nil
	end
end

function slot0._playDissolve(slot0)
	if uv0[slot0.context.dissolveType] and slot1.path then
		if FightPreloadController.instance:getFightAssetItem(slot2) then
			slot0:_reallyPlayDissolve(slot3)
		else
			slot0._animatorLoader = MultiAbLoader.New()

			slot0._animatorLoader:addPath(slot2)
			slot0._animatorLoader:startLoad(slot0._onAnimatorLoaded, slot0)
		end
	else
		logError(slot0.context.dissolveEntity:getMO():getEntityName() .. "没有配置死亡消融动画 type = " .. (slot0.context.dissolveType or "nil"))
	end
end

function slot0._onAnimatorLoaded(slot0)
	slot0:_reallyPlayDissolve(slot0._animatorLoader:getFirstAssetItem())
end

function slot0._reallyPlayDissolve(slot0, slot1)
	if not (slot0.context.dissolveEntity and slot0.context.dissolveEntity.spine and slot0.context.dissolveEntity.spine:getSpineGO()) then
		slot0:_afterPlayDissolve()

		return
	end

	slot4 = gohelper.onceAddComponent(slot2, typeof(UnityEngine.Animator))
	slot4.enabled = true
	slot4.runtimeAnimatorController = slot1:GetResource()
	slot4.speed = FightModel.instance:getSpeed()

	TaskDispatcher.runDelay(slot0._afterPlayDissolve, slot0, (uv0[slot0.context.dissolveType] and slot5.duration or 1.67) / FightModel.instance:getSpeed())
end

function slot0._afterPlayDissolve(slot0)
	slot0:_clearAnim()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, slot0._onUpdateSpeed, slot0)
	slot0:_clearAnim()
	TaskDispatcher.cancelTask(slot0._afterPlayDissolve, slot0)

	if slot0._animationLoader then
		slot0._animationLoader:dispose()

		slot0._animationLoader = nil
	end

	if slot0._animatorLoader then
		slot0._animatorLoader:dispose()

		slot0._animatorLoader = nil
	end
end

return slot0
