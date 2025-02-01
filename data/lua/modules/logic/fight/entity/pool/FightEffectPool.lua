module("modules.logic.fight.entity.pool.FightEffectPool", package.seeall)

slot0 = _M
slot1 = 1
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot0.isForbidEffect = nil

function slot0.getId2UsingWrapDict()
	return uv0
end

function slot0.releaseUnuseEffect()
	for slot3, slot4 in pairs(uv0) do
		for slot8, slot9 in pairs(slot4) do
			for slot13, slot14 in ipairs(slot9) do
				slot14:markCanDestroy()
				gohelper.destroy(slot14.containerGO)
			end
		end
	end

	uv0 = {}
	slot0 = {
		[slot5.path] = true
	}

	for slot4, slot5 in pairs(uv1) do
		-- Nothing
	end

	for slot5, slot6 in pairs(uv2) do
		if not slot0[slot5] then
			slot6:Release()

			uv2[slot5] = nil
		end
	end

	return {
		[slot5] = true
	}
end

function slot0.dispose()
	for slot3, slot4 in pairs(uv0) do
		slot4:Release()

		uv0[slot3] = nil
	end

	for slot3, slot4 in pairs(uv1) do
		for slot8, slot9 in pairs(slot4) do
			for slot13, slot14 in ipairs(slot9) do
				slot14:markCanDestroy()
				gohelper.destroy(slot14.containerGO)
			end
		end
	end

	for slot3, slot4 in pairs(uv2) do
		slot4:markCanDestroy()
		gohelper.destroy(slot4.containerGO)
	end

	for slot3, slot4 in pairs(uv3) do
		for slot8, slot9 in ipairs(slot4) do
			slot9:markCanDestroy()
			gohelper.destroy(slot9.containerGO)
		end
	end

	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}

	gohelper.destroy(uv4)

	uv4 = nil
	uv5 = nil
	uv6 = 1
end

function slot0.hasLoaded(slot0)
	return (uv0 and uv0[slot0]) ~= nil
end

function slot0.isLoading(slot0)
	return uv0[slot0]
end

function slot0.getEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = uv1.getPoolContainerGO()
	slot8 = nil

	if uv0[slot0] then
		slot8 = uv1._getLoadedEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	else
		slot8 = uv1._getNotLoadEffect(slot0, slot1, slot2, slot3, slot4, slot5)
		uv2[slot8.uniqueId] = slot8

		if not uv1.isForbidEffect then
			slot9 = MultiAbLoader.New()

			slot9:addPath(slot8.abPath)
			slot9:startLoad(uv1._onEffectLoaded)
		end
	end

	uv2[slot8.uniqueId] = slot8

	return slot8
end

function slot0._getLoadedEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = nil
	slot8 = uv0.getPoolContainerGO()

	if uv1[slot0] and slot9[slot1] and #slot10 > 0 then
		slot11 = #slot10

		for slot15, slot16 in ipairs(slot10) do
			if slot4 == nil and slot16.hangPointGO == slot8 or slot4 ~= nil and slot16.hangPointGO == slot4 then
				slot11 = slot15

				break
			end
		end

		table.remove(slot10, slot11):setHangPointGO(slot4 or slot8)
	else
		slot7 = uv0._createWrap(slot0)

		slot7:setHangPointGO(slot4 or slot8)

		slot7.side = slot1

		uv0._instantiateEffectGO(slot6, slot7)
	end

	slot7:setCallback(slot2, slot3)
	slot7:doCallback(true)
	slot7:setTimeScale(FightModel.instance:getSpeed())

	slot7.dontPlay = slot5

	slot7:play()

	return slot7
end

function slot0._getNotLoadEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = uv0._createWrap(slot0)
	slot7.side = slot1

	slot7:setHangPointGO(slot4 or uv0.getPoolContainerGO())
	slot7:setCallback(slot2, slot3)

	slot7.dontPlay = slot5

	if not uv1[slot0] then
		uv1[slot0] = {}
	end

	table.insert(slot8, slot7)

	return slot7
