module("modules.common.utils.Base64Util", package.seeall)

slot0 = _M
slot0.b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

function slot0.encode(slot0)
	return (slot0:gsub(".", function (slot0)
		slot2 = slot0:byte()

		for slot6 = 8, 1, -1 do
			slot1 = "" .. (slot2 % 2^slot6 - slot2 % 2^(slot6 - 1) > 0 and "1" or "0")
		end

		return slot1
	end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function (slot0)
		if #slot0 < 6 then
			return ""
		end

		for slot5 = 1, 6 do
			slot1 = 0 + (slot0:sub(slot5, slot5) == "1" and 2^(6 - slot5) or 0)
		end

		return uv0.b:sub(slot1 + 1, slot1 + 1)
	end) .. ({
		"",
		"==",
		"="
	})[#slot0 % 3 + 1]
end

function slot0.decode(slot0)
	return string.gsub(string.gsub(string.gsub(slot0, "data:image/jpeg;base64,", "", 1), "data:image/png;base64,", "", 1), "[^" .. uv0.b .. "=]", ""):gsub(".", function (slot0)
		if slot0 == "=" then
			return ""
		end

		slot2 = uv0.b:find(slot0) - 1

		for slot6 = 6, 1, -1 do
			slot1 = "" .. (slot2 % 2^slot6 - slot2 % 2^(slot6 - 1) > 0 and "1" or "0")
		end

		return slot1
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function (slot0)
		if #slot0 ~= 8 then
			return ""
		end

		for slot5 = 1, 8 do
			slot1 = 0 + (slot0:sub(slot5, slot5) == "1" and 2^(8 - slot5) or 0)
		end

		return string.char(slot1)
	end)
end

function slot0.saveImage(slot0)
	slot3 = System.DateTime.Now
	slot5 = System.IO.Path.Combine(System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot"), string.format("screenshot_%s%s%s_%s%s%s%s.png", slot3.Year, slot3.Month, slot3.Day, slot3.Hour, slot3.Minute, slot3.Second, slot3.Millisecond))

	SLFramework.FileHelper.WriteAllBytesToPath(slot5, uv0.decode(slot0))
	SDKMgr.instance:saveImage(slot5)
end

return slot0
