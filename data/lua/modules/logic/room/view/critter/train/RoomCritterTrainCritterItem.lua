module("modules.logic.room.view.critter.train.RoomCritterTrainCritterItem", package.seeall)

slot0 = class("RoomCritterTrainCritterItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goshadow = gohelper.create2d(slot1, "critter_shadow")

	gohelper.setAsFirstSibling(slot0._goshadow)
	gohelper.setActive(slot0._goshadow, false)

	slot0._roleSpine = GuiSpine.Create(slot1, false)
	slot0._canvasGroup = gohelper.onceAddComponent(slot1, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot1, true)

	slot0._effs = {}
	slot0._tamingEffs = {}
	slot0._effLoader = MultiAbLoader.New()
	slot0._tamingEffLoader = MultiAbLoader.New()
	slot0._shadowLoader = MultiAbLoader.New()
end

slot1 = {
	"roomcritteremoji1",
	"roomcritteremoji2",
	"roomcritteremoji3",
	"roomcritteremoji4",
	"roomcritteremoji5",
	"roomcritteremoji6"
}

function slot0.showByEffectType(slot0, slot1, slot2, slot3)
	slot0._critterMo = slot1
	slot0._critterPos = slot2
	slot0._inDialog = slot3

	slot0:_refreshItem()
end

function slot0.showByEffectName(slot0, slot1, slot2, slot3)
	slot0._critterMo = slot1
	slot0._critterPos = slot2
	slot0._inDialog = slot3

	slot0:_refreshItem()
end

slot2 = "ui/viewres/room/critter/roomcrittershadowitem.prefab"

function slot0.showShadow(slot0, slot1)
	gohelper.setActive(slot0._goshadow, slot1)

	if slot1 and not slot0._shadowGo then
		slot0._shadowLoader:addPath(uv0)
		slot0._shadowLoader:startLoad(slot0._loadShadowFinished, slot0)
	end
end

function slot0._loadShadowFinished(slot0)
	slot0._shadowGo = gohelper.clone(slot0._shadowLoader:getAssetItem(uv0):GetResource(), slot0._goshadow)
	slot3, slot4, slot5 = transformhelper.getPos(gohelper.findChild(slot0._spineGo, "mountroot/mountbottom").transform)

	transformhelper.setPos(slot0._shadowGo.transform, slot3, slot4, slot5)
end

function slot0.showTamingEffects(slot0, slot1, slot2)
	if LuaUtil.tableNotEmpty(slot0._tamingEffs) then
		for slot6, slot7 in pairs(slot0._tamingEffs) do
			for slot11, slot12 in pairs(slot7.effGos) do
				gohelper.setActive(slot12, slot1)
			end
		end
	else
		if LuaUtil.isEmptyStr(CritterConfig.instance:getCritterSkinCfg(slot0._critterMo:getSkinId()).handEffects) then
			return
		end

		if not string.split(slot3.handEffects, ";")[slot2] or LuaUtil.isEmptyStr(slot4[slot2]) then
			return
		end

		for slot9, slot10 in pairs(string.split(slot4[slot2], "&")) do
			slot11 = string.split(slot10, "|")
			slot12 = {
				root = string.format("mountroot/%s", slot11[1]),
				effPaths = {}
			}

			for slot17, slot18 in ipairs(string.split(slot11[2], "#")) do
				table.insert(slot12.effPaths, slot18)
			end

			table.insert(slot0._tamingEffs, slot12)
		end

		slot0:_loadTamingEffects()
	end
end

function slot0._loadTamingEffects(slot0)
	for slot4, slot5 in pairs(slot0._tamingEffs) do
		for slot9, slot10 in pairs(slot5.effPaths) do
			slot0._tamingEffLoader:addPath(string.format("effects/prefabs_ui/%s.prefab", slot10))
		end
	end

	slot0._tamingEffLoader:startLoad(slot0._loadTamingEffsResFinish, slot0)
end

function slot0._loadTamingEffsResFinish(slot0)
	for slot4 = 1, #slot0._tamingEffs do
		slot0._tamingEffs[slot4].effGos = {}

		for slot8, slot9 in pairs(slot0._tamingEffs[slot4].effPaths) do
			table.insert(slot0._tamingEffs[slot4].effGos, gohelper.clone(slot0._tamingEffLoader:getAssetItem(string.format("effects/prefabs_ui/%s.prefab", slot9)):GetResource(), gohelper.findChild(slot0._spineGo, slot0._tamingEffs[slot4].root)))
		end
	end
end

function slot0.setEffectByName(slot0, slot1)
	slot0._critterEffType = 0

	for slot5, slot6 in ipairs(uv0) do
		if string.find(slot1, slot6) then
			slot0._critterEffType = slot5
		end
	end
end

function slot0.setEffectByType(slot0, slot1)
	slot0._critterEffType = slot1
end

function slot0.hideEffects(slot0)
	for slot4, slot5 in pairs(slot0._effs) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.setCritterPos(slot0, slot1, slot2)
	slot0._critterPos = slot1
	slot0._inDialog = slot2

	slot0:_refreshItem()
end

function slot0.getCritterPos(slot0)
	return slot0._critterPos
end

function slot0.setCritterEffectOffset(slot0, slot1, slot2)
	slot0._effOffsetX = slot1
	slot0._effOffsetY = slot2
end

function slot0.setCritterEffectScale(slot0, slot1)
	slot0._scale = slot1
end

slot3 = {
	[true] = -160,
	[false] = -140
}
slot4 = {
	-150,
	0,
	150
}
slot5 = {
	2,
	1.5,
	2
}

function slot0._onSpineLoaded(slot0)
	slot0._spineGo = slot0._roleSpine:getSpineGo()

	slot0:_setSpine()
end

function slot0.playBodyAnim(slot0, slot1, slot2)
	slot0._roleSpine:play(slot1, slot2)

	if slot0._critterMo and CritterConfig.instance:getCritterInteractionAudioList(slot0._critterMo:getDefineId(), slot1) then
		for slot8, slot9 in ipairs(slot4) do
			AudioMgr.instance:trigger(slot9)
		end
	end
end

function slot0.fadeIn(slot0)
	UIBlockMgr.instance:startBlock("fadeShow")
	slot0:_clearTweens()
	slot0:_fadeUpdate(0)

	slot0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0._fadeUpdate, slot0._fadeInFinished, slot0, nil, EaseType.Linear)
