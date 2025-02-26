module("modules.logic.fight.view.cardeffect.FightCardDissolveEffect", package.seeall)

slot0 = class("FightCardDissolveEffect", BaseWork)
slot2 = 1 * 0.033
slot3 = "CardItemMeshs"
slot4 = 11
slot5 = "_MainTex"
slot6 = "UNITY_UI_DISSOLVE"
slot7 = "_UseUIDissolve"
slot8 = {
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
	slot4 = CameraMgr.instance:getUICamera()
	slot5 = CameraMgr.instance:getCameraTraceGO().transform.rotation * Quaternion.Euler(0, 180, 0)
	slot8 = UnityEngine.Screen.width / UnityEngine.Screen.height
	slot9 = CameraMgr.instance:getUnitCamera().fieldOfView * Mathf.Deg2Rad
	slot10 = Mathf.Tan(slot9 * 0.5) * uv0 / UnityEngine.Screen.height
	slot11 = Mathf.Tan(slot9 * 0.5) * uv0 / 1080 * slot8 * 0.5625

	if 1.7777777777777777 < slot8 then
		slot11 = Mathf.Tan(slot9 * 0.5) * uv0 / 1080
	end

	slot12 = UnityEngine.GameObject.New()
	slot12.name = uv1
	slot12.transform.parent = slot3.transform

	for slot16 = 0, slot1.Length - 1 do
		slot17 = slot1[slot16]
		slot18 = slot17.transform
		slot19 = UnityEngine.GameObject.Instantiate(slot17.material)

		table.insert(slot0._cloneMats, slot19)

		slot19.name = slot17.material.name .. "_clone"

		if not gohelper.isNil(slot17.sprite) and not gohelper.isNil(slot17.sprite.texture) then
			slot19:SetTexture(uv2, slot17.sprite.texture)

			slot20 = Vector2.New(slot17.sprite.texture.width, slot17.sprite.texture.height)
			slot21 = slot17.sprite.textureRect.min
			slot22 = slot17.sprite.textureRect.size

			slot19:SetTextureOffset(uv2, Vector2.New(slot21.x / slot20.x, slot21.y / slot20.y))
			slot19:SetTextureScale(uv2, Vector2.New(slot22.x / slot20.x, slot22.y / slot20.y))
		end

		slot20 = gohelper.clone(slot2, slot12, slot17.name)
		slot21 = slot20.transform

		gohelper.setLayer(slot20, UnityLayer.Unit, true)

		slot22 = slot20:GetComponent(typeof(UnityEngine.Renderer))
		slot22.sortingOrder = slot22.sortingOrder + slot16
		slot22.sharedMaterial = slot19

		table.insert(slot0._renderers, slot22)

		slot23 = slot4:WorldToScreenPoint(slot18.position)
		slot21.localScale = Vector3.New(slot11 * slot18.sizeDelta.x * (slot0.context.dissolveScale or 1), slot11 * slot18.sizeDelta.y * (slot0.context.dissolveScale or 1), 1)
		slot21.rotation = slot5
		slot21.position = slot3.transform:TransformPoint(Vector3.New(-((UnityEngine.Screen.width - slot23.x * 2) * slot10), -((UnityEngine.Screen.height - slot23.y * 2) * slot10), uv0) * 0.5)
	end

	return slot12
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
