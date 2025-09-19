module("modules.logic.fight.view.cardeffect.FightCardDissolveEffect", package.seeall)

local var_0_0 = class("FightCardDissolveEffect", BaseWork)
local var_0_1 = 1
local var_0_2 = var_0_1 * 0.033
local var_0_3 = "CardItemMeshs"
local var_0_4 = "_MainTex"
local var_0_5 = "UNITY_UI_DISSOLVE"
local var_0_6 = "_UseUIDissolve"
local var_0_7 = {
	"_DissolveOffset",
	"Vector4",
	Vector4.New(0, 25, 3.35, 0),
	Vector4.New(1.3, 25, 3.35, 0)
}

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	arg_1_0._dt = var_0_2 / FightModel.instance:getUISpeed()
	arg_1_0._cloneItemGOs = {}

	local var_1_0 = FightHelper.getPreloadAssetItem(FightPreloadOthersWork.ui_mesh):GetResource(FightPreloadOthersWork.ui_mesh)
	local var_1_1 = FightHelper.getPreloadAssetItem(FightPreloadOthersWork.ui_effectsmat):GetResource(FightPreloadOthersWork.ui_effectsmat)

	arg_1_0._mats = {}
	arg_1_0._cloneMats = {}
	arg_1_0._meshGOs = {}
	arg_1_0._renderers = {}
	arg_1_0._txtList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.dissolveSkillItemGOs) do
		local var_1_2 = gohelper.cloneInPlace(iter_1_1)

		gohelper.setActive(iter_1_1, false)
		table.insert(arg_1_0._cloneItemGOs, var_1_2)
		arg_1_0:_hideEffect(var_1_2)

		local var_1_3 = var_1_2:GetComponentsInChildren(gohelper.Type_Image, false)

		for iter_1_2 = 0, var_1_3.Length - 1 do
			local var_1_4 = var_1_3[iter_1_2]

			var_1_4.color.a = 1
			var_1_4.enabled = false

			if var_1_4.material == var_1_4.defaultMaterial then
				var_1_4.material = var_1_1
			end
		end

		local var_1_5 = var_1_2:GetComponentsInChildren(gohelper.Type_TextMesh, false)

		for iter_1_3 = 0, var_1_5.Length - 1 do
			local var_1_6 = var_1_5[iter_1_3]

			table.insert(arg_1_0._txtList, var_1_6)
		end

		local var_1_7 = var_1_2:GetComponentsInChildren(gohelper.Type_Text, false)

		for iter_1_4 = 0, var_1_7.Length - 1 do
			local var_1_8 = var_1_7[iter_1_4]

			table.insert(arg_1_0._txtList, var_1_8)
		end

		local var_1_9 = arg_1_0:_setupMesh(var_1_3, var_1_0)

		table.insert(arg_1_0._meshGOs, var_1_9)

		local var_1_10 = var_1_9:GetComponentsInChildren(typeof(UnityEngine.Renderer), false)

		for iter_1_5 = 0, var_1_10.Length - 1 do
			local var_1_11 = var_1_10[iter_1_5].material

			table.insert(arg_1_0._mats, var_1_11)
			var_1_11:EnableKeyword(var_0_5)
			var_1_11:SetFloat(var_0_6, 1)
		end
	end

	arg_1_0._flow = FlowSequence.New()

	arg_1_0._flow:addWork(TweenWork.New({
		from = 0,
		type = "DOTweenFloat",
		to = 1,
		t = arg_1_0._dt * 30,
		frameCb = arg_1_0._tweenFrameFunc,
		cbObj = arg_1_0
	}))
	arg_1_0._flow:registerDoneListener(arg_1_0._onWorkDone, arg_1_0)
	arg_1_0._flow:start()
end

function var_0_0._tweenFrameFunc(arg_2_0, arg_2_1)
	if arg_2_0._txtList then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._txtList) do
			ZProj.UGUIHelper.SetColorAlpha(iter_2_1, math.max(1 - arg_2_1 * 2, 0))
		end
	end

	if arg_2_0._mats then
		for iter_2_2, iter_2_3 in ipairs(arg_2_0._mats) do
			local var_2_0 = var_0_7[1]
			local var_2_1 = var_0_7[2]
			local var_2_2 = var_0_7[3]
			local var_2_3 = var_0_7[4]
			local var_2_4 = MaterialUtil.getLerpValue(var_2_1, var_2_2, var_2_3, arg_2_1)

			MaterialUtil.setPropValue(iter_2_3, var_2_0, var_2_1, var_2_4)
		end
	end
