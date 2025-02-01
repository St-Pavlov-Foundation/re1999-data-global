module("modules.ugui.UIColorHelper", package.seeall)

return {
	PressColor = GameUtil.parseColor("#C8C8C8"),
	setUIPressState = function (slot0, slot1, slot2, slot3, slot4)
		if not slot0 then
			return
		end

		slot5 = slot0:GetEnumerator()

		while slot5:MoveNext() do
			slot6 = nil

			if slot2 then
				(slot1 and slot1[slot5.Current] * (slot4 or 0.85) or slot3 or uv0.PressColor).a = slot5.Current.color.a
			else
				slot6 = slot1 and slot1[slot5.Current] or Color.white
			end

			slot5.Current.color = slot6
		end
	end,
	setGameObjectPressState = function (slot0, slot1, slot2)
		if not slot0.pressGoContainer or not slot0.pressGoContainer[slot1] then
			if not slot0.pressGoContainer then
				slot0.pressGoContainer = slot0:getUserDataTb_()
			end

			slot0.pressGoContainer[slot1] = {}
			slot3 = slot1:GetComponentsInChildren(gohelper.Type_Image, true)
			slot0.pressGoContainer[slot1].images = slot3
			slot0.pressGoContainer[slot1].tmps = slot1:GetComponentsInChildren(gohelper.Type_TextMesh, true)
			slot0.pressGoContainer[slot1].compColor = {}
			slot5 = slot3:GetEnumerator()

			while slot5:MoveNext() do
				slot0.pressGoContainer[slot1].compColor[slot5.Current] = slot5.Current.color
			end

			slot5 = slot4:GetEnumerator()

			while slot5:MoveNext() do
				slot0.pressGoContainer[slot1].compColor[slot5.Current] = slot5.Current.color
			end
		end

		if slot0.pressGoContainer[slot1] then
			uv0.setUIPressState(slot0.pressGoContainer[slot1].images, slot0.pressGoContainer[slot1].compColor, slot2, nil, 0.7)
			uv0.setUIPressState(slot0.pressGoContainer[slot1].tmps, slot0.pressGoContainer[slot1].compColor, slot2, nil, 0.7)
		end
	end,
	set = function (slot0, slot1)
		SLFramework.UGUI.GuiHelper.SetColor(slot0, slot1)
	end,
	setGray = function (slot0, slot1)
		ZProj.UGUIHelper.SetGrayscale(slot0, slot1 and true or false)
	end
}
