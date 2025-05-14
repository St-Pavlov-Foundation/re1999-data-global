module("modules.logic.gm.view.GMPostProcessItem", package.seeall)

local var_0_0 = class("GMPostProcessItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._ppvolumeWrap = gohelper.findChildComponent(CameraMgr.instance:getUnitCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	arg_1_0._ppvolumeWrap.refresh = true
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._togglePrefab = gohelper.findChild(arg_1_1, "toggle")
	arg_1_0._sliderPrefab = gohelper.findChild(arg_1_1, "slider")
	arg_1_0._vector2Prefab = gohelper.findChild(arg_1_1, "vector2")
	arg_1_0._colorPrefab = gohelper.findChild(arg_1_1, "color")

	gohelper.setActive(arg_1_0._togglePrefab, false)
	gohelper.setActive(arg_1_0._sliderPrefab, false)
	gohelper.setActive(arg_1_0._vector2Prefab, false)
	gohelper.setActive(arg_1_0._colorPrefab, false)

	arg_1_0._typePrefabs = {
		bool = arg_1_0._togglePrefab,
		float = arg_1_0._sliderPrefab,
		int = arg_1_0._sliderPrefab,
		Vector2 = arg_1_0._vector2Prefab,
		Color = arg_1_0._colorPrefab
	}
	arg_1_0._itemGOs = {}
end

function var_0_0.removeEventListeners(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._itemGOs) do
		local var_2_0 = gohelper.findChildToggle(iter_2_1, "Toggle")
		local var_2_1 = gohelper.findChildSlider(iter_2_1, "Slider")
		local var_2_2 = gohelper.findChildTextMeshInputField(iter_2_1, "inpx")
		local var_2_3 = gohelper.findChildTextMeshInputField(iter_2_1, "inpy")
		local var_2_4 = gohelper.findChildTextMeshInputField(iter_2_1, "inp")

		if var_2_0 then
			var_2_0:RemoveOnValueChanged()
		end

		if var_2_1 then
			var_2_1:RemoveOnValueChanged()
		end

		if var_2_2 then
			var_2_2:RemoveOnValueChanged()
		end

		if var_2_3 then
			var_2_3:RemoveOnValueChanged()
		end

		if var_2_4 then
			var_2_4:RemoveOnValueChanged()
		end
	end
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	recthelper.setHeight(arg_3_0._tr, arg_3_3)

	arg_3_0._mo = arg_3_1

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = var_0_0["_update" .. iter_3_1.type]

		if var_3_0 then
			local var_3_1 = arg_3_0._itemGOs[iter_3_0]

			if not var_3_1 then
				var_3_1 = gohelper.cloneInPlace(arg_3_0._typePrefabs[iter_3_1.type], iter_3_0)

				table.insert(arg_3_0._itemGOs, var_3_1)
				gohelper.setActive(var_3_1, true)
			end

			var_3_0(arg_3_0, iter_3_0, var_3_1, iter_3_1)

			local var_3_2 = gohelper.findChild(var_3_1, "split")

			gohelper.setActive(var_3_2, iter_3_0 ~= #arg_3_1)
		else
			logError("fuck no type function: " .. iter_3_1.type)
		end
	end
end

function var_0_0._updatebool(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = gohelper.findChildToggle(arg_4_2, "Toggle")

	local function var_4_1(arg_5_0, arg_5_1, arg_5_2)
		arg_5_0:_setPPValue(arg_4_3.val, arg_5_2)
	end

	var_4_0:AddOnValueChanged(var_4_1, arg_4_0)

	gohelper.findChildText(arg_4_2, "Text").text = arg_4_3.name
	var_4_0.isOn = arg_4_0:_getPPValue(arg_4_3.val)
end

function var_0_0._updatefloat(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildSlider(arg_6_2, "Slider")
	local var_6_1 = gohelper.findChildText(arg_6_2, "Slider/Text")

	local function var_6_2(arg_7_0, arg_7_1, arg_7_2)
		arg_7_0:_setPPValue(arg_6_3.val, arg_7_2)

		var_6_1.text = string.format("%.2f", arg_7_2)
	end

	var_6_0:AddOnValueChanged(var_6_2, arg_6_0)

	var_6_0.slider.wholeNumbers = false
	var_6_0.slider.minValue = arg_6_3.min
	var_6_0.slider.maxValue = arg_6_3.max
	gohelper.findChildText(arg_6_2, "Text").text = arg_6_3.name

	local var_6_3 = arg_6_0:_getPPValue(arg_6_3.val)

	var_6_0:SetValue(var_6_3)

	var_6_1.text = string.format("%.2f", var_6_3)
end

function var_0_0._updateint(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildSlider(arg_8_2, "Slider")
	local var_8_1 = gohelper.findChildText(arg_8_2, "Slider/Text")

	local function var_8_2(arg_9_0, arg_9_1, arg_9_2)
		arg_9_0:_setPPValue(arg_8_3.val, arg_9_2)

		var_8_1.text = string.format("%d", arg_9_2)
	end

	var_8_0:AddOnValueChanged(var_8_2, arg_8_0)

	var_8_0.slider.wholeNumbers = true
	var_8_0.slider.minValue = arg_8_3.min
	var_8_0.slider.maxValue = arg_8_3.max
	gohelper.findChildText(arg_8_2, "Text").text = arg_8_3.name

	local var_8_3 = arg_8_0:_getPPValue(arg_8_3.val)

	var_8_0:SetValue(var_8_3)

	var_8_1.text = string.format("%d", var_8_3)
end

function var_0_0._updateVector2(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildTextMeshInputField(arg_10_2, "inpx")
	local var_10_1 = gohelper.findChildTextMeshInputField(arg_10_2, "inpy")

	local function var_10_2(arg_11_0, arg_11_1)
		local var_11_0 = tonumber(var_10_0:GetText()) or 0
		local var_11_1 = tonumber(var_10_1:GetText()) or 0

		arg_11_0:_setPPValue(arg_10_3.val, Vector2.New(var_11_0, var_11_1))
	end

	var_10_0:AddOnValueChanged(var_10_2, arg_10_0)
	var_10_1:AddOnValueChanged(var_10_2, arg_10_0)

	gohelper.findChildText(arg_10_2, "Text").text = arg_10_3.name

	local var_10_3 = arg_10_0:_getPPValue(arg_10_3.val)

	var_10_0:SetText(var_10_3.x)
	var_10_1:SetText(var_10_3.y)
end

function var_0_0._updateColor(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChildTextMeshInputField(arg_12_2, "inp")

	local function var_12_1(arg_13_0, arg_13_1)
		local var_13_0 = var_12_0:GetText()

		arg_13_0:_setPPValue(arg_12_3.val, GameUtil.parseColor(var_13_0))
	end

	var_12_0:AddOnValueChanged(var_12_1, arg_12_0)

	gohelper.findChildText(arg_12_2, "Text").text = arg_12_3.name

	local var_12_2 = arg_12_0:_getPPValue(arg_12_3.val)

	var_12_0:SetText(GameUtil.colorToHex(var_12_2))
end

function var_0_0._getPPValue(arg_14_0, arg_14_1)
	arg_14_1 = string.upper(string.sub(arg_14_1, 1, 1)) .. string.sub(arg_14_1, 2)

	return arg_14_0._ppvolumeWrap[arg_14_1]
end

function var_0_0._setPPValue(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = string.lower(string.sub(arg_15_1, 1, 1)) .. string.sub(arg_15_1, 2)
	arg_15_0._ppvolumeWrap[arg_15_1] = arg_15_2
end

return var_0_0
