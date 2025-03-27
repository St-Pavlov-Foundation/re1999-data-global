module("projbooter.utils.VersionUtil", package.seeall)

return {
	versionStrToNumber = function (slot0)
		slot1 = string.splitToNumber(slot0, ".")

		return slot1[1] * 10000 + slot1[2] * 100 + slot1[3]
	end,
	compareVersion = function (slot0, slot1)
		if uv0.versionStrToNumber(slot0) < uv0.versionStrToNumber(slot1) then
			return -1
		elseif slot3 < slot2 then
			return 1
		end

		return 0
	end,
	isVersionLarger = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) > 0
	end,
	isVersionLargeEqual = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) >= 0
	end,
	isVersionLess = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) < 0
	end,
	isVersionLessEqual = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) <= 0
	end,
	isVersionEqual = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) == 0
	end,
	isVersionNotEqual = function (slot0)
		return uv0.compareVersion(UnityEngine.Application.version, slot0) ~= 0
	end
}
