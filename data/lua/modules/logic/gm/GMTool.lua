slot1 = _G.debug.getupvalue
slot2 = _G.tostring
slot3 = _G.tonumber
slot4 = _G.assert
slot5 = _G.string.find
slot6 = _G.type
slot7 = table.concat
slot8 = "#00FF00"
slot9 = "#FFFFFF"
slot10 = "#FFFF00"

function slot12(slot0, slot1)
	if slot0 ~= nil and uv0(slot0) ~= "string" then
		slot0 = uv1(slot0)
	end

	if string.nilorempty(slot0) then
		slot0 = "[None]"
	end

	return gohelper.getRichColorText(slot0, slot1 or uv2)
end

function slot13(slot0)
	return slot0 and uv0("true", uv1) or uv0("false", uv2)
end

function slot14(slot0, slot1, slot2, slot3)
	uv0(slot1)

	if slot3 then
		uv0(uv1(slot2) ~= nil)
	end

	for slot7 = slot2 or 1, slot3 or math.huge do
		slot8, slot9 = uv2(slot0, slot7)

		if not slot8 then
			break
		end

		if slot8 == slot1 then
			return slot9
		end
	end
end

function slot15(slot0, slot1)
	if string.nilorempty(slot0) or string.nilorempty(slot1) then
		return false
	end

	slot2, slot3 = uv0(slot0, slot1)

	return slot2 == 1
end

function slot16(slot0, slot1)
	if string.nilorempty(slot0) or string.nilorempty(slot1) then
		return false
	end

	if #slot0 - #slot1 + 1 < 1 then
		return false
	end

	return slot0:sub(slot2) == slot1
end

function slot17(slot0)
	ZProj.UGUIHelper.CopyText(slot0)
end

function slot18()
	function slot1(slot0, slot1)
		if not slot1 then
			table.insert(uv0, slot0)
		else
			table.insert(uv0, uv1(slot0, uv2) .. ": " .. uv1(slot1, uv3))
		end
	end

	slot1("================= (海外GM) 使用方式 =================")
	slot1("LCtrl(x2)", "                             可打印玩家信息")
	slot1("Ctrl + 鼠标左键 + 点击UI", "可查看UI最顶层点击到的节点路径")
	slot1("F2", "                                         通关所有关卡")
	slot1("F12", "                                       退出登录")
	slot1("Ctrl + Alt + 3", "                      开/关资源加载耗时Log")
	slot1("Ctrl + Alt + 2", "                      查看正在打开的ViewNames")
	slot1("Ctrl + Alt + 1", "                      显示/隐藏LangKey")

	return uv3({}, "\n")
end

if getGlobal("Partial_GMTool") then
	logNormal("<color=#00FF00> hotfix finished </color>")
	function (slot0)
		slot4 = slot0

		UpdateBeat:Remove(slot0._update, slot4)

		for slot4, slot5 in pairs(slot0) do
			if uv0(slot5) == "table" and slot5.onClear then
				slot5:onClear()
				logNormal(slot4 .. "<color=#00FF00> clear finished </color>")
			end
		end
	end(slot19)
else
	logNormal("<color=#00FF00>Hello World!</color>\n" .. slot18())
end

slot20 = slot19 or {}

setGlobal(slot0, slot20)

function slot20._update()
	uv0._accountDummper:onUpdate()
	uv0._input:onUpdate()
end

slot20.util = {
	setColorDesc = slot12,
	getUpvalue = slot14,
	startsWith = slot15,
	endsWith = slot16,
	colorBoolStr = slot13,
	saveClipboard = slot17
}

require("modules/logic/gm/GMTool__Input")
require("modules/logic/gm/GMTool__AccountDummper")
require("modules/logic/gm/GMTool__ViewHooker")
UpdateBeat:Add(slot20._update, slot20)

return {}