end

function slot0.returnEffect(slot0)
	if gohelper.isNil(slot0.containerGO) then
		return
	end

	slot0:setActive(false)
	slot0:onReturnPool()

	uv0[slot0.uniqueId] = nil

	if not uv1[slot0.path] then
		uv1[slot0.path] = {}
	end

	if not slot1[slot0.side] then
		slot1[slot0.side] = {}
	end

	if not tabletool.indexOf(slot2, slot0) then
		table.insert(slot2, slot0)
	end
end

function slot0.returnEffectToPoolContainer(slot0)
	slot0:setHangPointGO(uv0.getPoolContainerGO())
end

function slot0.getPoolContainerGO()
	if not uv0 then
		uv0 = gohelper.create3d(GameSceneMgr.instance:getScene(SceneType.Fight):getSceneContainerGO(), "EffectPool")
		uv1 = uv0.transform
	end

	return uv0
end

function slot0._onEffectLoaded(slot0)
	if slot0:getFirstAssetItem() and slot1.IsLoadSuccess then
		if GameResMgr.IsFromEditorDir then
			uv0._createLoadedEffectWrap(slot1, slot1.ResPath)
		elseif slot1.AllAssetNames then
			for slot6 = 0, slot2.Length - 1 do
				uv0._createLoadedEffectWrap(slot1, ResUrl.getPathWithoutAssetLib(slot2[slot6]))
			end
		end
	else
		for slot5, slot6 in pairs(uv1) do
			slot7 = nil

			for slot11, slot12 in ipairs(slot6) do
				if slot1 then
					if slot12.abPath == slot1.ResPath then
						slot12:doCallback(false)

						slot7 = true
					end
				elseif slot0._pathList and slot12.abPath == slot0._pathList[1] then
					slot12:doCallback(false)

					slot7 = true
				end
			end

			if slot7 then
				uv1[slot5] = nil
			end
		end

		if slot1 then
			logError("load effect fail: " .. slot1.ResPath)
		end
	end

	slot0:dispose()
end

function slot0._createLoadedEffectWrap(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = slot0

		slot0:Retain()
	end

	uv1[slot1] = nil

	for slot7 = 1, uv1[slot1] and #slot2 or 0 do
		slot8 = slot2[slot7]

		uv2._instantiateEffectGO(slot0, slot8)

		if uv3[slot8.uniqueId] then
			slot8:doCallback(true)
			slot8:setTimeScale(FightModel.instance:getSpeed())
			slot8:setActive(false)
			slot8:play()
		end
	end
end

function slot0._instantiateEffectGO(slot0, slot1)
	slot3 = gohelper.clone(slot0:GetResource(slot1.path), slot1.containerGO)
	slot4 = nil

	if slot1.side == FightEnum.EntitySide.MySide then
		slot4 = "_r"
	elseif slot1.side == FightEnum.EntitySide.EnemySide then
		slot4 = "_l"
	end

	if not string.nilorempty(slot4) then
		for slot10 = 0, slot2.transform.childCount - 1 do
			slot12 = slot5:GetChild(slot10).name
			slot13 = string.len(slot12)

			if string.sub(slot12, slot13 - 1, slot13) == slot4 then
				gohelper.addChild(slot1.containerGO, slot11.gameObject)
				gohelper.destroy(slot2)

				break
			end
		end
	end

	gohelper.removeEffectNode(slot3)
	slot1:setEffectGO(slot3)
end

function slot0._createWrap(slot0)
	slot1 = FightStrUtil.instance:getSplitCache(slot0, "/")
	slot4 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(uv0.getPoolContainerGO(), slot1[#slot1]), FightEffectWrap)

	slot4:setUniqueId(uv1)
	slot4:setPath(slot0)

	uv1 = uv1 + 1

	return slot4
end

return slot0
