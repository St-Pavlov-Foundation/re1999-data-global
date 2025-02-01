module("modules.logic.optionpackage.utils.OptionPackageHelper", package.seeall)

return {
	formatLangPackName = function (slot0, slot1)
		return string.format("%s-%s", slot0, slot1)
	end,
	getLeftSizeMBorGB = function (slot0, slot1)
		slot5 = "GB"

		if math.max(0, slot0 - (slot1 or 0)) / 1073741824 < 0.1 then
			slot5 = "MB"

			if slot2 / 1048576 < 0.01 then
				slot4 = 0.01
			end
		end

		return slot4, math.max(0.01, slot0 / slot3), slot5
	end,
	getLeftSizeMBNum = function (slot0, slot1)
		if math.max(0, slot0 - (slot1 or 0)) / 1048576 < 0.01 then
			slot4 = 0.01
		end

		return slot4
	end
}
