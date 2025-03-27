module("modules.common.utils.NumberCompressUtil", package.seeall)

slot0 = {}
slot1 = require("bit")
slot3 = {
	[slot8] = slot7
}

for slot7, slot8 in pairs({
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"-",
	"/"
}) do
	-- Nothing
end

function slot0.compress(slot0)
	for slot5, slot6 in ipairs(slot0) do
		-- Nothing
	end

	return table.concat({
		[slot5] = uv0.numToStr(slot6)
	}, "#")
end

function slot0.decompress(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(string.split(slot0, "#")) do
		if uv0.strToNum(slot7) ~= 0 then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.numToStr(slot0)
	if type(slot0) ~= "number" then
		return ""
	end

	slot1 = ""

	while slot0 > 0 do
		if not uv1[uv0.band(slot0, 63) + 1] then
			logError("NumberCompressUtil.numToStr Error:" .. tostring(slot2))

			return ""
		end

		slot1 = uv1[slot2 + 1] .. slot1
		slot0 = uv0.rshift(slot0, 6)
	end

	return slot1
end

function slot0.strToNum(slot0)
	if string.nilorempty(slot0) then
		return 0
	end

	slot2 = 0

	for slot6 = 1, #slot0 do
		if not uv0[string.sub(slot0, slot6, slot6)] then
			logError("NumberCompressUtil.strToNum Error：" .. tostring(slot0))

			return 0
		end

		slot2 = slot2 + uv1.lshift(uv0[slot7] - 1, (slot1 - slot6) * 6)
	end

	return slot2
end

return slot0