end

function var_0_0._setupMesh(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = CameraMgr.instance:getUnitCamera()
	local var_3_1 = CameraMgr.instance:getUICamera()
	local var_3_2 = CameraMgr.instance:getCameraTraceGO().transform.rotation * Quaternion.Euler(0, 180, 0)
	local var_3_3 = arg_3_0:getCameraDistance()
	local var_3_4 = var_3_0.fieldOfView * Mathf.Deg2Rad
	local var_3_5 = Mathf.Tan(var_3_4 * 0.5) * var_3_3 / UnityEngine.Screen.height
	local var_3_6, var_3_7 = arg_3_0:getScaleFactor()
	local var_3_8 = UnityEngine.GameObject.New()

	var_3_8.name = var_0_3
	var_3_8.transform.parent = var_3_0.transform

	for iter_3_0 = 0, arg_3_1.Length - 1 do
		local var_3_9 = arg_3_1[iter_3_0]
		local var_3_10 = var_3_9.transform
		local var_3_11 = UnityEngine.GameObject.Instantiate(var_3_9.material)

		table.insert(arg_3_0._cloneMats, var_3_11)

		var_3_11.name = var_3_9.material.name .. "_clone"

		if not gohelper.isNil(var_3_9.sprite) and not gohelper.isNil(var_3_9.sprite.texture) then
			var_3_11:SetTexture(var_0_4, var_3_9.sprite.texture)

			local var_3_12 = Vector2.New(var_3_9.sprite.texture.width, var_3_9.sprite.texture.height)
			local var_3_13 = var_3_9.sprite.textureRect.min
			local var_3_14 = var_3_9.sprite.textureRect.size
			local var_3_15 = Vector2.New(var_3_14.x / var_3_12.x, var_3_14.y / var_3_12.y)
			local var_3_16 = Vector2.New(var_3_13.x / var_3_12.x, var_3_13.y / var_3_12.y)

			var_3_11:SetTextureOffset(var_0_4, var_3_16)
			var_3_11:SetTextureScale(var_0_4, var_3_15)
		end

		local var_3_17 = gohelper.clone(arg_3_2, var_3_8, var_3_9.name)
		local var_3_18 = var_3_17.transform

		gohelper.setLayer(var_3_17, UnityLayer.Unit, true)

		local var_3_19 = var_3_17:GetComponent(typeof(UnityEngine.Renderer))

		var_3_19.sortingOrder = var_3_19.sortingOrder + iter_3_0
		var_3_19.sharedMaterial = var_3_11

		table.insert(arg_3_0._renderers, var_3_19)

		local var_3_20 = var_3_1:WorldToScreenPoint(var_3_10.position)
		local var_3_21 = (UnityEngine.Screen.width - var_3_20.x * 2) * var_3_5
		local var_3_22 = (UnityEngine.Screen.height - var_3_20.y * 2) * var_3_5
		local var_3_23 = var_3_6 * var_3_10.sizeDelta.x * (arg_3_0.context.dissolveScale or 1)
		local var_3_24 = var_3_7 * var_3_10.sizeDelta.y * (arg_3_0.context.dissolveScale or 1)
		local var_3_25 = Vector3.New(-var_3_21, -var_3_22, var_3_3) * 0.5

		var_3_18.localScale = Vector3.New(var_3_23, var_3_24, 1)
		var_3_18.rotation = var_3_2
		var_3_18.position = var_3_0.transform:TransformPoint(var_3_25)
	end

	return var_3_8
end

function var_0_0.getScaleFactor(arg_4_0)
	if arg_4_0.wRate then
		return arg_4_0.wRate, arg_4_0.hRate
	end

	local var_4_0 = CameraMgr.instance:getUnitCamera()
	local var_4_1 = arg_4_0:getCameraDistance()
	local var_4_2 = ViewMgr.instance:getUIRoot():GetComponent(gohelper.Type_RectTransform)
	local var_4_3 = recthelper.getWidth(var_4_2)
	local var_4_4 = recthelper.getHeight(var_4_2)
	local var_4_5 = var_4_3 / var_4_4
	local var_4_6 = var_4_0.fieldOfView * Mathf.Deg2Rad * 0.5
	local var_4_7 = Mathf.Tan(var_4_6) * var_4_1

	arg_4_0.wRate, arg_4_0.hRate = var_4_5 * var_4_7 / var_4_3, var_4_7 / var_4_4

	return arg_4_0.wRate, arg_4_0.hRate
end

function var_0_0.onStop(arg_5_0)
	var_0_0.super.onStop(arg_5_0)

	if arg_5_0._flow then
		arg_5_0._flow:unregisterDoneListener(arg_5_0._onWorkDone, arg_5_0)

		if arg_5_0._flow.status == WorkStatus.Running then
			arg_5_0._flow:stop()
		end
	end
end

function var_0_0._onWorkDone(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	if arg_7_0._cloneMats then
		for iter_7_0 = 1, #arg_7_0._cloneMats do
			gohelper.destroy(arg_7_0._cloneMats[iter_7_0])

			arg_7_0._cloneMats[iter_7_0] = nil
		end
	end

	if arg_7_0._cloneItemGOs then
		for iter_7_1 = 1, #arg_7_0._cloneItemGOs do
			gohelper.destroy(arg_7_0._cloneItemGOs[iter_7_1])

			arg_7_0._cloneItemGOs[iter_7_1] = nil
		end
	end

	if arg_7_0._meshGOs then
		for iter_7_2 = 1, #arg_7_0._meshGOs do
			gohelper.destroy(arg_7_0._meshGOs[iter_7_2])

			arg_7_0._meshGOs[iter_7_2] = nil
		end
	end

	if arg_7_0._mats then
		for iter_7_3 = 1, #arg_7_0._mats do
			arg_7_0._mats[iter_7_3] = nil
		end
	end

	if arg_7_0._txtList then
		for iter_7_4 = 1, #arg_7_0._txtList do
			arg_7_0._txtList[iter_7_4] = nil
		end
	end

	if arg_7_0._renderers then
		for iter_7_5 = 1, #arg_7_0._renderers do
			gohelper.destroy(arg_7_0._renderers[iter_7_5].material)

			arg_7_0._renderers[iter_7_5] = nil
		end
	end

	if arg_7_0._flow then
		arg_7_0._flow:unregisterDoneListener(arg_7_0._onWorkDone, arg_7_0)
		arg_7_0._flow:stop()

		arg_7_0._flow = nil
	end

	arg_7_0._cloneMats = nil
	arg_7_0._cloneItemGOs = nil
	arg_7_0._meshGOs = nil
	arg_7_0._mats = nil
	arg_7_0._renderers = nil
end

function var_0_0.clear()
	local var_8_0 = CameraMgr.instance:getUnitCameraTrs()
	local var_8_1
	local var_8_2 = var_8_0.childCount

	for iter_8_0 = 1, var_8_2 do
		local var_8_3 = var_8_0:GetChild(iter_8_0 - 1)

		if var_8_3.name == var_0_3 then
			var_8_1 = var_8_1 or {}

			table.insert(var_8_1, var_8_3)
		end
	end

	if var_8_1 then
		for iter_8_1, iter_8_2 in ipairs(var_8_1) do
			gohelper.destroy(iter_8_2.gameObject)
		end
	end
end

function var_0_0.getCameraDistance(arg_9_0)
	if arg_9_0.cameraDistance then
		return arg_9_0.cameraDistance
	end

	local var_9_0 = CameraMgr.instance:getUnitCamera()
	local var_9_1 = ViewMgr.instance:getUIRoot()

	arg_9_0.cameraDistance = math.abs(var_9_0.transform.position.z - var_9_1.transform.position.z)

	return arg_9_0.cameraDistance
end

function var_0_0._hideEffect(arg_10_0, arg_10_1)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "lock"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/ui_dazhaoka(Clone)"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/predisplay"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "vx_balance"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/lv1/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/lv2/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/lv3/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/card/lv4/#cardeffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "cardmask"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "cardAppearEffectRoot"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "lvChangeEffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/cardConvertEffect"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "layout"), false)
	gohelper.setActive(gohelper.findChild(arg_10_1, "foranim/restrain"), false)
end

return var_0_0
