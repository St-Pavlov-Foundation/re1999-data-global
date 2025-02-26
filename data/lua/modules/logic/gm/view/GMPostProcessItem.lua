module("modules.logic.gm.view.GMPostProcessItem", package.seeall)

slot0 = class("GMPostProcessItem", MixScrollCell)

function slot0.init(slot0, slot1)
	slot0._ppvolumeWrap = gohelper.findChildComponent(CameraMgr.instance:getUnitCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	slot0._ppvolumeWrap.refresh = true
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._togglePrefab = gohelper.findChild(slot1, "toggle")
	slot0._sliderPrefab = gohelper.findChild(slot1, "slider")
	slot0._vector2Prefab = gohelper.findChild(slot1, "vector2")
	slot0._colorPrefab = gohelper.findChild(slot1, "color")

	gohelper.setActive(slot0._togglePrefab, false)
	gohelper.setActive(slot0._sliderPrefab, false)
	gohelper.setActive(slot0._vector2Prefab, false)
	gohelper.setActive(slot0._colorPrefab, false)

	slot0._typePrefabs = {
		bool = slot0._togglePrefab,
		float = slot0._sliderPrefab,
		int = slot0._sliderPrefab,
		Vector2 = slot0._vector2Prefab,
		Color = slot0._colorPrefab
	}
	slot0._itemGOs = {}
end

function slot0.removeEventListeners(slot0)
	for slot4, slot5 in ipairs(slot0._itemGOs) do
		slot7 = gohelper.findChildSlider(slot5, "Slider")
		slot8 = gohelper.findChildTextMeshInputField(slot5, "inpx")
		slot9 = gohelper.findChildTextMeshInputField(slot5, "inpy")
		slot10 = gohelper.findChildTextMeshInputField(slot5, "inp")

		if gohelper.findChildToggle(slot5, "Toggle") then
			slot6:RemoveOnValueChanged()
		end

		if slot7 then
			slot7:RemoveOnValueChanged()
		end

		if slot8 then
			slot8:RemoveOnValueChanged()
		end

		if slot9 then
			slot9:RemoveOnValueChanged()
		end

		if slot10 then
			slot10:RemoveOnValueChanged()
		end
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	recthelper.setHeight(slot0._tr, slot3)

	slot0._mo = slot1

	for slot7, slot8 in ipairs(slot1) do
		if uv0["_update" .. slot8.type] then
			if not slot0._itemGOs[slot7] then
				slot10 = gohelper.cloneInPlace(slot0._typePrefabs[slot8.type], slot7)

				table.insert(slot0._itemGOs, slot10)
				gohelper.setActive(slot10, true)
			end

			slot9(slot0, slot7, slot10, slot8)
			gohelper.setActive(gohelper.findChild(slot10, "split"), slot7 ~= #slot1)
		else
			logError("fuck no type function: " .. slot8.type)
		end
	end
end

function slot0._updatebool(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildToggle(slot2, "Toggle")

	slot4:AddOnValueChanged(function (slot0, slot1, slot2)
		slot0:_setPPValue(uv0.val, slot2)
	end, slot0)

	gohelper.findChildText(slot2, "Text").text = slot3.name
	slot4.isOn = slot0:_getPPValue(slot3.val)
end

function slot0._updatefloat(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildSlider(slot2, "Slider")

	slot4:AddOnValueChanged(function (slot0, slot1, slot2)
		slot0:_setPPValue(uv0.val, slot2)

		uv1.text = string.format("%.2f", slot2)
	end, slot0)

	slot4.slider.wholeNumbers = false
	slot4.slider.minValue = slot3.min
	slot4.slider.maxValue = slot3.max
	gohelper.findChildText(slot2, "Text").text = slot3.name
	slot8 = slot0:_getPPValue(slot3.val)

	slot4:SetValue(slot8)

	gohelper.findChildText(slot2, "Slider/Text").text = string.format("%.2f", slot8)
end

function slot0._updateint(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildSlider(slot2, "Slider")

	slot4:AddOnValueChanged(function (slot0, slot1, slot2)
		slot0:_setPPValue(uv0.val, slot2)

		uv1.text = string.format("%d", slot2)
	end, slot0)

	slot4.slider.wholeNumbers = true
	slot4.slider.minValue = slot3.min
	slot4.slider.maxValue = slot3.max
	gohelper.findChildText(slot2, "Text").text = slot3.name
	slot8 = slot0:_getPPValue(slot3.val)

	slot4:SetValue(slot8)

	gohelper.findChildText(slot2, "Slider/Text").text = string.format("%d", slot8)
end

function slot0._updateVector2(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMeshInputField(slot2, "inpx")
	slot5 = gohelper.findChildTextMeshInputField(slot2, "inpy")

	function slot6(slot0, slot1)
		slot0:_setPPValue(uv2.val, Vector2.New(tonumber(uv0:GetText()) or 0, tonumber(uv1:GetText()) or 0))
	end

	slot4:AddOnValueChanged(slot6, slot0)
	slot5:AddOnValueChanged(slot6, slot0)

	gohelper.findChildText(slot2, "Text").text = slot3.name
	slot8 = slot0:_getPPValue(slot3.val)

	slot4:SetText(slot8.x)
	slot5:SetText(slot8.y)
end

function slot0._updateColor(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildTextMeshInputField(slot2, "inp")

	slot4:AddOnValueChanged(function (slot0, slot1)
		slot0:_setPPValue(uv1.val, GameUtil.parseColor(uv0:GetText()))
	end, slot0)

	gohelper.findChildText(slot2, "Text").text = slot3.name

	slot4:SetText(GameUtil.colorToHex(slot0:_getPPValue(slot3.val)))
end

function slot0._getPPValue(slot0, slot1)
	return slot0._ppvolumeWrap[string.upper(string.sub(slot1, 1, 1)) .. string.sub(slot1, 2)]
end

function slot0._setPPValue(slot0, slot1, slot2)
	slot0._ppvolumeWrap[string.lower(string.sub(slot1, 1, 1)) .. string.sub(slot1, 2)] = slot2
end

return slot0
