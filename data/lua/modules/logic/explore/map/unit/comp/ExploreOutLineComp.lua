module("modules.logic.explore.map.unit.comp.ExploreOutLineComp", package.seeall)

slot0 = class("ExploreOutLineComp", LuaCompBase)
slot1 = Color(0.7529, 0.6831, 0.1721, 1)
slot2 = Color.white
slot3 = Color.black
slot4 = 0.5
slot5 = 0.3
slot6 = 3

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
end

function slot0.setup(slot0, slot1)
	slot0.go = slot1
	slot0._renderers = slot1:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
	slot0._iconHangPoint = gohelper.findChild(slot1, "msts_icon")

	ExploreController.instance:registerCallback(ExploreEvent.HeroTweenDisTr, slot0.setCameraPos, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, slot0.setCameraPos, slot0)

	if not lua_explore_unit.configDict[slot0.unit:getUnitType()] then
		return
	end

	if not string.nilorempty(slot0.unit.mo.isStrong and slot2.icon2 or slot2.icon) then
		slot0._iconPath = "explore/common/sprite/prefabs/" .. slot3 .. ".prefab"
	end
end

function slot0.setCameraPos(slot0)
	if not slot0.go or slot0._renderers.Length <= 0 then
		return
	end

	if slot0._isOutLight then
		if slot0._renderers[0].isVisible ~= slot0._isMarkOutLight then
			if slot1 then
				slot0._isMarkOutLight = true
				slot5 = 1

				ExploreMapModel.instance:changeOutlineNum(slot5)

				for slot5 = 0, slot0._renderers.Length - 1 do
					slot0._renderers[slot5].renderingLayerMask = ExploreHelper.setBit(slot0._renderers[slot5].renderingLayerMask, uv0, true)
				end
			else
				slot0._isMarkOutLight = false
				slot5 = -1

				ExploreMapModel.instance:changeOutlineNum(slot5)

				for slot5 = 0, slot0._renderers.Length - 1 do
					slot0._renderers[slot5].renderingLayerMask = ExploreHelper.setBit(slot0._renderers[slot5].renderingLayerMask, uv0, false)
				end
			end
		end
	elseif not slot0._isOutLight and slot0._tweenId and not slot0._renderers[0].isVisible then
		ZProj.TweenHelper.KillById(slot0._tweenId, true)

		slot0._tweenId = nil

		TaskDispatcher.cancelTask(slot0._delayTweenClear, slot0)
	end
end

function slot0.setOutLight(slot0, slot1)
	slot2, slot3 = slot0.unit:isCustomShowOutLine()

	if (slot3 or slot1 and slot0._iconPath) and slot0._iconHangPoint then
		if not slot0._iconLoader then
			slot0._iconLoader = PrefabInstantiate.Create(slot0._iconHangPoint)
		end

		if not slot3 then
			slot4 = slot0._iconPath
		end

		if slot4 ~= slot0._iconLoader:getPath() then
			slot0._iconLoader:dispose()
			slot0._iconLoader:startLoad(slot4)
		end
	elseif slot0._iconLoader then
		slot0._iconLoader:dispose()

		slot0._iconLoader = nil
	end

	if not slot0._isOutLight == not slot1 then
		return
	end

	slot0._isOutLight = slot1

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId, true)
	end

	slot4 = false

	if slot0._renderers.Length > 0 then
		slot4 = ExploreHelper.getDistance(slot0.unit.nodePos, ExploreController.instance:getMap():getHeroPos()) <= 3 and true or slot0._renderers[0].isVisible
	end

	if not slot4 then
		if slot0._isMarkOutLight then
			slot0._isMarkOutLight = false
			slot8 = -1

			ExploreMapModel.instance:changeOutlineNum(slot8)

			for slot8 = 0, slot0._renderers.Length - 1 do
				slot0._renderers[slot8].renderingLayerMask = ExploreHelper.setBit(slot0._renderers[slot8].renderingLayerMask, uv0, false)
			end
		end

		slot0._isOutLight = false

		return
	end

	for slot8 = 0, slot0._renderers.Length - 1 do
		slot0._renderers[slot8].renderingLayerMask = ExploreHelper.setBit(slot0._renderers[slot8].renderingLayerMask, uv0, true)
	end

	if not slot0._isMarkOutLight then
		slot0._isMarkOutLight = true

		ExploreMapModel.instance:changeOutlineNum(1)
	end

	TaskDispatcher.cancelTask(slot0._delayTweenClear, slot0)

	if slot1 then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowLerpValue or 0, 1, uv1, slot0.tweenColor, nil, slot0)
	else
		TaskDispatcher.runDelay(slot0._delayTweenClear, slot0, 0.05)
	end
end

function slot0._delayTweenClear(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowLerpValue or 1, 0, uv0, slot0.tweenColor, slot0.outLineEnd, slot0)
end

function slot0.tweenColor(slot0, slot1)
	for slot6 = 0, slot0._renderers.Length - 1 do
		if not tolua.isnull(slot0._renderers[slot6]) then
			slot0._reuseValue = MaterialUtil.getLerpValue("Color", uv2, slot0.unit.mo.isStrong and uv0 or uv1, slot1, slot0._reuseValue)

			MaterialUtil.setPropValue(slot7.material, "_OutlineColor", "Color", slot0._reuseValue)
		end
	end

	slot0._nowLerpValue = slot1
end

function slot0.outLineEnd(slot0)
	for slot4 = 0, slot0._renderers.Length - 1 do
		if not tolua.isnull(slot0._renderers[slot4]) then
			slot5.renderingLayerMask = ExploreHelper.setBit(slot5.renderingLayerMask, uv0, false)
		end
	end

	if slot0._isMarkOutLight then
		slot0._isMarkOutLight = false

		ExploreMapModel.instance:changeOutlineNum(-1)
	end
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._delayTweenClear, slot0)

	slot0._nowLerpValue = 0

	if slot0._isMarkOutLight then
		ExploreMapModel.instance:changeOutlineNum(-1)

		slot0._isMarkOutLight = false
	end

	if slot0._iconLoader then
		slot0._iconLoader:dispose()

		slot0._iconLoader = nil
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._renderers = nil
	slot0._iconHangPoint = nil
	slot0._iconPath = nil
	slot0._isOutLight = false

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroTweenDisTr, slot0.setCameraPos, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, slot0.setCameraPos, slot0)
end

function slot0.onDestroy(slot0)
	slot0:clear()
end

return slot0
