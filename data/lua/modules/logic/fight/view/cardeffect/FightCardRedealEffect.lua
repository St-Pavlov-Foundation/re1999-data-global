module("modules.logic.fight.view.cardeffect.FightCardRedealEffect", package.seeall)

slot0 = class("FightCardRedealEffect", BaseWork)
slot1 = "UNITY_UI_DISSOLVE"
slot2 = "ui/materials/dynamic/kapairongjie.mat"

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0.context.newCards and #slot0.context.newCards > 0 then
		slot0._paramDict = {}
		slot0._loadingDissolveMat = true

		loadAbAsset(uv1, false, slot0._onLoadDissolveMat, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 1.3 / FightModel.instance:getUISpeed())
	else
		logError("手牌变更失败，没有数据")
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function slot0._onLoadDissolveMat(slot0, slot1)
	slot0._loadingDissolveMat = nil

	if slot1.IsLoadSuccess then
		slot0._dissolveMat = UnityEngine.GameObject.Instantiate(slot1:GetResource())

		slot0:_setupDissolveMat()
		slot0:_playDissolveMat()
	end

	slot0:_playEffects()
end

function slot0._playEffects(slot0)
	slot0._effectGOList = {}
	slot0._effectLoaderList = {}
	slot1 = slot0.context.oldCards

	for slot5, slot6 in ipairs(slot0.context.newCards) do
		if not slot0.context.handCardItemList[slot5].go.activeInHierarchy then
			slot0:onDone(true)

			return
		end
	end

	for slot5, slot6 in ipairs(slot0.context.newCards) do
		slot8 = slot1[slot5]
		slot10 = gohelper.findChild(slot0.context.handCardItemList[slot5].go, "changeEffect") or gohelper.create2d(slot7.go, "changeEffect")
		slot11 = PrefabInstantiate.Create(slot10)
		slot0._paramDict[slot11] = {
			oldCardLv = FightCardModel.instance:getSkillLv(slot8.uid, slot8.skillId)
		}

		slot11:startLoad(FightPreloadOthersWork.ClothSkillEffectPath, slot0._onClothSkillEffectLoaded, slot0)
		table.insert(slot0._effectGOList, slot10)
		table.insert(slot0._effectLoaderList, slot11)
	end
end

function slot0._onClothSkillEffectLoaded(slot0, slot1)
	slot4 = gohelper.findChild(slot1:getInstGO(), tostring(slot0._paramDict[slot1].oldCardLv))

	gohelper.onceAddComponent(slot4, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
	gohelper.setActive(slot4, true)
end

function slot0._setupDissolveMat(slot0)
	slot0._imgMaskMatDict = {}
	slot0._imgMaskCloneDict = {}

	for slot4, slot5 in ipairs(slot0.context.newCards) do
		slot8 = {}
		slot12 = slot8

		uv0._getChildActiveImage(gohelper.findChild(slot0.context.handCardItemList[slot4].go, "foranim"), slot12)

		for slot12, slot13 in ipairs(slot8) do
			if slot13.material == slot13.defaultMaterial then
				slot0._needSetMatNilDict = slot0._needSetMatNilDict or {}
				slot0._needSetMatNilDict[slot13] = true
				slot13.material = slot0._dissolveMat
			else
				slot0._imgMaskMatDict[slot13] = slot13.material
				slot13.material = UnityEngine.GameObject.Instantiate(slot13.material)

				slot13.material:EnableKeyword(uv1)
				slot13.material:SetVector("_OutSideColor", Vector4.New(0, 0, 0, 1))
				slot13.material:SetVector("_InSideColor", Vector4.New(0, 0, 0, 1))

				slot0._imgMaskCloneDict[slot13] = slot13.material
			end
		end
	end
end

function slot0._getChildActiveImage(slot0, slot1)
	if slot0.activeInHierarchy and slot0:GetComponent(typeof(UnityEngine.RectTransform)) then
		if slot0:GetComponent(gohelper.Type_Image) then
			table.insert(slot1, slot2)
		end

		for slot8 = 0, slot0.transform.childCount - 1 do
			uv0._getChildActiveImage(slot3:GetChild(slot8).gameObject, slot1)
		end
	end
end

function slot0._playDissolveMat(slot0)
	slot1 = MaterialUtil.getPropValueFromMat(slot0._dissolveMat, "_DissolveOffset", "Vector4")

	MaterialUtil.setPropValue(slot0._dissolveMat, "_DissolveOffset", "Vector4", Vector4.New(0.07, slot1.y, slot1.z, slot1.w))

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0.07, 1.7526, 0.6, function (slot0)
		uv0.x = slot0

		MaterialUtil.setPropValue(uv1._dissolveMat, "_DissolveOffset", "Vector4", uv0)

		if uv1._imgMaskCloneDict then
			for slot4, slot5 in pairs(uv1._imgMaskCloneDict) do
				MaterialUtil.setPropValue(slot5, "_DissolveOffset", "Vector4", uv0)
			end
		end
	end, function ()
		for slot3, slot4 in ipairs(uv0.context.newCards) do
			uv0.context.handCardItemList[slot3]:updateItem(slot3, slot4)
		end

		uv0._tweenId = ZProj.TweenHelper.DOTweenFloat(1.7526, 0.07, 0.6, function (slot0)
			uv0.x = slot0

			MaterialUtil.setPropValue(uv1._dissolveMat, "_DissolveOffset", "Vector4", uv0)

			if uv1._imgMaskCloneDict then
				for slot4, slot5 in pairs(uv1._imgMaskCloneDict) do
					MaterialUtil.setPropValue(slot5, "_DissolveOffset", "Vector4", uv0)
				end
			end
		end)
	end)
end

function slot0._delayDone(slot0)
	if slot0._lockGO then
		gohelper.setActive(slot0._lockGO, true)

		slot0._lockGO = nil
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._loadingDissolveMat then
		removeAssetLoadCb(uv0, slot0._onLoadDissolveMat, slot0)
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_removeEffect()
	slot0:_removeDissolveMat()

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end

	if slot0._dissolveMat then
		gohelper.destroy(slot0._dissolveMat)
	end

	slot0._imgMaskMatDict = nil
	slot0._dissolveMat = nil
	slot0._tweenId = nil
	slot0._lockGO = nil
	slot0._paramDict = nil
end

function slot0._removeDissolveMat(slot0)
	if slot0._imgMaskMatDict then
		for slot4, slot5 in pairs(slot0._imgMaskMatDict) do
			slot4.material = slot5
			slot0._imgMaskMatDict[slot4] = nil
		end
	end

	if slot0._imgMaskCloneDict then
		for slot4, slot5 in pairs(slot0._imgMaskCloneDict) do
			gohelper.destroy(slot5)

			slot0._imgMaskCloneDict[slot4] = nil
		end
	end

	if slot0._needSetMatNilDict then
		for slot4, slot5 in pairs(slot0._needSetMatNilDict) do
			slot4.material = nil
			slot0._needSetMatNilDict[slot4] = nil
		end
	end

	slot0._needSetMatNilDict = nil
	slot0._imgMaskCloneDict = nil
	slot0._imgMaskMatDict = nil
end

function slot0._removeEffect(slot0)
	if slot0._effectLoaderList then
		for slot4, slot5 in ipairs(slot0._effectLoaderList) do
			slot5:dispose()
		end
	end

	if slot0._effectGOList then
		for slot4, slot5 in ipairs(slot0._effectGOList) do
			gohelper.destroy(slot5)
		end
	end

	slot0._effectGOList = nil
	slot0._effectLoaderList = nil
end

return slot0
