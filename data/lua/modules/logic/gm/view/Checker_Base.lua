module("modules.logic.gm.view.Checker_Base", package.seeall)

slot0 = class("Checker_Base")
slot0.Color = {
	Blue = "#0000FF",
	Green = "#00FF00",
	Red = "#FF0000",
	Yellow = "#FFFF00",
	White = "#FFFFFF"
}

function slot0.makeColorStr(slot0, slot1, slot2)
	return gohelper.getRichColorText(tostring(slot1), slot2 or "#FFFFFF")
end

function slot0.ctor(slot0)
	slot0:clearAll()
end

function slot0.clearAll(slot0)
	slot0._strBuilder = {}
	slot0._indentCount = 0
	slot0._stackIndent = {}
	slot0._stackMarkLineIndex = {}
end

function slot0.lineCount(slot0)
	return #slot0._strBuilder
end

function slot0.addIndent(slot0)
	slot0._indentCount = slot0._indentCount + 1
end

function slot0.subIndent(slot0)
	slot0._indentCount = slot0._indentCount - 1
end

function slot0.pushIndent(slot0)
	table.insert(slot0._stackIndent, slot0._indentCount)

	slot0._indentCount = 0
end

function slot0.popIndent(slot0)
	assert(#slot0._stackIndent > 0, "[popIndent] invalid stack balance!")

	slot0._indentCount = table.remove(slot0._stackIndent)
end

function slot0.pushMarkLine(slot0)
	table.insert(slot0._stackMarkLineIndex, slot0:lineCount())
end

function slot0.popMarkLine(slot0)
	assert(#slot0._stackMarkLineIndex > 0, "[popMarkLine]invalid stack balance!")

	return table.remove(slot0._stackMarkLineIndex)
end

function slot0.appendWithIndex(slot0, slot1, slot2)
	assert(tonumber(slot2) ~= nil)

	slot4 = nil
	slot0._strBuilder[slot2] = (slot2 > 0 and slot0:lineCount() >= slot2 or slot0:_validateValue(slot1)) and slot0._strBuilder[slot2] .. slot0:_validateValue(slot1)
end

function slot0.append(slot0, slot1)
	slot0:appendWithIndex(slot1, math.max(1, slot0:lineCount()))
end

function slot0.appendLine(slot0, slot1)
	table.insert(slot0._strBuilder, slot0:_validateValue(slot1))
end

function slot0.insertLine(slot0, slot1, slot2)
	table.insert(slot0._strBuilder, slot0:_validateValue(slot2), GameUtil.clamp(slot1, 1, slot0:lineCount()))
end

function slot0.appendRange(slot0, slot1)
	if not slot1 or #slot1 == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:appendLine(slot6)
	end
end

function slot0.move(slot0, slot1)
	if not slot1 then
		return
	end

	for slot6, slot7 in ipairs(slot1._strBuilder) do
		slot0:appendLine(slot7)
	end

	slot1._strBuilder = {}
end

function slot0.tostring(slot0)
	return table.concat(slot0._strBuilder, "\n")
end

function slot0._indentStr(slot0)
	if slot0._indentCount <= 0 then
		return ""
	end

	return string.rep("\t", slot0._indentCount)
end

function slot0._validateValue(slot0, slot1)
	return slot0:_indentStr() .. tostring(slot1)
end

function slot0.log(slot0)
	logNormal(slot0:tostring())
end

return slot0
