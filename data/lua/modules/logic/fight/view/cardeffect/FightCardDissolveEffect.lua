module("modules.logic.fight.view.cardeffect.FightCardDissolveEffect", package.seeall)

slot0 = class("FightCardDissolveEffect", BaseWork)
slot2 = 1 * 0.033
slot3 = "CardItemMeshs"
slot4 = "_MainTex"
slot5 = "UNITY_UI_DISSOLVE"
slot6 = "_UseUIDissolve"
slot7 = {
	"_DissolveOffset",
	"Vector4",
	Vector4.New(0, 25, 3.35, 0),
	Vector4.New(1.3, 25, 3.35, 0)
}

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	slot0._dt = uv1 / FightModel.instance:getUISpeed()
	slot0._cloneItemGOs = {}
	slot3 = FightHelper.getPreloadAssetItem(FightPreloadOthersWork.ui_mesh):GetResource(FightPreloadOthersWork.ui_mesh)
	slot5 = FightHelper.getPreloadAssetItem(FightPreloadOthersWork.ui_effectsmat):GetResource(FightPreloadOthersWork.ui_effectsmat)
	slot0._mats = {}
	slot0._cloneMats = {}
	slot0._meshGOs = {}
	slot0._renderers = {}

	for slot9, slot10 in ipairs(slot1.dissolveSkillItemGOs) do
		slot11 = gohelper.cloneInPlace(slot10)

		gohelper.setActive(slot10, false)
		table.insert(slot0._cloneItemGOs, slot11)
		slot0:_hideEffect(slot11)

		for slot16 = 0, slot11:GetComponentsInChildren(gohelper.Type_Image, false).Length - 1 do
			slot17 = slot12[slot16]
			slot17.color.a = 1
			slot17.enabled = false

			if slot17.material == slot17.defaultMaterial then
				slot17.material = slot5
			end
		end

		slot13 = slot0:_setupMesh(slot12, slot3)

		table.insert(slot0._meshGOs, slot13)

		for slot18 = 0, slot13:GetComponentsInChildren(typeof(UnityEngine.Renderer), false).Length - 1 do
			slot19 = slot14[slot18].material

			table.insert(slot0._mats, slot19)
			slot19:EnableKeyword(uv2)
			slot19:SetFloat(uv3, 1)
		end
	end

	slot0._flow = FlowSequence.New()

	slot0._flow:addWork(TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = 1,
		t = slot0._dt * 30,
		frameCb = slot0._tweenFrameFunc,
		cbObj = slot0
	}))
	slot0._flow:registerDoneListener(slot0._onWorkDone, slot0)
	slot0._flow:start()
end

function slot0._tweenFrameFunc(slot0, slot1)
	if slot0._mats then
		for slot5, slot6 in ipairs(slot0._mats) do
			slot8 = uv0[2]

			MaterialUtil.setPropValue(slot6, uv0[1], slot8, MaterialUtil.getLerpValue(slot8, uv0[3], uv0[4], slot1))
		end
	end
end

function slot0._setupMesh(slot0, slot1, slot2)
	slot3 = CameraMgr.instance:getUnitCamera()
	slot4 = CameraMgr.instance:getUICamera()
	slot5 = CameraMgr.instance:getCameraTraceGO().transform.rotation * Quaternion.Euler(0, 180, 0)
	slot8 = Mathf.Tan(slot3.fieldOfView * Mathf.Deg2Rad * 0.5) * slot0:getCameraDistance() / UnityEngine.Screen.height
	slot9, slot10 = slot0:getScaleFactor()
	slot11 = UnityEngine.GameObject.New()
	slot11.name = uv0
	slot11.transform.parent = slot3.transform

	for slot15 = 0, slot1.Length - 1 do
		slot16 = slot1[slot15]
		slot17 = slot16.transform
		slot18 = UnityEngine.GameObject.Instantiate(slot16.material)

		table.insert(slot0._cloneMats, slot18)

		slot18.name = slot16.material.name .. "_clone"

		if not gohelper.isNil(slot16.sprite) and not gohelper.isNil(slot16.sprite.texture) then
			slot18:SetTexture(uv1, slot16.sprite.texture)

			slot19 = Vector2.New(slot16.sprite.texture.width, slot16.sprite.texture.height)
			slot20 = slot16.sprite.textureRect.min
			slot21 = slot16.sprite.textureRect.size

			slot18:SetTextureOffset(uv1, Vector2.New(slot20.x / slot19.x, slot20.y / slot19.y))
			slot18:SetTextureScale(uv1, Vector2.New(slot21.x / slot19.x, slot21.y / slot19.y))
		end

		slot19 = gohelper.clone(slot2, slot11, slot16.name)
		slot20 = slot19.transform

		gohelper.setLayer(slot19, UnityLayer.Unit, true)

		slot21 = slot19:GetComponent(typeof(UnityEngine.Renderer))
		slot21.sortingOrder = slot21.sortingOrder + slot15
		slot21.sharedMaterial = slot18

		table.insert(slot0._renderers, slot21)

		slot22 = slot4:WorldToScreenPoint(slot17.position)
		slot20.localScale = Vector3.New(slot9 * slot17.sizeDelta.x * (slot0.context.dissolveScale or 1), slot10 * slot17.sizeDelta.y * (slot0.context.dissolveScale or 1), 1)
		slot20.rotation = slot5
		slot20.position = slot3.transform:TransformPoint(Vector3.New(-((UnityEngine.Screen.width - slot22.x * 2) * slot8), -((UnityEngine.Screen.height - slot22.y * 2) * slot8), slot6) * 0.5)
	end

	return slot11