end

function slot0._fadeUpdate(slot0, slot1)
	slot0._canvasGroup.alpha = slot1
end

function slot0._fadeInFinished(slot0)
	UIBlockMgr.instance:endBlock("fadeShow")
end

function slot0.fadeOut(slot0)
	UIBlockMgr.instance:startBlock("fadeShow")
	slot0:_clearTweens()
	slot0:_fadeUpdate(1)

	slot0._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, slot0._fadeUpdate, slot0._fadeOutFinished, slot0, nil, EaseType.Linear)
end

function slot0._fadeOutFinished(slot0)
	UIBlockMgr.instance:endBlock("fadeShow")
end

function slot0._clearTweens(slot0)
	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end

	if slot0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeOutTweenId)

		slot0._fadeOutTweenId = nil
	end
end

function slot0._setSpine(slot0)
	slot3 = uv2[slot0._critterPos]
	slot4 = slot0._scale and slot0._scale / slot3 or 1 / slot3

	transformhelper.setLocalPos(slot0._spineGo.transform, uv0[slot0._critterPos], uv1[slot0._inDialog], 0)
	transformhelper.setLocalScale(slot0._go.transform, slot3, slot3, 1)

	for slot8, slot9 in pairs(slot0._effs) do
		transformhelper.setLocalScale(slot9.transform, slot4, slot4, 1)
	end

	slot0:showShadow(slot0._critterPos == CritterEnum.PosType.Middle)
end

function slot0._refreshItem(slot0)
	if slot0._critterMo then
		if not slot0._spineGo then
			slot0._roleSpine:setResPath(ResUrl.getSpineUIPrefab(CritterConfig.instance:getCritterSkinCfg(slot0._critterMo:getSkinId()).spine), slot0._onSpineLoaded, slot0, true)
		else
			slot0:_setSpine()
		end
	end

	slot0:hideEffects()

	if not slot0._critterEffType or slot0._critterEffType == 0 then
		return
	end

	if slot0._effs[slot0._critterEffType] then
		gohelper.setActive(slot0._effs[slot0._critterEffType], true)
		transformhelper.setLocalPos(slot0._effs[slot0._critterEffType].transform, slot0._effOffsetX or 0, slot0._effOffsetY or 0, 0)
	else
		slot0._effLoader:addPath(string.format("ui/viewres/story/%s.prefab", uv0[slot0._critterEffType]))
		slot0._effLoader:startLoad(function ()
			slot0 = uv0._effLoader:getAssetItem(uv1):GetResource(uv1)
			slot1 = nil

			if uv0._spineGo then
				slot1 = gohelper.findChild(uv0._spineGo, "mountroot/mounthead")
			end

			slot2 = gohelper.clone(slot0, slot1 or uv0._go)
			uv0._effs[uv0._critterEffType] = slot2

			transformhelper.setLocalPos(slot2.transform, uv0._effOffsetX or 0, uv0._effOffsetY or 0, 0)
		end)
	end
end

function slot0.onDestroy(slot0)
	slot0:_clearTweens()

	if slot0._effs then
		for slot4, slot5 in pairs(slot0._effs) do
			gohelper.destroy(slot5)
		end

		slot0._effs = nil
	end

	if slot0._effLoader then
		slot0._effLoader:dispose()

		slot0._effLoader = nil
	end

	if slot0._tamingEffLoader then
		slot0._tamingEffLoader:dispose()

		slot0._tamingEffLoader = nil
	end

	if slot0._shadowLoader then
		slot0._shadowLoader:dispose()

		slot0._shadowLoader = nil
	end

	AudioMgr.instance:trigger(AudioEnum.Room.stop_mi_bus)
end

return slot0
