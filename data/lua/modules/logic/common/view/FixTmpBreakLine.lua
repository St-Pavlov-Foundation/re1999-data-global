module("modules.logic.common.view.FixTmpBreakLine", package.seeall)

slot0 = class("FixTmpBreakLine", LuaCompBase)
slot1 = {
	"en",
	"de",
	"fr",
	"thai"
}

function slot0.initData(slot0, slot1)
	slot0.textMeshPro = slot1.gameObject:GetComponent(typeof(TMPro.TextMeshProUGUI))

	if slot0.textMeshPro then
		slot0.textMeshPro.richText = true
	end
end

function slot0.refreshTmpContent(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if GameConfig:GetCurLangShortcut() == slot6 then
			return
		end
	end

	if not slot1 then
		return
	end

	slot0:initData(slot1)

	if not slot0:startsWith(slot0.textMeshPro.text, "<nobr>") then
		slot2 = string.format("<nobr>%s", slot2)
	end

	slot0.textMeshPro.text = slot0:replaceContent(slot2)

	slot0.textMeshPro:Rebuild(UnityEngine.UI.CanvasUpdate.PreRender)
end

function slot0.replaceContent(slot0, slot1)
	slot2 = 0
	slot3 = ""
	slot4 = ""
	slot5 = false

	for slot9 = 1, #slot1 do
		if string.sub(slot1, slot9, slot9) == "<" then
			slot5 = true
		elseif slot4 == ">" then
			slot5 = false
		end

		if not slot5 and slot4 == " " then
			slot2 = slot2 + 1
		else
			if slot2 > 0 then
				slot3 = slot3 .. "<space=" .. slot2 * ZProj.GameHelper.GetTmpCharWidth(slot0.textMeshPro, 32) .. ">"
				slot2 = 0
			end

			slot3 = slot3 .. slot4
		end
	end

	return slot3
end

function slot0.startsWith(slot0, slot1, slot2)
	return string.sub(slot1, 1, string.len(slot2)) == slot2
end

return slot0