end

function slot0.getScaleFactor(slot0)
	if slot0.wRate then
		return slot0.wRate, slot0.hRate
	end

	slot4 = ViewMgr.instance:getUIRoot():GetComponent(gohelper.Type_RectTransform)
	slot5 = recthelper.getWidth(slot4)
	slot6 = recthelper.getHeight(slot4)
	slot10 = Mathf.Tan(CameraMgr.instance:getUnitCamera().fieldOfView * Mathf.Deg2Rad * 0.5) * slot0:getCameraDistance()
	slot0.hRate = slot10 / slot6
	slot0.wRate = slot5 / slot6 * slot10 / slot5

	return slot0.wRate, slot0.hRate
end

function slot0.onStop(slot0)
	uv0.super.onStop(slot0)

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)

		if slot0._flow.status == WorkStatus.Running then
			slot0._flow:stop()
		end
	end
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._cloneMats then
		for slot4 = 1, #slot0._cloneMats do
			gohelper.destroy(slot0._cloneMats[slot4])

			slot0._cloneMats[slot4] = nil
		end
	end

	if slot0._cloneItemGOs then
		for slot4 = 1, #slot0._cloneItemGOs do
			gohelper.destroy(slot0._cloneItemGOs[slot4])

			slot0._cloneItemGOs[slot4] = nil
		end
	end

	if slot0._meshGOs then
		for slot4 = 1, #slot0._meshGOs do
			gohelper.destroy(slot0._meshGOs[slot4])

			slot0._meshGOs[slot4] = nil
		end
	end

	if slot0._mats then
		for slot4 = 1, #slot0._mats do
			slot0._mats[slot4] = nil
		end
	end

	if slot0._renderers then
		for slot4 = 1, #slot0._renderers do
			gohelper.destroy(slot0._renderers[slot4].material)

			slot0._renderers[slot4] = nil
		end
	end

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onWorkDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end

	slot0._cloneMats = nil
	slot0._cloneItemGOs = nil
	slot0._meshGOs = nil
	slot0._mats = nil
	slot0._renderers = nil
end

function slot0.clear()
	slot1 = nil

	for slot6 = 1, CameraMgr.instance:getUnitCameraTrs().childCount do
		if slot0:GetChild(slot6 - 1).name == uv0 then
			table.insert(slot1 or {}, slot7)
		end
	end

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			gohelper.destroy(slot7.gameObject)
		end
	end
end

function slot0.getCameraDistance(slot0)
	if slot0.cameraDistance then
		return slot0.cameraDistance
	end

	slot0.cameraDistance = math.abs(CameraMgr.instance:getUnitCamera().transform.position.z - ViewMgr.instance:getUIRoot().transform.position.z)

	return slot0.cameraDistance
end

function slot0._hideEffect(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(slot1, "lock"), false)
	gohelper.setActive(gohelper.findChild(slot1, "ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/predisplay"), false)
	gohelper.setActive(gohelper.findChild(slot1, "vx_balance"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/lv1/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/lv2/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/lv3/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/card/lv4/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "cardmask"), false)
	gohelper.setActive(gohelper.findChild(slot1, "cardAppearEffectRoot"), false)
	gohelper.setActive(gohelper.findChild(slot1, "lvChangeEffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/cardConvertEffect"), false)
	gohelper.setActive(gohelper.findChild(slot1, "layout"), false)
	gohelper.setActive(gohelper.findChild(slot1, "foranim/restrain"), false)
end

return slot0
